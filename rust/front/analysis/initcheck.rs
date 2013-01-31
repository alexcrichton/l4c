use core::util::with;
use front::error;
use front::ast::*;

struct Initchecker {
  err: error::List,
  step: @Statement,
}

pub fn check(a: &Program) {
  let mut ic = Initchecker{ err: error::new(), step: @Nop };
  debug!("initchecking");
  ic.check(a);
  ic.err.check();
}

impl Initchecker {
  fn check(&mut self, a: &Program) {
    for a.decls.each |&x| {
      self.check_gdecl(x);
    }
  }

  fn check_gdecl(&mut self, g: @GDecl) {
    match g {
      @Markedg(ref m) => self.check_gdecl(m.data),
      @Function(_, _, _, body) => self.analyze(body),
      _ => ()
    }
  }

  fn analyze(&mut self, s: @Statement) {
    match s {
      @Markeds(ref m) => self.err.with(m, |x| self.analyze(x)),
      @If(_, s1, s2) | @Seq(s1, s2) => { self.analyze(s1); self.analyze(s2); },
      @While(_, s) => self.analyze(s),
      @Declare(id, _, None, s) =>
        if self.live(id, s) {
          self.err.add(fmt!("Uninitialized variable: '%s'", id.val));
        } else {
          self.analyze(s);
        },
      @Declare(_, _, _, s) => self.analyze(s),
      @For(_, _, _, body) => self.analyze(body),
      _ => ()
    }
  }

  fn live(&mut self, sym: Ident, s: @Statement) -> bool {
    match s {
      @Declare(id, _, init, s) =>
        id != sym && (self.live(sym, s) || self.uses_opt(sym, init)),
      @Assign(e1, Some(_), e2) => self.uses(sym, e1) || self.uses(sym, e2),
      @Assign(_, _, e2) => self.uses(sym, e2),
      @If(e, s1, s2) =>
        self.uses(sym, e) || self.live(sym, s1) || self.live(sym, s2),
      @While(e, s) => {
        do with(&mut self.step, @Nop) {
          self.uses(sym, e) || self.live(sym, s)
        }
      }
      @Break | @Nop => false,
      @Continue => self.live(sym, self.step),
      @Express(e) | @Return(e) => self.uses(sym, e),
      @Seq(s1, s2) =>
        self.live(sym, s1) || (self.live(sym, s2) && !self.defines(sym, s1)),
      @Markeds(ref m) => self.live(sym, m.data),
      @For(s1, e, s2, s3) => {
        do with(&mut self.step, s2) {
          self.live(sym, s1) ||
            ((self.uses(sym, e) || self.live(sym, @Seq(s3, s2))) &&
             !self.defines(sym, s1))
        }
      }
    }
  }

  pure fn uses(&self, sym: Ident, e: @Expression) -> bool {
    match e {
      @Marked(ref m) => self.uses(sym, m.data),
      @Var(id) => id == sym,
      @UnaryOp(_, e) | @Field(e, _, _) | @Deref(e, _) | @AllocArray(_, e) =>
        self.uses(sym, e),
      @BinaryOp(_, e1, e2) | @ArrSub(e1, e2, _) =>
        self.uses(sym, e1) || self.uses(sym, e2),
      @Ternary(e1, e2, e3, _) =>
        self.uses(sym, e1) || self.uses(sym, e2) || self.uses(sym, e3),
      @Call(_, ref args, _) => args.any(|x| self.uses(sym, *x)),
      _ => false
    }
  }

  pure fn uses_opt(&self, sym: Ident, e: Option<@Expression>) -> bool {
    match e {
      None => false,
      Some(e) => self.uses(sym, e)
    }
  }

  pure fn defines(&self, sym: Ident, s: @Statement) -> bool {
    match s {
      @Declare(id, _, Some(_), s) => sym == id || self.defines(sym, s),
      @Declare(_, _, _, s) => self.defines(sym, s),
      @Assign(@Marked(ref m), op, e2) =>
        self.defines(sym, @Assign(m.data, op, e2)),
      @Assign(@Var(id), _, _) => id == sym,
      @If(_, s1, s2) => self.defines(sym, s1) && self.defines(sym, s2),
      @While(_, _) | @Assign(_, _, _) | @Nop | @Express(_) => false,
      @For(init, _, _, _) => self.defines(sym, init),
      @Break | @Continue | @Return(_) => true,
      @Seq(s1, s2) => self.defines(sym, s1) || self.defines(sym, s2),
      @Markeds(ref m) => self.defines(sym, m.data)
    }
  }
}
