use std::map;

pub struct Program {
  decls: ~[@GDecl],
}

struct Elaborator {
  priv efuns:   map::Set<Ident>,
  priv funs:    map::Set<Ident>,
  priv structs: map::Set<Ident>,
  priv types:   map::HashMap<Ident, @Type>,
  priv err:     ~error::List
}

pub type Ident = @symbol::Symbol;

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
  Declare(Ident, @Type, Option<@Expression>, @Statement),
  Markeds(~mark::Mark<Statement>)
}

pub enum Expression {
  Var(Ident),
  Boolean(bool),
  Const(i32),
  BinaryOp(Binop, @Expression, @Expression),
  UnaryOp(Unop, @Expression),
  Ternary(@Expression, @Expression, @Expression, Ref<@Type>),
  Call(@Expression, ~[@Expression], Ref<(@Type, @~[@Type])>),
  Deref(@Expression, Ref<@Type>),
  Field(@Expression, Ident, Ref<Ident>),
  ArrSub(@Expression, @Expression, Ref<@Type>),
  Alloc(@Type),
  AllocArray(@Type, @Expression),
  Null,
  Marked(~mark::Mark<Expression>)
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
  mut val : Option<T>
}

pub fn Ref<T>() -> Ref<T> {
  Ref{ val : None }
}

impl<T : Copy> Ref<T> {
  pub fn set(t : T) {
    self.val = Some(t);
  }

  pub fn get() -> T {
    self.val.get()
  }
}

pub fn new(g : ~[@GDecl]) -> Program {
  Program{decls: g}
}

impl Program {
  fn elaborate() -> Program {
    let e = Elaborator{ efuns:   map::HashMap(),
                        funs:    map::HashMap(),
                        structs: map::HashMap(),
                        types:   map::HashMap(),
                        err:     error::new() };
    let prog = new(self.decls.map(|x| e.elaborate(*x)));
    e.err.check();
    prog
  }
}

impl Program : utils::PrettyPrint {
  pure fn pp() -> ~str {
    str::connect(self.decls.map(|d| d.pp()), "\n")
  }
}

impl Elaborator {
  fn elaborate(g : @GDecl) -> @GDecl {
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
      @Markedg(ref m) => {
        m.data = self.err.with(m, |x| self.elaborate(x));
        g
      },
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
      @Markeds(ref m) => {
        m.data = self.err.with(m, |x| self.elaborate_stm(x));
        s
      },
      @Continue | @Break | @Nop => s,
      @Declare(id, typ, init, rest) => {
        self.check_id(id);
        @Declare(id, self.resolve(typ), init.map(|x| self.elaborate_exp(*x)),
                 self.elaborate_stm(rest))
      },
      @For(@Declare(id, typ, init, s1), e1, s2, s3) =>
        self.elaborate_stm(@Declare(id, typ, init, @For(s1, e1, s2, s3))),
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
          @Declare(id, typ, init, s1) =>
            self.elaborate_stm(@Declare(id, typ, init, @Seq(s1, s2))),
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
      @Marked(ref m) => {
        m.data = self.err.with(m, |x| self.elaborate_exp(x));
        e
      },
      @Var(_) | @Boolean(_) | @Const(_) | @Null => e,
      @UnaryOp(o, e) =>
        @UnaryOp(o, self.elaborate_exp(e)),
      @BinaryOp(o, e1, e2) =>
        @BinaryOp(o, self.elaborate_exp(e1), self.elaborate_exp(e2)),
      @Ternary(e1, e2, e3, _) =>
        @Ternary(self.elaborate_exp(e1), self.elaborate_exp(e2),
                 self.elaborate_exp(e3), Ref()),
      @Call(id, ref L, _) =>
        @Call(id, L.map(|x| self.elaborate_exp(*x)), Ref()),
      @Deref(e, _) => @Deref(self.elaborate_exp(e), Ref()),
      @Field(e, id, _) => @Field(self.elaborate_exp(e), id, Ref()),
      @ArrSub(e1, e2, _) =>
        @ArrSub(self.elaborate_exp(e1), self.elaborate_exp(e2), Ref()),
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
        },
      @Fun(t1, L) => @Fun(self.resolve(t1),
                          @L.map(|&t| self.resolve(t)))
    }
  }

  priv fn resolve_pairs(pairs : &~[(Ident, @Type)]) -> ~[(Ident, @Type)] {
    pairs.map(|&(id, typ)| (id, self.resolve(typ)))
  }
}

impl Expression {
  pure fn lvalue() -> bool {
    match self {
      Var(_)          => true,
      Field(e, _, _)  => e.lvalue(),
      Deref(e, _)     => e.lvalue(),
      ArrSub(e, _, _) => e.lvalue(),
      Marked(ref m)   => m.data.lvalue(),
      _               => false
    }
  }
}

impl Type {
  fn small() -> bool {
    match self {
      Struct(_) => false,
      _ => true
    }
  }
}

impl Type : cmp::Eq {
  pure fn eq(&self, other : &Type) -> bool {
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

  pure fn ne(&self, other : &Type) -> bool { !self.eq(other) }
}
