use core::util::{ignore, with, swap, replace};
use core::hashmap::linear::LinearMap;

use front::ast;
use middle::{temp, ir, label};
use utils::graph;

type StructInfo = LinearMap<ast::Ident, (ir::Type, uint)>;
type AllStructInfo = LinearMap<ast::Ident, (StructInfo, uint)>;

struct ProgramInfo {
  funs: LinearMap<ast::Ident, @ir::Expression>,
  structs: AllStructInfo,
}

struct Translator {
  t: &ProgramInfo,
  f: &mut ir::Function,
  vars: LinearMap<ast::Ident, temp::Temp>,
  temps: temp::Allocator,

  /* cfg creation */
  cur_id: graph::NodeId,
  stms: ~[@ir::Statement],

  /* loop translation */
  break_to: graph::NodeId,
  continue_to: graph::NodeId,
  for_step: @ast::Statement,

  /* different codegen flags */
  safe: bool,
}

pub fn translate(p: ast::Program, safe: bool) -> ir::Program {
  debug!("building translation info");
  /* TODO: rename to 'info' once it's not a global log level */
  let mut pi = ProgramInfo { funs: LinearMap::new(), structs: LinearMap::new() };
  pi.build(&p);

  debug!("translating");
  let mut accum = ~[];
  for p.decls.each |&d| {
    match d.unmark() {
      @ast::Function(_, id, ref args, body) => {
        let mut f = ir::Function(copy id.val);
        f.root = f.cfg.new_id();
        {
          /* loan f to trans for just this block of code */
          let mut trans = Translator {
            t: &pi,
            f: &mut f,
            vars: LinearMap::new(),
            temps: temp::new(),
            cur_id: f.root,
            stms: ~[],
            break_to: 0,
            continue_to: 0,
            for_step: @ast::Nop,
            safe: safe
          };
          trans.run(args, body);
        }
        accum.push(f);
      }
      _ => ()
    };
  }

  return ir::Program { funs: accum };
}

pure fn typ(t: @ast::Type) -> ir::Type {
  match t {
    @ast::Array(_) | @ast::Struct(_) | @ast::Pointer(_) => ir::Pointer,
    _ => ir::Int
  }
}

pure fn typ_size(t: @ast::Type, structs: &AllStructInfo) -> uint {
  match t {
    @ast::Int | @ast::Bool => 4,
    @ast::Pointer(_) | @ast::Array(_) => 8,
    @ast::Struct(ref id) => {
      let &(_, size) = structs.get(id);
      size
    }
    _ => die!(~"bad type to typ_size")
  }
}

impl ProgramInfo {
  fn build(&mut self, p: &ast::Program) {
    for p.decls.each |&d| {
      self.build_gdecl(d)
    }
  }

  fn build_gdecl(&mut self, g: @ast::GDecl) {
    match g {
      @ast::Markedg(ref m) => self.build_gdecl(m.data),
      @ast::StructDef(id, ref fields) => {
        let mut table = LinearMap::new();
        let mut size = 0;
        for fields.each |&(id, t)| {
          let typsize = typ_size(t, &self.structs);
          if (size != 0 && size % typsize != 0) {
            size += 4; /* TODO: real math */
          }
          table.insert(id, (typ(t), size));
          size += typsize;
        }
        self.structs.insert(id, (table, size));
      }
      @ast::FunIDecl(_, id, _) => {
        self.funs.insert(id, @ir::LabelExp(label::Internal(copy id.val)));
      }
      @ast::FunEDecl(_, id, _) => {
        self.funs.insert(id, @ir::LabelExp(label::External(copy id.val)));
      }
      @ast::Function(_, id, _, _) => {
        if !self.funs.contains_key(&id) {
          self.funs.insert(id, @ir::LabelExp(label::Internal(copy id.val)));
        }
      }
      _ => ()
    }
  }
}

impl Translator {
  fn run(&mut self, args: &~[(ast::Ident, @ast::Type)], body: @ast::Statement) {
    /* TODO: why can't this be above */
    self.arguments(args);
    self.stm(body);
  }

  fn arguments(&mut self, args: &~[(ast::Ident, @ast::Type)]) {
    let args = args.map(|&(id, t)| {
      let tmp = self.tmp(typ(t));
      self.vars.insert(id, tmp);
      tmp
    });
    self.stms.push(@ir::Arguments(args));
  }

  fn stm(&mut self, s: @ast::Statement) {
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
        let e = self.exp(e, false);
        let size = self.f.size(e);
        self.stms.push(@ir::Move(self.tmp(size), e));
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
      @ast::Declare(id, t, exp, s) => {
        let tmp = self.tmp(typ(t));
        match exp {
          None => (),
          Some(init) => {
            self.stms.push(@ir::Move(tmp, self.exp(init, false)));
          }
        }
        self.vars.insert(id, tmp);
        self.stm(s);
        self.vars.remove(&id);
      }
      @ast::Assign(e1, op, e2) => {
        let (ismem, leftsize) = match self.unmark(e1) {
          @ast::Var(_) => (false, ir::Int), /* size doesn't matter */
          @ast::Deref(_, ref t) | @ast::ArrSub(_, _, ref t) =>
            (true, typ(t.get())),
          @ast::Field(_, ref f, ref s) => {
            /* TODO(#4653): make this actually sane */
            /*let &(ref fields, _) = self.t.structs.get(&s.get());*/
            let sinfo = self.t.structs.get(&s.get());
            let fields = match *sinfo { (ref fields, _) => fields };
            (true, fields.get(f).first())
          }
          _ => die!(~"invalid assign")
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
          let tmp = match left { @ir::Temp(t) => t, _ => die!(~"bad left") };
          self.stms.push(@ir::Move(tmp, right));
        }
      }
    }
  }

  pure fn unmark(&self, e: @ast::Expression) -> @ast::Expression {
    match e {
      @ast::Marked(ref m) => self.unmark(m.data),
      _ => e
    }
  }

  fn trans_loop(&mut self, cond: @ast::Expression, body: @ast::Statement) {
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

  fn condition(&mut self, e: @ast::Expression, tid: graph::NodeId,
               tedge: ir::Edge, fid: graph::NodeId, fedge: ir::Edge,
               into: graph::NodeId) {
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

  fn exp(&mut self, e: @ast::Expression, addr: bool) -> @ir::Expression {
    match e {
      @ast::Marked(ref m) => self.exp(m.data, addr),
      @ast::Boolean(b) => self.consti(if b { 1 } else { 0 }),
      @ast::Const(c) => self.consti(c),
      @ast::Var(ref id) => match self.vars.find(id) {
        Some(&t) => @ir::Temp(t),
        None    => *self.t.funs.get(id)
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
        self.tern(e1, e2, e3, typ(t.get()), addr),

      @ast::Call(e, ref args, ref t) => {
        let (ret, argtyps) = t.get();
        ignore(argtyps); // TODO: remove this entirely?
        let fun = self.exp(e, false);
        let args = args.map(|&e| self.exp(e, false));
        let typ = typ(ret);
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
        let elsize = self.constp(typ_size(t.get(), &self.t.structs) as i32);
        let offset = @ir::BinaryOp(ir::Mul, idx, elsize);
        let address = @ir::BinaryOp(ir::Add, base, offset);
        self.check_null(base);
        self.check_bounds(base, idx);
        if addr {
          return address;
        }
        let dest = self.tmp(typ(t.get()));
        self.stms.push(@ir::Load(dest, address));
        @ir::Temp(dest)
      }

      @ast::Field(e, ref id, ref s) => {
        let base = self.exp(e, true);
        /* TODO(#4653): make this actually sane */
        /*let &(ref fields, _) = self.t.structs.get(&s.get());*/
        let sinfo = self.t.structs.get(&s.get());
        let fields = match *sinfo { (ref fields, _) => fields };
        let &(typ, size) = fields.get(id);
        let address = @ir::BinaryOp(ir::Add, base, self.constp(size as i32));
        self.check_null(address);
        if addr {
          return address;
        }
        let dest = self.tmp(typ);
        self.stms.push(@ir::Load(dest, address));
        @ir::Temp(dest)
      }

      @ast::Deref(e, ref t) => {
        let address = self.exp(e, false);
        self.check_null(address);
        if addr {
          return address;
        }
        let dest = self.tmp(typ(t.get()));
        self.stms.push(@ir::Load(dest, address));
        @ir::Temp(dest)
      }
    }
  }

  fn alloc(&mut self, t: @ast::Type, cnt: @ir::Expression,
           safe: ~str) -> @ir::Expression {
    let fun = label::External(if self.safe { safe } else { ~"calloc" });
    let fun = @ir::LabelExp(fun);
    let result = self.tmp(ir::Pointer);
    let args = ~[cnt, self.constp(typ_size(t, &self.t.structs) as i32)];
    self.stms.push(@ir::Call(result, fun, args));
    @ir::Temp(result)
  }

  fn tern(&mut self, cond: @ast::Expression, t: @ast::Expression,
          f: @ast::Expression, size: ir::Type, addr: bool) -> @ir::Expression {
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
    self.f.cfg.add_edge(cond_id, false_id, ir::FBranch);
    self.f.cfg.add_edge(true_end, self.cur_id, ir::Branch);
    self.f.cfg.add_edge(false_end, self.cur_id, ir::Always);

    @ir::Temp(result)
  }

  fn check_null(&mut self, e: @ir::Expression) {
    if !self.safe { return; }
    let cond = @ir::BinaryOp(ir::Eq, e, self.constp(0));
    self.stms.push(@ir::Die(cond));
  }

  fn check_bounds(&mut self, base: @ir::Expression, idx: @ir::Expression) {
    if !self.safe { return; }
    let tmp = self.tmp(ir::Int);
    let size = @ir::BinaryOp(ir::Sub, base, self.constp(8));
    self.stms.push(@ir::Load(tmp, size));

    let under = @ir::BinaryOp(ir::Lt, idx, self.consti(0));
    self.stms.push(@ir::Die(under));
    let over = @ir::BinaryOp(ir::Gte, idx, @ir::Temp(tmp));
    self.stms.push(@ir::Die(over));
  }

  fn oper(&mut self, b: ast::Binop) -> ir::Binop {
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
      ast::LAnd | ast::LOr => die!(~"invalid binop trans")
    }
  }

  fn commit(&mut self) -> graph::NodeId {
    self.commit_with(self.f.cfg.new_id())
  }

  pure fn consti(&self, c: i32) -> @ir::Expression { @ir::Const(c, ir::Int) }
  pure fn constp(&self, c: i32) -> @ir::Expression { @ir::Const(c, ir::Pointer) }

  fn commit_with(&mut self, next: graph::NodeId) -> graph::NodeId {
    let mut L = ~[];
    L <-> self.stms; /* swap a new block into place */
    let id = replace(&mut self.cur_id, next);
    self.f.cfg.add_node(id, @L);
    return id;
  }

  fn tmp(&mut self, t: ir::Type) -> temp::Temp {
    let tmp = self.temps.new();
    self.f.types.insert(tmp, t);
    return tmp;
  }
}
