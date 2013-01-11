use back::assem::*;
use middle::{liveness, temp};

pub fn constrain(p : &Program) {
  for p.funs.each |f| {
    let (live_in, deltas) = liveness::calculate(&f.cfg, f.root, 0);
    let temps = temp::new_init(f.temps);
    for f.cfg.each_node |id, &stms| {
      let blk = constrain_block(live_in[id], deltas[id], |t| {
        let tmp = temps.new();
        f.sizes.insert(tmp, f.sizes[t]);
        tmp
      }, stms);
      f.cfg.update_node(id, @blk);
    }
  }
}

fn constrain_block(live : liveness::LiveIn, delta : liveness::DeltaList,
                   tmpclone : &fn(Temp) -> Temp,
                   ins : @~[@Instruction]) -> ~[@Instruction] {
  let mut new = ~[];
  let live_in = live;
  let live_out = map::HashMap();
  for live_in.each |k, v| { live_out.insert(k, v); }

  /* SSA will deal with these renamings later? */
  fn pcopy(live : liveness::LiveIn) -> @Instruction {
    let mut list = ~[];
    for set::each(live) |tmp| {
      list.push((tmp, tmp));
    }
    @PCopy(list)
  }

  for vec::each2(*ins, *delta) |&ins, delta| {
    live_out.apply(delta);

    match ins {
      @BinaryOp(op, dest, o1, o2) if op.constrained() => {
        match op {
          /* x86 shifts must have the operand in the %cl register unless the
             argument is an immediate */
          Lsh | Rsh => {
            if !o2.imm() {
              new.push(pcopy(live_in));
            }
            new.push(ins);
          }

          /* div/mod both use and define edx/eax. If the first operand is live
             after the div instruction, then we have to use a copy of it because
             the operand's register will be clobbered */
          Div | Mod => {
            new.push(pcopy(live_in));
            let o1 = match o1 {
              @Temp(t) if set::contains(live_out, t) => {
                let dst = @Temp(tmpclone(t));
                new.push(@Move(dst, o1));
                dst
              }
              _ => o1
            };
            new.push(@BinaryOp(op, dest, o1, o2));
          }

          _ => fail(fmt!("%? doesn't have constraints listed", op))
        }
      }

      /* Because x86 has two-operand form, all non-commutative operations need
         to have their second argument in interference with the destination
         because otherwise when moving the first argument to the destination the
         second argument could get clobbered. This is fixed with a pseudo-use of
         the second operand right after the instruction */
      @BinaryOp(op, _, _, @Temp(t)) if !op.commutative() => {
        new.push(ins);
        new.push(@Use(t));
      }

      /* calling conventions dictate that we must save all caller-saved
         registers and we will have to put our first few arguments in very
         specific registers */
      @Call(dst, fun, ref args) => {
        new.push(pcopy(live_in)); /* break liveness of all variables */

        let args = do args.mapi |i, &arg| {
          /* the first few arguments in registers need to be copied because all
             argument registers are caller-saved registers */
          let src = match arg {
            @Temp(t) if i < arch::arg_regs && set::contains(live_out, t) => {
              let dst = @Temp(tmpclone(t));
              new.push(@Move(dst, arg));
              dst
            }
            _ => arg
          };
          /* Move the argument to the right spot */
          if i >= arch::arg_regs {
            new.push(@Store(@StackArg(i - arch::arg_regs), src));
          }

          src
        };

        new.push(@Call(dst, fun, args));
      }

      _ => new.push(ins)
    }

    live_in.apply(delta);
  }
  return new;
}
