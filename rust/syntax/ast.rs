pub type Program = ~[GDecl];
pub type Ident = ~str;

pub enum GDecl {
  Markedg(mark::Mark<~GDecl>),
  Typedef(Ident, ~Type),
  StructDef(Ident, ~[(Ident, ~Type)]),
  StructDecl(Ident),
  Function(~Type, Ident, ~[(Ident, ~Type)], ~Statement),
  FunIDecl(~Type, Ident, ~[(Ident, ~Type)]),
  FunEDecl(~Type, Ident, ~[(Ident, ~Type)])
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
  Declare(Ident, ~Type, ~Statement),
  Markeds(mark::Mark<~Statement>)
}

pub enum Expression {
  Var(Ident),
  Boolean(bool),
  Const(i32),
  BinaryOp(Binop, ~Expression, ~Expression),
  UnaryOp(Unop, ~Expression),
  Ternary(~Expression, ~Expression, ~Expression),
  Call(Ident, ~[~Expression]),
  Deref(~Expression),
  Field(~Expression, Ident),
  ArrSub(~Expression, ~Expression),
  Alloc(~Type),
  AllocArray(~Type, ~Expression),
  Null,
  Marked(mark::Mark<~Expression>)
}

pub enum Type {
  Int, Bool, Alias(Ident), Pointer(~Type), Array(~Type), Struct(Ident), Nullp
}

pub enum Binop {
  Plus, Minus, Times, Divide, Modulo, Less, LessEq, Greater, GreaterEq,
  Equals, NEquals, LAnd, LOr, BAnd, BOr, Xor, LShift, RShift
}

pub enum Unop {
  Negative, Invert, Bang
}
