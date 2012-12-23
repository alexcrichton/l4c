use std::json;
use std::json::*;

pub fn from_str(s : ~str) -> ast::Program {
  match prof(~"parse json", || json::from_str(s)) {
    result::Ok(List(data)) => data.map(|x| to_gdecl(x)),
    result::Ok(_) => fail(~"expected JSON list"),
    result::Err(e) => fail(fmt!("JSON parse error: %?", e.msg))
  }
}

fn gettyp(j : &L/Json) -> (~str, &L/~Object) {
  match *j {
    Object(ref obj) =>
      match *(obj.get_ref(&~"typ")) {
        String(copy s) => (s, obj),
        _ => fail(~"expected string key")
      },
    _ => fail(~"gdecl expects an object")
  }
}

fn to_id(j : &Json) -> ast::Ident {
  match *j { String(copy s) => s, _ => fail(~"not a string") }
}

fn to_mark<T>(o : &~Object, f : fn(j : &Json) -> T) -> mark::Mark<@T> {
  let src   = to_id(o.get_ref(&~"f"));
  let left  = to_coord(o.get_ref(&~"l"));
  let right = to_coord(o.get_ref(&~"r"));
  let data  = f(o.get_ref(&~"d"));
  mark::make(@data, (left, right, src))
}

fn to_coord(j : &Json) -> (int, int) {
  match *j {
    List([Number(a), Number(b)]) => (a as int, b as int),
    _ => fail(~"expected list with two pairs")
  }
}

fn to_gdecl(j : &Json) -> ast::GDecl {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"typedef" => ast::Typedef(to_id(fields.get_ref(&~"id")),
                               to_typ(fields.get_ref(&~"type"))),
    ~"mark"    => ast::Markedg(to_mark(fields, to_gdecl)),
    ~"fun"     => ast::Function(to_typ(fields.get_ref(&~"ret")),
                                to_id(fields.get_ref(&~"name")),
                                to_pairs(fields.get_ref(&~"args")),
                                to_stm(fields.get_ref(&~"body"))),
    ~"intdecl" => ast::FunIDecl(to_typ(fields.get_ref(&~"ret")),
                                to_id(fields.get_ref(&~"name")),
                                to_pairs(fields.get_ref(&~"args"))),
    ~"extdecl" => ast::FunEDecl(to_typ(fields.get_ref(&~"ret")),
                                to_id(fields.get_ref(&~"name")),
                                to_pairs(fields.get_ref(&~"args"))),
    ~"struct"  => ast::StructDef(to_id(fields.get_ref(&~"val")),
                                 to_pairs(fields.get_ref(&~"fields"))),
    ~"strdecl" => ast::StructDecl(to_id(fields.get_ref(&~"val"))),
    _ => fail(fmt!("Unknown gdecl type: %?", typ))
  }
}

fn to_pairs(j : &Json) -> ~[(ast::Ident, ast::Type)] {
  match *j {
    List(ref L) =>
      L.map(|x|
        match *x {
          Object(o) => (to_id(o.get_ref(&~"name")), to_typ(o.get_ref(&~"typ"))),
          _ => fail(~"expected object for each pair")
        }
      ),
    _ => fail(~"expected list for arguments")
  }
}

fn to_typ(j : &Json) -> ast::Type {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"int"      => ast::Int,
    ~"bool"     => ast::Bool,
    ~"null"     => ast::Nullp,
    ~"typedef"  => ast::Alias(to_id(fields.get_ref(&~"of"))),
    ~"struct"   => ast::Struct(to_id(fields.get_ref(&~"id"))),
    ~"ptr"      => ast::Pointer(@to_typ(fields.get_ref(&~"to"))),
    ~"array"    => ast::Array(@to_typ(fields.get_ref(&~"of"))),
    _           => fail(~"invalid type")
  }
}

fn to_stm(j : &Json) -> ast::Statement {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"if"       => ast::If(to_exp(fields.get_ref(&~"cond")),
                           @to_stm(fields.get_ref(&~"true")),
                           @to_stm(fields.get_ref(&~"false"))),
    ~"while"    => ast::While(to_exp(fields.get_ref(&~"cond")),
                              @to_stm(fields.get_ref(&~"body"))),
    ~"for"      => ast::For(@to_stm(fields.get_ref(&~"init")),
                            to_exp(fields.get_ref(&~"cond")),
                            @to_stm(fields.get_ref(&~"step")),
                            @to_stm(fields.get_ref(&~"body"))),
    ~"continue" => ast::Continue,
    ~"break"    => ast::Break,
    ~"nop"      => ast::Nop,
    ~"seq"      => ast::Seq(@to_stm(fields.get_ref(&~"s1")),
                            @to_stm(fields.get_ref(&~"s2"))),
    ~"return"   => ast::Return(to_exp(fields.get_ref(&~"exp"))),
    ~"express"  => ast::Express(to_exp(fields.get_ref(&~"exp"))),
    ~"declare"  => ast::Declare(to_id(fields.get_ref(&~"id")),
                                to_typ(fields.get_ref(&~"type")),
                                @to_stm(fields.get_ref(&~"rest"))),
    ~"mark"     => ast::Markeds(to_mark(fields, to_stm)),
    ~"assign"   => ast::Assign(to_exp(fields.get_ref(&~"e1")),
                               to_extra(fields.get_ref(&~"extra")),
                               to_exp(fields.get_ref(&~"e2"))),
    _           => fail(fmt!("invalid stm: %?", typ))
  }
}

fn to_exp(j : &Json) -> ast::Expression {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"var"      => ast::Var(to_id(fields.get_ref(&~"var"))),
    ~"const"    => match *fields.get_ref(&~"val") {
                     Number(f) => ast::Const(f as i32),
                     _         => fail(~"expected number")
                   },
    ~"bool"     => match *fields.get_ref(&~"val") {
                     Boolean(b) => ast::Boolean(b),
                     _          => fail(~"expected boolean")
                   },
    ~"null"     => ast::Null,
    ~"deref"    => ast::Deref(@to_exp(fields.get_ref(&~"e"))),
    ~"field"    => ast::Field(@to_exp(fields.get_ref(&~"e")),
                              to_id(fields.get_ref(&~"field"))),
    ~"arrsub"   => ast::ArrSub(@to_exp(fields.get_ref(&~"e1")),
                               @to_exp(fields.get_ref(&~"e2"))),
    ~"alloc"    => ast::Alloc(to_typ(fields.get_ref(&~"type"))),
    ~"allocarr" => ast::AllocArray(to_typ(fields.get_ref(&~"type")),
                                   @to_exp(fields.get_ref(&~"e"))),
    ~"binop"    => ast::BinaryOp(to_binop(fields.get_ref(&~"oper")),
                                 @to_exp(fields.get_ref(&~"e1")),
                                 @to_exp(fields.get_ref(&~"e2"))),
    ~"unop"     => ast::UnaryOp(to_unop(fields.get_ref(&~"unop")),
                                @to_exp(fields.get_ref(&~"e"))),
    ~"ternary"  => ast::Ternary(@to_exp(fields.get_ref(&~"e1")),
                                @to_exp(fields.get_ref(&~"e2")),
                                @to_exp(fields.get_ref(&~"e3"))),
    ~"mark"     => ast::Marked(to_mark(fields, to_exp)),
    ~"call"     => match *fields.get_ref(&~"args") {
                     List(ref L) => ast::Call(to_id(fields.get_ref(&~"fun")),
                                              L.map(|x| to_exp(x))),
                     _       => fail(~"expected list")
                   },
    _ => fail(fmt!("invalid exp: %?", typ))
  }
}

fn to_binop(j : &Json) -> ast::Binop {
  match *j {
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

fn to_unop(j : &Json) -> ast::Unop {
  match *j {
    String(~"-")  => ast::Negative,
    String(~"~")  => ast::Invert,
    String(~"!")  => ast::Bang,
    _ => fail(fmt!("invalid unop: %?", j))
  }
}

fn to_extra(j : &Json) -> Option<ast::Binop> {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"none" => None,
    ~"oper" => Some(to_binop(fields.get_ref(&~"op"))),
    _       => fail(fmt!("invalid extra: %?", typ))
  }
}
