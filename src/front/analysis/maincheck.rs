use front::ast::*;
use front::mark;
use front::pp::WithAST;

pub fn check(p: &Program) {
    debug!("mainchecking");
    if !p.decls.iter().any(|x| ismain(p, &**x)) {
        p.error(mark::dummy, "No main function was found");
    }
    p.check();
}

fn ismain(p: &Program, g: &GDecl) -> bool {
    match g.node {
        Function(ref ret, id, ref args, _) => {
            if id == p.mainid {
                if *ret != Int {
                    p.error(g.span, format!("main should return int, not {}",
                                            WithAST(ret, p)).as_slice());
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
