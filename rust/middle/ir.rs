pub type Program = int;

pub type Temp = (temp::Temp, Type);

pub enum Statement {
  Move(Temp, @Expression),
  Load(Temp, @Expression),
  Store(@Expression, Type, @Expression),
  Condition(@Expression),
  Return(@Expression)
}

pub enum Expression {
  Temp(Temp),
  Phi(~[temp::Temp]),
  Const(i32, Type),
  BinaryOp(Binop, @Expression, @Expression),
  Call(@Expression, Type, ~[(@Expression, Type)]),
  LabelExp(label::Label)
}

pub enum Type { Int, Pointer }

pub enum Binop {
  Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

pub enum Edge {
  Always, True, False,      /* fall through if condition holds */
  Branch, TBranch, FBranch  /* branch if condition holds */
}

impl Binop {
  fn associative() -> bool {
    match self {
      Add | Mul | And | Or | Xor => true,
      _ => false
    }
  }

  fn commutative() -> bool {
    match self {
      Add | Mul | Eq | Neq | And | Or | Xor => true,
      _ => false
    }
  }
}
