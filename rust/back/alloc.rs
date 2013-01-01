use std::map;
use middle::temp;
use back::assem::*;
use utils::bitv::Bitv;

struct Allocator {
  f : &Function,
  colors : map::HashMap<temp::Temp, uint>,

  live_in : map::HashMap<graph::NodeId, @Bitv>,
  defs : map::HashMap<temp::Temp, graph::NodeId>,
  last_uses : map::HashMap<graph::NodeId, map::HashMap<temp::Temp, uint>>,
  phi_uses : map::HashMap<graph::NodeId, map::Set<temp::Temp>>,
  args : Bitv,
}

pub fn color(p : &Program) {
  for p.funs.each |f| {
    let a = Allocator{ colors: map::HashMap(),
                       f: f,
                       live_in: map::HashMap(),
                       defs: map::HashMap(),
                       last_uses: map::HashMap(),
                       phi_uses: map::HashMap(),
                       args : Bitv(f.temps, false) };

    for f.args.eachi |i, &tmp| {
      a.args.set(tmp as uint, true);
      a.colors.insert(tmp, i + 1);
    }
    a.eliminate_critical();
    info!("preparing: %s", f.name);
    for f.cfg.each_node |id, _| {
      a.last_uses.insert(id, map::HashMap());
      a.live_in.insert(id, @Bitv(f.temps, false));
      a.phi_uses.insert(id, map::HashMap());
    }
    for f.postorder.each |&id| {
      a.prepare(id);
    }
    info!("building live_in: %s", f.name);
    for f.args.each |&arg| {
      a.live_in[f.root].set(arg, true);
    }
    for f.postorder.each |&id| {
      a.build_live(id);
    }
    info!("coloring: %s", f.name);
    a.color(f.root);
    for a.colors.each |tmp, color| {
      debug!("%s => %?", tmp.to_str(), color);
    }

    a.remove_phis();
    a.apply_coloring();
  }
}

impl Allocator {
  /**
   * Eliminate all critical edges in the graph by splitting them and placing a
   * basic block on the edge. The fact that there are no critical edges in the
   * graph is leveraged when spilling registers and removing phi nodes.
   */
  fn eliminate_critical() {
    /* can't modify the graph during traversal */
    let mut critical = ~[];
    let cfg = &self.f.cfg;
    for cfg.each_edge |n1, n2| {
      /* critical edges are defined as those whose source has multiple out edges
         and whose target has multiple in edges */
      if cfg.num_succ(n1) > 1 && cfg.num_pred(n2) > 1 {
        critical.push((n1, n2));
      }
    }
    for critical.each |&(n1, n2)| {
      let edge = cfg.remove_edge(n1, n2);
      let new = cfg.new_id();
      cfg.add_node(new, @~[]);
      cfg.add_edge(n1, new, edge);
      cfg.add_edge(new, n2, ir::Always);
    }
  }

  /* Build up tables needed for liveness */
  fn prepare(n : graph::NodeId) {
    debug!("preparing %?", n);
    let last_uses = self.last_uses[n];
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
      self.upmark(n, tmp);
    }

    /* For each temp used in this block, mark it as live in the block and then
       traverse back towards its definition doing the same */
    for self.f.cfg[n].each |&ins| {
      /* each_use skips phi nodes */
      for ins.each_use |tmp| {
        debug!("-- use %? at %?", tmp, n);
        self.upmark(n, tmp);
      }
    }
  }

  fn upmark(n : graph::NodeId, t : temp::Temp) {
    debug!("upmark %? %?", n, t);
    if self.args[t as uint] || self.defs[t] == n { return }
    let bitv = self.live_in[n];
    if bitv[t as uint] { return }
    bitv.set(t as uint, true);
    for self.f.cfg.each_pred(n) |pred| {
      self.upmark(pred, t);
    }
  }

  /**
   * Color the functions CFG according to the algorithm outlined in the paper
   * "Towards Register Allocation for Programs in SSA-form" by Hack et al.
   * A top-down traversal of the dominator tree is done, coloring all
   * definitions as they are seen with the first available color.
   */
  fn color(n : graph::NodeId) {
    let assigned = map::HashMap();
    debug!("at block %?", n);
    for self.live_in[n].ones |t| {
      debug!("live in %?", t as temp::Temp);
      set::add(assigned, self.colors[t as temp::Temp]);
    }

    for self.f.cfg[n].eachi |i, &ins| {
      for ins.each_use |tmp| {
        debug!("found use %?", tmp);
        if self.last_use(tmp, n, i) {
          debug!("removing %?", tmp);
          assigned.remove(self.colors[tmp]);
        }
      }
      for ins.each_def |tmp| {
        let color = self.min_vacant(assigned);
        self.colors.insert(tmp, color);
        set::add(assigned, color);
      }
    }

    for set::each(self.f.idominated[n]) |id| {
      self.color(id);
    }
  }

  fn last_use(t : temp::Temp, n : graph::NodeId, i : uint) -> bool {
    /* If any block n immediately dominates use t, then we certainly aren't the
       last use of the variable t */
    for set::each(self.f.idominated[n]) |id| {
      if self.live_in[id][t as uint] {
        return false;
      }
    }
    /* otherwise make sure we're the last instruction in the block to use */
    return self.last_uses[n][t] == i;
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
   * all basic blocks.
   *
   * This also converts all three-operand binary ops to two-operand binops
   * because x86 is so awesome.
   */
  fn apply_coloring() {
    for self.f.cfg.each_node |id, ins| {
      let ins = vec::build(|push|
        for ins.each |&ins| { self.alloc_ins(ins, push); }
      );
      self.f.cfg.update_node(id, @ins);
    }
  }

  fn alloc_ins(i : @Instruction, push : &pure fn(@Instruction)) {
    match i {
      @Return | @Raw(*) | @Comment(*) | @Phi(*) => push(i),
      @Condition(c, o1, o2) =>
        push(@Condition(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Die(c, o1, o2) =>
        push(@Die(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Move(o1, o2) => push(@Move(self.alloc_op(o1), self.alloc_op(o2))),

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
          fail(~"think about this");
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
      @Memory(@MOp(o), size) => @Memory(@MOp(self.alloc_op(o)), size),
      @Immediate(*) | @LabelOp(*) | @Register(*) | @Memory(*) => o,
      @Temp(tmp) =>
        @Register(arch::num_reg(self.colors[tmp]),
                  self.f.sizes[tmp])
    }
  }
}
