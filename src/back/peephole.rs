/**
 * @brief Peephole optimizations on assembly
 *
 * Does a peek at all the instructions in a program and optimizes them if
 * possible. This just does small things like 'a * 4' == 'a << 2' or things like
 * that.
 */

use back::assem::*;

pub fn optimize(p: &mut Program) {
    for f in p.funs.mut_iter() {
        f.cfg.map_nodes(|_, ins| {
            peep(ins)
        })
    }
}

fn peep(ins: Vec<Box<Instruction>>) -> Vec<Box<Instruction>> {
    use BO  = back::assem::BinaryOp;
    use Imm = back::assem::Immediate;

    /* right now, we don't need a look ahead of more than one */
    ins.move_iter().map(|i| {
        match i {
            /* shifting has constraints, so add if we can */
            box BO(Mul, d, box Imm(2, _), t) | box BO(Mul, d, t, box Imm(2, _)) =>
                box BO(Add, d, t.clone(), t),
            /* Multiplying by a power of 2 is equivalent by shifting by the log */
            box BO(Mul, d, box Imm(c, s), t) | box BO(Mul, d, t, box Imm(c, s)) => {
                let (op, c) = if pow2(c) { (Lsh, log2(c)) } else { (Mul, c) };
                box BO(op, d, t, box Imm(c, s))
            }
            /* dividing/mod by a power of 2 can also be simplified. */
            box BO(op, d, t, box Imm(c, s)) => {
                match (op, pow2(c)) {
                    (Div, true) => box BO(Rsh, d, t, box Imm(log2(c), s)),
                    (Mod, true) => box BO(And, d, t, box Imm(c - 1, s)),
                    _           => box BO(op, d, t, box Imm(c, s)),
                }
            }
            i => i
        }
    }).collect()
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
