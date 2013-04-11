use front::error;
use front::ast::*;

struct ReturnChecker {
  err: @mut error::List,
}

pub fn check(a: &Program) {
  let mut rc = ReturnChecker{ err: @mut error::new() };
  debug!("returnchecking");
  rc.check(a);
  rc.err.check();
}

impl ReturnChecker {
  fn check(&mut self, p: &Program) {
    for p.decls.each |x| {
      self.rc_gdecl(p, *x);
    }
  }

  fn rc_gdecl(&mut self, p: &Program, g: &GDecl) {
    match *g {
      Markedg(ref m) => self.err.with(m, |x| self.rc_gdecl(p, x)),
      Function(_, id, _, ref body) => {
        if !self.returns(*body) {
          self.err.add(fmt!("Function '%s' does not return", p.str(id)));
        }
      }
      _ => ()
    }
  }

  fn returns(&self, s: &Statement) -> bool {
    match *s {
      If(_, ref s1, ref s2)   => self.returns(*s1) && self.returns(*s2),
      Seq(ref s1, ref s2)     => self.returns(*s1) || self.returns(*s2),
      Declare(_, _, _, ref s) => self.returns(*s),
      Markeds(ref m)          => self.returns(m.data),
      Return(_)               => true,
      _                       => false
    }
  }
}
