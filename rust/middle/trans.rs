use std::map;
use front::ast;

type StructInfo = map::HashMap<ast::Ident, (ir::Type, uint)>;

struct Translator {
  funs : map::HashMap<ast::Ident, bool>,
  structs : map::HashMap<ast::Ident, (StructInfo, uint)>,
  vars : map::HashMap<ast::Ident, ir::Temp>,
  temps : temp::Allocator,

  /* cfg creation */
  mut cur_id : graph::NodeId,
  mut stms : ~[@ir::Statement],
  cfg : graph::Graph<@~[@ir::Statement], ir::Edge>,

  /* loop translation */
  mut break_to : graph::NodeId,
  mut continue_to : graph::NodeId,
  mut for_step : @ast::Statement,
}

pub fn translate(p : &ast::Program) -> ir::Program {
  let t = Translator{ funs:    map::HashMap(),
                      structs: map::HashMap(),
                      vars:    map::HashMap(),
                      temps:   temp::new(),
                      cur_id:  0,
                      break_to: 0,
                      continue_to: 0,
                      for_step: @ast::Nop,
                      stms:    ~[],
                      cfg:     graph::Graph()};
  t.translate(p)
}

impl Translator {
  fn translate(p : &ast::Program) -> ir::Program {
    for p.decls.each |&d| {
      self.trans(d);
    }
    3
  }

  fn trans(g : @ast::GDecl) {
    match g {
      @ast::Markedg(ref m) => self.trans(m.data),
      @ast::Function(_, id, ref args, body) => {
        self.vars.clear();
        self.funs.insert(id, true);
        for args.each |&(id, typ)| {
          self.vars.insert(id, (self.temps.new(), self.typ(typ)));
        }
        self.stm(body);
      },
      @ast::FunEDecl(_, id, _) => { self.funs.insert(id, false); },
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
      }
      _ => ()
    }
  }

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
        self.cfg.add_edge(self.continue_to, self.commit(), ir::Branch);
      }
      @ast::Break => {
        self.cfg.add_edge(self.break_to, self.commit(), ir::Branch);
      }
      @ast::Return(e) => {
        self.stms.push(@ir::Return(self.exp(e, false)));
        self.commit();
      }
      @ast::Express(e) => {
        let stm = @ir::Move((self.temps.new(), ir::Pointer), self.exp(e, false));
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
        let true_id = self.cfg.new_id();
        let false_id = self.cfg.new_id();
        self.condition(cond, true_id, ir::True, false_id, ir::False);
        self.commit_with(true_id); // TODO: needed?

        self.stm(t);
        let true_end = self.commit_with(false_id);
        self.stm(f);
        let false_end = self.commit();

        self.cfg.add_edge(true_end, self.cur_id, ir::Branch);
        self.cfg.add_edge(false_end, self.cur_id, ir::Always);
      }
      @ast::Declare(id, typ, exp, s) => {
        let tmp = (self.temps.new(), self.typ(typ));
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
        let (ismem, leftsize) = match e1 {
          @ast::Var(_) => (false, ir::Int), /* size doesn't matter */
          @ast::Deref(_, ref t) | @ast::ArrSub(_, _, ref t) =>
            (true, self.typ(t.get())),
          @ast::Field(_, f, ref s) =>
            (true, self.structs.get(s.get()).first().get(f).first()), /* ... */
          _ => fail(~"invalid assign")
        };
        let left = self.exp(e1, true);
        let right = match op {
          None => self.exp(e2, false),
          Some(op) => {
            if ismem {
              let tmp = (self.temps.new(), leftsize);
              self.stms.push(@ir::Load(tmp, left));
              @ir::BinaryOp(self.oper(op), @ir::Temp(tmp), self.exp(e2, false))
            } else {
              @ir::BinaryOp(self.oper(op), left, self.exp(e2, false))
            }
          }
        };
        if ismem {
          self.stms.push(@ir::Store(left, leftsize, right));
        } else {
          let tmp = match left { @ir::Temp(t) => t, _ => fail(~"bad left") };
          self.stms.push(@ir::Move(tmp, right));
        }
      }
    }
  }

  fn trans_loop(cond : @ast::Expression, body : @ast::Statement) {
    let pred = self.commit();
    let condid = self.cur_id;
    let bodyid = self.cfg.new_id();
    let afterid = self.cfg.new_id();
    self.cfg.add_edge(pred, condid, ir::Always);
    self.condition(cond, bodyid, ir::True, afterid, ir::False);
    self.commit_with(bodyid); // TODO: needed?

    do with(&mut self.continue_to, condid) {
      do with(&mut self.break_to, afterid) {
        self.stm(body);
      }
    }
    let bodyend = self.commit_with(afterid);
    self.cfg.add_edge(bodyend, condid, ir::Always);
  }

  fn condition(e : @ast::Expression, tid : graph::NodeId, tedge : ir::Edge,
               fid : graph::NodeId, fedge : ir::Edge) {
    match e {
      @ast::Marked(ref m) => self.condition(m.data, tid, tedge, fid, fedge),
      @ast::BinaryOp(ast::LOr, e1, e2) => {
        let next = self.cfg.new_id();
        self.condition(e1, tid, ir::TBranch, next, ir::False);
        self.commit_with(next);
        self.condition(e2, tid, tedge, fid, fedge);
      }
      @ast::BinaryOp(ast::LAnd, e1, e2) => {
        let next = self.cfg.new_id();
        self.condition(e1, next, ir::True, fid, ir::FBranch);
        self.commit_with(next);
        self.condition(e2, tid, tedge, fid, fedge);
      }
      _ => {
        self.stms.push(@ir::Condition(self.exp(e, false)));
        let id = self.commit();
        self.cfg.add_edge(id, tid, tedge);
        self.cfg.add_edge(id, fid, fedge);
      }
    }
  }

  fn exp(e : @ast::Expression, addr : bool) -> @ir::Expression {
    ignore(e);
    ignore(addr);
    @ir::Const(2, ir::Int)
  }

  fn typ(t : @ast::Type) -> ir::Type {
    match t {
      @ast::Array(_) | @ast::Struct(_) | @ast::Pointer(_) => ir::Pointer,
      _ => ir::Int
    }
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

  fn typ_size(t : @ast::Type) -> uint {
    match t {
      @ast::Int | @ast::Bool => 4,
      @ast::Pointer(_) | @ast::Array(_) => 8,
      @ast::Struct(id) => self.structs.get(id).second(),
      _ => fail(~"bad type to typ_size")
    }
  }

  fn commit() -> graph::NodeId {
    self.commit_with(self.cfg.new_id())
  }

  fn commit_with(next : graph::NodeId) -> graph::NodeId {
    // TODO: better way to consume vectors?
    let L = self.stms.map(|x| *x);
    self.stms.truncate(0);
    /*do consume(&mut self.preds) |(n, e)| {*/
    /*  self.cfg.add_edge(self.cur_id, n, e);*/
    /*}*/
    let id = self.cur_id;
    self.cfg.add_node(id, @L);
    self.cur_id = next;
    return id;
  }
}

/*fn consume<T>(v: &mut ~[T], f : fn(T)) {*/
/*  // TODO: better way to consume vectors?*/
/*  while v.len() > 0 {*/
/*    f(v.pop());*/
/*  }*/
/*}*/
