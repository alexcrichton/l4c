use middle::temp;
use middle::label;
use middle::ir;
use std::map;

pub type Label = label::Label;
pub type Edge = ir::Edge;
pub type Size = ir::Type;

pub struct Program {
  funs : ~[Function]
}

pub struct Function {
  root : graph::NodeId,
  cfg : graph::Graph<@~[@Instruction], Edge>
}

pub enum Instruction {
  BinaryOp(Binop, @Operand, @Operand, @Operand),
  Move(@Operand, @Operand),
  Condition(Cond, @Operand, @Operand),
  Die(Cond, @Operand, @Operand),
  Return,
  Call(@Operand, uint),
  Raw(~str),
  Comment(~str),
  Phi(temp::Temp, Size, map::HashMap<graph::NodeId, temp::Temp>)
}

pub enum Operand {
  Immediate(i32, Size),
  Register(Register, Size),
  Temp(temp::Temp, Size),
  Memory(@Address, Size),
  LabelOp(Label)
}

pub enum Address {
  MOp(@Operand),
  Stack(uint),
  StackArg(int),
  StackLoc(int),
}

pub enum Binop {
  Add, Sub, Mul, Div, Mod, Cmp(Cond), And, Or, Xor, Lsh, Rsh
}

pub enum Cond {
  Lt, Lte, Gt, Gte, Eq, Neq
}

pub enum Register {
  EAX, EBX, ECX, EDX, EDI, ESI, ESP, EBP,
  R8D, R9D, R10D, R11D, R12D, R13D, R14D, R15D
}
