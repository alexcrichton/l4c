/**
 * ~brief Peephole optimizations on assembly
 *
 * Does a peek at all the instructions in a program and optimizes them if
 * possible. This just does small things like 'a * 4' == 'a << 2' or things like
 * that.
 */

use back::assem::*;

pub fn optimize(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    do f.cfg.map_nodes |_, ins| {
      peep(ins)
    }
  }
}

fn peep(mut ins: ~[~Instruction]) -> ~[~Instruction] {
  use BO  = back::assem::BinaryOp;
  use Imm = back::assem::Immediate;

  /* right now, we don't need a look ahead of more than one */
  do vec::map_consume(ins) |i| {
    match i {
      /* shifting has constraints, so add if we can */
      ~BO(Mul, d, ~Imm(2, _), t) | ~BO(Mul, d, t, ~Imm(2, _)) =>
        ~BO(Add, d, copy t, t),
      /* Multiplying by a power of 2 is equivalent by shifting by the log */
      ~BO(Mul, d, ~Imm(c, s), t) | ~BO(Mul, d, t, ~Imm(c, s)) => {
        let (op, c) = if pow2(c) { (Lsh, log2(c)) } else { (Mul, c) };
        ~BO(op, d, t, ~Imm(c, s))
      }
      /* dividing/mod by a power of 2 can also be simplified. */
      ~BO(op, d, t, ~Imm(c, s)) => {
        match (op, pow2(c)) {
          (Div, true) => ~BO(Rsh, d, t, ~Imm(log2(c), s)),
          (Mod, true) => ~BO(And, d, t, ~Imm(c - 1, s)),
          _           => ~BO(op, d, t, ~Imm(c, s)),
        }
      }
      i => i
    }
  }
}

fn pow2(c: i32) -> bool {
   // http://stackoverflow.com/questions/600293/how-to-check-if-a-number-is-a-power-of-2
  c > 0 && (c & (c - 1) == 0)
}

fn log2(mut c: i32) -> i32 {
  let mut ret = 0;
  while c > 1 {
    ret += 1;
    c /= 2;
  }
  return ret;
}

#[test]
fn test_pow2() {
  fail_unless!(pow2(2));
  fail_unless!(pow2(4));
  fail_unless!(pow2(8));
  fail_unless!(pow2(16));
  fail_unless!(pow2(32));
  fail_unless!(pow2(64));
  fail_unless!(pow2(1 << 22));
  fail_unless!(!pow2(3));
  fail_unless!(!pow2(5));
  fail_unless!(!pow2(135318));
  fail_unless!(!pow2(1991919));
}

#[test]
fn test_log2() {
  fail_unless!(log2(1) == 0);
  fail_unless!(log2(2) == 1);
  fail_unless!(log2(4) == 2);
  fail_unless!(log2(8) == 3);
  fail_unless!(log2(1 << 22) == 22);
}
