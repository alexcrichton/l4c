use front::error;
use front::ast::*;

struct MainChecker {
  program: &'self Program,
  err: error::List,
}

pub fn check(a: &Program) {
  let mut mc = MainChecker{ program: a, err: error::new() };
  debug!("mainchecking");
  mc.run();
}

impl MainChecker {
  fn run(&mut self) {
    if !vec::any(self.program.decls, |x| self.ismain(*x)) {
      self.err.add(~"No main function was found");
    }
    self.err.check();
  }

  fn ismain(&mut self, g: &GDecl) -> bool {
    match *g {
      Markedg(ref m) => self.ismain(m.data),
      Function(ret, id, ref args, _) => {
        if id == self.program.mainid {
          if ret != @Int {
            self.err.add(fmt!("main should return int, not %s",
                              ret.pp(self.program)));
          }
          if args.len() != 0 {
            self.err.add(fmt!("main should not take any arguments"));
          }
        }
        id == self.program.mainid
      },
      _ => false
    }
  }
}
