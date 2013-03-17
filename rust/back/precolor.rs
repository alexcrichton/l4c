use core::hashmap::linear::LinearSet;

use back::assem::*;
use middle::{liveness, temp};
use middle::temp::Temp;
use back::arch;

pub fn constrain(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    let mut live = liveness::Analysis();
    liveness::calculate(&f.cfg, f.root, &mut live);
    let mut temps = temp::new_init(f.temps);
    do f.cfg.map_nodes |id, stms| {
      constrain_block(live.in.get(&id), *live.deltas.get(&id), |t| {
        let tmp = temps.new();
        /* TODO: why can't this be one statement */
        let size; size = *f.sizes.get(&t);
        f.sizes.insert(tmp, size);
        tmp
      }, stms)
    }
  }
}

fn constrain_block(live: &temp::TempSet, delta: &[liveness::Delta],
                   tmpclone: &fn(Temp) -> Temp,
                   ins: ~[~Instruction]) -> ~[~Instruction] {
  let mut new = ~[];
  let mut synthetic = ~[];
  let mut live_in = LinearSet::new();
  let mut live_out = LinearSet::new();
  for live.each |&t| {
    live_in.insert(t);
    live_out.insert(t);
  }

  /* SSA will deal with these renamings later */
  fn pcopy(live: &temp::TempSet) -> ~Instruction {
    let mut copies = ~[];
    for live.each |&tmp| {
      copies.push((tmp, tmp));
    }
    ~PCopy(copies)
  }

  /* If a constrained use is also always clobbered as a result of an
     instruction, then it needs to be moved into a temporary before the
     instruction runs to not destroy the actual value. We push this move
     before the PCopy as well for ease later on */
  macro_rules! constrain_clobber(
    ($op:expr) =>
    (
      match $op {
        ~Temp(t) if live_out.contains(&t) => {
          let dup = tmpclone(t);
          let dst = ~Temp(dup);
          new.push(~Move(copy dst, ~Temp(t)));
          fail_unless!(live_in.insert(dup));
          synthetic.push(dup);
          dst
        }
        o => o
      }
    )
  );

  do vec::consume(ins) |i, ins| {
    liveness::apply(&mut live_out, &delta[i]);

    match ins {
      ~BinaryOp(op, dest, o1, o2) => {
        match (op, o2) {
          /* x86 shifts must have the operand in the %cl register unless the
             argument is an immediate */
          (Lsh, ~Temp(t)) | (Rsh, ~Temp(t)) => {
            new.push(pcopy(&live_in));
            new.push(~BinaryOp(op, dest, o1, ~Temp(t)));
            new.push(~Use(t));
          }

          /* div/mod both use and define edx/eax */
          (Div, o2) | (Mod, o2) => {
            let o1 = constrain_clobber!(o1);
            new.push(pcopy(&live_in));
            new.push(~BinaryOp(op, dest, o1, o2));
          }

          /* Because x86 has two-operand form, all non-commutative operations
             need to have their second argument in interference with the
             destination because otherwise when moving the first argument to the
             destination the second argument could get clobbered. This is fixed
             with a pseudo-use of the second operand right after the
             instruction */
          (op, ~Temp(t)) if !op.commutative() => {
            new.push(~BinaryOp(op, dest, o1, ~Temp(t)));
            new.push(~Use(t));
          }

          /* otherwise we're unconstrained! */
          (_, o2) => { new.push(~BinaryOp(op, dest, o1, o2)); }
        }
      }

      /* calling conventions dictate that we must save all caller-saved
         registers and we will have to put our first few arguments in very
         specific registers. This throws in a lot of complications, so here we
         throw in a PCopy for live-range splitting, and we also move all the
         arguments to the stack that need to be on the stack  */
      ~Call(dst, fun, args) => {
        let mut newargs = ~[];
        let mut tempregs = LinearSet::new();
        for args.view(0, uint::min(arch::arg_regs, args.len())).each |t| {
          match *t {
            ~Temp(t) => { tempregs.insert(t); }
            _ => ()
          }
        }
        do vec::consume(args) |i, arg| {
          /* the first few arguments in registers need to be copied because all
             argument registers are caller-saved registers */
          if i < arch::arg_regs {
            newargs.push(constrain_clobber!(arg));
          } else {
            match arg {
              ~Temp(ref t) if !live_out.contains(t) && !tempregs.contains(t) => {
                live_in.remove(t);
              }
              _ => ()
            }
            new.push(~Store(~Stack((i - arch::arg_regs) * arch::ptrsize), arg));
          }
        }

        new.push(pcopy(&live_in));
        new.push(~Call(dst, fun, newargs));
      }

      /* x86 forces the return register to be %eax */
      ~Return(o) => {
        new.push(pcopy(&live_in));
        new.push(~Return(o));
      }

      ins => new.push(ins)
    }

    liveness::apply(&mut live_in, &delta[i]);
    for synthetic.each |tmp| {
      live_in.remove(tmp);
    }
    synthetic.truncate(0);
  }
  return new;
}
