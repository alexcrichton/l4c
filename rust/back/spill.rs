use std::{map, sort};
use middle::temp::Temp;
use back::assem::*;
use utils::graph::*;

/* If a temp isn't in a set, then its next_use distance is infinity */
type NextUse = map::HashMap<Temp, uint>;
type TempSet = map::Set<Temp>;

struct Spiller {
  f : &Function,
  next_use : map::HashMap<NodeId, NextUse>,
  deltas : map::HashMap<NodeId, @~[~[(Temp, Option<uint>)]]>,
  regs_entry : map::HashMap<NodeId, TempSet>,
  regs_end : map::HashMap<NodeId, TempSet>,
  spill_entry : map::HashMap<NodeId, TempSet>,
  spill_exit : map::HashMap<NodeId, TempSet>,
}

pub fn spill(p : &Program) {
  for p.funs.each |f| {
    let s = Spiller{ f: f,
                     next_use: map::HashMap(),
                     deltas: map::HashMap(),
                     regs_end: map::HashMap(),
                     regs_entry: map::HashMap(),
                     spill_entry: map::HashMap(),
                     spill_exit: map::HashMap() };

    /* Initialize state, prepare the graph */
    s.eliminate_critical();
    /* Prepare the graph and build all next_use information */
    let mut changed = true;
    while changed {
      changed = false;
      for f.postorder.each |&id| {
        changed = s.process(id) || changed;
      }
    }

    /* In reverse postorder, spill everything! */
    for vec::rev_each(*f.postorder) |&id| {
      s.spill(id);
    }
  }
}

fn sort(v : ~[Temp], s : NextUse) -> ~[Temp] {
  sort::quick_sort(vec::to_mut(v),
                   |&a, &b| match s.find(b) {
                              None => true,       /* a is always < infty */
                              Some(b) => match s.find(a) {
                                None => false,    /* infty always > n */
                                Some(a) => a < b
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

  fn process(n : NodeId) -> bool {
    debug!("processing: %?", n);
    let bottom = map::HashMap();
    let block = self.f.cfg[n];
    for self.f.cfg.each_succ(n) |pred| {
      if !self.next_use.contains_key(pred) { loop }
      /* TODO: if this is a loop-out edge, then have a higher merge weight */
      /* Assume that all variables aren't used in this block and add block.len()
         to the value being merged. This will be updated if the value is
         actually used in the block */
      self.merge(bottom, self.next_use[pred], block.len());
    }
    let mut deltas = ~[];

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
    }

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
    self.next_use.insert(n, bottom);
    vec::reverse(deltas);
    self.deltas.insert(n, @deltas);
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

  fn spill(n : NodeId) {
    debug!("spilling: %?", n);
    let regs_entry = self.init_usual(n); /* TODO: special case loop headers */
    let spill_entry = self.connect_pred(n, regs_entry);
    self.regs_entry.insert(n, regs_entry);
    self.spill_entry.insert(n, spill_entry);

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
        let sorted = sort(map::vec_from_set(regs), next_use);
        for sorted.view(max, sorted.len()).each |&tmp| {
          if !set::contains(spill, tmp) && next_use.contains_key(tmp) {
            push(@Spill(tmp));
          }
          set::remove(regs, tmp);
          set::remove(spill, tmp);
        }
      }
    };

    debug!("%s", map_to_str(next_use));
    for vec::each2(*self.f.cfg[n], *self.deltas[n]) |&ins, delta| {
      debug!("%40s  %s", ins.pp(),
             str::connect(delta.map(|a| fmt!("%?", a)), ~", "));
      /* Determine what needs to be reloaded */
      for ins.each_use |tmp| {
        if regs.contains_key(tmp) { loop }
        reloaded.push(tmp);
        set::add(regs, tmp);
        set::add(spill, tmp);
      }
      /* This limit is relative to the next_use of this instruction */
      limit(arch::num_regs, |i| block.push(i));

      /* The next limit is relative to the next_use of the next instruction, so
         for each delta if the value is None, then that means the liveness has
         stopped. Otherwise the next_use value is updated with what it should be
         for down the road */
      for delta.each |&(tmp, amt)| {
        match amt {
          None    => { assert next_use.remove(tmp); }
          Some(d) => { next_use.insert(tmp, d); }
        }
      }
      let mut defs = 0;
      for ins.each_def |_| { defs += 1; }
      limit(arch::num_regs - defs, |i| block.push(i));

      /* Add all defined temps to the set of those in regs */
      for ins.each_def |tmp| {
        set::add(regs, tmp);
      }

      /* Finally reload all operands as necessary, and then run ins */
      for reloaded.each |&tmp| {
        block.push(@Reload(tmp));
      }
      reloaded.truncate(0);
      block.push(ins);
    }

    self.f.cfg.update_node(n, @block);
    self.regs_end.insert(n, regs);
    self.spill_exit.insert(n, spill);
    debug!("node %? exit regs:%s spill:%s", n,
           set_to_str(regs), set_to_str(spill));
  }

  fn init_usual(n : NodeId) -> map::Set<Temp> {
    debug!("init_usual: %?", n);
    let freq = map::HashMap();
    let take = map::HashMap();
    let cand = map::HashMap();
    for self.f.cfg.each_pred(n) |pred| {
      for set::each(self.regs_end[pred]) |tmp| {
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
      let sorted = sort(map::vec_from_set(cand), self.next_use[n]);
      let max = arch::num_regs - take.size();
      for sorted.view(0, uint::min(max, sorted.len())).each |&tmp| {
        set::add(take, tmp);
      }
    }
    return take;
  }

  fn connect_pred(n : NodeId, entry : TempSet) -> TempSet {
    debug!("connecting preds: %?", n);
    /* Build up our list of required spilled registers */
    let entry = self.regs_entry[n];
    let spill_entry = map::HashMap();
    for self.f.cfg.each_pred(n) |pred| {
      assert(self.spill_exit.contains_key(pred));
      set::union(spill_entry, self.spill_exit[pred]);
    }
    set::intersect(spill_entry, entry);
    debug!("node %? entry regs:%s spill:%s", n,
           set_to_str(entry), set_to_str(spill_entry));

    /* Now modify all predecessors to get to our state */
    for self.f.cfg.each_pred(n) |pred| {
      let mut append = ~[];
      let exit = self.regs_end[pred];
      for set::each(spill_entry) |tmp| {
        if !exit.contains_key(tmp) && exit.contains_key(tmp) {
          append.push(@Spill(tmp));
        }
      }
      for set::each(entry) |tmp| {
        if !exit.contains_key(tmp) {
          append.push(@Reload(tmp));
        }
      }
      self.f.cfg.update_node(n, @(*self.f.cfg[n] + append));
    }
    return spill_entry;
  }
}
