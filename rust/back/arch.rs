use middle::ir;
use back::assem::*;
use back::codegen::CodeGenerator;

pub const arg_regs : uint = 6;
pub const ptrsize : uint = 8;
pub const intsize : uint = 4;
pub const ret_reg : Register = EAX;

pub fn arg_reg(i : uint) -> Register {
  match i {
    0 => EDI,
    1 => ESI,
    2 => EDX,
    3 => ECX,
    4 => R8D,
    5 => R9D,
    _ => fail(~"not that many argument registers")
  }
}

pub fn constrain(ins : @Instruction,
                 push : &pure fn(@Instruction),
                 cg : &CodeGenerator) {
  ignore(cg);
  match ins {
    @Condition(c, o1, o2) => constrain_cmp(c, o1, o2, push, cg, Condition),
    @Die(c, o1, o2) => constrain_cmp(c, o1, o2, push, cg, Die),
    @BinaryOp(op, d, s1, s2) => {
      match op {
        Mul | Cmp(_) if d.mem() => {
          let tmp = @Temp(cg.temps.new(), ir::Int);
          constrain(@BinaryOp(op, tmp, s1, s2), push, cg);
          return push(@Move(d, tmp));
        }
        Cmp(c) =>
          constrain_cmp(c, s1, s2, push, cg,
                        |c, o1, o2| BinaryOp(Cmp(c), d, o1, o2)),
        _ => return push(ins)
      }
    }
    _ => push(ins)
  }
}

fn constrain_cmp(c : Cond, o1 : @Operand, o2 : @Operand,
                 push : &pure fn(@Instruction), cg : &CodeGenerator,
                 f : &fn(Cond, @Operand, @Operand) -> Instruction ) {
  match (o1, o2) {
    (@Immediate(*), @Immediate(*)) => {
      let tmp = @Temp(cg.temps.new(), ir::Int);
      push(@Move(tmp, o1));
      push(@f(c, tmp, o2));
    }
    (@Immediate(*), _) => push(@f(c.flip(), o2, o1)),
    _ => push(@f(c, o1, o2))
  }
}
