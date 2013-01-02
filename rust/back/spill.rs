/**
 * The spilling algorithm implemented is outlined in the paper "Register
 * Spilling and Live-Range Splitting for SSA-Form Programs" by Braun and Hack.
 *
 * The basic idea of the spilling algorithm is to run the "Belady Method" on all
 * basic blocks and combine the data. The Belady method states that if a
 * register must be evicted, then the register which should be evicted is the
 * one that is used "farthest in the future."
 *
 * To implement this, each block develops a set of temps assumed in registers on
 * entry, and a subset of this which may be spilled. The belady method is then
 * run, inserting reloads/spills as the block progresses, and then the results
 * are recorded in the output.
 *
 * When inserting reloads, the SSA form of the graph is destroyed because a
 * reload is a redefinition of that temporary. For this reason, register
 * allocation puts the graph back into SSA form right before running its
 * coloring algorithm.
 *
 * Much more detailed information about how the spilling works in theory is
 * located in the paper above, and comments of implementation can be found
 * throughout the code in this file.
 */

use std::{map, sort};
use middle::temp::Temp;
use back::assem::*;
use utils::graph::*;

const loop_out_weight : uint = 100000;

/* If a temp isn't in a set, then its next_use distance is infinity */
type NextUse = map::HashMap<Temp, uint>;
type TempSet = map::Set<Temp>;

struct Spiller {
  f : &Function,
  /* next_use information for each node in the graph */
  next_use : map::HashMap<NodeId, NextUse>,
  /* Delta information for next_use as a block is traversed top down */
  deltas : map::HashMap<NodeId, @~[~[(Temp, Option<uint>)]]>,

  /* Information required by the spilling algorithm */
  regs_entry : map::HashMap<NodeId, TempSet>,
  regs_end : map::HashMap<NodeId, TempSet>,
  spill_entry : map::HashMap<NodeId, TempSet>,
  spill_exit : map::HashMap<NodeId, TempSet>,

  /* m[(a, b)] => (t1 -> t2) means that any temp known by the name t1 in a
     becomes the temp named t2 in b */
  renamings : map::HashMap<(NodeId, NodeId), map::HashMap<Temp, Temp>>,
  /* m[a] = t1 -> (n -> t2) means that in block a, the temp t1 is known under the
     name t2 in node n */
  phis : map::HashMap<NodeId, map::HashMap<Temp, map::HashMap<NodeId, Temp>>>,

  /* Maximum register pressure at each basic block */
  max_pressures : map::HashMap<NodeId, uint>,
  /* Set of edges which have been connected (spills/reloads placed) so far */
  connected : map::Set<(NodeId, NodeId)>,
}

pub fn spill(p : &Program) {
  for p.funs.each |f| {
    let s = Spiller{ f: f,
                     next_use: map::HashMap(),
                     deltas: map::HashMap(),
                     regs_end: map::HashMap(),
                     regs_entry: map::HashMap(),
                     spill_entry: map::HashMap(),
                     spill_exit: map::HashMap(),
                     renamings: map::HashMap(),
                     phis: map::HashMap(),
                     max_pressures: map::HashMap(),
                     connected: map::HashMap() };

    /* Build up phi renaming maps */
    s.eliminate_critical();
    for f.cfg.each_node |n, _| {
      s.build_renamings(n);
    }

    /* Prepare the graph and build all next_use information */
    let mut changed = true;
    while changed {
      changed = false;
      for f.cfg.each_postorder(f.root) |&id| {
        changed = s.build_next_use(id) || changed;
      }
    }

    /* In reverse postorder, spill everything! */
    for f.cfg.each_rev_postorder(f.root) |&id| {
      s.spill(id);
    }
  }
}

fn sort(set : TempSet, s : NextUse) -> ~[Temp] {
  let mut v = ~[];
  for set::each(set) |tmp| {
    v.push(tmp);
  }
  sort::quick_sort(v, |&a : &Temp, &b : &Temp| {
    match s.find(b) {
      None => true,       /* a is always < infty */
      Some(b) => match s.find(a) {
        None => false,    /* infty always > n */
        Some(a) => a <= b
      }
    }
  });
  return v;
}

fn map_to_str(m : NextUse) -> ~str {
  let mut s = ~"{";
  for m.each |k, v| {
    s += fmt!("(%? => %?) ", k, v);
  }
  return s + ~"}";
}

fn set_to_str(m : TempSet) -> ~str {
  let mut s = ~"{";
  for m.each_key |k| {
    s += fmt!("%? ", k);
  }
  return s + ~"}";
}

impl Spiller {
  /**
   * Build up internal maps of the renaming of temps done by phi functions per
   * node. This just needs to iterate and look at every phi node in a block.
   */
  fn build_renamings(n : NodeId) {
    for self.f.cfg.each_pred(n) |pred| {
      self.renamings.insert((pred, n), map::HashMap());
    }
    let phis = map::HashMap();
    self.phis.insert(n, phis);
    for self.f.cfg[n].each |&ins| {
      match ins {
        @Phi(my_name, renamings) => {
          for renamings.each |pred, their_name| {
            self.renamings[(pred, n)].insert(their_name, my_name);
          }
          phis.insert(my_name, renamings);
        }
        _ => ()
      }
    }
  }

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
      debug!("splitting critical edge %? %?", n1, n2);
      let edge = cfg.remove_edge(n1, n2);
      let new = cfg.new_id();
      cfg.add_node(new, @~[]);
      cfg.add_edge(n1, new, edge);
      cfg.add_edge(new, n2, ir::Always);
    }
  }

  /**
   * This performs the dataflow analysis necessary to build the internal maps of
   * the next_use information. This returns whether any information was modified
   * or not.
   *
   * The analysis is a backwards analysis (like liveness).
   */
  fn build_next_use(n : NodeId) -> bool {
    debug!("processing: %?", n);
    let bottom = map::HashMap();
    let block = self.f.cfg[n];

    /* Union each of our predecessors into the 'bottom' map */
    for self.f.cfg.each_succ(n) |succ| {
      if !self.next_use.contains_key(succ) { loop }
      let edge_cost = match self.f.cfg.edge(n, succ) {
        ir::LoopOut | ir::FLoopOut => loop_out_weight, _ => 0
      };
      /* Assume that all variables aren't used in this block and add block.len()
         to the value being merged. This will be updated if the value is
         actually used in the block */
      self.merge(bottom, self.next_use[succ], block.len() + edge_cost);
    }

    /* Process all of our block's statements backwards */
    let mut deltas = ~[];
    let mut max = bottom.size();
    for vec::rev_eachi(*block) |i, &ins| {
      let mut delta = ~[];
      /* If we define a temp, then the distance to the next use from the start
         is infinity because it's just not relevant */
      for ins.each_def |tmp| {
        match bottom.find(tmp) {
          None    => (), /* well apparently this wasn't used anywhere */
          Some(d) => {
            bottom.remove(tmp);         /* liveness stops here */
            delta.push((tmp, Some(d)));
          }
        }
      }

      /* Our delta contains what the last distance to the temp used to be (None
       * for infty), and then we update it to our current distance now */
      for ins.each_use |tmp| {
        delta.push((tmp, bottom.find(tmp)));
        bottom.insert(tmp, i);
      }
      deltas.push(delta);
      max = uint::max(max, bottom.size());
    }

    /* If we didn't update anything, return false */
    match self.next_use.find(n) {
      Some(before) => {
        let mut diff = false;
        for bottom.each |k, v| {
          match before.find(k) {
            Some(v2) => { diff = v2 != v; }
            None     => { diff = true; }
          }
          if diff { break }
        }
        if !diff {
          return false;
        }
      }
      None => ()
    }

    /* If we did update something, then update it and return so */
    self.next_use.insert(n, bottom);
    vec::reverse(deltas);
    self.deltas.insert(n, @deltas);
    self.max_pressures.insert(n, max);
    return true;
  }

  fn merge(a : NextUse, b : NextUse, edge : uint) {
    for b.each |tmp, next| {
      let cost = next + edge;
      match a.find(tmp) {
        Some(amt) => { if cost < amt { a.insert(tmp, cost); } }
        None => { a.insert(tmp, cost); }
      }
    }
  }

  /**
   * This functions spills all necessary temps for the specified block. This may
   * possibly insert spills/reloads in predecessor and successors depending on
   * their processed state.
   */
  fn spill(n : NodeId) {
    debug!("spilling: %?", n);
    let regs_entry = match self.f.loops.find(n) {
      Some((body, end)) => self.init_loop(n, body, end),
      None            => self.init_usual(n)
    };
    let spill_entry = self.connect_pred(n, regs_entry);
    self.regs_entry.insert(n, regs_entry);
    self.spill_entry.insert(n, spill_entry);
    /* connect what we can, may not succeed */
    for self.f.cfg.each_pred(n) |pred| {
      self.connect_edge(pred, n);
    }

    /* Set up the maps which will become {regs,spill}_exit */
    let regs = map::HashMap();
    let spill = map::HashMap();
    set::union(regs, regs_entry);
    set::union(spill, spill_entry);
    let mut reloaded = ~[];
    let mut block = ~[];

    /* next_use is always relative to the top of the block */
    let next_use = self.next_use[n];

    /* Limit the amount of variables in registers by spilling those which are
       used the farthest away */
    let limit = |max : uint, push : &fn(@Instruction)| {
      if regs.size() >= max {
        let sorted = sort(regs, next_use);
        debug!("%? %s", sorted, map_to_str(next_use));
        for sorted.view(max, sorted.len()).each |&tmp| {
          if !set::contains(spill, tmp) && next_use.contains_key(tmp) {
            debug!("spilling %?", tmp);
            push(@Spill(tmp, tmp));
          }
          set::remove(regs, tmp);
          set::remove(spill, tmp);
        }
      }
      assert(regs.size() <= max);
    };

    debug!("%s", map_to_str(next_use));
    let mut i = 0;
    for vec::each2(*self.f.cfg[n], *self.deltas[n]) |&ins, delta| {
      debug!("%2d %30s  %s %s", i, ins.pp(), map_to_str(next_use),
             str::connect(delta.map(|a| fmt!("%?", a)), ~", "));
      /* Determine what needs to be reloaded */
      for ins.each_use |tmp| {
        if regs.contains_key(tmp) { loop }
        reloaded.push(tmp);
        set::add(regs, tmp);
        set::add(spill, tmp);
      }
      debug!("making room for operands");
      /* This limit is relative to the next_use of this instruction */
      limit(arch::num_regs, |i| block.push(i));

      /* The next limit is relative to the next_use of the next instruction, so
         for each delta if the value is None, then that means the liveness has
         stopped. Otherwise the next_use value is updated with what it should be
         for down the road. We iterate in reverse order in case one instruction
         uses the same operand more than once. In this case the first listed
         delta is the one which is the relevant value */
      for vec::rev_each(*delta) |&(tmp, amt)| {
        match amt {
          None    => { assert next_use.remove(tmp); }
          Some(d) => { next_use.insert(tmp, d); }
        }
      }
      let mut defs = 0;
      for ins.each_def |_| { defs += 1; }
      debug!("making room for results");
      limit(arch::num_regs - defs, |i| block.push(i));

      /* Add all defined temps to the set of those in regs */
      for ins.each_def |tmp| {
        set::add(regs, tmp);
      }
      assert(regs.size() <= arch::num_regs);

      /* Finally reload all operands as necessary, and then run ins */
      for reloaded.each |&tmp| {
        block.push(@Reload(tmp, tmp));
      }
      reloaded.truncate(0);
      block.push(ins);
      i += 1;
    }

    self.f.cfg.update_node(n, @block);
    self.regs_end.insert(n, regs);
    self.spill_exit.insert(n, spill);
    debug!("node %? exit regs:%s spill:%s", n,
           set_to_str(regs), set_to_str(spill));

    /* connect any lingering edges which weren't covered beforehand */
    for self.f.cfg.each_succ(n) |succ| {
      if self.spill_entry.contains_key(succ) {
        self.connect_edge(n, succ);
      }
    }
  }

  fn init_usual(n : NodeId) -> TempSet {
    debug!("init_usual: %?", n);
    let freq = map::HashMap();
    let take = map::HashMap();
    let cand = map::HashMap();
    for self.f.cfg.each_pred(n) |pred| {
      debug!("%?", pred);
      assert(self.regs_end.contains_key(pred));
      for set::each(self.regs_end[pred]) |tmp| {
        /* tmp from pred may be known by a different name in this block if there
           is a phi node for this temp */
        let tmp = self.my_name(tmp, pred, n);
        freq.insert(tmp, freq.find(tmp).get_default(0) + 1);
      }
    }
    let preds = self.f.cfg.num_pred(n);
    for freq.each |tmp, n| {
      if n == preds {
        set::add(take, tmp);
      } else {
        set::add(cand, tmp);
      }
    }
    if arch::num_regs - take.size() > 0 {
      let sorted = sort(cand, self.next_use[n]);
      let max = arch::num_regs - take.size();
      for sorted.view(0, uint::min(max, sorted.len())).each |&tmp| {
        set::add(take, tmp);
      }
    }
    return take;
  }

  fn init_loop(n : NodeId, body : NodeId, end : NodeId) -> TempSet {
    debug!("init_loop %? %? %?", n, body, end);
    /* cand = (phis | live_in) & used_in_loop */
    let cand = map::HashMap();
    /* If a variable is used in the loop, then its next_use as viewed from the
       body of the loop would be less than loop_out_weight */
    for self.next_use[body].each |tmp, n| {
      if n < loop_out_weight {
        set::add(cand, tmp);
      }
    }
    debug!("loop candidates: %s", set_to_str(cand));
    if cand.size() < arch::num_regs {
      /* live_through = (phis | live_in) - cand */
      let live_through = map::HashMap();
      for self.next_use[n].each_key |tmp| {
        if !set::contains(cand, tmp) { set::add(live_through, tmp); }
      }
      for self.phis[n].each_key |tmp| {
        if !set::contains(cand, tmp) { set::add(live_through, tmp); }
      }

      let visited = map::HashMap();
      set::add(visited, n);     /* don't loop back to the start */
      set::add(visited, end);   /* don't go outside the loop */
      let free = arch::num_regs - self.max_pressure(body, visited);
      debug!("live through loop: %s", set_to_str(live_through));
      if free > 0 {
        let sorted = sort(live_through, self.next_use[n]);
        for sorted.view(0, uint::min(free, sorted.len())).each |&tmp| {
          set::add(cand, tmp);
        }
      }
    } else {
      let sorted = sort(cand, self.next_use[n]);
      cand.clear();
      for sorted.each |&tmp| {
        set::add(cand, tmp);
      }
    }
    return cand;
  }

  fn max_pressure(cur : NodeId, visited : map::Set<NodeId>) -> uint {
    if set::contains(visited, cur) { return 0; }
    set::add(visited, cur);
    let mut ret = self.max_pressures[cur];
    for self.f.cfg.each_succ(cur) |succ| {
      ret = uint::max(ret, self.max_pressure(succ, visited));
    }
    return ret;
  }

  fn connect_pred(n : NodeId, entry : TempSet) -> TempSet {
    debug!("connecting preds: %?", n);
    /* Build up our list of required spilled registers */
    let spill = map::HashMap();
    for self.f.cfg.each_pred(n) |pred| {
      if !self.spill_exit.contains_key(pred) { loop }
      /* Be sure we're using the right name for each temp spilled on the exit of
         our predecessors because we may be renaming it with a phi node */
      for set::each(self.spill_exit[pred]) |tmp| {
        set::add(spill, self.my_name(tmp, pred, n));
      }
    }
    set::intersect(spill, entry);
    debug!("node %? entry regs:%s spill:%s", n,
           set_to_str(entry), set_to_str(spill));
    return spill;
  }

  fn connect_edge(pred : NodeId, succ : NodeId) {
    if set::contains(self.connected, (pred, succ)) { return }
    if !self.spill_exit.contains_key(pred) { return }
    set::add(self.connected, (pred, succ));
    let succ_spill = self.spill_entry[succ];
    let succ_regs = self.regs_entry[succ];

    let mut append = ~[];
    let pred_regs_exit = self.regs_end[pred];
    let pred_spill_exit = self.spill_exit[pred];
    for set::each(succ_spill) |tmp| {
      let theirs = self.their_name(tmp, pred, succ);
      if !pred_spill_exit.contains_key(theirs) &&
          pred_regs_exit.contains_key(theirs) {
        append.push(@Spill(theirs, theirs));
      }
    }
    for set::each(succ_regs) |tmp| {
      let theirs = self.their_name(tmp, pred, succ);
      if !pred_regs_exit.contains_key(theirs) {
        append.push(@Reload(theirs, theirs));
      }
    }
    if append.len() > 0 {
      debug!("appending to %? : %?", pred, append);
      self.f.cfg.update_node(pred, @(*self.f.cfg[pred] + append));
    }
  }

  fn my_name(tmp : Temp, from : NodeId, to : NodeId) -> Temp {
    self.renamings[(from, to)].find(tmp).get_default(tmp)
  }

  fn their_name(tmp : Temp, from : NodeId, to : NodeId) -> Temp {
    match self.phis[to].find(tmp) {
      Some(map) => map[from],
      None => tmp
    }
  }
}

#[cfg(test)]
mod test {
  fn set(v : ~[int]) -> TempSet {
    let set = map::HashMap();
    for v.each |&i| {
      set::add(set, i as Temp);
    }
    return set;
  }

  #[test]
  fn test_sort_works1() {
    let map : NextUse = map::HashMap();
    map.insert(4, 5);
    map.insert(5, 6);
    let sorted = sort(set(~[4, 5, 6]), map);
    assert(sorted[0] == 4);
    assert(sorted[1] == 5);
    assert(sorted[2] == 6);
  }

  #[test]
  fn test_sort_works2() {
    let map : NextUse = map::HashMap();
    map.insert(4, 5);
    map.insert(5, 6);
    let sorted = sort(set(~[4, 5]), map);
    assert(sorted[0] == 4);
    assert(sorted[1] == 5);
  }
}
