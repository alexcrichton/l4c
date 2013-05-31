use std::cell;
use std::cmp;
use std::hashmap::{HashSet, HashMap};
use std::io;
use std::libc;
use std::str;
use std::util;
use std::vec;

use front::mark;
use front::mark::Marked;
use utils::PrettyPrint;

pub struct Program {
  decls: ~[~GDecl],
  priv symbols: ~[~str],
  priv positions: ~[mark::Coords],
  priv errored: @mut bool,
  mainid: Ident,
}

struct Elaborator<'self> {
  efuns:   HashSet<Ident>,
  funs:    HashSet<Ident>,
  structs: HashSet<Ident>,
  types:   HashMap<Ident, @Type>,
  program: &'self mut Program,
}

#[deriving(IterBytes, Clone, Eq)]
pub struct Ident(uint);

pub type GDecl = Marked<gdecl>;

#[deriving(Eq)]
pub enum gdecl {
  Typedef(Ident, @Type),
  StructDef(Ident, ~[(Ident, @Type)]),
  StructDecl(Ident),
  Function(@Type, Ident, ~[(Ident, @Type)], ~Statement),
  FunIDecl(@Type, Ident, ~[(Ident, @Type)]),
  FunEDecl(@Type, Ident, ~[(Ident, @Type)])
}

pub type Statement = Marked<stmt>;

#[deriving(Eq)]
pub enum stmt {
  Assign(~Expression, Option<Binop>, ~Expression),
  If(~Expression, ~Statement, ~Statement),
  While(~Expression, ~Statement),
  For(~Statement, ~Expression, ~Statement, ~Statement),
  Express(~Expression),
  Continue,
  Break,
  Nop,
  Return(~Expression),
  Seq(~Statement, ~Statement),
  Declare(Ident, @Type, Option<~Expression>, ~Statement),
}

pub type Expression = Marked<expr>;

#[deriving(Eq)]
pub enum expr {
  Var(Ident),
  Boolean(bool),
  Const(i32),
  BinaryOp(Binop, ~Expression, ~Expression),
  UnaryOp(Unop, ~Expression),
  Ternary(~Expression, ~Expression, ~Expression, cell::Cell<@Type>),
  Call(~Expression, ~[~Expression], cell::Cell<(@Type)>),
  Deref(~Expression, cell::Cell<@Type>),
  Field(~Expression, Ident, cell::Cell<Ident>),
  ArrSub(~Expression, ~Expression, cell::Cell<@Type>),
  Alloc(@Type),
  AllocArray(@Type, ~Expression),
  Null,
}

pub enum Type {
  Int, Bool, Alias(Ident), Pointer(@Type), Array(@Type), Struct(Ident), Nullp,
  Fun(@Type, @~[@Type])
}

#[deriving(Eq)]
pub enum Binop {
  Plus, Minus, Times, Divide, Modulo, Less, LessEq, Greater, GreaterEq,
  Equals, NEquals, LAnd, LOr, BAnd, BOr, Xor, LShift, RShift
}

#[deriving(Eq)]
pub enum Unop {
  Negative, Invert, Bang
}

pub impl Program {
  fn new(decls: ~[~GDecl], mut syms: ~[~str], p: ~[mark::Coords]) -> Program {
    let main = &~"main";
    let mainid = match vec::position(syms, |s| s.eq(main)) {
      Some(i) => Ident(i),
      None => {
        syms.push(~"main");
        Ident(syms.len() - 1)
      }
    };
    Program{ decls: decls, symbols: syms, mainid: mainid, positions: p,
             errored: @mut false }
  }

  fn elaborate(&mut self) {
    let prev = util::replace(&mut self.decls, ~[]);
    let decls;
    {
      let mut e = Elaborator{ efuns:   HashSet::new(),
                              funs:    HashSet::new(),
                              structs: HashSet::new(),
                              types:   HashMap::new(),
                              program: self };
      decls = e.run(prev);
    }
    self.decls = decls;
  }

  fn str(&self, id: Ident) -> ~str {
    copy self.symbols[*id]
  }

  fn error(&self, m: mark::Mark, msg: &str) {
    let out = io::stderr();
    if m == mark::dummy {
      out.write_str(fmt!("error: %s\n", msg));
    } else {
      match self.positions[m] {
        mark::Coords(((l1, c1), (l2, c2)), file) => {
          out.write_str(fmt!("%s:%u.%u-%u.%u:error: %s\n", file, l1, c1, l2,
                             c2, msg));
        }
      }
    }
    *self.errored = true;
  }

  fn die(&self, m: mark::Mark, msg: &str) -> ! {
    self.error(m, msg);
    unsafe { libc::exit(1); }
  }

  fn check(&self) {
    if *self.errored {
      unsafe { libc::exit(1); }
    }
  }
}

impl Eq for Program {
  fn eq(&self, other: &Program) -> bool { self.decls == other.decls }
  fn ne(&self, other: &Program) -> bool { !self.eq(other) }
}

impl PrettyPrint for Program {
  fn pp(&self) -> ~str {
    use front::pp::PrettyPrintAST;
    str::connect(self.decls.map(|d| d.pp(self)), "\n")
  }
}

impl<'self> Elaborator<'self> {
  fn run(&mut self, decls: ~[~GDecl]) -> ~[~GDecl] {
    let decls = vec::map_consume(decls, |x| self.elaborate(x));
    self.program.check();
    return decls;
  }
  fn elaborate(&mut self, g: ~GDecl) -> ~GDecl {
    /* TODO(#4653): in this macro, it should be $id instead of 'id' */
    macro_rules! check_set (
      ($set:expr, $id:expr, $name:expr) => {
        if $set.contains(&id) {
          self.program.error(span, fmt!("'%s' already a %s",
                                        self.program.str(id), $name));
        }
      }
    );
    let span = g.span;
    let node = match g.unwrap() {
      FunEDecl(typ, id, args) => {
        self.check_id(span, id);
        self.efuns.insert(id);
        FunEDecl(self.resolve(span, typ), id, self.resolve_pairs(span, args))
      }
      FunIDecl(typ, id, args) => {
        self.check_id(span, id);
        FunIDecl(self.resolve(span, typ), id, self.resolve_pairs(span, args))
      }
      Typedef(id, typ) => {
        self.check_id(span, id);
        check_set!(self.efuns, *id, "function");
        check_set!(self.efuns, *id, "function");
        check_set!(self.funs, *id, "function");
        let typ = self.resolve(span, typ);
        self.types.insert(id, typ);
        Typedef(id, typ)
      }
      StructDef(id, fields) => {
        check_set!(self.structs, id, "struct");
        self.structs.insert(id);
        StructDef(id, self.resolve_pairs(span, fields))
      }
      Function(ret, id, args, body) => {
        self.check_id(span, id);
        check_set!(self.efuns, id, "function");
        check_set!(self.funs, id, "function");
        self.funs.insert(id);
        Function(self.resolve(span, ret), id, self.resolve_pairs(span, args),
                  self.elaborate_stm(body))
      }
      StructDecl(id) => StructDecl(id),
    };
    return ~Marked::new(node, span);
  }

  fn elaborate_stm(&mut self, s: ~Statement) -> ~Statement {
    let span = s.span;
    let node = match s.unwrap() {
      Continue => Continue,
      Break => Break,
      Nop => Nop,
      Declare(id, typ, init, rest) => {
        let rest = self.elaborate_stm(rest);
        self.declare(id, span, typ, init, rest)
      }
      For(~Marked{ node: Declare(id, typ, init, s1), span: dspan},
          e1, s2, s3) =>
      {
        let f = ~Marked::new(For(s1, e1, s2, s3), span);
        let d = ~Marked::new(Declare(id, typ, init, f), dspan);
        return self.elaborate_stm(d);
      }
      For(s1, e1, s2, s3) => {
        match s2 {
          ~Marked{ node: Declare(*), span } => {
            self.program.error(span, "declarations not allowed in for-loop steps")
          }
          _ => {}
        }
        For(self.elaborate_stm(s1), self.elaborate_exp(e1),
            self.elaborate_stm(s2), self.elaborate_stm(s3))
      }
      If(e, s1, s2) =>
        If(self.elaborate_exp(e), self.elaborate_stm(s1),
           self.elaborate_stm(s2)),
      While(e, s) => While(self.elaborate_exp(e), self.elaborate_stm(s)),
      Return(e) => Return(self.elaborate_exp(e)),
      Express(e) => Express(self.elaborate_exp(e)),
      Seq(s1, s2) => Seq(self.elaborate_stm(s1), self.elaborate_stm(s2)),
      Assign(~Marked{ node: Var(id), span: e1span }, Some(o), e2) => {
        let e2span = e2.span;
        let v = ~Marked::new(Var(id), e1span);
        let b = ~Marked::new(BinaryOp(o, copy v, e2), e2span);
        let e = ~Marked::new(Assign(v, None, b), span);
        return self.elaborate_stm(e);
      }
      Assign(e1, o, e2) =>
        Assign(self.elaborate_exp(e1), o, self.elaborate_exp(e2)),
    };
    return ~Marked::new(node, span);
  }

  fn declare(&mut self, id: Ident, m: mark::Mark, typ: @Type,
             init: Option<~Expression>, rest: ~Statement) -> stmt {
    self.check_id(m, id);
    Declare(id, self.resolve(m, typ),
            init.map_consume(|x| self.elaborate_exp(x)), rest)
  }

  fn elaborate_exp(&mut self, e: ~Expression) -> ~Expression {
    let span = e.span;
    let node = match e.unwrap() {
      Var(id) => Var(id),
      Boolean(b) => Boolean(b),
      Const(c) => Const(c),
      Null => Null,
      UnaryOp(o, e) =>
        UnaryOp(o, self.elaborate_exp(e)),
      BinaryOp(o, e1, e2) =>
        BinaryOp(o, self.elaborate_exp(e1), self.elaborate_exp(e2)),
      Ternary(e1, e2, e3, _) =>
        Ternary(self.elaborate_exp(e1), self.elaborate_exp(e2),
                self.elaborate_exp(e3), cell::empty_cell()),
      Call(id, L, _) =>
        Call(id, vec::map_consume(L, |x| self.elaborate_exp(x)),
             cell::empty_cell()),
      Deref(e, _) => Deref(self.elaborate_exp(e),
                           cell::empty_cell()),
      Field(e, id, _) => Field(self.elaborate_exp(e), id, cell::empty_cell()),
      ArrSub(e1, e2, _) =>
        ArrSub(self.elaborate_exp(e1), self.elaborate_exp(e2),
               cell::empty_cell()),
      Alloc(t) => Alloc(self.resolve(span, t)),
      AllocArray(t, e) => AllocArray(self.resolve(span, t),
                                     self.elaborate_exp(e))
    };
    return ~Marked::new(node, span);
  }

  fn check_id(&mut self, m: mark::Mark, s: Ident) {
    if self.types.contains_key(&s) {
      self.program.error(m, fmt!("'%s' already a type", self.program.str(s)));
    }
  }

  fn resolve(&mut self, m: mark::Mark, t: @Type) -> @Type {
    match t {
      @Int | @Bool | @Nullp | @Struct(_) => t,
      @Pointer(t) => @Pointer(self.resolve(m, t)),
      @Array(t) => @Array(self.resolve(m, t)),
      @Alias(sym) =>
        match self.types.find(&sym) {
          Some(&t) => t,
          None    => {
            self.program.error(m, fmt!("'%s' is undefined",
                                       self.program.str(sym)));
            t
          }
        },
      @Fun(t1, L) => @Fun(self.resolve(m, t1), @L.map(|&t| self.resolve(m, t)))
    }
  }

  fn resolve_pairs(&mut self, m: mark::Mark,
                   pairs: ~[(Ident, @Type)]) -> ~[(Ident, @Type)] {
    vec::map_consume(pairs, |(id, typ)| (id, self.resolve(m, typ)))
  }
}

impl expr {
  fn lvalue(&self) -> bool {
    match *self {
      Var(_)              => true,
      Field(ref e, _, _)  => e.node.lvalue(),
      Deref(ref e, _)     => e.node.lvalue(),
      ArrSub(ref e, _, _) => e.node.lvalue(),
      _                   => false
    }
  }
}

impl Type {
  fn small(&self) -> bool {
    match *self {
      Struct(_) => false,
      _ => true
    }
  }
}

impl cmp::Eq for Type {
  fn eq(&self, other: &Type) -> bool {
    match (self, other) {
      (&Bool, &Bool) | (&Int, &Int) | (&Nullp, &Nullp) => true,
      (&Nullp, &Pointer(_)) | (&Pointer(_), &Nullp) => true,
      (&Pointer(ref t1), &Pointer(ref t2)) => t1.eq(t2),
      (&Array(ref t1), &Array(ref t2)) => t1.eq(t2),
      (&Struct(ref s1), &Struct(ref s2)) => s1.eq(s2),
      (&Fun(t1, L1), &Fun(t2, L2)) =>
        t1 == t2 && L1.len() == L2.len() && vec::all2(*L1, *L2, |a, b| a == b),
      _ => false
    }
  }

  fn ne(&self, other: &Type) -> bool { !self.eq(other) }
}
