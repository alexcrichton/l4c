use core::util::{replace, swap};
use core::hashmap::HashMap;

use front::ast;
use middle::{temp, ir, label};
use utils::graph;

type StructInfo = HashMap<ast::Ident, (ir::Type, uint)>;
type AllStructInfo = HashMap<ast::Ident, (StructInfo, uint)>;

struct ProgramInfo {
  funs: HashMap<ast::Ident, ~ir::Expression>,
  structs: AllStructInfo,
}

struct Translator<'self> {
  t: &'self ProgramInfo,
  f: ir::Function,
  vars: HashMap<ast::Ident, temp::Temp>,
  temps: temp::Allocator,

  /* cfg creation */
  cur_id: graph::NodeId,
  stms: ~[~ir::Statement],

  /* loop translation */
  break_to: graph::NodeId,
  continue_to: graph::NodeId,
  for_step: ast::stmt,

  /* different codegen flags */
  safe: bool,
}

pub fn translate(mut p: ast::Program, safe: bool) -> ir::Program {
  debug!("building translation info");
  let mut info = ProgramInfo { funs: HashMap::new(), structs: HashMap::new() };
  info.build(&p);
  let decls = replace(&mut p.decls, ~[]);

  debug!("translating");
  let mut accum = ~[];
  /* TODO(#4878): 'decls.consume' causes segfault */
  do vec::consume(decls) |_, d| {
    match d.unwrap() {
      ast::Function(_, id, args, body) => {
        let mut trans = Translator {
          t: &info,
          f: ir::Function(p.str(id)),
          vars: HashMap::new(),
          temps: temp::new(),
          cur_id: 0,
          stms: ~[],
          break_to: 0,
          continue_to: 0,
          for_step: ast::Nop,
          safe: safe
        };
        trans.cur_id = trans.f.cfg.new_id();
        trans.f.root = trans.cur_id;
        trans.arguments(args);
        trans.stm(body.unwrap());
        let Translator{ f, _ } = trans;
        accum.push(f);
      }
      _ => ()
    };
  }

  return ir::Program(accum);
}

fn typ(t: @ast::Type) -> ir::Type {
  match t {
    @ast::Array(_) | @ast::Struct(_) | @ast::Pointer(_) => ir::Pointer,
    _ => ir::Int
  }
}

fn typ_size(t: @ast::Type, structs: &AllStructInfo) -> uint {
  match t {
    @ast::Int | @ast::Bool => 4,
    @ast::Pointer(_) | @ast::Array(_) => 8,
    @ast::Struct(ref id) => {
      let &(_, size) = structs.get(id);
      size
    }
    _ => fail!(~"bad type to typ_size")
  }
}

impl ProgramInfo {
  fn build(&mut self, p: &ast::Program) {
    for p.decls.each |d| {
      self.build_gdecl(p, *d)
    }
  }

  fn build_gdecl(&mut self, p: &ast::Program, g: &ast::GDecl) {
    match g.node {
      ast::StructDef(id, ref fields) => {
        let mut table = HashMap::new();
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
      ast::FunIDecl(_, id, _) => {
        let f = self.ilabel(p, id);
        self.funs.insert(id, f);
      }
      ast::FunEDecl(_, id, _) => {
        let f = self.elabel(p, id);
        self.funs.insert(id, f);
      }
      ast::Function(_, id, _, _) => {
        if !self.funs.contains_key(&id) {
          let f = self.ilabel(p, id);
          self.funs.insert(id, f);
        }
      }
      _ => ()
    }
  }

  fn elabel(&self, p: &ast::Program, id: ast::Ident) -> ~ir::Expression {
    ~ir::LabelExp(label::External(p.str(id)))
  }

  fn ilabel(&self, p: &ast::Program, id: ast::Ident) -> ~ir::Expression {
    ~ir::LabelExp(label::Internal(p.str(id)))
  }
}

impl<'self> Translator<'self> {
  fn arguments(&mut self, args: ~[(ast::Ident, @ast::Type)]) {
    let args = vec::map_consume(args, |(id, t)| {
      let tmp = self.tmp(typ(t));
      self.vars.insert(id, tmp);
      tmp
    });
    self.stms.push(~ir::Arguments(args));
  }

  fn stm(&mut self, s: ast::stmt) {
    match s {
      ast::Nop => (),
      ast::Seq(s1, s2) => {
        self.stm(s1.unwrap());
        self.stm(s2.unwrap());
      }
      ast::Continue => {
        /* TODO: can this copy be avoided? */
        self.stm(copy self.for_step);
        let n = self.commit();
        self.f.cfg.add_edge(n, self.continue_to, ir::Branch);
      }
      ast::Break => {
        let n = self.commit();
        self.f.cfg.add_edge(n, self.break_to, ir::LoopOut);
      }
      ast::Return(e) => {
        let e = self.exp(e.unwrap(), false);
        self.stms.push(~ir::Return(e));
        self.commit();
      }
      ast::Express(e) => {
        let e = self.exp(e.unwrap(), false);
        let size = e.size(&self.f.types);
        let tmp = self.tmp(size);
        self.stms.push(~ir::Move(tmp, e));
      }
      ast::For(init, cond, step, body) => {
        self.stm(init.unwrap());
        /* TODO: can this copy be avoided? */
        let prevstep = replace(&mut self.for_step, copy step.node);
        self.trans_loop(cond.unwrap(), ast::Seq(body, step));
        self.for_step = prevstep;
      }
      ast::While(cond, body) => {
        let prevstep = replace(&mut self.for_step, ast::Nop);
        self.trans_loop(cond.unwrap(), body.unwrap());
        self.for_step = prevstep;
      }
      ast::If(cond, t, f) => {
        let true_id = self.f.cfg.new_id();
        let false_id = self.f.cfg.new_id();
        self.condition(cond.unwrap(),
                       true_id, ir::True, false_id, ir::False, true_id);

        self.stm(t.unwrap());
        let true_end = self.commit_with(false_id);
        self.stm(f.unwrap());
        let false_end = self.commit();

        self.f.cfg.add_edge(true_end, self.cur_id, ir::Branch);
        self.f.cfg.add_edge(false_end, self.cur_id, ir::Always);
      }
      ast::Declare(id, t, exp, s) => {
        let tmp = self.tmp(typ(t));
        match exp {
          None => (),
          Some(init) => {
            let init = self.exp(init.unwrap(), false);
            self.stms.push(~ir::Move(tmp, init));
          }
        }
        self.vars.insert(id, tmp);
        self.stm(s.unwrap());
        self.vars.remove(&id);
      }
      ast::Assign(e1, op, e2) => {
        let (ismem, leftsize) = match e1.node {
          ast::Var(_) => (false, ir::Int), /* size doesn't matter */
          ast::Deref(_, ref t) | ast::ArrSub(_, _, ref t) =>
            (true, do t.with_ref |&t| { typ(t) }),
          ast::Field(_, ref f, ref s) => {
            /* TODO(#4653): make this actually sane */
            /*let &(ref fields, _) = self.t.structs.get(&s.get());*/
            let typ = do s.with_ref |s| {
              match *self.t.structs.get(s) {
                (ref fields, _) => fields.get(f).first()
              }
            };
            (true, typ)
          }
          _ => fail!(~"invalid assign")
        };
        let left = self.exp(e1.unwrap(), true);
        let right = match op {
          None => self.exp(e2.unwrap(), false),
          Some(op) => {
            if ismem {
              let tmp = self.tmp(leftsize);
              self.stms.push(~ir::Load(tmp, copy left));
              ~ir::BinaryOp(self.oper(op), ~ir::Temp(tmp),
                            self.exp(e2.unwrap(), false))
            } else {
              ~ir::BinaryOp(self.oper(op), copy left,
                            self.exp(e2.unwrap(), false))
            }
          }
        };
        if ismem {
          self.stms.push(~ir::Store(left, right));
        } else {
          let tmp = match left { ~ir::Temp(t) => t, _ => fail!(~"bad left") };
          self.stms.push(~ir::Move(tmp, right));
        }
      }
    }
  }

  fn trans_loop(&mut self, cond: ast::expr, body: ast::stmt) {
    let pred = self.commit();
    let condid = self.cur_id;
    let bodyid = self.f.cfg.new_id();
    let afterid = self.f.cfg.new_id();
    self.f.cfg.add_edge(pred, condid, ir::Always);
    self.condition(cond, bodyid, ir::True, afterid, ir::FLoopOut, bodyid);

    {
      let prevcont = replace(&mut self.continue_to, condid);
      let prevbreak = replace(&mut self.break_to, afterid);
      self.stm(body);
      self.continue_to = prevcont;
      self.break_to = prevbreak;
    }

    let bodyend = self.commit_with(afterid);
    self.f.cfg.add_edge(bodyend, condid, ir::Always);
    self.f.loops.insert(condid, (bodyid, afterid));
  }

  fn condition(&mut self, e: ast::expr, tid: graph::NodeId,
               tedge: ir::Edge, fid: graph::NodeId, fedge: ir::Edge,
               into: graph::NodeId) {
    match e {
      ast::BinaryOp(ast::LOr, e1, e2) => {
        let next = self.f.cfg.new_id();
        self.condition(e1.unwrap(), tid, ir::TBranch, next, ir::False, next);
        self.condition(e2.unwrap(), tid, tedge, fid, fedge, into);
      }
      ast::BinaryOp(ast::LAnd, e1, e2) => {
        let next = self.f.cfg.new_id();
        self.condition(e1.unwrap(), next, ir::True, fid, ir::FBranch, next);
        self.condition(e2.unwrap(), tid, tedge, fid, fedge, into);
      }
      e => {
        let e = self.exp(e, false);
        self.stms.push(~ir::Condition(e));
        let id = self.commit_with(into);
        self.f.cfg.add_edge(id, tid, tedge);
        self.f.cfg.add_edge(id, fid, fedge);
      }
    }
  }

  fn exp(&mut self, e: ast::expr, addr: bool) -> ~ir::Expression {
    match e {
      ast::Boolean(b) => self.consti(if b { 1 } else { 0 }),
      ast::Const(c) => self.consti(c),
      ast::Var(ref id) => match self.vars.find(id) {
        Some(&t) => ~ir::Temp(t),
        None     => copy *self.t.funs.get(id)
      },
      ast::Null => self.constp(0),

      /* All unary ops can be expressed as binary ops */
      ast::UnaryOp(ast::Negative, e) =>
        ~ir::BinaryOp(ir::Sub, self.consti(0), self.exp(e.unwrap(), addr)),
      ast::UnaryOp(ast::Invert, e) =>
        ~ir::BinaryOp(ir::Xor, self.consti(-1), self.exp(e.unwrap(), addr)),
      ast::UnaryOp(ast::Bang, e) =>
        ~ir::BinaryOp(ir::Xor, self.consti(1), self.exp(e.unwrap(), addr)),

      /* Take care of logical binops as ternaries */
      ast::BinaryOp(ast::LOr, e1, e2) =>
        self.tern(e1.unwrap(), ast::Boolean(true), e2.unwrap(), ir::Int, false),
      ast::BinaryOp(ast::LAnd, e1, e2) =>
        self.tern(e1.unwrap(), e2.unwrap(), ast::Boolean(false), ir::Int, false),

      ast::BinaryOp(op, e1, e2) => {
        let v1 = self.exp(e1.unwrap(), addr);
        let v2 = self.exp(e2.unwrap(), addr);
        let op = self.oper(op);
        let ret = ~ir::BinaryOp(op, v1, v2);
        match op {
          /* div/mod have side effects, the result is a temp so they happen */
          ir::Div | ir::Mod => {
            let tmp = self.tmp(ir::Int);
            self.stms.push(~ir::Move(tmp, ret));
            ~ir::Temp(tmp)
          }
          _ => ret
        }
      }

      ast::Ternary(e1, e2, e3, t) =>
        self.tern(e1.unwrap(), e2.unwrap(), e3.unwrap(), typ(t.take()), addr),

      ast::Call(e, args, t) => {
        let ret = t.take();
        let fun = self.exp(e.unwrap(), false);
        let args = vec::map_consume(args, |e| self.exp(e.unwrap(), false));
        let typ = typ(ret);
        let tmp = self.tmp(typ);
        self.stms.push(~ir::Call(tmp, fun, args));
        ~ir::Temp(tmp)
      }

      ast::Alloc(t) => {
        let amt = self.consti(1);
        self.alloc(t, amt, ~"salloc")
      }
      ast::AllocArray(t, e) => {
        let amt = self.exp(e.unwrap(), false);
        self.alloc(t, amt, ~"salloc_array")
      }

      ast::ArrSub(arr, idx, t) => {
        let base = self.exp(arr.unwrap(), false);
        let idx = self.exp(idx.unwrap(), false);
        let idxt = self.tmp(ir::Int);
        self.stms.push(~ir::Move(idxt, idx));
        let idxp = self.tmp(ir::Pointer);
        self.stms.push(~ir::Cast(idxp, idxt));

        self.check_null(base);
        self.check_bounds(base, ~ir::Temp(idxt));

        let t = t.take();
        let elsize = self.constp(typ_size(t, &self.t.structs) as i32);
        let offset = ~ir::BinaryOp(ir::Mul, ~ir::Temp(idxp), elsize);
        let address = ~ir::BinaryOp(ir::Add, base, offset);
        if addr {
          return address;
        }
        let dest = self.tmp(typ(t));
        self.stms.push(~ir::Load(dest, address));
        ~ir::Temp(dest)
      }

      ast::Field(e, id, s) => {
        let base = self.exp(e.unwrap(), true);
        /* TODO(#4653): make this actually sane */
        /*let &(ref fields, _) = self.t.structs.get(&s.get());*/
        let sinfo = self.t.structs.get(&s.take());
        let fields = match *sinfo { (ref fields, _) => fields };
        let &(typ, size) = fields.get(&id);
        let address = ~ir::BinaryOp(ir::Add, base, self.constp(size as i32));
        self.check_null(address);
        if addr {
          return address;
        }
        let dest = self.tmp(typ);
        self.stms.push(~ir::Load(dest, address));
        ~ir::Temp(dest)
      }

      ast::Deref(e, t) => {
        let address = self.exp(e.unwrap(), false);
        self.check_null(address);
        if addr {
          return address;
        }
        let dest = self.tmp(typ(t.take()));
        self.stms.push(~ir::Load(dest, address));
        ~ir::Temp(dest)
      }
    }
  }

  fn alloc(&mut self, t: @ast::Type, cnt: ~ir::Expression,
           safe: ~str) -> ~ir::Expression {
    let fun = label::External(if self.safe { safe } else { ~"calloc" });
    let fun = ~ir::LabelExp(fun);
    let result = self.tmp(ir::Pointer);
    let args = ~[cnt, self.constp(typ_size(t, &self.t.structs) as i32)];
    self.stms.push(~ir::Call(result, fun, args));
    ~ir::Temp(result)
  }

  /**
   * Translates a ternary statement
   *
   * # Arguments
   *
   * * cond - The condition for the ternary statement
   * * t - The expression to execute in the 'true' case
   * * f - The expression to execute in the 'false' case
   * * size - The size of the destination operand
   * * addr - 'true' if an address is desired, or 'false' if the value is needed
   *
   * This returns the temp which holds the result of the ternary statement.
   */
  fn tern(&mut self, cond: ast::expr, t: ast::expr,
          f: ast::expr, size: ir::Type, addr: bool) -> ~ir::Expression {
    let dst = self.tmp(size);
    let end = self.f.cfg.new_id();
    self.dotern(cond, t, f, dst, addr,
                (end, ir::Branch, ir::Always));
    self.commit_with(end);
    ~ir::Temp(dst)
  }

  /**
   * Actually translate a ternary statement
   *
   * # Arguments
   *
   * * c - the condition
   * * t - The true expression
   * * f - The false expression
   * * dst - The temp to place the result into
   * * addr - Flag if the address of the expressions are desired
   * * (end, endt, endf) - The node to finally branch to at the end, and the
   *                       types of edges that should be used to go from the
   *                       true branch and false branch to the end
   */
  fn dotern(&mut self, c: ast::expr,
            t: ast::expr, f: ast::expr,
            dst: temp::Temp, addr: bool,
            (end, endt, endf): (graph::NodeId, ir::Edge, ir::Edge)) {
    /* Translate the conditional, terminating the basic block */
    let true_id = self.f.cfg.new_id();
    let false_id = self.f.cfg.new_id();
    let c = self.exp(c, false);
    self.stms.push(~ir::Condition(c));

    /* translate each true/false branch */
    let cond_id = self.commit_with(true_id);
    self.f.cfg.add_edge(cond_id, true_id, ir::True);
    self.process_tern(t, endt, dst, addr, end);
    self.commit_with(false_id);
    self.f.cfg.add_edge(cond_id, false_id, ir::FBranch);
    self.process_tern(f, endf, dst, addr, end);
  }

  fn process_tern(&mut self, e: ast::expr, typ: ir::Edge,
                  dst: temp::Temp, addr: bool, end: graph::NodeId) {
    match e {
      /* Some cases don't necessarily always need a 'join' node */
      ast::Ternary(e1, e2, e3, _) => {
        self.dotern(e1.unwrap(), e2.unwrap(), e3.unwrap(),
                    dst, addr, (end, ir::Branch, typ));
      }
      ast::BinaryOp(ast::LOr, e1, e2) => {
        self.dotern(e1.unwrap(), ast::Boolean(true), e2.unwrap(), dst, addr,
                    (end, ir::Branch, typ));
      }
      ast::BinaryOp(ast::LAnd, e1, e2) => {
        self.dotern(e1.unwrap(), e2.unwrap(), ast::Boolean(false), dst, addr,
                    (end, ir::Branch, typ));
      }

      /* Otherwise, we have to finish things up */
      e => {
        let e = self.exp(e, addr);
        self.stms.push(~ir::Move(dst, e));
        self.f.cfg.add_edge(self.cur_id, end, typ);
      }
    }
  }

  fn check_null(&mut self, e: &ir::Expression) {
    if !self.safe { return; }
    let cond = ~ir::BinaryOp(ir::Eq, ~copy *e, self.constp(0));
    self.stms.push(~ir::Die(cond));
  }

  fn check_bounds(&mut self, base: &ir::Expression, idx: &ir::Expression) {
    if !self.safe { return; }
    let tmp = self.tmp(ir::Int);
    let size = ~ir::BinaryOp(ir::Sub, ~copy *base, self.constp(8));
    self.stms.push(~ir::Load(tmp, size));

    let under = ~ir::BinaryOp(ir::Lt, ~copy *idx, self.consti(0));
    self.stms.push(~ir::Die(under));
    let over = ~ir::BinaryOp(ir::Gte, ~copy *idx, ~ir::Temp(tmp));
    self.stms.push(~ir::Die(over));
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
      ast::LAnd | ast::LOr => fail!(~"invalid binop trans")
    }
  }

  fn commit(&mut self) -> graph::NodeId {
    let id = self.f.cfg.new_id();
    self.commit_with(id)
  }

  fn consti(&self, c: i32) -> ~ir::Expression { ~ir::Const(c, ir::Int) }
  fn constp(&self, c: i32) -> ~ir::Expression { ~ir::Const(c, ir::Pointer) }

  fn commit_with(&mut self, next: graph::NodeId) -> graph::NodeId {
    let mut L = ~[];
    swap(&mut L, &mut self.stms); /* swap a new block into place */
    let id = replace(&mut self.cur_id, next);
    self.f.cfg.add_node(id, L);
    return id;
  }

  fn tmp(&mut self, t: ir::Type) -> temp::Temp {
    let tmp = self.temps.new();
    self.f.types.insert(tmp, t);
    return tmp;
  }
}
