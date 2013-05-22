use core::hashmap::HashMap;
use core::cell;

use std::json::*;

use front::ast;
use front::mark;
use front::mark::{Coords, Mark, Marked};

pub struct SymbolGenerator {
  symbols: ~[~str],
  table: HashMap<~str, uint>,
}

struct PositionGenerator {
  table:     ~[Coords],
  positions: ~[Mark],
}

struct Parser<'self> {
  file:   @str,
  ismain: bool,
  symgen: &'self mut SymbolGenerator,
  posgen: &'self mut PositionGenerator,
}

pub fn from_json(j: &Json, main: ~str) -> ast::Program {
  let mut symgen = SymbolGenerator::new();
  let mut posgen = PositionGenerator { table: ~[], positions: ~[] };
  let mut decls = ~[];

  match *j {
    List(ref data) => {
      for data.each |&j| {
        match j {
          List([String(copy s), List(ref data)]) => {
            let mut parser = Parser{
              ismain: s == main,
              file:   s.to_managed(),
              symgen: &mut symgen,
              posgen: &mut posgen,
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
  let PositionGenerator{ table, _ } = posgen;
  return ast::Program::new(decls, symbols, table);
}

fn gettyp<'r>(j: &'r Json) -> (~str, &'r Object) {
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

fn to_opt<T>(j: &Json, f: &fn(&Json) -> T) -> Option<T> {
  let (typ, fields) = gettyp(j);
  match typ {
    ~"none" => None,
    ~"some" => Some(f(fields.get(&~"val"))),
    _       => fail!(fmt!("invalid extra: %?", typ))
  }
}

pub impl SymbolGenerator {
  fn new() -> SymbolGenerator {
    SymbolGenerator{ table: HashMap::new(), symbols: ~[] }
  }

  fn intern(&mut self, s: &~str) -> ast::Ident {
    let s = match self.table.find(s) {
      Some(&i) => { return ast::Ident(i) }
      None => copy *s
    };
    let ret = self.symbols.len();
    self.table.insert(copy s, ret);
    self.symbols.push(s);
    return ast::Ident(ret);
  }

  fn unwrap(self) -> ~[~str] {
    match self { SymbolGenerator{ symbols, _ } => symbols }
  }
}

impl PositionGenerator {
  fn generate(&mut self, pos: Coords) -> Mark {
    self.table.push(pos);
    return self.table.len() - 1;
  }

  fn mark<'r>(&mut self, o: &'r Object, file: @str) -> &'r Json {
    let left  = self.to_coord(o.get(&~"l"));
    let right = self.to_coord(o.get(&~"r"));
    let mark = self.generate(Coords((left, right), file));
    self.positions.push(mark);
    return o.get(&~"d")
  }

  fn pop(&mut self) {
    self.positions.pop();
  }

  fn cur(&self) -> Mark {
    if self.positions.len() == 0 {
      mark::dummy
    } else {
      *self.positions.last()
    }
  }

  fn to_coord(&self, j: &Json) -> (uint, uint) {
    match *j {
      List([Number(a), Number(b)]) => (a as uint, b as uint),
      _ => fail!(~"expected list with two pairs")
    }
  }
}

impl<'self> Parser<'self> {
  fn to_id(&mut self, j: &Json) -> ast::Ident {
    match *j {
      String(ref s) => self.symgen.intern(s),
      _ => fail!(~"not a string")
    }
  }

  fn to_gdecl(&mut self, j: &Json) -> ~ast::GDecl {
    let (typ, fields) = gettyp(j);
    let node = match typ {
      ~"typedef" => ast::Typedef(self.to_id(fields.get(&~"id")),
                                 self.to_typ(fields.get(&~"type"))),
      ~"fun"     => ast::Function(self.to_typ(fields.get(&~"ret")),
                                  self.to_id(fields.get(&~"name")),
                                  self.to_pairs(fields.get(&~"args")),
                                  self.to_stm(fields.get(&~"body"))),
      ~"intdecl" | ~"extdecl" => {
        let ret = self.to_typ(fields.get(&~"ret"));
        let name = self.to_id(fields.get(&~"name"));
        let args = self.to_pairs(fields.get(&~"args"));
        if self.ismain {
          ast::FunIDecl(ret, name, args)
        } else {
          ast::FunEDecl(ret, name, args)
        }
      }
      ~"struct"  => ast::StructDef(self.to_id(fields.get(&~"val")),
                                   self.to_pairs(fields.get(&~"fields"))),
      ~"strdecl" => ast::StructDecl(self.to_id(fields.get(&~"val"))),
      ~"mark"    => {
        let obj = self.posgen.mark(fields, self.file);
        let ret = self.to_gdecl(obj);
        self.posgen.pop();
        return ret;
      }
      _ => fail!(fmt!("Unknown gdecl type: %?", typ))
    };
    return ~Marked::new(node, self.posgen.cur());
  }

  fn to_pairs(&mut self, j: &Json) -> ~[(ast::Ident, @ast::Type)] {
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

  fn to_typ(&mut self, j: &Json) -> @ast::Type {
    let (typ, fields) = gettyp(j);
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

  fn to_stm(&mut self, j: &Json) -> ~ast::Statement {
    let (typ, fields) = gettyp(j);
    let stm = match typ {
      ~"if"       => ast::If(self.to_exp(fields.get(&~"cond")),
                             self.to_stm(fields.get(&~"true")),
                             self.to_stm(fields.get(&~"false"))),
      ~"while"    => ast::While(self.to_exp(fields.get(&~"cond")),
                                self.to_stm(fields.get(&~"body"))),
      ~"for"      => ast::For(self.to_stm(fields.get(&~"init")),
                              self.to_exp(fields.get(&~"cond")),
                              self.to_stm(fields.get(&~"step")),
                              self.to_stm(fields.get(&~"body"))),
      ~"continue" => ast::Continue,
      ~"break"    => ast::Break,
      ~"nop"      => ast::Nop,
      ~"seq"      => ast::Seq(self.to_stm(fields.get(&~"s1")),
                              self.to_stm(fields.get(&~"s2"))),
      ~"return"   => ast::Return(self.to_exp(fields.get(&~"exp"))),
      ~"express"  => ast::Express(self.to_exp(fields.get(&~"exp"))),
      ~"declare"  => ast::Declare(self.to_id(fields.get(&~"id")),
                                  self.to_typ(fields.get(&~"type")),
                                  to_opt(fields.get(&~"eopt"),
                                         |x| self.to_exp(x)),
                                  self.to_stm(fields.get(&~"rest"))),
      ~"assign"   => ast::Assign(self.to_exp(fields.get(&~"e1")),
                                 to_opt(fields.get(&~"extra"),
                                        |x| self.to_binop(x)),
                                 self.to_exp(fields.get(&~"e2"))),
      ~"mark"     => {
        let obj = self.posgen.mark(fields, self.file);
        let ret = self.to_stm(obj);
        self.posgen.pop();
        return ret;
      }
      _           => fail!(fmt!("invalid stm: %?", typ))
    };
    return ~Marked::new(stm, self.posgen.cur());
  }

  fn to_exp(&mut self, j: &Json) -> ~ast::Expression {
    let (typ, fields) = gettyp(j);
    let e = match typ {
      ~"var"      => ast::Var(self.to_id(fields.get(&~"var"))),
      ~"const"    => match *fields.get(&~"val") {
                       Number(f) => ast::Const(f as i32),
                       _         => fail!(~"expected number")
                     },
      ~"bool"     => match *fields.get(&~"val") {
                       Boolean(b) => ast::Boolean(b),
                       _          => fail!(~"expected boolean")
                     },
      ~"null"     => ast::Null,
      ~"deref"    => ast::Deref(self.to_exp(fields.get(&~"e")),
                                cell::empty_cell()),
      ~"field"    => ast::Field(self.to_exp(fields.get(&~"e")),
                                self.to_id(fields.get(&~"field")),
                                cell::empty_cell()),
      ~"arrsub"   => ast::ArrSub(self.to_exp(fields.get(&~"e1")),
                                 self.to_exp(fields.get(&~"e2")),
                                 cell::empty_cell()),
      ~"alloc"    => ast::Alloc(self.to_typ(fields.get(&~"type"))),
      ~"allocarr" => ast::AllocArray(self.to_typ(fields.get(&~"type")),
                                     self.to_exp(fields.get(&~"e"))),
      ~"binop"    => ast::BinaryOp(self.to_binop(fields.get(&~"oper")),
                                   self.to_exp(fields.get(&~"e1")),
                                   self.to_exp(fields.get(&~"e2"))),
      ~"unop"     => ast::UnaryOp(self.to_unop(fields.get(&~"unop")),
                                  self.to_exp(fields.get(&~"e"))),
      ~"ternary"  => ast::Ternary(self.to_exp(fields.get(&~"e1")),
                                  self.to_exp(fields.get(&~"e2")),
                                  self.to_exp(fields.get(&~"e3")),
                                  cell::empty_cell()),
      ~"mark"     => {
        let obj = self.posgen.mark(fields, self.file);
        let ret = self.to_exp(obj);
        self.posgen.pop();
        return ret;
      }
      ~"call"     => {
        match *fields.get(&~"args") {
          List(ref L) => ast::Call(self.to_exp(fields.get(&~"fun")),
                                   L.map(|x| self.to_exp(x)),
                                   cell::empty_cell()),
          _ => fail!(~"expected list")
        }
      },
      _ => fail!(fmt!("invalid exp: %?", typ))
    };
    return ~Marked::new(e, self.posgen.cur());
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
}
