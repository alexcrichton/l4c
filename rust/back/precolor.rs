use back::assem::*;
use middle::liveness;

pub fn constrain(p : &Program) {
  for p.funs.each |f| {
    let (live_in, deltas) = liveness::calculate(&f.cfg, f.root, 0);
    for f.cfg.each_node |id, &stms| {
      f.cfg.update_node(id, @constrain_block(live_in[id], deltas[id], stms));
    }
  }
}

fn constrain_block(live : liveness::LiveIn, delta : liveness::DeltaList,
                   ins : @~[@Instruction]) -> ~[@Instruction] {
  let mut new = ~[];
  for vec::each2(*ins, *delta) |&ins, delta| {
    match ins {
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

    live.apply(delta);
    new.push(ins);
  }
  return new;
}
