use std::json;
use std::json::*;

pub fn from_str(s : ~str) -> ast::Program {
  match prof(~"parse json", || json::from_str(s)) {
    result::Ok(List(data)) => data.map(|x| to_gdecl(*x)),
    result::Ok(_) => fail(~"expected JSON list"),
    result::Err(e) => fail(fmt!("JSON parse error: %?", e.msg))
  }
}

fn gettyp(j : Json) -> (~str, ~Object) {
  match j {
    Object(obj) =>
      match obj.get(&~"typ") {
        String(s) => (s, obj),
        _ => fail(~"expected string key")
      },
    _ => fail(~"gdecl expects an object")
  }
}

fn to_id(j : Json) -> ast::Ident {
  match j { String(s) => s, _ => fail(~"not a string") }
}

fn to_mark<T>(o : ~Object, f : fn(j : Json) -> T) -> mark::Mark<@T> {
  let src   = to_id(o.get(&~"f"));
  let left  = to_coord(o.get(&~"l"));
  let right = to_coord(o.get(&~"r"));
  let data  = f(o.get(&~"d"));
  mark::make(@data, (left, right, src))
}

fn to_coord(j : Json) -> (int, int) {
  match j {
    List([Number(a), Number(b)]) => (a as int, b as int),
    _ => fail(~"expected list with two pairs")
  }
}

fn to_gdecl(j : Json) -> ast::GDecl {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"typedef" => ast::Typedef(to_id(fields.get(&~"id")),
                               to_typ(fields.get(&~"type"))),
    ~"mark"    => ast::Markedg(to_mark(fields, to_gdecl)),
    ~"fun"     => ast::Function(to_typ(fields.get(&~"ret")),
                                to_id(fields.get(&~"name")),
                                to_pairs(fields.get(&~"args")),
                                to_stm(fields.get(&~"body"))),
    ~"intdecl" => ast::FunIDecl(to_typ(fields.get(&~"ret")),
                                to_id(fields.get(&~"name")),
                                to_pairs(fields.get(&~"args"))),
    ~"extdecl" => ast::FunEDecl(to_typ(fields.get(&~"ret")),
                                to_id(fields.get(&~"name")),
                                to_pairs(fields.get(&~"args"))),
    ~"struct"  => ast::StructDef(to_id(fields.get(&~"val")),
                                 to_pairs(fields.get(&~"fields"))),
    ~"strdecl" => ast::StructDecl(to_id(fields.get(&~"val"))),
    _ => fail(fmt!("Unknown gdecl type: %?", typ))
  }
}

fn to_pairs(j : Json) -> ~[(ast::Ident, ast::Type)] {
  let L = match j { List(L) => L, _ => fail(~"expected list for arguments") };
  L.map(|x|
    match *x {
      Object(o) => (to_id(o.get(&~"name")), to_typ(o.get(&~"typ"))),
      _ => fail(~"expected object for each pair")
    }
  )
}

fn to_typ(j : Json) -> ast::Type {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"int"      => ast::Int,
    ~"bool"     => ast::Bool,
    ~"null"     => ast::Nullp,
    ~"typedef"  => ast::Alias(to_id(fields.get(&~"of"))),
    ~"struct"   => ast::Struct(to_id(fields.get(&~"id"))),
    ~"ptr"      => ast::Pointer(@to_typ(fields.get(&~"to"))),
    ~"array"    => ast::Array(@to_typ(fields.get(&~"of"))),
    _           => fail(~"invalid type")
  }
}

fn to_stm(j : Json) -> ast::Statement {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"if"       => ast::If(to_exp(fields.get(&~"cond")),
                           @to_stm(fields.get(&~"true")),
                           @to_stm(fields.get(&~"false"))),
    ~"while"    => ast::While(to_exp(fields.get(&~"cond")),
                              @to_stm(fields.get(&~"body"))),
    ~"for"      => ast::For(@to_stm(fields.get(&~"init")),
                            to_exp(fields.get(&~"cond")),
                            @to_stm(fields.get(&~"step")),
                            @to_stm(fields.get(&~"body"))),
    ~"continue" => ast::Continue,
    ~"break"    => ast::Break,
    ~"nop"      => ast::Nop,
    ~"seq"      => ast::Seq(@to_stm(fields.get(&~"s1")),
                            @to_stm(fields.get(&~"s2"))),
    ~"return"   => ast::Return(to_exp(fields.get(&~"exp"))),
    ~"express"  => ast::Express(to_exp(fields.get(&~"exp"))),
    ~"declare"  => ast::Declare(to_id(fields.get(&~"id")),
                                to_typ(fields.get(&~"type")),
                                @to_stm(fields.get(&~"rest"))),
    ~"mark"     => ast::Markeds(to_mark(fields, to_stm)),
    ~"assign"   => ast::Assign(to_exp(fields.get(&~"e1")),
                               to_extra(fields.get(&~"extra")),
                               to_exp(fields.get(&~"e2"))),
    _           => fail(fmt!("invalid stm: %?", typ))
  }
}

fn to_exp(j : Json) -> ast::Expression {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"var"      => ast::Var(to_id(fields.get(&~"var"))),
    ~"const"    => match fields.get(&~"val") {
                     Number(f) => ast::Const(f as i32),
                     _         => fail(~"expected number")
                   },
    ~"bool"     => match fields.get(&~"val") {
                     Boolean(b) => ast::Boolean(b),
                     _          => fail(~"expected boolean")
                   },
    ~"null"     => ast::Null,
    ~"deref"    => ast::Deref(@to_exp(fields.get(&~"e"))),
    ~"field"    => ast::Field(@to_exp(fields.get(&~"e")),
                              to_id(fields.get(&~"field"))),
    ~"arrsub"   => ast::ArrSub(@to_exp(fields.get(&~"e1")),
                               @to_exp(fields.get(&~"e2"))),
    ~"alloc"    => ast::Alloc(to_typ(fields.get(&~"type"))),
    ~"allocarr" => ast::AllocArray(to_typ(fields.get(&~"type")),
                                   @to_exp(fields.get(&~"e"))),
    ~"binop"    => ast::BinaryOp(to_binop(fields.get(&~"oper")),
                                 @to_exp(fields.get(&~"e1")),
                                 @to_exp(fields.get(&~"e2"))),
    ~"unop"     => ast::UnaryOp(to_unop(fields.get(&~"unop")),
                                @to_exp(fields.get(&~"e"))),
    ~"ternary"  => ast::Ternary(@to_exp(fields.get(&~"e1")),
                                @to_exp(fields.get(&~"e2")),
                                @to_exp(fields.get(&~"e3"))),
    ~"mark"     => ast::Marked(to_mark(fields, to_exp)),
    ~"call"     => match fields.get(&~"args") {
                     List(L) => ast::Call(to_id(fields.get(&~"fun")),
                                          L.map(|x| to_exp(*x))),
                     _       => fail(~"expected list")
                   },
    _ => fail(fmt!("invalid exp: %?", typ))
  }
}

fn to_binop(j : Json) -> ast::Binop {
  match j {
    String(~"+")  => ast::Plus,
    String(~"-")  => ast::Minus,
    String(~"/")  => ast::Divide,
    String(~"*")  => ast::Times,
    String(~"%")  => ast::Modulo,
    String(~"<")  => ast::Less,
    String(~"<=") => ast::LessEq,
    String(~">")  => ast::Greater,
    String(~">=") => ast::GreaterEq,
    String(~"==") => ast::Equals,
    String(~"!=") => ast::NEquals,
    String(~"&&") => ast::LAnd,
    String(~"||") => ast::LOr,
    String(~"&")  => ast::BAnd,
    String(~"|")  => ast::BOr,
    String(~"^")  => ast::Xor,
    String(~"<<") => ast::LShift,
    String(~">>") => ast::RShift,
    _ => fail(fmt!("invalid binop: %?", j))
  }
}

fn to_unop(j : Json) -> ast::Unop {
  match j {
    String(~"-")  => ast::Negative,
    String(~"~")  => ast::Invert,
    String(~"!")  => ast::Bang,
    _ => fail(fmt!("invalid unop: %?", j))
  }
}

fn to_extra(j : Json) -> Option<ast::Binop> {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"none" => None,
    ~"oper" => Some(to_binop(fields.get(&~"op"))),
    _       => fail(fmt!("invalid extra: %?", typ))
  }
}
