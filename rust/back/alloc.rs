use std::map;
use middle::{ssa, ir};
use middle::temp::Temp;
use back::assem::*;
use utils::bitv::Bitv;

type CFG = graph::Graph<@~[@assem::Instruction], ir::Edge>;

struct Allocator {
  f : &Function,
  colors : map::HashMap<Temp, uint>,
  slots : map::HashMap<Tag, uint>,

  live_in : map::HashMap<graph::NodeId, (@Bitv, @Bitv)>,
  defs : map::HashMap<Temp, graph::NodeId>,
  spill_defs : map::HashMap<Tag, graph::NodeId>,
  last_uses : map::HashMap<graph::NodeId, map::HashMap<Temp, uint>>,
  last_spill_uses : map::HashMap<graph::NodeId, map::HashMap<Tag, uint>>,
  phi_uses : map::HashMap<graph::NodeId, map::Set<Temp>>,
}

pub fn color(p : &Program) {
  for p.funs.each |f| {
    let a = Allocator{ colors: map::HashMap(),
                       slots: map::HashMap(),
                       f: f,
                       live_in: map::HashMap(),
                       defs: map::HashMap(),
                       spill_defs: map::HashMap(),
                       last_uses: map::HashMap(),
                       last_spill_uses: map::HashMap(),
                       phi_uses: map::HashMap(), };

    info!("preparing: %s", f.name);
    for f.cfg.each_node |id, _| {
      a.last_uses.insert(id, map::HashMap());
      a.last_spill_uses.insert(id, map::HashMap());
      a.live_in.insert(id, (@Bitv(f.temps, false), @Bitv(f.temps, false)));
      a.phi_uses.insert(id, map::HashMap());
    }
    for f.cfg.each_node |id, _| {
      a.prepare(id);
    }

    /* Build all the metadata about phis/liveness needed */
    info!("building live_in: %s", f.name);
    for f.cfg.each_node |id, _| {
      a.build_live(id);
    }

    /* Color the graph completely */
    info!("coloring: %s", f.name);
    a.color(f.root, f.idominated);
    for a.colors.each |tmp, color| {
      debug!("%s => %?", tmp.to_str(), color);
    }

    /* Finally remove all phi nodes and all temps */
    a.remove_phis();
    a.remove_temps();
  }
}

impl Allocator {
  /* Build up tables needed for liveness */
  fn prepare(n : graph::NodeId) {
    debug!("preparing %?", n);
    let last_uses = self.last_uses[n];
    let last_spill_uses = self.last_spill_uses[n];
    for self.f.cfg[n].eachi |i, &ins| {
      for ins.each_def |tmp| {
        assert self.defs.insert(tmp, n);
      }
      for ins.each_use |tmp| {
        last_uses.insert(tmp, i);
      }
      match ins {
        @Phi(_, map) => {
          for map.each |pred, tmp| {
            set::add(self.phi_uses[pred], tmp);
          }
        }
        @Spill(_, t) => assert self.spill_defs.insert(t, n),
        @Reload(_, t) => { last_spill_uses.insert(t, i); }
        _ => ()
      }
    }
  }

  /**
   * Build the live_in sets of the allocator. This is used when coloring the
   * graph later on. this algorithm is described here:
   *    http://hal.inria.fr/docs/00/58/53/03/PDF/RR-7503.pdf
   * as algorithms 4/5. The paper describes how to calculate the live_in and
   * live_out sets for each basic block, but we're only interested in the
   * live_in information so we can slightly modify the algorithm.
   */
  fn build_live(n : graph::NodeId) {
    debug!("building %?", n);

    for set::each(self.phi_uses[n]) |tmp| {
      self.upmark(n, tmp, false);
    }

    /* For each temp used in this block, mark it as live in the block and then
       traverse back towards its definition doing the same */
    for self.f.cfg[n].each |&ins| {
      /* each_use skips phi nodes */
      for ins.each_use |tmp| {
        debug!("-- use %? at %?", tmp, n);
        self.upmark(n, tmp, false);
      }
      match ins {
        @Reload(_, t) => self.upmark(n, t, true),
        _ => ()
      }
    }
  }

  fn upmark(n : graph::NodeId, t : Temp, spill : bool) {
    debug!("upmark %? %? %?", n, t, spill);
    if spill {
      if self.spill_defs[t] == n { return }
      let bitv = self.live_in[n].second();
      if bitv[t as uint] { return }
      bitv.set(t as uint, true);
    } else {
      if self.defs[t] == n { return }
      let bitv = self.live_in[n].first();
      if bitv[t as uint] { return }
      bitv.set(t as uint, true);
    }
    for self.f.cfg.each_pred(n) |pred| {
      self.upmark(pred, t, spill);
    }
  }

  /**
   * Color the functions CFG according to the algorithm outlined in the paper
   * "Towards Register Allocation for Programs in SSA-form" by Hack et al.
   * A top-down traversal of the dominator tree is done, coloring all
   * definitions as they are seen with the first available color.
   */
  fn color(n : graph::NodeId, idominated : ssa::Idominated) {
    debug!("at block %? %?", n, self.f.temps);
    let registers = map::HashMap();
    let slots = map::HashMap();
    for self.live_in[n].first().ones |t| {
      set::add(registers, self.colors[t as Temp]);
    }
    for self.live_in[n].second().ones |t| {
      set::add(slots, self.slots[t as Temp]);
    }

    for self.f.cfg[n].eachi |i, &ins| {
      debug!("%s", ins.pp());
      for ins.each_use |tmp| {
        debug!("found use %?", tmp);
        if self.last_use(tmp, n, i) {
          debug!("removing %?", tmp);
          set::remove(registers, self.colors[tmp]);
        }
      }
      for ins.each_def |tmp| {
        let color = self.min_vacant(registers);
        assert(color <= arch::num_regs);
        self.colors.insert(tmp, color);
        if !self.last_use(tmp, n, i) {
          set::add(registers, color);
        }
      }
      match ins {
        @Spill(_, t) => {
          let slot = self.min_vacant(slots);
          self.slots.insert(t, slot);
          set::add(slots, slot);
        }
        @Reload(_, t) => {
          if self.last_spill_use(t, n, i) {
            set::remove(slots, self.slots[t]);
          }
        }
        _ => ()
      }
    }

    for set::each(idominated[n]) |id| {
      self.color(id, idominated);
    }
  }

  fn last_use(t : Temp, n : graph::NodeId, i : uint) -> bool {
    /* If any block n immediately dominates use t, then we certainly aren't the
       last use of the variable t */
    for self.f.cfg.each_succ(n) |id| {
      if self.live_in[id].first()[t as uint] {
        return false;
      }
    }
    /* otherwise make sure we're the last instruction in the block to use */
    match self.last_uses[n].find(t) {
      None => true, /* this is never used anywhere */
      Some(last) => i == last
    }
  }

  fn last_spill_use(t : Temp, n : graph::NodeId, i : uint) -> bool {
    /* If any block n immediately dominates use t, then we certainly aren't the
       last use of the variable t */
    for self.f.cfg.each_succ(n) |id| {
      if self.live_in[id].second()[t as uint] {
        return false;
      }
    }
    /* otherwise make sure we're the last instruction in the block to use */
    return self.last_spill_uses[n][t] == i;
  }

  fn min_vacant(colors : map::Set<uint>) -> uint {
    let mut i = 1;
    while set::contains(colors, i) {
      i += 1;
    }
    return i;
  }

  fn remove_phis() {
    let cfg = &self.f.cfg;
    for cfg.each_node |id, ins| {
      let mut phi_vars = ~[];
      let mut phi_maps = ~[];
      for ins.each |&ins| {
        match ins {
          @Phi(tmp, map) => {
            phi_vars.push(self.colors[tmp]);
            phi_maps.push(map);
          }
          _ => break
        }
      }

      for cfg.each_pred(id) |pred| {
        let mut perm = ~[];
        for phi_maps.each |map| {
          perm.push(self.colors[map[pred]]);
        }
        /* there are no critical edges in the graph, so we can just append */
        let ins = self.resolve_perm(phi_vars, perm);
        if ins.len() == 0 { loop }
        let prev = cfg[pred];
        cfg.update_node(pred, @(prev + ins));
      }
    }
  }

  fn resolve_perm(result : &[uint], incoming : &[uint]) -> ~[@Instruction] {
    let mut diff = ~[];
    for vec::each2(result, incoming) |&a, &b| {
      if a != b {
        diff.push((a, b));
      }
    }
    let tmp = |i : uint| @Register(arch::num_reg(i), ir::Pointer);

    if diff.len() == 0 {
      return ~[];
    } else if diff.len() == 1 {
      return ~[
        @Move(tmp(diff[0].first()), tmp(diff[0].second()))
      ];
    }
    fail(fmt!("%? %? %?", diff, result, incoming));
  }

  /**
   * Apply the coloring previously generated to all instructions and operands in
   * all basic blocks. This means that the cfg will no longer have any temps,
   * and that it will no longer be in SSA-form.
   *
   * This also converts all three-operand binary ops to two-operand binops
   * because x86 is so awesome.
   */
  fn remove_temps() {
    for self.f.cfg.each_node |id, ins| {
      let ins = vec::build(|push|
        for ins.each |&ins| { self.alloc_ins(ins, push); }
      );
      self.f.cfg.update_node(id, @ins);
    }
  }

  fn alloc_ins(i : @Instruction, push : &pure fn(@Instruction)) {
    match i {
      @Spill(tmp, tag) => {
        let reg = @Register(arch::num_reg(self.colors[tmp]), self.f.sizes[tmp]);
        let slot = @Stack(self.slots[tag] * arch::ptrsize);
        push(@Store(slot, reg));
      }
      @Reload(dst, tag) => {
        let reg = @Register(arch::num_reg(self.colors[dst]), self.f.sizes[dst]);
        let slot = @Stack(self.slots[tag] * arch::ptrsize);
        push(@Load(reg, slot));
      }
      @Load(dst, @MOp(addr)) =>
        push(@Load(self.alloc_op(dst), @MOp(self.alloc_op(addr)))),
      @Load(dst, addr) => push(@Load(self.alloc_op(dst), addr)),
      @Store(@MOp(addr), src) =>
        push(@Store(@MOp(self.alloc_op(addr)), self.alloc_op(src))),
      @Store(addr, src) => push(@Store(addr, self.alloc_op(src))),
      @Return | @Raw(*) | @Phi(*) => push(i),
      @Condition(c, o1, o2) =>
        push(@Condition(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Die(c, o1, o2) =>
        push(@Die(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Move(o1, o2) => push(@Move(self.alloc_op(o1), self.alloc_op(o2))),

      /* x86 imul can have 3 operands if one is an immediate */
      @BinaryOp(Mul, d, s1, s2) if s1.imm() && !s2.imm() =>
        push(@BinaryOp(Mul, self.alloc_op(d), self.alloc_op(s2), s1)),
      @BinaryOp(Mul, d, s1, s2) if s2.imm() && !s1.imm() =>
        push(@BinaryOp(Mul, self.alloc_op(d), self.alloc_op(s1), s2)),

      /* When going through formatting and on x86 -
            BinaryOp(op, d, s1, s2) <=> d = d op s1
         and s2 is put in the commments */
      @BinaryOp(op, d, s1, s2) => {
        let d = self.alloc_op(d);
        let s1 = self.alloc_op(s1);
        let s2 = self.alloc_op(s2);

        if s1 == d {                             /* d = d op s2, perfect! */
          push(@BinaryOp(op, d, s2, s1));
        } else if s2 == d && op.commutative() {  /* d = s1 op d, must commute */
          push(@BinaryOp(op, d, s1, s2));
        } else if s2 == d {
          match op {
            /* d = s1 - d = -(d - s1) */
            assem::Sub => {
              push(@BinaryOp(op, d, s1, s2));
              push(@Raw(~"neg " + d.pp()));
            }
            _ => fail(fmt!("think about this: %s", i.pp()))
          }
        } else {
          push(@Move(d, s1));
          push(@BinaryOp(op, d, s2, s1));
        }
      }
      @Call(e, n) => push(@Call(self.alloc_op(e), n))
    }
  }

  fn alloc_op(o : @Operand) -> @Operand {
    match o {
      @Immediate(*) | @LabelOp(*) | @Register(*) => o,
      @Temp(tmp) =>
        @Register(arch::num_reg(self.colors[tmp]),
                  self.f.sizes[tmp])
    }
  }
}
