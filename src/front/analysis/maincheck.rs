use front::ast::{self, Item_, Type};
use utils::{Errors, DUMMY_MARK};

pub fn check(p: &ast::Program) {
    debug!("mainchecking");
    let errors = p.errors();
    if !p.decls.iter().any(|x| ismain(errors, x)) {
        errors.add(DUMMY_MARK, "No main function was found");
    }
    errors.check();
}

fn ismain(errors: &Errors, g: &ast::Item) -> bool {
    if let Item_::Function(ref ret, id, ref args, _) = g.node {
        if id == "main" {
            if *ret != Type::Int {
                errors.add(g.mark, &format!("main should return int, \
                                             not {}", ret));
            }
            if args.len() != 0 {
                errors.add(g.mark, "main should not take any arguments");
            }
            return true
        }
    }
    false
}
