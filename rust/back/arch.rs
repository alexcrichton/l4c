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
    /* TODO: actually use this */
    /*
    @BinaryOp(op, d, s1, s2) => {
      let (d, s) = match op {
        Mul | Cmp(_) if d.mem() => {
          let tmp = @Temp(cg.temps.new(), ir::Int);
          constrain(@BinaryOp(op, tmp, s1, s2), push, cg);
          return push(@Move(d, tmp));
        }
        Cmp(c) if s1.imm() && !s2.imm() => {
          return constrain(@BinaryOp(Cmp(c.rev()), d, s2, s1), push, cg);
        }
        _ => {
          if s1.imm() && op.commutative() {
            push(@Move(d, s2));
            (d, s1)
          } else if d != s2 {
            push(@Move(d, s1));
            (d, s2)
          } else if op.commutative() {
            push(@Move(d, s2));
            (d, s1)
          } else {
            fail(~"you never thought this much, did you?");
          }
        }
      };
      let s = if (d.mem() && s.mem()) || d.size() != s.size() {
        let tmp = @Temp(cg.temps.new(), s.size());
        push(@Move(tmp, s));
        tmp
      } else {
        s
      };

      push(@BinaryOp(op, d, d, s));
    }*/
    _ => push(ins)
  }
}
