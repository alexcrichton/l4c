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

use core::hashmap::{HashMap, HashSet};

use std::sort;
use middle::{ir, ssa, opt};
use middle::temp::{Temp, TempSet};
use back::assem::*;
use utils::graph::*;
use back::arch;

static loop_out_weight: uint = 100000;

/* If a temp isn't in a set, then its next_use distance is infinity */
type NextUse = HashMap<Temp, uint>;

struct Spiller {
  f: @mut Function,
  /* next_use information for each node in the graph */
  next_use: HashMap<NodeId, NextUse>,
  /* Delta information for next_use as a block is traversed top down */
  deltas: HashMap<NodeId, ~[~[(Temp, Option<uint>)]]>,

  /* Information required by the spilling algorithm */
  regs_entry: HashMap<NodeId, TempSet>,
  regs_end: HashMap<NodeId, TempSet>,
  spill_entry: HashMap<NodeId, TempSet>,
  spill_exit: HashMap<NodeId, TempSet>,

  /* m[(a, b)] => (t1 -> t2) means that any temp known by the name t1 in a
     becomes the temp named t2 in b */
  renamings: HashMap<(NodeId, NodeId), ~HashMap<Temp, ~[Temp]>>,
  /* m[a] = t1 -> (n -> t2) means that in block a, the temp t1 is known under the
     name t2 in node n */
  phis: HashMap<NodeId, HashMap<Temp, ssa::PhiMap>>,

  /* Maximum register pressure at each basic block */
  max_pressures: HashMap<NodeId, uint>,
  /* Set of edges which have been connected (spills/reloads placed) so far */
  connected: HashSet<(NodeId, NodeId)>,
}

pub fn spill(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    opt::cfg::eliminate_critical(f.cfg);

    let mut s = Spiller{ f: *f,
                         next_use: HashMap::new(),
                         deltas: HashMap::new(),
                         regs_end: HashMap::new(),
                         regs_entry: HashMap::new(),
                         spill_entry: HashMap::new(),
                         spill_exit: HashMap::new(),
                         renamings: HashMap::new(),
                         phis: HashMap::new(),
                         max_pressures: HashMap::new(),
                         connected: HashSet::new() };

    s.run();
  }
}

fn sort(set: &TempSet, s: &NextUse) -> ~[Temp] {
  let mut v = ~[];
  for set.each |&tmp| {
    v.push(tmp);
  }
  sort::quick_sort(v, |&a: &Temp, &b: &Temp| {
    match s.find(&b) {
      None => true,       /* a is always < infty */
      Some(&b) => match s.find(&a) {
        None => false,    /* infty always > n */
        Some(&a) => a <= b
      }
    }
  });
  return v;
}

impl Spiller {
  fn run(&mut self) {
    /* TODO: why can't this all be above */
    /* Build up phi renaming maps */
    unsafe {
      for self.f.cfg.each_node |n, _| {
        self.build_renamings(n);
      }

      /* Prepare the graph and build all next_use information */
      let mut changed = true;
      while changed {
        changed = false;
        for self.f.cfg.each_postorder(self.f.root) |&id| {
          changed = self.build_next_use(id) || changed;
        }
      }

      /* In reverse postorder, spill everything! */
      for self.f.cfg.each_rev_postorder(self.f.root) |&id| {
        self.spill(id);
      }
    }
  }

  /**
   * Build up internal maps of the renaming of temps done by phi functions per
   * node. This just needs to iterate and look at every phi node in a block.
   */
  fn build_renamings(&mut self, n: NodeId) {
    let mut phis = HashMap::new();
    for self.f.cfg.node(n).each |&ins| {
      match ins {
        ~Phi(my_name, ref renamings) => unsafe {
          for renamings.each |&pred, &their_name| {
            match self.renamings.find_mut(&(pred, n)) {
              Some(m) => {
                match m.find_mut(&their_name) {
                  Some(l) => { l.push(my_name); loop }
                  None => ()
                }
                m.insert(their_name, ~[my_name]);
                loop
              }
              None => ()
            }
            let mut m = ~HashMap::new();
            m.insert(their_name, ~[my_name]);
            self.renamings.insert((pred, n), m);
          }
          /* TODO: is the dup necessary? */
          let mut dup = HashMap::new();
          for renamings.each |&k, &v| {
            dup.insert(k, v);
          }
          assert!(phis.insert(my_name, dup));
        },
        _ => ()
      }
    }
    assert!(self.phis.insert(n, phis));
  }

  /**
   * This performs the dataflow analysis necessary to build the internal maps of
   * the next_use information. This returns whether any information was modified
   * or not.
   *
   * The analysis is a backwards analysis (like liveness).
   *
   * TODO: move this into middle/liveness.rs
   */
  fn build_next_use(&mut self, n: NodeId) -> bool {
    debug!("processing: %?", n);
    let mut bottom = HashMap::new();
    let block = self.f.cfg.node(n);

    /* Union each of our predecessors into the 'bottom' map */
    unsafe {
      for self.f.cfg.each_succ(n) |succ| {
        /* at the end the next use of each of the temps we transfer to the next
           node via phis is the length of the block that we're at */
        match self.phis.find(&succ) {
          None => (),
          Some(map) => {
            for map.each |_, phis| {
              bottom.insert(*phis.get(&n), block.len());
            }
          }
        }
        if !self.next_use.contains_key(&succ) { loop }
        let edge_cost = match *self.f.cfg.edge(n, succ) {
          ir::LoopOut | ir::FLoopOut => loop_out_weight, _ => 0
        };

        /* Assume that all variables aren't used in this block and add block.len()
           to the value being merged. This will be updated if the value is
           actually used in the block */
        let edge_cost = block.len() + edge_cost;

        /* Temps may change names along edges because of phi nodes, so be sure to
           account for that here */
        for self.next_use.get(&succ).each |&tmp, &next| {
          let cost = next + edge_cost;
          let mytmp = self.their_name(tmp, n, succ);
          match bottom.pop(&mytmp) {
            Some(amt) => { bottom.insert(mytmp, uint::min(cost, amt)); }
            None      => { bottom.insert(mytmp, cost); }
          }
        }
      }
    }

    /* Process all of our block's statements backwards */
    let mut deltas = ~[];
    let mut max = bottom.len();
    for block.eachi_reverse |i, &ins| {
      let mut delta = ~[];
      match ins {
        ~PCopy(*) => { deltas.push(delta); loop; }
        _ => ()
      }
      /* If we define a temp, then the distance to the next use from the start
         is infinity because it's just not relevant */
      for ins.each_def |tmp| {
        /* liveness stops here (hence pop) except for phi nodes */
        match bottom.pop(&tmp) {
          None    => (), /* well apparently this wasn't used anywhere */
          Some(d) => {
            delta.push((tmp, Some(d)));
            if ins.is_phi() {
              bottom.insert(tmp, d);
            }
          }
        }
      }

      /* Our delta contains what the last distance to the temp used to be (None
       * for infty), and then we update it to our current distance now */
      for ins.each_use |tmp| {
        delta.push((tmp, bottom.find(&tmp).map(|&x| *x)));
        bottom.insert(tmp, i);
      }
      deltas.push(delta);
      max = uint::max(max, bottom.len());
    }
    vec::reverse(deltas);

    /* If we didn't update anything, return false */
    match self.next_use.find(&n) {
      Some(before) => {
        if bottom.eq(before) && deltas.eq(self.deltas.get(&n)) {
          return false;
        }
      }
      None => ()
    }
    debug!("next_use: %s", bottom.pp());
    debug!("deltas: %?", deltas);

    /* If we did update something, then update it and return so */
    self.next_use.insert(n, bottom);
    self.deltas.insert(n, deltas);
    self.max_pressures.insert(n, max);
    return true;
  }

  /**
   * This functions spills all necessary temps for the specified block. This may
   * possibly insert spills/reloads in predecessor and successors depending on
   * their processed state.
   */
  fn spill(&mut self, n: NodeId) {
    debug!("spilling: %?", n);
    let regs_entry;
    unsafe {
      regs_entry = match self.f.loops.find(&n) {
        Some(&(body, end)) => self.init_loop(n, body, end),
        None               => self.init_usual(n)
      };
    }
    let spill_entry = self.connect_pred(n, &regs_entry);

    /* Set up the sets which will become {regs,spill}_exit */
    let mut regs = HashSet::new();
    let mut spill = HashSet::new();
    for regs_entry.each |&t| { regs.insert(t); }
    for spill_entry.each |&t| { spill.insert(t); }

    /* move out of {regs,spill}_entry because we're done with them now */
    self.regs_entry.insert(n, regs_entry);
    self.spill_entry.insert(n, spill_entry);

    /* connect what we can, may not succeed */
    unsafe {
      for self.f.cfg.each_pred(n) |pred| {
        self.connect_edge(pred, n);
      }
    }

    let mut reloaded = ~[];
    let mut block = ~[];

    /* next_use is always relative to the top of the block */
    let mut next_use = HashMap::new();
    for self.next_use.get(&n).each |&k, &v| {
      next_use.insert(k, v);
    }

    /* Limit the amount of variables in registers by spilling those which are
       used the farthest away */
    macro_rules! limit (
      ($max:expr) =>
      ({
        if regs.len() >= $max {
          let sorted = sort(&regs, &next_use);
          debug!("%? %s", sorted, next_use.pp());
          for sorted.slice($max, sorted.len()).each |&tmp| {
            if !spill.contains(&tmp) && next_use.contains_key(&tmp) {
              debug!("spilling %?", tmp);
              block.push(~Spill(tmp, tmp));
            }
            regs.remove(&tmp);
            spill.remove(&tmp);
          }
        }
        assert!(regs.len() <= $max);
      })
    );

    let apply_delta = |delta: &~[(Temp, Option<uint>)]| {
      /* For each delta if the value is None, then that means the liveness has
         stopped. Otherwise the next_use value is updated with what it should be
         for down the road. We iterate in reverse order in case one instruction
         uses the same operand more than once. In this case the first listed
         delta is the one which is the relevant value */
      for delta.each_reverse |&(tmp, amt)| {
        match amt {
          None    => { assert!(next_use.remove(&tmp)); }
          Some(d) => { next_use.insert(tmp, d); }
        }
      }
    };

    debug!("%s", next_use.pp());
    let mut i = 0;
    for vec::each2(*self.f.cfg.node(n), *self.deltas.get(&n)) |&ins, delta| {
      debug!("%2? %30s  %s %s", i, ins.pp(), next_use.pp(),
             str::connect(delta.map(|a| fmt!("%?", a)), ~", "));

      match ins {
        /* If the destination of a phi is not currently in the registers, then
           we don't need the phi instruction because it's been spilled and we
           don't want to put register moves onto the incoming edges */
        ~Phi(tmp, map) => {
          if regs.contains(&tmp) {
            block.push(~Phi(tmp, map));
          } else if next_use.contains_key(&tmp) {
            block.push(~MemPhi(tmp, map));
          }
          apply_delta(delta);
        }

        ~PCopy(copies) => {
          let newcopies = do vec::filter(copies) |&(dst, src)| {
            assert!(dst == src);
            regs.contains(&src)
          };
          block.push(~PCopy(newcopies));
          apply_delta(delta);
        }

        ins => {
          /* Determine what needs to be reloaded */
          for ins.each_use |tmp| {
            debug!("%? %?", tmp, *next_use.get(&tmp));
            assert!(*next_use.get(&tmp) == i);
            if regs.contains(&tmp) { loop }
            reloaded.push(tmp);
            regs.insert(tmp);
            spill.insert(tmp);
          }
          let extra = match ins {
            ~BinaryOp(op, _, _, _) if op.constrained() => 1,
            ~Call(*) => arch::caller_regs,
            _ => 0
          };
          /* This limit is relative to the next_use of this instruction */
          debug!("making room for operands");
          limit!(arch::num_regs - extra);

          /* The next limit is relative to the next instruction */
          apply_delta(delta);
          let mut defs = 0;
          for ins.each_def |_| { defs += 1; }
          debug!("making room for results");
          limit!(arch::num_regs - defs);

          /* Add all defined temps to the set of those in regs */
          for ins.each_def |tmp| {
            regs.insert(tmp);
          }
          assert!(regs.len() <= arch::num_regs);

          /* Finally reload all operands as necessary, and then run ins */
          for reloaded.each |&tmp| {
            block.push(~Reload(tmp, tmp));
          }
          reloaded.truncate(0);
          block.push(ins);
        }
      }

      i += 1;
    }

    debug!("node %? exit regs:%s spill:%s", n, regs.pp(), spill.pp());
    self.f.cfg.update_node(n, block);
    self.regs_end.insert(n, regs);
    self.spill_exit.insert(n, spill);

    /* connect any lingering edges which weren't covered beforehand */
    unsafe {
      for self.f.cfg.each_succ(n) |succ| {
        if self.spill_entry.contains_key(&succ) {
          self.connect_edge(n, succ);
        }
      }
    }
  }

  fn init_usual(&self, n: NodeId) -> TempSet {
    debug!("init_usual: %?", n);
    let mut freq = HashMap::new();
    let mut take = HashSet::new();
    let mut cand = HashSet::new();
    unsafe {
      for self.f.cfg.each_pred(n) |pred| {
        debug!("pred %?", pred);
        assert!(self.regs_end.contains_key(&pred));
        for self.regs_end.get(&pred).each |&tmp| {
          for self.my_names(tmp, pred, n) |mine| {
            let prev : uint = freq.find(&mine).map_default(0, |&x| *x);
            freq.insert(mine, prev + 1);
          }
        }
      }
      debug!("frequencies: %s", freq.pp());
      let preds = self.f.cfg.num_pred(n);
      for freq.each |&tmp, &n| {
        if n == preds {
          take.insert(tmp);
        } else {
          cand.insert(tmp);
        }
      }
      if arch::num_regs - take.len() > 0 {
        let sorted = sort(&cand, self.next_use.get(&n));
        let max = arch::num_regs - take.len();
        for sorted.slice(0, uint::min(max, sorted.len())).each |&tmp| {
          if self.next_use.get(&n).contains_key(&tmp) {
            take.insert(tmp);
          }
        }
      }
    }
    return take;
  }

  fn init_loop(&self, n: NodeId, body: NodeId, end: NodeId) -> TempSet {
    debug!("init_loop %? %? %?", n, body, end);
    /* cand = (phis | live_in) & used_in_loop */
    let mut cand = HashSet::new();
    /* If a variable is used in the loop, then its next_use as viewed from the
       body of the loop would be less than loop_out_weight */
    for self.next_use.get(&n).each |&tmp, &n| {
      if n < loop_out_weight {
        cand.insert(tmp);
      }
    }
    debug!("loop candidates: %s", cand.pp());
    if cand.len() < arch::num_regs {
      /* live_through = (phis | live_in) - cand */
      let mut live_through = HashSet::new();
      for self.next_use.get(&n).each_key |&tmp| {
        if !cand.contains(&tmp) { live_through.insert(tmp); }
      }
      for self.phis.get(&n).each_key |&tmp| {
        if !cand.contains(&tmp) { live_through.insert(tmp); }
      }

      let mut visited = HashSet::new();
      visited.insert(n);   /* don't loop back to the start */
      visited.insert(end); /* don't go outside the loop */
      let free = (arch::num_regs - self.max_pressure(body, &mut visited)) as int;
      debug!("live through loop: %s %?", live_through.pp(), free);
      if free > 0 {
        let sorted = sort(&live_through, self.next_use.get(&n));
        debug!("%?", sorted);
        for sorted.slice(0, uint::min(free as uint, sorted.len())).each |&tmp| {
          cand.insert(tmp);
        }
      }
    } else if cand.len() > arch::num_regs {
      let sorted = sort(&cand, self.next_use.get(&n));
      for sorted.slice(arch::num_regs, sorted.len()).each |tmp| {
        cand.remove(tmp);
      }
    }
    return cand;
  }

  fn max_pressure(&self, cur: NodeId, visited: &mut NodeSet) -> uint {
    if visited.contains(&cur) { return 0; }

    visited.insert(cur);
    let mut ret = *self.max_pressures.get(&cur);
    /* TODO(purity): this shouldn't be unsafe */
    unsafe {
      for self.f.cfg.each_succ(cur) |succ| {
        ret = uint::max(ret, self.max_pressure(succ, visited));
      }
    }
    return ret;
  }

  fn connect_pred(&self, n: NodeId, entry: &TempSet) -> TempSet {
    debug!("connecting preds: %?", n);
    /* Build up our list of required spilled registers */
    let mut spill = HashSet::new();
    /* TODO(purity): this shouldn't be unsafe */
    unsafe {
      for self.f.cfg.each_pred(n) |pred| {
        if !self.spill_exit.contains_key(&pred) { loop }
        /* Be sure we're using the right name for each temp spilled on the exit of
           our predecessors because we may be renaming it with a phi node */
        for self.spill_exit.get(&pred).each |&tmp| {
          /* spill is intersected with the entry set */
          if entry.contains(&tmp) {
            for self.my_names(tmp, pred, n) |mine| {
              spill.insert(mine);
            }
          }
        }
      }
    }
    /* TODO: this needs a better solution... */
    for self.phis.get(&n).each |k, _| {
      spill.remove(k);
    }
    debug!("node %? entry regs:%s spill:%s", n, entry.pp(), spill.pp());
    return spill;
  }

  fn connect_edge(&mut self, pred: NodeId, succ: NodeId) {
    if self.connected.contains(&(pred, succ)) { return }
    if !self.spill_exit.contains_key(&pred) { return }
    debug!("connecting %? %?", pred, succ);
    self.connected.insert((pred, succ));
    let succ_spill = self.spill_entry.get(&succ);
    let succ_regs = self.regs_entry.get(&succ);

    let mut append = ~[];
    let pred_regs_exit = self.regs_end.get(&pred);
    let pred_spill_exit = self.spill_exit.get(&pred);
    let nxt = self.next_use.get(&succ);

    /* All registers they had which we don't have which we may eventually use
       need to be spilled */
    for pred_regs_exit.each |&tmp| {
      /* no need to spill if it's already spilled */
      if pred_spill_exit.contains(&tmp) { loop }

      /* for each of my names for this temp, see if a spill is needed */
      for self.my_names(tmp, pred, succ) |mine| {
        debug!("name %? %? %?", mine, succ_regs.contains(&mine),
               nxt.contains_key(&mine));
        if !succ_regs.contains(&mine) && nxt.contains_key(&mine) {
          append.push(~Spill(tmp, tmp));
        }
      }
    }

    /* Each register we want spilled that they haven't spilled needs a spill */
    for succ_spill.each |&tmp| {
      let theirs = self.their_name(tmp, pred, succ);
      if !pred_spill_exit.contains(&theirs) &&
          pred_regs_exit.contains(&theirs) {
        append.push(~Spill(theirs, theirs));
      }
    }

    /* Each register we have which they don't have needs a reload */
    for succ_regs.each |&tmp| {
      let theirs = self.their_name(tmp, pred, succ);
      debug!("ours %? theirs %?", tmp, theirs);
      if !pred_regs_exit.contains(&theirs) {
        append.push(~Reload(theirs, theirs));
      }
    }
    if append.len() > 0 {
      debug!("appending to %?: %?", pred, append);
      self.f.cfg.update_node(pred, self.f.cfg.node(pred) + append);
    }
  }

  fn my_names(&self, tmp: Temp, from: NodeId, to: NodeId, f: &fn(Temp) -> bool) {
    match self.renamings.find(&(from, to)) {
      Some(m) => match m.find(&tmp) {
        Some(ret) => {
          ret.each(|&t| f(t));
          if self.next_use.get(&to).contains_key(&tmp) {
            f(tmp);
          }
        }
        None => { f(tmp); }
      },
      None => { f(tmp); }
    }
  }

  fn their_name(&self, tmp: Temp, from: NodeId, to: NodeId) -> Temp {
    match self.phis.get(&to).find(&tmp) {
      Some(map) => *map.get(&from),
      None => tmp
    }
  }
}

#[cfg(test)]
fn set(v: ~[int]) -> TempSet {
  let mut set = HashSet::new();
  for v.each |&i| {
    set.insert(i as Temp);
  }
  return set;
}

#[test]
fn test_sort_works1() {
  let mut map: NextUse = HashMap::new();
  map.insert(4, 5);
  map.insert(5, 6);
  let sorted = sort(&set(~[4, 5, 6]), &map);
  assert!(sorted[0] == 4);
  assert!(sorted[1] == 5);
  assert!(sorted[2] == 6);
}

#[test]
fn test_sort_works2() {
  let mut map: NextUse = HashMap::new();
  map.insert(4, 5);
  map.insert(5, 6);
  let sorted = sort(&set(~[4, 5]), &map);
  assert!(sorted[0] == 4);
  assert!(sorted[1] == 5);
}
