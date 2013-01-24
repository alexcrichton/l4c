use front::error;
use front::ast::*;

struct MainChecker {
  err : error::List,
}

pub fn check(a : &Program) {
  let mut mc = MainChecker{ err: error::new() };
  debug!("mainchecking");
  mc.check(a);
  mc.err.check();
}

impl MainChecker {
  fn check(&mut self, a : &Program) {
    if !vec::any(a.decls, |x| self.ismain(*x)) {
      self.err.add(~"No main function was found");
    }
  }

  fn ismain(&mut self, g : @GDecl) -> bool {
    match g {
      @Markedg(ref m) => self.ismain(m.data),
      @Function(ret, id, ref args, _) => {
        if id.val == ~"main" {
          if ret != @Int {
            self.err.add(fmt!("main should return int, not %s", ret.pp()));
          }
          if args.len() != 0 {
            self.err.add(fmt!("main should not take any arguments"));
          }
        }
        id.val == ~"main"
      },
      _ => false
    }
  }
}
