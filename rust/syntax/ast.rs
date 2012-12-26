use symbol::*;
use std::map;

pub struct Program {
  decls: ~[mut @GDecl],
  priv efuns:   map::Set<Ident>,
  priv funs:    map::Set<Ident>,
  priv structs: map::Set<Ident>,
  priv types:   map::HashMap<Ident, @Type>,
  priv err:     ~error::List
}

pub type Ident = @Symbol;

pub enum GDecl {
  Markedg(~mark::Mark<GDecl>),
  Typedef(Ident, @Type),
  StructDef(Ident, ~[(Ident, @Type)]),
  StructDecl(Ident),
  Function(@Type, Ident, ~[(Ident, @Type)], @Statement),
  FunIDecl(@Type, Ident, ~[(Ident, @Type)]),
  FunEDecl(@Type, Ident, ~[(Ident, @Type)])
}

pub enum Statement {
  Assign(@Expression, Option<Binop>, @Expression),
  If(@Expression, @Statement, @Statement),
  While(@Expression, @Statement),
  For(@Statement, @Expression, @Statement, @Statement),
  Express(@Expression),
  Continue,
  Break,
  Nop,
  Return(@Expression),
  Seq(@Statement, @Statement),
  Declare(Ident, @Type, @Statement),
  Markeds(~mark::Mark<Statement>)
}

pub enum Expression {
  Var(Ident),
  Boolean(bool),
  Const(i32),
  BinaryOp(Binop, @Expression, @Expression),
  UnaryOp(Unop, @Expression),
  Ternary(@Expression, @Expression, @Expression),
  Call(Ident, ~[@Expression]),
  Deref(@Expression),
  Field(@Expression, Ident),
  ArrSub(@Expression, @Expression),
  Alloc(@Type),
  AllocArray(@Type, @Expression),
  Null,
  Marked(~mark::Mark<Expression>)
}

pub enum Type {
  Int, Bool, Alias(Ident), Pointer(@Type), Array(@Type), Struct(Ident), Nullp
}

pub enum Binop {
  Plus, Minus, Times, Divide, Modulo, Less, LessEq, Greater, GreaterEq,
  Equals, NEquals, LAnd, LOr, BAnd, BOr, Xor, LShift, RShift
}

pub enum Unop {
  Negative, Invert, Bang
}

pub fn new(g : ~[@GDecl]) -> Program {
  Program{decls: vec::to_mut(g),
          efuns:   map::HashMap(),
          funs:    map::HashMap(),
          structs: map::HashMap(),
          types:   map::HashMap(),
          err:     error::new()}
}

impl Program {
  fn elaborate() {
    for vec::each_mut(self.decls) |x| {
      *x = self.elaborate_gdecl(*x)
    }
    self.err.check();
  }

  priv fn elaborate_gdecl(g : @GDecl) -> @GDecl {
    match g {
      @FunEDecl(typ, id, ref args) => {
        self.check_id(id);
        map::set_add(self.efuns, id);
        @FunEDecl(self.resolve(typ), id, self.resolve_pairs(args))
      },
      @FunIDecl(typ, id, ref args) => {
        self.check_id(id);
        @FunIDecl(self.resolve(typ), id, self.resolve_pairs(args))
      },
      @StructDecl(_) => g,
      @Markedg(ref m) => self.err.with(m, |x| self.elaborate_gdecl(x)) ,
      @Typedef(id, typ) => {
        self.check_id(id);
        self.check_set(&self.efuns, id, ~"function");
        self.check_set(&self.funs, id, ~"function");
        self.types.insert(id, self.resolve(typ));
        g
      },
      @StructDef(id, ref fields) => {
        self.check_set(&self.structs, id, ~"struct");
        map::set_add(self.structs, id);
        @StructDef(id, self.resolve_pairs(fields))
      },
      @Function(ret, id, ref args, body) => {
        self.check_id(id);
        self.check_set(&self.efuns, id, ~"function");
        self.check_set(&self.funs, id, ~"function");
        map::set_add(self.funs, id);
        @Function(self.resolve(ret), id, self.resolve_pairs(args),
                  self.elaborate_stm(body))
      }
    }
  }

  priv fn elaborate_stm(s : @Statement) -> @Statement {
    match s {
      @Markeds(ref m) => self.err.with(m, |x| self.elaborate_stm(x)) ,
      @Continue | @Break | @Nop => s,
      @Declare(id, typ, rest) => {
        self.check_id(id);
        @Declare(id, self.resolve(typ), self.elaborate_stm(rest))
      },
      @For(@Declare(id, typ, s1), e1, s2, s3) =>
        self.elaborate_stm(@Declare(id, typ, @For(s1, e1, s2, s3))),
      @For(@Markeds(ref m), e1, s2, s3) =>
        self.elaborate_stm(@For(m.data, e1, s2, s3)),
      @For(s1, e1, s2, s3) =>
        @For(self.elaborate_stm(s1), self.elaborate_exp(e1),
             self.elaborate_stm(s2), self.elaborate_stm(s3)),
      @If(e, s1, s2) =>
        @If(self.elaborate_exp(e), self.elaborate_stm(s1),
            self.elaborate_stm(s2)),
      @While(e, s) => @While(self.elaborate_exp(e), self.elaborate_stm(s)),
      @Return(e) => @Return(self.elaborate_exp(e)),
      @Express(e) => @Express(self.elaborate_exp(e)),
      @Seq(s1, s2) => {
        match s1 {
          @Declare(id, typ, s1) =>
            self.elaborate_stm(@Declare(id, typ, @Seq(s1, s2))),
          @Markeds(ref m) => {
            m.data = @Seq(m.data, s2);
            self.elaborate_stm(s1)
          },
          _ => @Seq(self.elaborate_stm(s1), self.elaborate_stm(s2)),
        }
      },
      @Assign(e1, o, e2) => {
        match (e1, o) {
          (@Marked(ref m), _) => self.elaborate_stm(@Assign(m.data, o, e2)),
          (@Var(id), Some(o)) =>
            self.elaborate_stm(@Assign(@Var(id), None, @BinaryOp(o, e1, e2))),
          _ => @Assign(self.elaborate_exp(e1), o, self.elaborate_exp(e2))
        }
      }
    }
  }

  priv fn elaborate_exp(e : @Expression) -> @Expression {
    match e {
      @Marked(ref m) => self.err.with(m, |x| self.elaborate_exp(x)),
      @Var(_) | @Boolean(_) | @Const(_) | @Null => e,
      @UnaryOp(o, e) =>
        @UnaryOp(o, self.elaborate_exp(e)),
      @BinaryOp(o, e1, e2) =>
        @BinaryOp(o, self.elaborate_exp(e1), self.elaborate_exp(e2)),
      @Ternary(e1, e2, e3) =>
        @Ternary(self.elaborate_exp(e1), self.elaborate_exp(e2),
                 self.elaborate_exp(e3)),
      @Call(id, ref L) => @Call(id, L.map(|x| self.elaborate_exp(*x))),
      @Deref(e) => @Deref(self.elaborate_exp(e)),
      @Field(e, id) => @Field(self.elaborate_exp(e), id),
      @ArrSub(e1, e2) =>
        @ArrSub(self.elaborate_exp(e1), self.elaborate_exp(e2)),
      @Alloc(t) => @Alloc(self.resolve(t)),
      @AllocArray(t, e) => @AllocArray(self.resolve(t), self.elaborate_exp(e))
    }
  }

  priv fn check_id(s : Ident) {
    if self.types.contains_key(s) {
      self.err.add(fmt!("'%s' already a type", s.val));
    }
  }

  priv fn check_set(h : &map::Set<Ident>, s : Ident, typ : ~str) {
    if h.contains_key(s) {
      self.err.add(fmt!("'%s' already a %s", s.val, typ));
    }
  }

  priv fn resolve(t : @Type) -> @Type {
    match t {
      @Int | @Bool | @Nullp | @Struct(_) => t,
      @Pointer(t) => @Pointer(self.resolve(t)),
      @Array(t) => @Array(self.resolve(t)),
      @Alias(sym) =>
        match self.types.find(sym) {
          Some(t) => t,
          None    => {
            self.err.add(fmt!("'%s' is undefined", sym.val));
            t
          }
        }
    }
  }

  priv fn resolve_pairs(pairs : &~[(Ident, @Type)]) -> ~[(Ident, @Type)] {
    pairs.map(|&(id, typ)| (id, self.resolve(typ)))
  }

  pure fn pp() -> ~str {
    str::connect(self.decls.map(|d| d.pp()), "\n")
  }
}
