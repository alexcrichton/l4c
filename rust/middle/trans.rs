use std::map;
use front::ast;

struct Translator {
  f : int
}

pub fn translate(p : &ast::Program) -> ir::Program {
  let t = Translator{f: 3};
  t.translate(p)
}

impl Translator {
  fn translate(p : &ast::Program) -> ir::Program {
    ignore(p);
    3
  }

  fn typ(t : @ast::Type) -> ir::Type {
    match t {
      @ast::Array(_) | @ast::Struct(_) | @ast::Pointer(_) => ir::Pointer,
      _ => ir::Int
    }
  }
}
