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

            _ => continue,
        };
        *i = new;
    }
    return ins
}
