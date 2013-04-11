use core::hashmap::HashMap;
use std::json::*;

use front::{ast, mark};

struct SymbolGenerator {
  symbols: ~[~str],
  table: HashMap<~str, uint>,
}

struct Parser<'self> {
  file:  @~str,
  ismain: bool,
  symgen: &'self mut SymbolGenerator,
}

pub fn from_json(j: &Json, main: ~str) -> ast::Program {
  let mut symgen = SymbolGenerator { table: HashMap::new(), symbols: ~[] };
  let mut decls = ~[];

  match *j {
    List(ref data) => {
      for data.each |&j| {
        match j {
          List([String(copy s), List(ref data)]) => {
            let parser = Parser{
              ismain: s == main,
              file: @s,
              symgen: &mut symgen,
            };
            for data.each |j| {
              decls.push(parser.to_gdecl(j));
            }
          }
          _ => fail!(~"malformed json")
        }
      }
    }
    _ => fail!(~"expected object")
  }

  let SymbolGenerator{ symbols, _ } = symgen;
  return ast::Program::new(decls, symbols);
}

impl SymbolGenerator {
  fn intern(&mut self, s: &~str) -> ast::Ident {
    let s = match self.table.find(s) {
      Some(&i) => { return i }
      None => copy *s
    };
    let ret = self.symbols.len();
    self.table.insert(copy s, ret);
    self.symbols.push(s);
    return ret;
  }
}

impl<'self> Parser<'self> {
  fn gettyp<'r>(&self, j: &'r Json) -> (~str, &'r Object) {
    match *j {
      Object(ref obj) =>
        match *(obj.get(&~"typ")) {
          String(copy s) => {
            let o: &'r Object = *obj;
            (s, o)
          }
          _ => fail!(~"expected string key")
        },
      _ => fail!(~"gdecl expects an object")
    }
  }

  fn to_id(&self, j: &Json) -> ast::Ident {
    match *j {
      String(ref s) => self.symgen.intern(s),
      _ => fail!(~"not a string")
    }
  }

  fn to_mark<T>(&self, o: &Object, f: &fn(&Json) -> ~T) -> mark::Mark<T> {
    let left  = self.to_coord(o.get(&~"l"));
    let right = self.to_coord(o.get(&~"r"));
    let data  = f(o.get(&~"d"));
    mark::make(data, @mark::Coords(left, right, self.file))
  }

  fn to_coord(&self, j: &Json) -> (int, int) {
    match *j {
      List([Number(a), Number(b)]) => (a as int, b as int),
      _ => fail!(~"expected list with two pairs")
    }
  }

  fn to_gdecl(&self, j: &Json) -> ~ast::GDecl {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"typedef" => ~ast::Typedef(self.to_id(fields.get(&~"id")),
                                  self.to_typ(fields.get(&~"type"))),
      ~"mark"    => ~ast::Markedg(self.to_mark(fields, |a| self.to_gdecl(a))),
      ~"fun"     => ~ast::Function(self.to_typ(fields.get(&~"ret")),
                                   self.to_id(fields.get(&~"name")),
                                   self.to_pairs(fields.get(&~"args")),
                                   self.to_stm(fields.get(&~"body"))),
      ~"intdecl" | ~"extdecl" => {
        let ret = self.to_typ(fields.get(&~"ret"));
        let name = self.to_id(fields.get(&~"name"));
        let args = self.to_pairs(fields.get(&~"args"));
        if self.ismain {
          ~ast::FunIDecl(ret, name, args)
        } else {
          ~ast::FunEDecl(ret, name, args)
        }
      }
      ~"struct"  => ~ast::StructDef(self.to_id(fields.get(&~"val")),
                                    self.to_pairs(fields.get(&~"fields"))),
      ~"strdecl" => ~ast::StructDecl(self.to_id(fields.get(&~"val"))),
      _ => fail!(fmt!("Unknown gdecl type: %?", typ))
    }
  }

  fn to_pairs(&self, j: &Json) -> ~[(ast::Ident, @ast::Type)] {
    match *j {
      List(ref L) =>
        L.map(|x|
          match *x {
            Object(ref o) => (self.to_id(o.get(&~"name")),
                              self.to_typ(o.get(&~"typ"))),
            _ => fail!(~"expected object for each pair")
          }
        ),
      _ => fail!(~"expected list for arguments")
    }
  }

  fn to_typ(&self, j: &Json) -> @ast::Type {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"int"      => @ast::Int,
      ~"bool"     => @ast::Bool,
      ~"null"     => @ast::Nullp,
      ~"typedef"  => @ast::Alias(self.to_id(fields.get(&~"of"))),
      ~"struct"   => @ast::Struct(self.to_id(fields.get(&~"id"))),
      ~"ptr"      => @ast::Pointer(self.to_typ(fields.get(&~"to"))),
      ~"array"    => @ast::Array(self.to_typ(fields.get(&~"of"))),
      _           => fail!(~"invalid type")
    }
  }

  fn to_stm(&self, j: &Json) -> ~ast::Statement {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"if"       => ~ast::If(self.to_exp(fields.get(&~"cond")),
                              self.to_stm(fields.get(&~"true")),
                              self.to_stm(fields.get(&~"false"))),
      ~"while"    => ~ast::While(self.to_exp(fields.get(&~"cond")),
                                 self.to_stm(fields.get(&~"body"))),
      ~"for"      => ~ast::For(self.to_stm(fields.get(&~"init")),
                               self.to_exp(fields.get(&~"cond")),
                               self.to_stm(fields.get(&~"step")),
                               self.to_stm(fields.get(&~"body"))),
      ~"continue" => ~ast::Continue,
      ~"break"    => ~ast::Break,
      ~"nop"      => ~ast::Nop,
      ~"seq"      => ~ast::Seq(self.to_stm(fields.get(&~"s1")),
                               self.to_stm(fields.get(&~"s2"))),
      ~"return"   => ~ast::Return(self.to_exp(fields.get(&~"exp"))),
      ~"express"  => ~ast::Express(self.to_exp(fields.get(&~"exp"))),
      ~"declare"  => ~ast::Declare(self.to_id(fields.get(&~"id")),
                                   self.to_typ(fields.get(&~"type")),
                                   self.to_opt(fields.get(&~"eopt"),
                                               |x| self.to_exp(x)),
                                   self.to_stm(fields.get(&~"rest"))),
      ~"mark"     => ~ast::Markeds(self.to_mark(fields, |a| self.to_stm(a))),
      ~"assign"   => ~ast::Assign(self.to_exp(fields.get(&~"e1")),
                                  self.to_opt(fields.get(&~"extra"),
                                              |x| self.to_binop(x)),
                                  self.to_exp(fields.get(&~"e2"))),
      _           => fail!(fmt!("invalid stm: %?", typ))
    }
  }

  fn to_exp(&self, j: &Json) -> ~ast::Expression {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"var"      => ~ast::Var(self.to_id(fields.get(&~"var"))),
      ~"const"    => match *fields.get(&~"val") {
                       Number(f) => ~ast::Const(f as i32),
                       _         => fail!(~"expected number")
                     },
      ~"bool"     => match *fields.get(&~"val") {
                       Boolean(b) => ~ast::Boolean(b),
                       _          => fail!(~"expected boolean")
                     },
      ~"null"     => ~ast::Null,
      ~"deref"    => ~ast::Deref(self.to_exp(fields.get(&~"e")),
                                 ast::Ref()),
      ~"field"    => ~ast::Field(self.to_exp(fields.get(&~"e")),
                                 self.to_id(fields.get(&~"field")),
                                 ast::Ref()),
      ~"arrsub"   => ~ast::ArrSub(self.to_exp(fields.get(&~"e1")),
                                  self.to_exp(fields.get(&~"e2")),
                                  ast::Ref()),
      ~"alloc"    => ~ast::Alloc(self.to_typ(fields.get(&~"type"))),
      ~"allocarr" => ~ast::AllocArray(self.to_typ(fields.get(&~"type")),
                                      self.to_exp(fields.get(&~"e"))),
      ~"binop"    => ~ast::BinaryOp(self.to_binop(fields.get(&~"oper")),
                                    self.to_exp(fields.get(&~"e1")),
                                    self.to_exp(fields.get(&~"e2"))),
      ~"unop"     => ~ast::UnaryOp(self.to_unop(fields.get(&~"unop")),
                                   self.to_exp(fields.get(&~"e"))),
      ~"ternary"  => ~ast::Ternary(self.to_exp(fields.get(&~"e1")),
                                   self.to_exp(fields.get(&~"e2")),
                                   self.to_exp(fields.get(&~"e3")),
                                   ast::Ref()),
      ~"mark"     => ~ast::Marked(self.to_mark(fields, |a| self.to_exp(a))),
      ~"call"     => {
        match *fields.get(&~"args") {
          List(ref L) => ~ast::Call(self.to_exp(fields.get(&~"fun")),
                                    L.map(|x| self.to_exp(x)),
                                    ast::Ref()),
          _ => fail!(~"expected list")
        }
      },
      _ => fail!(fmt!("invalid exp: %?", typ))
    }
  }

  fn to_binop(&self, j: &Json) -> ast::Binop {
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
      _ => fail!(fmt!("invalid binop: %?", j))
    }
  }

  fn to_unop(&self, j: &Json) -> ast::Unop {
    match *j {
      String(~"-")  => ast::Negative,
      String(~"~")  => ast::Invert,
      String(~"!")  => ast::Bang,
      _ => fail!(fmt!("invalid unop: %?", j))
    }
  }

  fn to_opt<T>(&self, j: &Json, f: &fn(&Json) -> T) -> Option<T> {
    let (typ, fields) = self.gettyp(j);
    match typ {
      ~"none" => None,
      ~"some" => Some(f(fields.get(&~"val"))),
      _       => fail!(fmt!("invalid extra: %?", typ))
    }
  }
}
