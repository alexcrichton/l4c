/// Peephole optimizations on assembly
///
/// Does a peek at all the instructions in a program and optimizes them if
/// possible. This just does small things like 'a * 4' == 'a << 2' or things like
/// that.

use back::assem::{Program, Inst, Operand, Binop};

pub fn optimize(p: &mut Program) {
    for f in p.funs.iter_mut() {
        f.cfg.map_nodes(&mut |_, ins| {
            peep(ins)
        })
    }
}

fn peep(mut ins: Vec<Inst>) -> Vec<Inst> {
    // right now, we don't need a look ahead of more than one
    for i in ins.iter_mut() {
        let new = match *i {
            // multiplication has constraints, so add if we can
            Inst::BinaryOp(Binop::Mul, d, Operand::Imm(2, _), t) |
            Inst::BinaryOp(Binop::Mul, d, t, Operand::Imm(2, _)) => {
                Inst::BinaryOp(Binop::Add, d, t, t)
            }

            // Multiplying by a power of 2 is equivalent by shifting by the log
            Inst::BinaryOp(Binop::Mul, d, Operand::Imm(c, s), t) |
            Inst::BinaryOp(Binop::Mul, d, t, Operand::Imm(c, s)) => {
                let (op, c) = if pow2(c) {
                    (Binop::Lsh, log2(c))
                } else {
                    continue
                };
                Inst::BinaryOp(op, d, t, Operand::Imm(c, s))
            }

            // dividing/mod by a power of 2 can also be simplified. */
            Inst::BinaryOp(op, d, t, Operand::Imm(c, s)) => {
                match (op, pow2(c)) {
                    (Binop::Div, true) => {
                        Inst::BinaryOp(Binop::Rsh, d, t,
                                       Operand::Imm(log2(c), s))
                    }
                    (Binop::Mod, true) => {
                        Inst::BinaryOp(Binop::And, d, t,
                                       Operand::Imm(c - 1, s))
                    }
                    _ => continue,
                }
            }

            _ => continue,
        };
        *i = new;
    }
    return ins
}

fn pow2(c: i32) -> bool {
    // http://stackoverflow.com/questions/600293/how
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
    assert!(pow2(2));
    assert!(pow2(4));
    assert!(pow2(8));
    assert!(pow2(16));
    assert!(pow2(32));
    assert!(pow2(64));
    assert!(pow2(1 << 22));
    assert!(!pow2(3));
    assert!(!pow2(5));
    assert!(!pow2(135318));
    assert!(!pow2(1991919));
}

#[test]
fn test_log2() {
    assert!(log2(1) == 0);
    assert!(log2(2) == 1);
    assert!(log2(4) == 2);
    assert!(log2(8) == 3);
    assert!(log2(1 << 22) == 22);
}
