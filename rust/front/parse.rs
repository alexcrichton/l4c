use std::json;
use std::json::*;

struct Parser {
  syms : symbol::Symtab
}

pub fn from_str(s : ~str) -> ast::Program {
  let parser = Parser{syms: symbol::Symtab()};
  match json::from_str(s) {
    result::Ok(j) => parser.parse(j),
    result::Err(e) => fail(fmt!("JSON parse error: %?", e.msg))
  }
}

impl Parser {
  fn parse(j : Json) -> ast::Program {
    match j {
      List(data) => ast::new(data.map(|x| self.to_gdecl(x))),
      _          => fail(~"expected JSON list")
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
    match *j {
      String(copy s) => symbol::new(self.syms, s),
      _ => fail(~"not a string")
    }
  }

  fn to_mark<T>(o : &~Object, f : fn(j : &Json) -> @T) -> ~mark::Mark<T> {
    let src   = match *o.get_ref(&~"f") {
                  String(copy s) => s,
                  _ => fail(~"expected string for file")
                };
    let left  = self.to_coord(o.get_ref(&~"l"));
    let right = self.to_coord(o.get_ref(&~"r"));
    let data  = f(o.get_ref(&~"d"));
    mark::make(data, @mark::Coords(left, right, src))
  }

  fn to_coord(j : &Json) -> (int, int) {
    match *j {
      List([Number(a), Number(b)]) => (a as int, b as int),
      _ => fail(~"expected list with two pairs")
    }
  }

  fn to_gdecl(j : &Json) -> @ast::GDecl {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"typedef" => @ast::Typedef(self.to_id(fields.get_ref(&~"id")),
                                  self.to_typ(fields.get_ref(&~"type"))),
      ~"mark"    => @ast::Markedg(self.to_mark(fields, |a| self.to_gdecl(a))),
      ~"fun"     => @ast::Function(self.to_typ(fields.get_ref(&~"ret")),
                                   self.to_id(fields.get_ref(&~"name")),
                                   self.to_pairs(fields.get_ref(&~"args")),
                                   self.to_stm(fields.get_ref(&~"body"))),
      ~"intdecl" => @ast::FunIDecl(self.to_typ(fields.get_ref(&~"ret")),
                                   self.to_id(fields.get_ref(&~"name")),
                                   self.to_pairs(fields.get_ref(&~"args"))),
      ~"extdecl" => @ast::FunEDecl(self.to_typ(fields.get_ref(&~"ret")),
                                   self.to_id(fields.get_ref(&~"name")),
                                   self.to_pairs(fields.get_ref(&~"args"))),
      ~"struct"  => @ast::StructDef(self.to_id(fields.get_ref(&~"val")),
                                    self.to_pairs(fields.get_ref(&~"fields"))),
      ~"strdecl" => @ast::StructDecl(self.to_id(fields.get_ref(&~"val"))),
      _ => fail(fmt!("Unknown gdecl type: %?", typ))
    }
  }

  fn to_pairs(j : &Json) -> ~[(ast::Ident, @ast::Type)] {
    match *j {
      List(ref L) =>
        L.map(|x|
          match *x {
            Object(o) => (self.to_id(o.get_ref(&~"name")),
                          self.to_typ(o.get_ref(&~"typ"))),
            _ => fail(~"expected object for each pair")
          }
        ),
      _ => fail(~"expected list for arguments")
    }
  }

  fn to_typ(j : &Json) -> @ast::Type {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"int"      => @ast::Int,
      ~"bool"     => @ast::Bool,
      ~"null"     => @ast::Nullp,
      ~"typedef"  => @ast::Alias(self.to_id(fields.get_ref(&~"of"))),
      ~"struct"   => @ast::Struct(self.to_id(fields.get_ref(&~"id"))),
      ~"ptr"      => @ast::Pointer(self.to_typ(fields.get_ref(&~"to"))),
      ~"array"    => @ast::Array(self.to_typ(fields.get_ref(&~"of"))),
      _           => fail(~"invalid type")
    }
  }

  fn to_stm(j : &Json) -> @ast::Statement {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"if"       => @ast::If(self.to_exp(fields.get_ref(&~"cond")),
                              self.to_stm(fields.get_ref(&~"true")),
                              self.to_stm(fields.get_ref(&~"false"))),
      ~"while"    => @ast::While(self.to_exp(fields.get_ref(&~"cond")),
                                 self.to_stm(fields.get_ref(&~"body"))),
      ~"for"      => @ast::For(self.to_stm(fields.get_ref(&~"init")),
                               self.to_exp(fields.get_ref(&~"cond")),
                               self.to_stm(fields.get_ref(&~"step")),
                               self.to_stm(fields.get_ref(&~"body"))),
      ~"continue" => @ast::Continue,
      ~"break"    => @ast::Break,
      ~"nop"      => @ast::Nop,
      ~"seq"      => @ast::Seq(self.to_stm(fields.get_ref(&~"s1")),
                               self.to_stm(fields.get_ref(&~"s2"))),
      ~"return"   => @ast::Return(self.to_exp(fields.get_ref(&~"exp"))),
      ~"express"  => @ast::Express(self.to_exp(fields.get_ref(&~"exp"))),
      ~"declare"  => @ast::Declare(self.to_id(fields.get_ref(&~"id")),
                                   self.to_typ(fields.get_ref(&~"type")),
                                   self.to_stm(fields.get_ref(&~"rest"))),
      ~"mark"     => @ast::Markeds(self.to_mark(fields, |a| self.to_stm(a))),
      ~"assign"   => @ast::Assign(self.to_exp(fields.get_ref(&~"e1")),
                                  self.to_extra(fields.get_ref(&~"extra")),
                                  self.to_exp(fields.get_ref(&~"e2"))),
      _           => fail(fmt!("invalid stm: %?", typ))
    }
  }

  fn to_exp(j : &Json) -> @ast::Expression {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"var"      => @ast::Var(self.to_id(fields.get_ref(&~"var"))),
      ~"const"    => match *fields.get_ref(&~"val") {
                       Number(f) => @ast::Const(f as i32),
                       _         => fail(~"expected number")
                     },
      ~"bool"     => match *fields.get_ref(&~"val") {
                       Boolean(b) => @ast::Boolean(b),
                       _          => fail(~"expected boolean")
                     },
      ~"null"     => @ast::Null,
      ~"deref"    => @ast::Deref(self.to_exp(fields.get_ref(&~"e"))),
      ~"field"    => @ast::Field(self.to_exp(fields.get_ref(&~"e")),
                                 self.to_id(fields.get_ref(&~"field"))),
      ~"arrsub"   => @ast::ArrSub(self.to_exp(fields.get_ref(&~"e1")),
                                  self.to_exp(fields.get_ref(&~"e2"))),
      ~"alloc"    => @ast::Alloc(self.to_typ(fields.get_ref(&~"type"))),
      ~"allocarr" => @ast::AllocArray(self.to_typ(fields.get_ref(&~"type")),
                                      self.to_exp(fields.get_ref(&~"e"))),
      ~"binop"    => @ast::BinaryOp(self.to_binop(fields.get_ref(&~"oper")),
                                    self.to_exp(fields.get_ref(&~"e1")),
                                    self.to_exp(fields.get_ref(&~"e2"))),
      ~"unop"     => @ast::UnaryOp(self.to_unop(fields.get_ref(&~"unop")),
                                   self.to_exp(fields.get_ref(&~"e"))),
      ~"ternary"  => @ast::Ternary(self.to_exp(fields.get_ref(&~"e1")),
                                   self.to_exp(fields.get_ref(&~"e2")),
                                   self.to_exp(fields.get_ref(&~"e3"))),
      ~"mark"     => @ast::Marked(self.to_mark(fields, |a| self.to_exp(a))),
      ~"call"     => {
        match *fields.get_ref(&~"args") {
          List(ref L) => @ast::Call(self.to_id(fields.get_ref(&~"fun")),
              L.map(|x| self.to_exp(x))),
          _       => fail(~"expected list")
        }
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
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"none" => None,
      ~"oper" => Some(self.to_binop(fields.get_ref(&~"op"))),
      _       => fail(fmt!("invalid extra: %?", typ))
    }
  }
}
