use core::util::replace;
use front::error;
use front::ast::*;
use front::mark;

struct Initchecker<'self> {
  program: &'self Program,
  err: @mut error::List,
  step: ~Statement,
}

pub fn check(a: &Program) {
  // TODO(#5884) these shouldn't be up here
  let step = ~Nop;
  let err = @mut error::new();
  let mut ic = Initchecker{ program: a, err: err, step: step };
  debug!("initchecking");
  ic.run();
}

impl<'self> Initchecker<'self> {
  fn run(&mut self) {
    for self.program.decls.each |x| {
      self.check_gdecl(*x);
    }
    self.err.check();
  }

  fn check_gdecl(&mut self, g: &GDecl) {
    match *g {
      Markedg(ref m) => self.check_gdecl(m.data),
      Function(_, _, _, ref body) => self.analyze(*body),
      _ => ()
    }
  }

  fn analyze(&mut self, s: &Statement) {
    match *s {
      Markeds(ref m) => self.err.with(m, |x| self.analyze(x)),
      If(_, ref s1, ref s2) | Seq(ref s1, ref s2) => {
        self.analyze(*s1); self.analyze(*s2);
      }
      While(_, ref s) => self.analyze(*s),
      Declare(id, _, None, ref s) =>
        if self.live(id, *s) {
          self.err.add(fmt!("Uninitialized variable: '%s'",
                            self.program.str(id)));
        } else {
          self.analyze(*s);
        },
      Declare(_, _, _, ref s) => self.analyze(*s),
      For(_, _, _, ref body) => self.analyze(*body),
      _ => ()
    }
  }

  fn live(&mut self, sym: Ident, s: &Statement) -> bool {
    macro_rules! seq_live(
      ($s1:expr, $s2:expr) => (
        self.live(sym, *$s1) ||
          (self.live(sym, *$s2) && !self.defines(sym, *$s1)),
      )
    );
    match *s {
      Declare(id, _, ref init, ref s) =>
        id != sym && (self.live(sym, *s) || self.uses_opt(sym, init)),
      Assign(ref e1, Some(_), ref e2) =>
        self.uses(sym, *e1) || self.uses(sym, *e2),
      Assign(_, _, ref e2) => self.uses(sym, *e2),
      If(ref e, ref s1, ref s2) =>
        self.uses(sym, *e) || self.live(sym, *s1) || self.live(sym, *s2),
      While(ref e, ref s) => {
        /* TODO: use 'with' */
        let prev = replace(&mut self.step, ~Nop);
        let ret = self.uses(sym, *e) || self.live(sym, *s);
        self.step = prev;
        ret
      }
      Break | Nop => false,
      /* TODO: remove copy */
      Continue => self.live(sym, copy self.step),
      Express(ref e) | Return(ref e) => self.uses(sym, *e),
      Seq(ref s1, ref s2) => seq_live!(s1, s2),
      Markeds(ref m) => self.live(sym, m.data),
      For(ref s1, ref e, ref s2, ref s3) => {
        /* TODO: remove copy and use 'with' */
        let prev = replace(&mut self.step, copy *s2);
        let ret = self.live(sym, *s1) ||
            ((self.uses(sym, *e) || seq_live!(s3, s2)) &&
             !self.defines(sym, *s1));
        self.step = prev;
        ret
      }
    }
  }

  fn uses(&self, sym: Ident, e: &Expression) -> bool {
    match *e {
      Marked(ref m) => self.uses(sym, m.data),
      Var(id) => id == sym,
      UnaryOp(_, ref e) | Field(ref e, _, _) |
        Deref(ref e, _) | AllocArray(_, ref e) => self.uses(sym, *e),
      BinaryOp(_, ref e1, ref e2) | ArrSub(ref e1, ref e2, _) =>
        self.uses(sym, *e1) || self.uses(sym, *e2),
      Ternary(ref e1, ref e2, ref e3, _) =>
        self.uses(sym, *e1) || self.uses(sym, *e2) || self.uses(sym, *e3),
      Call(_, ref args, _) => args.any(|x| self.uses(sym, *x)),
      _ => false
    }
  }

  fn uses_opt(&self, sym: Ident, e: &Option<~Expression>) -> bool {
    match *e {
      None => false,
      Some(ref e) => self.uses(sym, *e)
    }
  }

  fn defines(&mut self, sym: Ident, s: &Statement) -> bool {
    match *s {
      Declare(id, _, Some(_), ref s) => sym == id || self.defines(sym, *s),
      Declare(_, _, _, ref s) => self.defines(sym, *s),
      Assign(~Var(id), _, _) |
        Assign(~Marked(mark::Mark{data: ~Var(id), _}), _, _) => id == sym,
      If(_, ref s1, ref s2) => self.defines(sym, *s1) && self.defines(sym, *s2),
      While(_, _) | Assign(_, _, _) | Nop | Express(_) => false,
      For(ref init, _, _, _) => self.defines(sym, *init),
      Break | Continue | Return(_) => true,
      Seq(ref s1, ref s2) => self.defines(sym, *s1) || self.defines(sym, *s2),
      Markeds(ref m) => self.defines(sym, m.data)
    }
  }
}
