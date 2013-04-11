use core::hashmap::{HashSet, HashMap};
use front::{mark, error};
use utils::PrettyPrint;

pub struct Program {
  decls: ~[~GDecl],
  priv symbols: ~[~str],
  mainid: Ident,
}

struct Elaborator {
  efuns:   HashSet<Ident>,
  funs:    HashSet<Ident>,
  structs: HashSet<Ident>,
  types:   HashMap<Ident, @Type>,
  err:     @mut error::List,
  symbols: ~[~str]
}

pub type Ident = uint;

pub enum GDecl {
  Markedg(mark::Mark<GDecl>),
  Typedef(Ident, @Type),
  StructDef(Ident, ~[(Ident, @Type)]),
  StructDecl(Ident),
  Function(@Type, Ident, ~[(Ident, @Type)], ~Statement),
  FunIDecl(@Type, Ident, ~[(Ident, @Type)]),
  FunEDecl(@Type, Ident, ~[(Ident, @Type)])
}

pub enum Statement {
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
  Markeds(mark::Mark<Statement>)
}

pub enum Expression {
  Var(Ident),
  Boolean(bool),
  Const(i32),
  BinaryOp(Binop, ~Expression, ~Expression),
  UnaryOp(Unop, ~Expression),
  Ternary(~Expression, ~Expression, ~Expression, Ref<@Type>),
  Call(~Expression, ~[~Expression], Ref<(@Type)>),
  Deref(~Expression, Ref<@Type>),
  Field(~Expression, Ident, Ref<Ident>),
  ArrSub(~Expression, ~Expression, Ref<@Type>),
  Alloc(@Type),
  AllocArray(@Type, ~Expression),
  Null,
  Marked(mark::Mark<Expression>)
}

pub enum Type {
  Int, Bool, Alias(Ident), Pointer(@Type), Array(@Type), Struct(Ident), Nullp,
  Fun(@Type, @~[@Type])
}

pub enum Binop {
  Plus, Minus, Times, Divide, Modulo, Less, LessEq, Greater, GreaterEq,
  Equals, NEquals, LAnd, LOr, BAnd, BOr, Xor, LShift, RShift
}

pub enum Unop {
  Negative, Invert, Bang
}

pub struct Ref<T> {
  mut val: Option<T>
}

pub fn Ref<T>() -> Ref<T> {
  Ref{ val: None }
}

pub impl<T: Copy> Ref<T> {
  pub fn set(&self, t: T) {
    self.val = Some(t);
  }

  fn get(&self) -> T {
    self.val.get()
  }
}

pub impl Program {
  fn new(decls: ~[~GDecl], mut syms: ~[~str]) -> Program {
    let main = &~"main";
    let mainid = match vec::position(syms, |s| s.eq(main)) {
      Some(i) => i,
      None => {
        syms.push(~"main");
        syms.len() - 1
      }
    };
    Program{ decls: decls, symbols: syms, mainid: mainid }
  }

  fn elaborate(self) -> Program {
    let Program{decls, symbols, _} = self;
    let mut decls = decls;
    {
      let mut e = Elaborator{ efuns:   HashSet::new(),
                              funs:    HashSet::new(),
                              structs: HashSet::new(),
                              types:   HashMap::new(),
                              err:     @mut error::new(),
                              symbols: copy symbols };
      decls = e.run(decls);
    }
    Program::new(decls, symbols)
  }

  fn str(&self, id: Ident) -> ~str {
    copy self.symbols[id]
  }
}

impl PrettyPrint for Program {
  fn pp(&self) -> ~str {
    str::connect(self.decls.map(|d| d.pp(self)), "\n")
  }
}

/* TODO(#4355): this used to cause a segfault */
/*impl GDecl {*/
/*  fn unmark(~self) -> ~GDecl {*/
/*    match self {*/
/*      ~Markedg(mark::Mark{data, _}) => data,*/
/*      g => g*/
/*    }*/
/*  }*/
/*}*/

pub fn unmarkg(g: ~GDecl) -> ~GDecl {
  match g {
    ~Markedg(mark::Mark{data, _}) => data,
    g => g
  }
}

impl Elaborator {
  fn run(&mut self, decls: ~[~GDecl]) -> ~[~GDecl] {
    let decls = vec::map_consume(decls, |x| self.elaborate(x));
    self.err.check();
    return decls;
  }
  fn elaborate(&mut self, g: ~GDecl) -> ~GDecl {
    /* TODO(#4653): in this macro, it should be $id instead of 'id' */
    macro_rules! check_set (
      ($set:expr, $id:expr, $name:expr) => {
        if $set.contains(&id) {
          self.err.add(fmt!("'%s' already a %s", self.symbols[id], $name));
        }
      }
    );
    match g {
      ~FunEDecl(typ, id, args) => {
        self.check_id(id);
        self.efuns.insert(id);
        ~FunEDecl(self.resolve(typ), id, self.resolve_pairs(args))
      }
      ~FunIDecl(typ, id, args) => {
        self.check_id(id);
        ~FunIDecl(self.resolve(typ), id, self.resolve_pairs(args))
      }
      ~Markedg(mark) =>
        ~Markedg(self.err.map_mark(mark, |g| self.elaborate(g))),
      ~Typedef(id, typ) => {
        self.check_id(id);
        check_set!(self.efuns, *id, ~"function");
        check_set!(self.efuns, *id, ~"function");
        check_set!(self.funs, *id, ~"function");
        let typ = self.resolve(typ);
        self.types.insert(id, typ);
        ~Typedef(id, typ) /* TODO: shouldn't have to re-build */
      }
      ~StructDef(id, fields) => {
        check_set!(self.structs, id, ~"struct");
        self.structs.insert(id);
        ~StructDef(id, self.resolve_pairs(fields))
      }
      ~Function(ret, id, args, body) => {
        self.check_id(id);
        check_set!(self.efuns, id, ~"function");
        check_set!(self.funs, id, ~"function");
        self.funs.insert(id);
        ~Function(self.resolve(ret), id, self.resolve_pairs(args),
                  self.elaborate_stm(body))
      }
      /* TODO: shouldn't have to re-build */
      ~StructDecl(id) => ~StructDecl(id),
    }
  }

  fn elaborate_stm(&mut self, s: ~Statement) -> ~Statement {
    macro_rules! declare(
      ($id:expr, $typ:expr, $init:expr, $rest:expr) => ({
        self.check_id($id);
        ~Declare($id, self.resolve($typ),
                 $init.map_consume(|x| self.elaborate_exp(x)), $rest)
      })
    );
    match s {
      ~Markeds(mark) =>
        ~Markeds(self.err.map_mark(mark, |s| self.elaborate_stm(s))),
      /* TODO: shouldn't have to rebuild these structures */
      ~Continue => ~Continue,
      ~Break => ~Break,
      ~Nop => ~Nop,
      ~Declare(id, typ, init, rest) =>
        declare!(id, typ, init, self.elaborate_stm(rest)),
      ~For(~Declare(id, typ, init, s1), e1, s2, s3) =>
        self.elaborate_stm(~Declare(id, typ, init, ~For(s1, e1, s2, s3))),
      ~For(~Markeds(mark::Mark{data, _}), e1, s2, s3) =>
        self.elaborate_stm(~For(data, e1, s2, s3)),
      ~For(s1, e1, s2, s3) =>
        ~For(self.elaborate_stm(s1), self.elaborate_exp(e1),
             self.elaborate_stm(s2), self.elaborate_stm(s3)),
      ~If(e, s1, s2) =>
        ~If(self.elaborate_exp(e), self.elaborate_stm(s1),
            self.elaborate_stm(s2)),
      ~While(e, s) => ~While(self.elaborate_exp(e), self.elaborate_stm(s)),
      ~Return(e) => ~Return(self.elaborate_exp(e)),
      ~Express(e) => ~Express(self.elaborate_exp(e)),
      ~Seq(s1, s2) => {
        match s1 {
          ~Declare(id, typ, init, s1) =>
            declare!(id, typ, init,
                     ~Seq(self.elaborate_stm(s1), self.elaborate_stm(s2))),
          ~Markeds(mark::Mark{data: ~Declare(id, typ, init, s1), pos}) => {
            let data = declare!(id, typ, init, ~Seq(self.elaborate_stm(s1),
                                                    self.elaborate_stm(s2)));
            ~Markeds(mark::Mark{data: data, pos: pos})
          }
          ~Markeds(mark::Mark{data, pos}) =>
            ~Markeds(mark::Mark{data: ~Seq(self.elaborate_stm(data),
                                           self.elaborate_stm(s2)),
                                pos: pos}),
          s1 => ~Seq(self.elaborate_stm(s1), self.elaborate_stm(s2)),
        }
      },
      ~Assign(e1, o, e2) => {
        match (e1, o) {
          (~Marked(mark::Mark{data, _}), _) =>
            self.elaborate_stm(~Assign(data, o, e2)),
          (~Var(id), Some(o)) =>
            self.elaborate_stm(~Assign(~Var(id), None,
                               ~BinaryOp(o, ~Var(id), e2))),
          (e1, _) => ~Assign(self.elaborate_exp(e1), o, self.elaborate_exp(e2))
        }
      }
    }
  }

  fn elaborate_exp(&mut self, e: ~Expression) -> ~Expression {
    match e {
      ~Marked(mark) =>
        ~Marked(self.err.map_mark(mark, |e| self.elaborate_exp(e))),
      /* TODO: shouldn't have to rebuild these structures */
      ~Var(id) => ~Var(id),
      ~Boolean(b) => ~Boolean(b),
      ~Const(c) => ~Const(c),
      ~Null => ~Null,
      ~UnaryOp(o, e) =>
        ~UnaryOp(o, self.elaborate_exp(e)),
      ~BinaryOp(o, e1, e2) =>
        ~BinaryOp(o, self.elaborate_exp(e1), self.elaborate_exp(e2)),
      ~Ternary(e1, e2, e3, _) =>
        ~Ternary(self.elaborate_exp(e1), self.elaborate_exp(e2),
                 self.elaborate_exp(e3), Ref()),
      ~Call(id, L, _) =>
        ~Call(id, vec::map_consume(L, |x| self.elaborate_exp(x)), Ref()),
      ~Deref(e, _) => ~Deref(self.elaborate_exp(e), Ref()),
      ~Field(e, id, _) => ~Field(self.elaborate_exp(e), id, Ref()),
      ~ArrSub(e1, e2, _) =>
        ~ArrSub(self.elaborate_exp(e1), self.elaborate_exp(e2), Ref()),
      ~Alloc(t) => ~Alloc(self.resolve(t)),
      ~AllocArray(t, e) => ~AllocArray(self.resolve(t), self.elaborate_exp(e))
    }
  }

  fn check_id(&mut self, s: Ident) {
    if self.types.contains_key(&s) {
      self.err.add(fmt!("'%s' already a type", self.symbols[s]));
    }
  }

  fn resolve(&mut self, t: @Type) -> @Type {
    match t {
      @Int | @Bool | @Nullp | @Struct(_) => t,
      @Pointer(t) => @Pointer(self.resolve(t)),
      @Array(t) => @Array(self.resolve(t)),
      @Alias(sym) =>
        match self.types.find(&sym) {
          Some(&t) => t,
          None    => {
            self.err.add(fmt!("'%s' is undefined", self.symbols[sym]));
            t
          }
        },
      @Fun(t1, L) => @Fun(self.resolve(t1),
                          @L.map(|&t| self.resolve(t)))
    }
  }

  fn resolve_pairs(&mut self, pairs: ~[(Ident, @Type)]) -> ~[(Ident, @Type)] {
    vec::map_consume(pairs, |(id, typ)| (id, self.resolve(typ)))
  }
}

impl Expression {
  fn lvalue(&self) -> bool {
    match *self {
      Var(_)              => true,
      Field(ref e, _, _)  => e.lvalue(),
      Deref(ref e, _)     => e.lvalue(),
      ArrSub(ref e, _, _) => e.lvalue(),
      Marked(ref m)       => m.data.lvalue(),
      _                   => false
    }
  }

  /* TODO(#4355): this used to cause a segfault */
  /*fn unmark(~self) -> ~Expression {*/
  /*  match self {*/
  /*    ~Marked(mark::Mark{data, _}) => data,*/
  /*    self => self*/
  /*  }*/
  /*}*/
}

pub fn unmarke(e: ~Expression) -> ~Expression {
  match e {
    ~Marked(mark::Mark{data, _}) => data,
    e => e
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
