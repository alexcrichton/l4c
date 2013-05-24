use front::ast::*;

pub fn check(p: &Program) {
  debug!("returnchecking");
  for p.decls.each |x| {
    rc_gdecl(p, *x);
  }
  p.check();
}

fn rc_gdecl(p: &Program, g: &GDecl) {
  match g.node {
    Function(_, id, _, ref body) => {
      if !returns(*body) {
        p.error(g.span, fmt!("Function '%s' does not return", p.str(id)));
      }
    }
    _ => ()
  }
}

fn returns(s: &Statement) -> bool {
  match s.node {
    If(_, ref s1, ref s2)   => returns(*s1) && returns(*s2),
    Seq(ref s1, ref s2)     => returns(*s1) || returns(*s2),
    Declare(_, _, _, ref s) => returns(*s),
    Return(_)               => true,
    _                       => false
  }
}