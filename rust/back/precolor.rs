use back::assem::*;
use middle::{liveness, temp};

pub fn constrain(p : &Program) {
  for p.funs.each |f| {
    let (live_in, deltas) = liveness::calculate(&f.cfg, f.root);
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
  let mut synthetic = ~[];
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

  /* If a constrained use is also always clobbered as a result of an
     instruction, then it needs to be moved into a temporary before the
     instruction runs to not destroy the actual value. We push this move
     before the PCopy as well for ease later on */
  macro_rules! constrain_clobber(
    ($op:expr) => (
      match $op {
        @Temp(t) if set::contains(live_out, t) => {
          let dup = tmpclone(t);
          let dst = @Temp(dup);
          new.push(@Move(dst, $op));
          assert set::add(live_in, dup);
          synthetic.push(dup);
          dst
        }
        _ => $op
      }
    );
  );

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
            match o2 {
              @Temp(t) => new.push(@Use(t)),
              _ => ()
            }
          }

          /* div/mod both use and define edx/eax */
          Div | Mod => {
            let o1 = constrain_clobber!(o1);
            new.push(pcopy(live_in));
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
        let mut i = -1;
        let args = do args.filter_map |&arg| {
          i += 1;
          /* the first few arguments in registers need to be copied because all
             argument registers are caller-saved registers */
          if i < arch::arg_regs {
            Some(constrain_clobber!(arg))
          } else {
            new.push(@Store(@Stack((i - arch::arg_regs) * arch::ptrsize), arg));
            match arg {
              @Temp(t) if !set::contains(live_out, t) =>
                { set::remove(live_in, t); }
              _ => ()
            }
            None
          }
        };

        new.push(pcopy(live_in));
        new.push(@Call(dst, fun, args));
      }

      _ => new.push(ins)
    }

    live_in.apply(delta);
    for synthetic.each |&tmp| {
      set::remove(live_in, tmp);
    }
    synthetic.truncate(0);
  }
  return new;
}
