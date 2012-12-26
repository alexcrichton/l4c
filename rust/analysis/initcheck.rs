use ast::*;
use std::map;

struct Initchecker {
  err : ~error::List,
}

pub fn check(a : &Program) {
  let ic = Initchecker{ err: error::new() };
  ic.check(a);
  ic.err.check();
}

impl Initchecker {
  fn check(a : &Program) {
    ignore(a);
    /*for a.decls().each |x| {*/
    /*  self.ic_gdecl(*x)*/
    /*}*/
  }
}
