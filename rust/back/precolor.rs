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

  fn pcopy(live : liveness::LiveIn) -> @Instruction {
    fail(~"need a parallel copy instruction");
  }

  for vec::each2(*ins, *delta) |&ins, delta| {
    live.apply(delta);

    match ins {
      @BinaryOp(op, dest, o1, o2) if op.constrained() => {
        match op {
          /* x86 shifts must have the operand in the %cl register unless the
             argument is an immediate */
          Lsh | Rsh => {
            if !o2.imm() {
              new.push(pcopy(live));
            }
            new.push(ins);
          }

          /* div/mod both use and define edx/eax. If the first operand is live
             after the div instruction, then we have to use a copy of it because
             the operand's register will be clobbered */
          Div | Mod => {
            new.push(pcopy(live));
            let o1 = match o1 {
              @Temp(t) if set::contains(live, t) => {
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

      _ => new.push(ins)
    }
  }
  return new;
}
