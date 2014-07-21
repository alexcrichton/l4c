#![allow(non_uppercase_statics, dead_code)]

use back::assem::*;

pub static arg_regs: uint = 6;
pub static ptrsize: uint = 8;
pub static intsize: uint = 4;
pub static ret_reg: Register = EAX;
pub static num_regs: uint = 15;
pub static caller_regs: uint = 9;

pub fn each_reg(f: |uint|) {
  for i in range(1, num_regs + 1) {
    f(i)
  }
}

pub fn arg_reg(i: uint) -> Register {
  match i {
    0 => EDI,
    1 => ESI,
    2 => EDX,
    3 => ECX,
    4 => R8D,
    5 => R9D,
    _ => fail!("not that many argument registers")
  }
}

pub fn reg_num(r: Register) -> uint {
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
    _    => fail!("no num assigned {}", r)
  }
}

pub fn num_reg(i: uint) -> Register {
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
    _ => fail!("{} is not a register", i)
  }
}

pub fn each_caller(f: |Register|) {
  f(EAX); f(ECX); f(EDX); f(ESI); f(EDI); f(R8D); f(R9D); f(R10D); f(R11D)
}

pub fn callee_reg(r: Register) -> bool {
  match r { EBX | R12D | R13D | R14D | R15D | EBP => true, _ => false }
}

pub fn align_stack(size: uint) -> uint {
  /* must be on a 16-byte boundary, but the call address pushes 8 bytes for a
     call instruction, so the size of a stack should be 8 bytes off a multiple
     of 16 */
  (size / 16) * 16 + 8
}

#[test]
fn test_stack_alignment() {
  assert!(align_stack(0) == 8);
  assert!(align_stack(8) == 8);
  assert!(align_stack(16) == 24);
  assert!(align_stack(24) == 24);
  assert!(align_stack(32) == 40);
  assert!(align_stack(40) == 40);
}
