use std::util::replace;
use front::ast::*;
use front::mark;

struct Initchecker<'self> {
  program: &'self Program,
  step: stmt,
}

pub fn check(a: &Program) {
  let mut ic = Initchecker{ program: a, step: Nop };
  debug!("initchecking");
  ic.run();
}

impl<'self> Initchecker<'self> {
  fn run(&mut self) {
    for self.program.decls.each |x| {
      self.check_gdecl(*x);
    }
    self.program.check();
  }

  fn check_gdecl(&mut self, g: &GDecl) {
    match g.node {
      Function(_, _, _, ref body) => self.analyze(*body),
      _ => ()
    }
  }

  fn analyze(&mut self, s: &Statement) {
    match s.node {
      If(_, ref s1, ref s2) | Seq(ref s1, ref s2) => {
        self.analyze(*s1); self.analyze(*s2);
      }
      While(_, ref s) => self.analyze(*s),
      Declare(id, _, None, ref s) =>
        if self.live(id, &s.node) {
          self.program.error(s.span, fmt!("Uninitialized variable: '%s'",
                                          self.program.str(id)));
        } else {
          self.analyze(*s);
        },
      Declare(_, _, _, ref s) => self.analyze(*s),
      For(_, _, _, ref body) => self.analyze(*body),
      _ => ()
    }
  }

  fn live(&mut self, sym: Ident, s: &stmt) -> bool {
    match *s {
      Declare(id, _, ref init, ref s) =>
        id != sym && (self.live(sym, &s.node) || self.uses_opt(sym, init)),
      Assign(ref e1, Some(_), ref e2) =>
        self.uses(sym, *e1) || self.uses(sym, *e2),
      Assign(_, _, ref e2) => self.uses(sym, *e2),
      If(ref e, ref s1, ref s2) =>
        self.uses(sym, *e) || self.live(sym, &s1.node) ||
          self.live(sym, &s2.node),
      While(ref e, ref s) => {
        let prev = replace(&mut self.step, Nop);
        let ret = self.uses(sym, *e) || self.live(sym, &s.node);
        self.step = prev;
        ret
      }
      Break | Nop => false,
      /* TODO: remove copy */
      Continue => self.live(sym, &copy self.step),
      Express(ref e) | Return(ref e) => self.uses(sym, *e),
      Seq(ref s1, ref s2) => self.seq_live(sym, &s1.node, &s2.node),
      For(ref s1, ref e, ref s2, ref s3) => {
        /* TODO: remove copy and use 'with' */
        let prev = replace(&mut self.step, copy s2.node);
        let ret = self.live(sym, &s1.node) ||
            ((self.uses(sym, *e) || self.seq_live(sym, &s3.node, &s2.node)) &&
             !self.defines(sym, &s1.node));
        self.step = prev;
        ret
      }
    }
  }

  fn seq_live(&mut self, sym: Ident, s1: &stmt, s2: &stmt) -> bool {
    self.live(sym, s1) || (self.live(sym, s2) && !self.defines(sym, s1))
  }

  fn uses(&self, sym: Ident, e: &Expression) -> bool {
    match e.node {
      Var(id) => id == sym,
      UnaryOp(_, ref e) | Field(ref e, _, _) |
        Deref(ref e, _) | AllocArray(_, ref e) => self.uses(sym, *e),
      BinaryOp(_, ref e1, ref e2) | ArrSub(ref e1, ref e2, _) =>
        self.uses(sym, *e1) || self.uses(sym, *e2),
      Ternary(ref e1, ref e2, ref e3, _) =>
        self.uses(sym, *e1) || self.uses(sym, *e2) || self.uses(sym, *e3),
      Call(_, ref args, _) => args.iter().any_(|x| self.uses(sym, *x)),
      _ => false
    }
  }

  fn uses_opt(&self, sym: Ident, e: &Option<~Expression>) -> bool {
    match *e {
      None => false,
      Some(ref e) => self.uses(sym, *e)
    }
  }

  fn defines(&mut self, sym: Ident, s: &stmt) -> bool {
    match *s {
      Declare(id, _, Some(_), ref s) => sym == id || self.defines(sym, &s.node),
      Declare(_, _, _, ref s) => self.defines(sym, &s.node),
      Assign(~mark::Marked{ node: Var(id), _ }, _, _) => id == sym,
      If(_, ref s1, ref s2) =>
        self.defines(sym, &s1.node) && self.defines(sym, &s2.node),
      While(_, _) | Assign(_, _, _) | Nop | Express(_) => false,
      For(ref init, _, _, _) => self.defines(sym, &init.node),
      Break | Continue | Return(_) => true,
      Seq(ref s1, ref s2) =>
        self.defines(sym, &s1.node) || self.defines(sym, &s2.node),
    }
  }
}
