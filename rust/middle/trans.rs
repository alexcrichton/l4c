use std::map;
use front::ast;

type StructInfo = map::HashMap<ast::Ident, (ir::Type, uint)>;

struct Translator {
  funs : map::HashMap<ast::Ident, @ir::Expression>,
  structs : map::HashMap<ast::Ident, (StructInfo, uint)>,
  temps : temp::Allocator,

  /* different codegen flags */
  safe : bool,
}

struct AstTranslator {
  t : &Translator,
  f : &ir::Function,
  vars : map::HashMap<ast::Ident, temp::Temp>,

  /* cfg creation */
  mut cur_id : graph::NodeId,
  mut stms : ~[@ir::Statement],

  /* loop translation */
  mut break_to : graph::NodeId,
  mut continue_to : graph::NodeId,
  mut for_step : @ast::Statement,
}

pub fn translate(p : &ast::Program, safe : bool) -> ir::Program {
  let t = Translator{ funs:    map::HashMap(),
                      structs: map::HashMap(),
                      temps:   temp::new(),
                      safe:    safe };
  t.translate(p)
}

impl Translator {
  fn translate(p : &ast::Program) -> ir::Program {
    let mut accum = ~[];
    for p.decls.each |&d| {
      match self.trans(d) {
        None => (),
        Some(f) => accum.push(f)
      }
    }
    ir::Program(accum)
  }

  fn trans(g : @ast::GDecl) -> Option<ir::Function> {
    match g {
      @ast::Markedg(ref m) => self.trans(m.data),
      @ast::StructDef(id, ref fields) => {
        let table = map::HashMap();
        let mut size = 0;
        for fields.each |&(id, typ)| {
          let typsize = self.typ_size(typ);
          if (size != 0 && size % typsize != 0) {
            size += 4; /* TODO: real math */
          }
          table.insert(id, (self.typ(typ), size));
          size += typsize;
        }
        self.structs.insert(id, (table, size));
        None
      }
      @ast::FunEDecl(_, id, _) => {
        self.funs.insert(id, @ir::LabelExp(label::External(copy id.val)));
        None
      }
      @ast::Function(_, id, ref args, body) => {
        let fun = ir::Function(copy id.val);
        self.trans_fun(id, args, body, &fun);
        Some(fun)
      }
      _ => None
    }
  }

  fn trans_fun(id : ast::Ident, args : &~[(ast::Ident, @ast::Type)],
               body : @ast::Statement, fun : &ir::Function) {
    self.temps.reset();
    let trans = AstTranslator {
      cur_id: 0,
      stms: ~[],
      break_to: 0,
      continue_to: 0,
      for_step: @ast::Nop,
      t: &self,
      f: fun,
      vars: map::HashMap()
    };
    self.funs.insert(id, @ir::LabelExp(label::Internal(copy id.val)));
    let mut argtmps = ~[];
    for args.each |&(id, typ)| {
      let tmp = self.temps.new();
      fun.types.insert(tmp, self.typ(typ));
      trans.vars.insert(id, tmp);
      argtmps.push(tmp);
    }
    trans.cur_id = fun.cfg.new_id();
    fun.root = trans.cur_id;
    fun.args = @argtmps;
    trans.stm(body);
  }

  fn typ(t : @ast::Type) -> ir::Type {
    match t {
      @ast::Array(_) | @ast::Struct(_) | @ast::Pointer(_) => ir::Pointer,
      _ => ir::Int
    }
  }

  fn typ_size(t : @ast::Type) -> uint {
    match t {
      @ast::Int | @ast::Bool => 4,
      @ast::Pointer(_) | @ast::Array(_) => 8,
      @ast::Struct(id) => self.structs.get(id).second(),
      _ => fail(~"bad type to typ_size")
    }
  }
}

impl AstTranslator {
  fn stm(s : @ast::Statement) {
    match s {
      @ast::Nop => (),
      @ast::Markeds(ref m) => self.stm(m.data),
      @ast::Seq(s1, s2) => {
        self.stm(s1);
        self.stm(s2);
      }
      @ast::Continue => {
        self.stm(self.for_step);
        self.f.cfg.add_edge(self.commit(), self.continue_to, ir::Branch);
      }
      @ast::Break => {
        self.f.cfg.add_edge(self.commit(), self.break_to, ir::LoopOut);
      }
      @ast::Return(e) => {
        self.stms.push(@ir::Return(self.exp(e, false)));
        self.commit();
      }
      @ast::Express(e) => {
        let stm = @ir::Move(self.tmp(ir::Pointer), self.exp(e, false));
        self.stms.push(stm);
      }
      @ast::For(init, cond, step, body) => {
        self.stm(init);
        do with(&mut self.for_step, step) {
          self.trans_loop(cond, @ast::Seq(body, step));
        }
      }
      @ast::While(cond, body) => {
        do with(&mut self.for_step, @ast::Nop) {
          self.trans_loop(cond, body);
        }
      }
      @ast::If(cond, t, f) => {
        let true_id = self.f.cfg.new_id();
        let false_id = self.f.cfg.new_id();
        self.condition(cond, true_id, ir::True, false_id, ir::False, true_id);

        self.stm(t);
        let true_end = self.commit_with(false_id);
        self.stm(f);
        let false_end = self.commit();

        self.f.cfg.add_edge(true_end, self.cur_id, ir::Branch);
        self.f.cfg.add_edge(false_end, self.cur_id, ir::Always);
      }
      @ast::Declare(id, typ, exp, s) => {
        let tmp = self.tmp(self.typ(typ));
        match exp {
          None => (),
          Some(init) => {
            self.stms.push(@ir::Move(tmp, self.exp(init, false)));
          }
        }
        self.vars.insert(id, tmp);
        self.stm(s);
        self.vars.remove(id);
      }
      @ast::Assign(e1, op, e2) => {
        let (ismem, leftsize) = match self.unmark(e1) {
          @ast::Var(_) => (false, ir::Int), /* size doesn't matter */
          @ast::Deref(_, ref t) | @ast::ArrSub(_, _, ref t) =>
            (true, self.typ(t.get())),
          @ast::Field(_, f, ref s) =>
            (true, self.t.structs.get(s.get()).first().get(f).first()), /* ... */
          _ => fail(~"invalid assign")
        };
        let left = self.exp(e1, true);
        let right = match op {
          None => self.exp(e2, false),
          Some(op) => {
            if ismem {
              let tmp = self.tmp(leftsize);
              self.stms.push(@ir::Load(tmp, left));
              @ir::BinaryOp(self.oper(op), @ir::Temp(tmp), self.exp(e2, false))
            } else {
              @ir::BinaryOp(self.oper(op), left, self.exp(e2, false))
            }
          }
        };
        if ismem {
          self.stms.push(@ir::Store(left, right));
        } else {
          let tmp = match left { @ir::Temp(t) => t, _ => fail(~"bad left") };
          self.stms.push(@ir::Move(tmp, right));
        }
      }
    }
  }

  fn unmark(e : @ast::Expression) -> @ast::Expression {
    match e {
      @ast::Marked(ref m) => self.unmark(m.data),
      _ => e
    }
  }

  fn trans_loop(cond : @ast::Expression, body : @ast::Statement) {
    let pred = self.commit();
    let condid = self.cur_id;
    let bodyid = self.f.cfg.new_id();
    let afterid = self.f.cfg.new_id();
    self.f.cfg.add_edge(pred, condid, ir::Always);
    self.condition(cond, bodyid, ir::True, afterid, ir::FLoopOut, bodyid);

    do with(&mut self.continue_to, condid) {
      do with(&mut self.break_to, afterid) {
        self.stm(body);
      }
    }
    let bodyend = self.commit_with(afterid);
    self.f.cfg.add_edge(bodyend, condid, ir::Always);
    self.f.loops.insert(condid, (bodyid, afterid));
  }

  fn condition(e : @ast::Expression, tid : graph::NodeId, tedge : ir::Edge,
               fid : graph::NodeId, fedge : ir::Edge,
               into : graph::NodeId) {
    match e {
      @ast::Marked(ref m) =>
        self.condition(m.data, tid, tedge, fid, fedge, into),
      @ast::BinaryOp(ast::LOr, e1, e2) => {
        let next = self.f.cfg.new_id();
        self.condition(e1, tid, ir::TBranch, next, ir::False, next);
        self.condition(e2, tid, tedge, fid, fedge, into);
      }
      @ast::BinaryOp(ast::LAnd, e1, e2) => {
        let next = self.f.cfg.new_id();
        self.condition(e1, next, ir::True, fid, ir::FBranch, next);
        self.condition(e2, tid, tedge, fid, fedge, into);
      }
      _ => {
        self.stms.push(@ir::Condition(self.exp(e, false)));
        let id = self.commit_with(into);
        self.f.cfg.add_edge(id, tid, tedge);
        self.f.cfg.add_edge(id, fid, fedge);
      }
    }
  }

  fn exp(e : @ast::Expression, addr : bool) -> @ir::Expression {
    match e {
      @ast::Marked(ref m) => self.exp(m.data, addr),
      @ast::Boolean(b) => self.consti(if b { 1 } else { 0 }),
      @ast::Const(c) => self.consti(c),
      @ast::Var(id) => match self.vars.find(id) {
        Some(t) => @ir::Temp(t),
        None    => self.t.funs.get(id)
      },
      @ast::Null => self.constp(0),

      /* All unary ops can be expressed as binary ops */
      @ast::UnaryOp(ast::Negative, e) =>
        @ir::BinaryOp(ir::Sub, self.consti(0), self.exp(e, addr)),
      @ast::UnaryOp(ast::Invert, e) =>
        @ir::BinaryOp(ir::Xor, self.consti(-1), self.exp(e, addr)),
      @ast::UnaryOp(ast::Bang, e) =>
        @ir::BinaryOp(ir::Xor, self.consti(1), self.exp(e, addr)),

      /* Take care of logical binops as ternaries */
      @ast::BinaryOp(ast::LOr, e1, e2) =>
        self.tern(e1, @ast::Boolean(true), e2, ir::Int, false),
      @ast::BinaryOp(ast::LAnd, e1, e2) =>
        self.tern(e1, e2, @ast::Boolean(false), ir::Int, false),

      @ast::BinaryOp(op, e1, e2) => {
        let v1 = self.exp(e1, addr);
        let v2 = self.exp(e2, addr);
        let op = self.oper(op);
        let ret = @ir::BinaryOp(op, v1, v2);
        match op {
          /* div/mod have side effects, the result is a temp so they happen */
          ir::Div | ir::Mod => {
            let tmp = self.tmp(ir::Int);
            self.stms.push(@ir::Move(tmp, ret));
            @ir::Temp(tmp)
          }
          _ => ret
        }
      }

      @ast::Ternary(e1, e2, e3, ref t) =>
        self.tern(e1, e2, e3, self.typ(t.get()), addr),

      @ast::Call(e, ref args, ref t) => {
        let (ret, argtyps) = t.get();
        ignore(argtyps); // TODO: remove this entirely?
        let fun = self.exp(e, false);
        let args = args.map(|&e| self.exp(e, false));
        let typ = self.typ(ret);
        let tmp = self.tmp(typ);
        self.stms.push(@ir::Call(tmp, fun, args));
        @ir::Temp(tmp)
      }

      @ast::Alloc(t) =>
        self.alloc(t, self.consti(1), ~"salloc"),
      @ast::AllocArray(t, e) =>
        self.alloc(t, self.exp(e, false), ~"salloc_array"),

      @ast::ArrSub(arr, idx, ref t) => {
        let base = self.exp(arr, false);
        let idx = self.exp(idx, false);
        let elsize = self.constp(self.typ_size(t.get()) as i32);
        let offset = @ir::BinaryOp(ir::Mul, idx, elsize);
        let address = @ir::BinaryOp(ir::Add, base, offset);
        if addr {
          return address;
        }
        let dest = self.tmp(self.typ(t.get()));
        self.check_null(base);
        self.check_bounds(base, idx);
        self.stms.push(@ir::Load(dest, address));
        @ir::Temp(dest)
      }

      @ast::Field(e, id, ref s) => {
        let base = self.exp(e, true);
        let (typ, size) = self.t.structs.get(s.get()).first().get(id);
        let address = @ir::BinaryOp(ir::Add, base, self.constp(size as i32));
        if addr {
          return address;
        }
        let dest = self.tmp(typ);
        self.check_null(address);
        self.stms.push(@ir::Load(dest, address));
        @ir::Temp(dest)
      }

      @ast::Deref(e, ref t) => {
        let address = self.exp(e, false);
        if addr {
          return address;
        }
        let dest = self.tmp(self.typ(t.get()));
        self.check_null(address);
        self.stms.push(@ir::Load(dest, address));
        @ir::Temp(dest)
      }
    }
  }

  fn alloc(t : @ast::Type, cnt : @ir::Expression,
           safe : ~str) -> @ir::Expression {
    let fun = label::External(if self.t.safe { safe } else { ~"calloc" });
    let fun = @ir::LabelExp(fun);
    let result = self.tmp(ir::Pointer);
    let args = ~[cnt, self.constp(self.typ_size(t) as i32)];
    self.stms.push(@ir::Call(result, fun, args));
    @ir::Temp(result)
  }

  fn tern(cond : @ast::Expression, t : @ast::Expression, f : @ast::Expression,
          size : ir::Type, addr : bool) -> @ir::Expression {
    /* Translate the conditional, terminating the basic block */
    let result = self.tmp(size);
    let true_id = self.f.cfg.new_id();
    let false_id = self.f.cfg.new_id();
    self.stms.push(@ir::Condition(self.exp(cond, false)));

    /* translate each true/false branch */
    let cond_id = self.commit_with(true_id);
    self.stms.push(@ir::Move(result, self.exp(t, addr)));
    let true_end = self.commit_with(false_id);
    self.stms.push(@ir::Move(result, self.exp(f, addr)));
    let false_end = self.commit();

    /* connect everything together */
    self.f.cfg.add_edge(cond_id, true_id, ir::True);
    self.f.cfg.add_edge(cond_id, false_id, ir::False);
    self.f.cfg.add_edge(true_end, self.cur_id, ir::Always);
    self.f.cfg.add_edge(false_end, self.cur_id, ir::Always);

    @ir::Temp(result)
  }

  fn check_null(e : @ir::Expression) {
    if !self.t.safe { return; }
    let cond = @ir::BinaryOp(ir::Eq, e, self.constp(0));
    self.stms.push(@ir::Die(cond));
  }

  fn check_bounds(base : @ir::Expression, idx : @ir::Expression) {
    if !self.t.safe { return; }
    let tmp = self.tmp(ir::Int);
    let size = @ir::BinaryOp(ir::Sub, base, self.constp(8));
    self.stms.push(@ir::Load(tmp, size));

    let under = @ir::BinaryOp(ir::Lt, idx, self.consti(0));
    self.stms.push(@ir::Die(under));
    let over = @ir::BinaryOp(ir::Gte, idx, @ir::Temp(tmp));
    self.stms.push(@ir::Die(over));
  }

  fn oper(b : ast::Binop) -> ir::Binop {
    match b {
      ast::Plus      => ir::Add,
      ast::Minus     => ir::Sub,
      ast::Times     => ir::Mul,
      ast::Divide    => ir::Div,
      ast::Modulo    => ir::Mod,
      ast::Less      => ir::Lt,
      ast::LessEq    => ir::Lte,
      ast::Greater   => ir::Gt,
      ast::GreaterEq => ir::Gte,
      ast::Equals    => ir::Eq,
      ast::NEquals   => ir::Neq,
      ast::BAnd      => ir::And,
      ast::BOr       => ir::Or,
      ast::Xor       => ir::Xor,
      ast::LShift    => ir::Lsh,
      ast::RShift    => ir::Rsh,
      ast::LAnd | ast::LOr => fail(~"invalid binop trans")
    }
  }

  fn commit() -> graph::NodeId {
    self.commit_with(self.f.cfg.new_id())
  }

  fn consti(c : i32) -> @ir::Expression { @ir::Const(c, ir::Int) }
  fn constp(c : i32) -> @ir::Expression { @ir::Const(c, ir::Pointer) }

  fn commit_with(next : graph::NodeId) -> graph::NodeId {
    // TODO: better way to consume vectors?
    let L = self.stms.map(|x| *x);
    self.stms.truncate(0);
    let id = self.cur_id;
    self.f.cfg.add_node(id, @L);
    self.cur_id = next;
    return id;
  }

  fn typ(t : @ast::Type) -> ir::Type { self.t.typ(t) }
  fn typ_size(t : @ast::Type) -> uint { self.t.typ_size(t) }
  fn tmp(t : ir::Type) -> temp::Temp {
    let tmp = self.t.temps.new();
    self.f.types.insert(tmp, t);
    return tmp;
  }
}
