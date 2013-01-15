use middle::ir;
use back::assem::*;
use back::codegen::CodeGenerator;

pub const arg_regs : uint = 6;
pub const ptrsize : uint = 8;
pub const intsize : uint = 4;
pub const ret_reg : Register = EAX;
pub const num_regs : uint = 15;

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

pub fn reg_num(r : Register) -> uint {
  match r {
    R9D  => 1,
    R8D  => 2,
    ECX  => 3,
    EDX  => 4,
    ESI  => 5,
    EDI  => 6,
    R10D => 7,
    R11D => 8,
    EAX  => 9,
    EBX  => 10,
    R12D => 11,
    R13D => 12,
    R14D => 13,
    R15D => 14,
    EBP  => 15,
    _    => fail(fmt!("no num assigned %?", r))
  }
}

pub fn num_reg(i : uint) -> Register {
  match i {
     1 => R9D,
     2 => R8D,
     3 => ECX,
     4 => EDX,
     5 => ESI,
     6 => EDI,
     7 => R10D,
     8 => R11D,
     9 => EAX,
    10 => EBX,
    11 => R12D,
    12 => R13D,
    13 => R14D,
    14 => R15D,
    15 => EBP,
    _ => fail(fmt!("%u is not a register", i))
  }
}

pub fn each_caller(f : &fn(Register) -> bool) {
  f(EAX); f(ECX); f(EDX); f(ESI); f(EDI); f(R8D); f(R9D); f(R10D); f(R11D);
}

pub fn callee_reg(r : Register) -> bool {
  match r { EBX | R12D | R13D | R14D | R15D | EBP => true, _ => false }
}

pub fn constrain(ins : @Instruction,
                 push : &pure fn(@Instruction),
                 cg : &CodeGenerator) {
  match ins {
    @Condition(c, o1, o2) => constrain_cmp(c, o1, o2, push, cg, Condition),
    @Die(c, o1, o2) => constrain_cmp(c, o1, o2, push, cg, Die),
    @BinaryOp(op, d, s1, s2) => {
      match op {
        /* the cmp instruction can only have immediates in a few places */
        Cmp(c) =>
          constrain_cmp(c, s1, s2, push, cg,
                        |c, o1, o2| BinaryOp(Cmp(c), d, o1, o2)),

        /* div/mod can't operate on immediates, only registers */
        Div | Mod => {
          let s1 = if s1.imm() {
            let tmp = cg.tmpnew(ir::Int);
            push(@Move(tmp, s1));
            tmp
          } else { s1 };
          let s2 = if s2.imm() {
            let tmp = cg.tmpnew(ir::Int);
            push(@Move(tmp, s2));
            tmp
          } else { s2 };
          push(@BinaryOp(op, d, s1, s2));
        }
        _ => push(ins)
      }
    }

    /* When invoking functions, all argument registers must be actual registers,
       not immediates. Also the same register can't be an argument twice because
       it has to be in two different places */
    @Call(dst, fun, ref args) => {
      let temps = map::HashMap();
      let args = args.mapi(|i, &arg| {
        match arg {
          /* If we have first saw this temp, or the immediates/labels need to be
             stored on the stack, then no copy is needed */
          @Temp(t) if set::add(temps, t) => arg,
          @Immediate(*) | @LabelOp(*) if i >= arch::arg_regs => arg,

          /* Otherwise we need to create a temp to store this argument */
          _ if i < arch::arg_regs => {
            let size = match arg { @Temp(t) => cg.sizes[t], _ => arg.size()};
            let tmp = cg.tmpnew(size);
            push(@Move(tmp, arg));
            tmp
          }
          _ => arg
        }
      });
      push(@Call(dst, fun, args));
    }
    _ => push(ins)
  }
}

fn constrain_cmp(c : Cond, o1 : @Operand, o2 : @Operand,
                 push : &pure fn(@Instruction), cg : &CodeGenerator,
                 f : &fn(Cond, @Operand, @Operand) -> Instruction ) {
  match (o1, o2) {
    (@Immediate(*), @Immediate(*)) => {
      let tmp = cg.tmpnew(ir::Int);
      push(@Move(tmp, o1));
      push(@f(c, tmp, o2));
    }
    (@Immediate(*), _) => push(@f(c.flip(), o2, o1)),
    _ => push(@f(c, o1, o2))
  }
}

pub fn align_stack(size : uint) -> uint {
  /* must be on a 16-byte boundary, but the call address pushes 8 bytes for a
     call instruction, so the size of a stack should be 8 bytes off a multiple
     of 16 */
  (size / 16) * 16 + 8
}

#[test]
fn test_stack_alignment() {
  assert align_stack(0) == 8;
  assert align_stack(8) == 8;
  assert align_stack(16) == 24;
  assert align_stack(24) == 24;
  assert align_stack(32) == 40;
  assert align_stack(40) == 40;
}
