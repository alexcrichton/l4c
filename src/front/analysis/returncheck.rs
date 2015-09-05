use front::ast::{self, Item_, Stmt_};

pub fn check(p: &ast::Program) {
    debug!("returnchecking");
    for x in p.decls.iter() {
        rc_item(p, x);
    }
    p.errors().check();
}

fn rc_item(p: &ast::Program, g: &ast::Item) {
    if let Item_::Function(_, id, _, ref body) = g.node {
        if !returns(body) {
            p.errors().add(g.mark, &format!("Function '{}' does not return", id));
        }
    }
}

fn returns(s: &ast::Stmt) -> bool {
    match s.node {
        Stmt_::If(_, ref s1, ref s2)   => returns(s1) && returns(s2),
        Stmt_::Seq(ref s1, ref s2)     => returns(s1) || returns(s2),
        Stmt_::Declare(_, _, _, ref s) => returns(s),
        Stmt_::Return(_) => true,
        _ => false
    }
}
