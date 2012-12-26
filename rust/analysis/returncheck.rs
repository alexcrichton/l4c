use ast::*;

struct ReturnChecker {
  err : ~error::List,
}

pub fn check(a : &Program) {
  let rc = ReturnChecker{ err: error::new() };
  rc.check(a);
  rc.err.check();
}

impl ReturnChecker {
  fn check(a : &Program) {
    for a.decls.each |x| {
      self.rc_gdecl(*x);
    }
  }

  fn rc_gdecl(g : @GDecl) {
    match g {
      @Markedg(ref m) => self.err.with(m, |x| self.rc_gdecl(x)),
      @Function(_, id, _, body) => {
        if !self.returns(body) {
          self.err.add(fmt!("Function '%s' does not return", id.val));
        }
      }
      _ => ()
    }
  }

  pure fn returns(s : @Statement) -> bool {
    match s {
      @If(_, s1, s2)    => self.returns(s1) && self.returns(s2),
      @Seq(s1, s2)      => self.returns(s1) || self.returns(s2),
      @Declare(_, _, s) => self.returns(s),
      @Markeds(ref m)   => self.returns(m.data),
      @Return(_)        => true,
      _                 => false
    }
  }
}
