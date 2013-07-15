use front::ast::*;
use front::mark;
use front::pp::PrettyPrintAST;

struct MainChecker<'self> {
  program: &'self Program,
}

pub fn check(p: &Program) {
  debug!("mainchecking");
  if !p.decls.iter().any(|x| ismain(p, *x)) {
    p.error(mark::dummy, "No main function was found");
  }
  p.check();
}

fn ismain(p: &Program, g: &GDecl) -> bool {
  match g.node {
    Function(ret, id, ref args, _) => {
      if id == p.mainid {
        if ret != @Int {
          p.error(g.span, fmt!("main should return int, not %s", ret.pp(p)));
        }
        if args.len() != 0 {
          p.error(g.span, "main should not take any arguments");
        }
      }
      id == p.mainid
    },
    _ => false
  }
}
