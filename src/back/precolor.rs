use std::cmp;
use std::collections::HashSet;

use back::arch;
use back::assem::{Program, RegisterInfo, Inst, Address, Operand, Binop};
use middle::liveness;
use utils::{TempAllocator, TempSet, Temp, FnvState};

pub fn constrain(p: &mut Program) {
    for f in p.funs.iter_mut() {
        let mut live = liveness::Analysis::new();
        liveness::calculate(&f.cfg, f.root, &mut live, &RegisterInfo);
        let temps = TempAllocator::new_from(f.temps);
        let sizes = &mut f.sizes;
        f.cfg.map_nodes(&mut |id, stms| {
            constrain_block(&live.in_[&id],
                            &live.deltas[&id], &mut |t| {
                let tmp = temps.gen();
                let size = sizes[&t];
                sizes.insert(tmp, size);
                tmp
            }, stms)
        });
    }
}

fn constrain_block(live: &TempSet, delta: &[liveness::Delta],
                   tmpclone: &mut FnMut(Temp) -> Temp,
                   ins: Vec<Inst>) -> Vec<Inst> {
    let mut new = Vec::new();
    let mut synthetic = Vec::new();
    let mut live_in = HashSet::with_hash_state(FnvState);
    let mut live_out = HashSet::with_hash_state(FnvState);
    for &t in live.iter() {
        live_in.insert(t);
        live_out.insert(t);
    }

    // SSA will deal with these renamings later
    fn pcopy(live: &TempSet) -> Inst {
        Inst::PCopy(live.iter().map(|tmp| (*tmp, *tmp)).collect())
    }

    // If a constrained use is also always clobbered as a result of an
    // instruction, then it needs to be moved into a temporary before the
    // instruction runs to not destroy the actual value. We push this move
    // before the PCopy as well for ease later on
    macro_rules! constrain_clobber {
        ($op:expr) => (match $op {
            Operand::Temp(t) if live_out.contains(&t) => {
                let dup = tmpclone(t);
                let dst = Operand::Temp(dup);
                new.push(Inst::Move(dst.clone(), Operand::Temp(t)));
                assert!(live_in.insert(dup));
                synthetic.push(dup);
                dst
            }
            o => o
        })
    }

    for (i, ins) in ins.into_iter().enumerate() {
        liveness::apply(&mut live_out, &delta[i]);

        match ins {
            Inst::BinaryOp(op, dest, o1, o2) => {
                match (op, o2) {
                    // x86 shifts must have the operand in the %cl register
                    // unless the argument is an immediate */
                    (Binop::Lsh, Operand::Temp(t)) |
                    (Binop::Rsh, Operand::Temp(t)) => {
                        new.push(pcopy(&live_in));
                        new.push(Inst::BinaryOp(op, dest, o1, Operand::Temp(t)));
                        new.push(Inst::Use(t));
                    }

                    // div/mod both use and define edx/eax
                    (Binop::Div, o2) | (Binop::Mod, o2) => {
                        let o1 = constrain_clobber!(o1);
                        new.push(pcopy(&live_in));
                        new.push(Inst::BinaryOp(op, dest, o1, o2));
                    }

                    // Because x86 has two-operand form, all non-commutative
                    // operations need to have their second argument in
                    // interference with the destination because otherwise when
                    // moving the first argument to the destination the second
                    // argument could get clobbered. This is fixed with a
                    // pseudo-use of the second operand right after the
                    // instruction
                    (op, Operand::Temp(t)) if !op.commutative() => {
                        new.push(Inst::BinaryOp(op, dest, o1, Operand::Temp(t)));
                        new.push(Inst::Use(t));
                    }

                    // otherwise we're unconstrained!
                    (_, o2) => {
                        new.push(Inst::BinaryOp(op, dest, o1, o2));
                    }
                }
            }

            // calling conventions dictate that we must save all caller-saved
            // registers and we will have to put our first few arguments in very
            // specific registers. This throws in a lot of complications, so
            // here we throw in a PCopy for live-range splitting, and we also
            // move all the arguments to the stack that need to be on the stack
            Inst::Call(dst, fun, args) => {
                let mut newargs = Vec::new();
                let mut tempregs = HashSet::new();
                let inregs = cmp::min(arch::ARG_REGS as usize, args.len());
                for t in args[0..inregs].iter() {
                    if let Operand::Temp(t) = *t {
                        tempregs.insert(t);
                    }
                }
                for (i, arg) in args.into_iter().enumerate() {
                    let i = i as u32;
                    // the first few arguments in registers need to be copied
                    // because all argument registers are caller-saved registers
                    if i < arch::ARG_REGS {
                        newargs.push(constrain_clobber!(arg));
                    } else {
                        if let Operand::Temp(ref t) = arg {
                            if !live_out.contains(t) && !tempregs.contains(t) {
                                live_in.remove(t);
                            }
                        }
                        let off = (i - arch::ARG_REGS) * arch::PTRSIZE;
                        new.push(Inst::Store(Address::Stack(off), arg));
                    }
                }

                new.push(pcopy(&live_in));
                new.push(Inst::Call(dst, fun, newargs));
            }

            // x86 forces the return register to be %eax
            Inst::Return(o) => {
                new.push(pcopy(&live_in));
                new.push(Inst::Return(o));
            }

            ins => new.push(ins)
        }

        liveness::apply(&mut live_in, &delta[i]);
        for tmp in synthetic.iter() {
            live_in.remove(tmp);
        }
        synthetic.truncate(0);
    }
    return new;
}
