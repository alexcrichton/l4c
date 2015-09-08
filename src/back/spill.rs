/// The spilling algorithm implemented is outlined in the paper "Register
/// Spilling and Live-Range Splitting for SSA-Form Programs" by Braun and Hack.
///
/// The basic idea of the spilling algorithm is to run the "Belady Method" on all
/// basic blocks and combine the data. The Belady method states that if a
/// register must be evicted, then the register which should be evicted is the
/// one that is used "farthest in the future."
///
/// To implement this, each block develops a set of temps assumed in registers on
/// entry, and a subset of this which may be spilled. The belady method is then
/// run, inserting reloads/spills as the block progresses, and then the results
/// are recorded in the output.
///
/// When inserting reloads, the SSA form of the graph is destroyed because a
/// reload is a redefinition of that temporary. For this reason, register
/// allocation puts the graph back into SSA form right before running its
/// coloring algorithm.
///
/// Much more detailed information about how the spilling works in theory is
/// located in the paper above, and comments of implementation can be found
/// throughout the code in this file.

use std::cmp::{self, Ordering};
use std::collections::{HashMap, HashSet};

use back::arch;
use back::assem::{Inst, Function, RegisterInfo, Program};
use middle::ir::Edge;
use middle::opt;
use middle::ssa;
use utils::{Temp, TempSet, FnvState};
use utils::graph::{NodeId, NodeSet};

static LOOP_OUT_WEIGHT: u32 = 100000;

// If a temp isn't in a set, then its next_use distance is infinity
type NextUse = HashMap<Temp, u32>;

struct Spiller {
    // next_use information for each node in the graph
    next_use: HashMap<NodeId, NextUse>,
    // Delta information for next_use as a block is traversed top down
    deltas: HashMap<NodeId, Vec<Vec<(Temp, Option<u32>)>>>,

    // Information required by the spilling algorithm
    regs_entry: HashMap<NodeId, TempSet>,
    regs_end: HashMap<NodeId, TempSet>,
    spill_entry: HashMap<NodeId, TempSet>,
    spill_exit: HashMap<NodeId, TempSet>,

    // m[(a, b)] => (t1 -> t2) means that any temp known by the name t1 in a
    // becomes the temp named t2 in b
    renamings: HashMap<(NodeId, NodeId), HashMap<Temp, Vec<Temp>>>,
    // m[a] = t1 -> (n -> t2) means that in block a, the temp t1 is known under the
    // name t2 in node n
    phis: HashMap<NodeId, HashMap<Temp, ssa::PhiMap>>,

    // Maximum register pressure at each basic block
    max_pressures: HashMap<NodeId, u32>,
    // Edges which have been connected (spills/reloads placed) so far, and the
    // instructions which need to be appended along the edge
    connected: HashMap<(NodeId, NodeId), Vec<Inst>>,
}

pub fn spill(p: &mut Program) {
    for f in p.funs.iter_mut() {
        opt::cfg::eliminate_critical(&mut f.cfg, &RegisterInfo);

        let mut s = Spiller{
            next_use: HashMap::new(),
            deltas: HashMap::new(),
            regs_end: HashMap::new(),
            regs_entry: HashMap::new(),
            spill_entry: HashMap::new(),
            spill_exit: HashMap::new(),
            renamings: HashMap::new(),
            phis: HashMap::new(),
            max_pressures: HashMap::new(),
            connected: HashMap::new(),
        };

        // Build up phi renaming maps
        for (n, _) in f.cfg.nodes() {
            s.build_renamings(f, n);
        }

        // Prepare the graph and build all next_use information
        let mut changed = true;
        while changed {
            changed = false;
            f.cfg.each_postorder(f.root, &mut |&id| {
                changed = s.build_next_use(f, id) || changed;
            });
        }

        // In reverse postorder, spill everything!
        let (order, _) = f.cfg.postorder(f.root);
        for &id in order.iter().rev() {
            s.spill(f, id);
        }

        // Finally, clean things up by appending the necessary spills/reloads to
        // the relevant basic block
        for ((pred, _), ins) in s.connected.into_iter() {
            f.cfg.node_mut(pred).extend(ins);
        }
    }
}

fn sort(set: &TempSet, s: &NextUse) -> Vec<Temp> {
    let mut v = set.iter().map(|&t| t).collect::<Vec<_>>();
    v.sort_by(|&a: &Temp, &b: &Temp| {
        match s.get(&b) {
            None => Ordering::Less,       // a is always < infty
            Some(&b) => match s.get(&a) {
                None => Ordering::Greater,    // infty always > n
                Some(&a) => a.cmp(&b)
            }
        }
    });
    return v;
}

impl Spiller {
    /// Build up internal maps of the renaming of temps done by phi functions per
    /// node. This just needs to iterate and look at every phi node in a block.
    fn build_renamings(&mut self, f: &Function, n: NodeId) {
        let mut phis = HashMap::new();
        for ins in f.cfg.node(n).iter() {
            if let Inst::Phi(my_name, ref renamings) = *ins {
                for (&pred, &their_name) in renamings.iter() {
                    self.renamings.entry((pred, n)).or_insert_with(|| {
                        HashMap::new()
                    }).entry(their_name).or_insert_with(|| {
                        Vec::new()
                    }).push(my_name);
                }
                // TODO: is the dup necessary?
                let mut dup = HashMap::new();
                for (&k, &v) in renamings.iter() {
                    dup.insert(k, v);
                }
                assert!(phis.insert(my_name, dup).is_none());
            }
        }
        assert!(self.phis.insert(n, phis).is_none());
    }

    /// This performs the dataflow analysis necessary to build the internal maps of
    /// the next_use information. This returns whether any information was modified
    /// or not.
    ///
    /// The analysis is a backwards analysis (like liveness).
    ///
    /// TODO: move this into middle/liveness.rs
    fn build_next_use(&mut self, f: &Function, n: NodeId) -> bool {
        debug!("processing: {}", n);
        let mut bottom = HashMap::new();
        let block = f.cfg.node(n);

        // Union each of our predecessors into the 'bottom' map
        for succ in f.cfg.succ(n) {
            // at the end the next use of each of the temps we transfer to the
            // next node via phis is the length of the block that we're at
            if let Some(map) = self.phis.get(&succ) {
                for (_, phis) in map.iter() {
                    bottom.insert(phis[&n], block.len() as u32);
                }
            }
            if !self.next_use.contains_key(&succ) {
                continue
            }
            let edge_cost = match *f.cfg.edge(n, succ) {
                Edge::LoopOut | Edge::FLoopOut => LOOP_OUT_WEIGHT,
                _ => 0,
            };

            // Assume that all variables aren't used in this block and add
            // block.len() to the value being merged. This will be updated if
            // the value is actually used in the block
            let edge_cost = block.len() as u32 + edge_cost;

            // Temps may change names along edges because of phi nodes, so be
            // sure to account for that here
            for (&tmp, &next) in self.next_use[&succ].iter() {
                let cost = next + edge_cost;
                let mytmp = self.their_name(tmp, n, succ);
                let slot = bottom.entry(mytmp).or_insert(cost);
                *slot = cmp::min(cost, *slot);
            }
        }

        // Process all of our block's statements backwards
        let mut deltas = Vec::new();
        let mut max = bottom.len() as u32;
        for (i, ins) in block.iter().enumerate().rev() {
            let i = i as u32;
            let mut delta = Vec::new();
            if let Inst::PCopy(..) = *ins {
                deltas.push(delta);
                continue
            }
            // If we define a temp, then the distance to the next use from the
            // start is infinity because it's just not relevant
            ins.each_def(&mut |tmp| {
                // liveness stops here (hence pop) except for phi nodes
                if let Some(d) = bottom.remove(&tmp) {
                    delta.push((tmp, Some(d)));
                    if ins.is_phi() {
                        bottom.insert(tmp, d);
                    }
                }
            });

            // Our delta contains what the last distance to the temp used to be
            // (None for infty), and then we update it to our current distance
            // now
            ins.each_use(&mut |tmp| {
                delta.push((tmp, bottom.get(&tmp).map(|x| *x)));
                bottom.insert(tmp, i);
            });
            deltas.push(delta);
            max = cmp::max(max, bottom.len() as u32);
        }
        deltas.reverse();

        // If we didn't update anything, return false
        if let Some(before) = self.next_use.get(&n) {
            if bottom == *before && deltas == self.deltas[&n] {
                return false;
            }
        }
        debug!("next_use: {:?}", bottom);
        debug!("deltas: {:?}", deltas);

        // If we did update something, then update it and return so
        self.next_use.insert(n, bottom);
        self.deltas.insert(n, deltas);
        self.max_pressures.insert(n, max);
        return true;
    }

    /// This functions spills all necessary temps for the specified block. This may
    /// possibly insert spills/reloads in predecessor and successors depending on
    /// their processed state.
    fn spill(&mut self, f: &mut Function, n: NodeId) {
        debug!("spilling: {}", n);
        let regs_entry = match f.loops.get(&n) {
            Some(&(body, end)) => self.init_loop(f, n, body, end),
            None => self.init_usual(f, n)
        };
        let spill_entry = self.connect_pred(f, n, &regs_entry);

        // Set up the sets which will become {regs,spill}_exit
        let mut regs = HashSet::with_hash_state(FnvState);
        let mut spill = HashSet::with_hash_state(FnvState);
        regs.extend(&regs_entry);
        spill.extend(&spill_entry);

        // move out of {regs,spill}_entry because we're done with them now
        self.regs_entry.insert(n, regs_entry);
        self.spill_entry.insert(n, spill_entry);

        // connect what we can, may not succeed
        for pred in f.cfg.preds(n) {
            self.connect_edge(pred, n);
        }

        let mut reloaded = Vec::new();
        let mut block = Vec::new();

        // next_use is always relative to the top of the block
        let mut next_use = self.next_use[&n].clone();

        // Limit the amount of variables in registers by spilling those which
        // are used the farthest away
        fn limit(max: u32, regs: &mut TempSet, spill: &mut TempSet,
                 next_use: &mut HashMap<Temp, u32>,
                 block: &mut Vec<Inst>) {
            let max = max as usize;
            if regs.len() >= max {
                let sorted = sort(regs, next_use);
                debug!("{:?} {:?}", sorted, next_use);
                for &tmp in sorted[max..].iter() {
                    if !spill.contains(&tmp) && next_use.contains_key(&tmp) {
                        debug!("spilling {}", tmp);
                        block.push(Inst::Spill(tmp, tmp));
                    }
                    regs.remove(&tmp);
                    spill.remove(&tmp);
                }
            }
            assert!(regs.len() <= max);
        };

        fn apply_delta(delta: &Vec<(Temp, Option<u32>)>,
                       next_use: &mut HashMap<Temp, u32>) {
            // For each delta if the value is None, then that means the liveness
            // has stopped. Otherwise the next_use value is updated with what it
            // should be for down the road. We iterate in reverse order in case
            // one instruction uses the same operand more than once. In this
            // case the first listed delta is the one which is the relevant
            // value
            for &(tmp, amt) in delta.iter().rev() {
                match amt {
                    None    => { assert!(next_use.remove(&tmp).is_some()); }
                    Some(d) => { next_use.insert(tmp, d); }
                }
            }
        };

        debug!("{:?}", next_use);
        let mut i = 0;
        let node = f.cfg.pop_node(n);
        for (ins, delta) in node.into_iter().zip(self.deltas[&n].iter()) {
            debug!("{:2} {:30}  {:?} {:?}", i, ins, next_use, delta);

            match ins {
                // If the destination of a phi is not currently in the
                // registers, then we don't need the phi instruction because
                // it's been spilled and we don't want to put register moves
                // onto the incoming edges
                Inst::Phi(tmp, map) => {
                    if regs.contains(&tmp) {
                        block.push(Inst::Phi(tmp, map));
                    } else if next_use.contains_key(&tmp) {
                        block.push(Inst::MemPhi(tmp, map));
                    }
                    apply_delta(delta, &mut next_use);
                }

                Inst::PCopy(copies) => {
                    let newcopies = copies.iter().filter(|& &(dst, src)| {
                        assert!(dst == src);
                        regs.contains(&src)
                    }).map(|&x| x).collect();
                    block.push(Inst::PCopy(newcopies));
                    apply_delta(delta, &mut next_use);
                }

                ins => {
                    // Determine what needs to be reloaded
                    ins.each_use(|tmp| {
                        debug!("{} {}", tmp, next_use[&tmp]);
                        assert!(next_use[&tmp] == i);
                        if !regs.contains(&tmp) {
                            reloaded.push(tmp);
                            regs.insert(tmp);
                            spill.insert(tmp);
                        }
                    });
                    let extra = match ins {
                        Inst::BinaryOp(op, _, _, _) if op.constrained() => 1,
                        Inst::Call(..) => arch::CALLER_REGS,
                        _ => 0
                    };
                    // This limit is relative to the next_use of this
                    // instruction
                    debug!("making room for operands");
                    limit(arch::NUM_REGS - extra, &mut regs, &mut spill,
                          &mut next_use, &mut block);

                    // The next limit is relative to the next instruction
                    apply_delta(delta, &mut next_use);
                    let mut defs = 0;
                    ins.each_def(&mut |_| {
                        defs += 1;
                    });
                    debug!("making room for results");
                    limit(arch::NUM_REGS - defs, &mut regs, &mut spill,
                          &mut next_use, &mut block);

                    // Add all defined temps to the set of those in regs
                    ins.each_def(&mut |tmp| {
                        regs.insert(tmp);
                    });
                    assert!(regs.len() <= arch::NUM_REGS as usize);

                    // Finally reload all operands as necessary, and then run
                    // ins
                    for &tmp in reloaded.iter() {
                        block.push(Inst::Reload(tmp, tmp));
                    }
                    reloaded.truncate(0);
                    block.push(ins);
                }
            }

            i += 1;
        }

        debug!("node {} exit regs:{:?} spill:{:?}", n, regs, spill);
        f.cfg.update_node(n, block);
        self.regs_end.insert(n, regs);
        self.spill_exit.insert(n, spill);

        // connect any lingering edges which weren't covered beforehand
        for succ in f.cfg.succ(n) {
            if self.spill_entry.contains_key(&succ) {
                self.connect_edge(n, succ);
            }
        }
    }

    fn init_usual(&self, f: &Function, n: NodeId) -> TempSet {
        debug!("init_usual: {}", n);
        let mut freq = HashMap::with_hash_state(FnvState);
        let mut take = HashSet::with_hash_state(FnvState);
        let mut cand = HashSet::with_hash_state(FnvState);
        for pred in f.cfg.preds(n) {
            debug!("pred {}", pred);
            assert!(self.regs_end.contains_key(&pred));
            for &tmp in self.regs_end[&pred].iter() {
                self.my_names(tmp, pred, n, &mut |mine| {
                    *freq.entry(mine).or_insert(0) += 1;
                });
            }
        }
        debug!("frequencies: {:?}", freq);
        let preds = f.cfg.num_pred(n);
        for (&tmp, &n) in freq.iter() {
            if n == preds {
                take.insert(tmp);
            } else {
                cand.insert(tmp);
            }
        }
        let max = arch::NUM_REGS as usize - take.len();
        if max > 0 {
            let sorted = sort(&cand, &self.next_use[&n]);
            for &tmp in sorted[0..cmp::min(max, sorted.len())].iter() {
                if self.next_use[&n].contains_key(&tmp) {
                    take.insert(tmp);
                }
            }
        }
        return take;
    }

    fn init_loop(&self, f: &Function,
                 n: NodeId, body: NodeId, end: NodeId) -> TempSet {
        debug!("init_loop {} {} {}", n, body, end);
        // cand = (phis | live_in) & used_in_loop
        let mut cand = HashSet::with_hash_state(FnvState);
        // If a variable is used in the loop, then its next_use as viewed from the
        // body of the loop would be less than LOOP_OUT_WEIGHT
        for (&tmp, &n) in self.next_use[&n].iter() {
            if n < LOOP_OUT_WEIGHT {
                cand.insert(tmp);
            }
        }
        debug!("loop candidates: {:?}", cand);
        if cand.len() < arch::NUM_REGS as usize {
            // live_through = (phis | live_in) - cand
            let mut live_through = HashSet::with_hash_state(FnvState);
            live_through.extend(self.next_use[&n].keys()
                                    .chain(self.phis[&n].keys())
                                    .filter(|tmp| !cand.contains(tmp)));

            let mut visited = HashSet::default();
            visited.insert(n);   // don't loop back to the start
            visited.insert(end); // don't go outside the loop
            let free = (arch::NUM_REGS -
                        self.max_pressure(f, body, &mut visited)) as i32;
            debug!("live through loop: {:?} {}", live_through, free);
            if free > 0 {
                let sorted = sort(&live_through, &self.next_use[&n]);
                debug!("{:?}", sorted);
                for &tmp in sorted.iter().take(free as usize) {
                    cand.insert(tmp);
                }
            }
        } else if cand.len() > arch::NUM_REGS as usize {
            let sorted = sort(&cand, &self.next_use[&n]);
            for tmp in sorted.iter().skip(arch::NUM_REGS as usize) {
                cand.remove(tmp);
            }
        }
        return cand;
    }

    fn max_pressure(&self, f: &Function,
                    cur: NodeId, visited: &mut NodeSet) -> u32 {
        if visited.contains(&cur) { return 0; }

        visited.insert(cur);
        let mut ret = self.max_pressures[&cur];
        for succ in f.cfg.succ(cur) {
            ret = cmp::max(ret, self.max_pressure(f, succ, visited));
        }
        return ret;
    }

    fn connect_pred(&self, f: &Function, n: NodeId, entry: &TempSet) -> TempSet {
        debug!("connecting preds: {}", n);
        // Build up our list of required spilled registers
        let mut spill = HashSet::with_hash_state(FnvState);
        for pred in f.cfg.preds(n) {
            if !self.spill_exit.contains_key(&pred) {
                continue
            }
            // Be sure we're using the right name for each temp spilled on the
            // exit of our predecessors because we may be renaming it with a phi
            // node
            for &tmp in self.spill_exit[&pred].iter() {
                // spill is intersected with the entry set
                if entry.contains(&tmp) {
                    self.my_names(tmp, pred, n, &mut |mine| {
                        spill.insert(mine);
                    });
                }
            }
        }
        // TODO: this needs a better solution...
        for (k, _) in self.phis[&n].iter() {
            spill.remove(k);
        }
        debug!("node {} entry regs:{:?} spill:{:?}", n, entry, spill);
        return spill;
    }

    fn connect_edge(&mut self, pred: NodeId, succ: NodeId) {
        if self.connected.contains_key(&(pred, succ)) { return }
        if !self.spill_exit.contains_key(&pred) { return }
        debug!("connecting {} {}", pred, succ);
        let succ_spill = &self.spill_entry[&succ];
        let succ_regs = &self.regs_entry[&succ];

        let pred_regs_exit = &self.regs_end[&pred];
        let pred_spill_exit = &self.spill_exit[&pred];
        let nxt = &self.next_use[&succ];

        let mut append = Vec::new();
        // All registers they had which we don't have which we may eventually use
        // need to be spilled
        for &tmp in pred_regs_exit.iter() {
            // no need to spill if it's already spilled
            if pred_spill_exit.contains(&tmp) { continue }

            // for each of my names for this temp, see if a spill is needed
            self.my_names(tmp, pred, succ, &mut |mine| {
                debug!("name {} {:?} {}", mine, succ_regs.contains(&mine),
                       nxt.contains_key(&mine));
                if !succ_regs.contains(&mine) && nxt.contains_key(&mine) {
                    append.push(Inst::Spill(tmp, tmp));
                }
            });
        }

        // Each register we want spilled that they haven't spilled needs a spill
        for &tmp in succ_spill.iter() {
            let theirs = self.their_name(tmp, pred, succ);
            if !pred_spill_exit.contains(&theirs) &&
                pred_regs_exit.contains(&theirs) {
                    append.push(Inst::Spill(theirs, theirs));
                }
        }

        // Each register we have which they don't have needs a reload
        for &tmp in succ_regs.iter() {
            let theirs = self.their_name(tmp, pred, succ);
            debug!("ours {} theirs {}", tmp, theirs);
            if !pred_regs_exit.contains(&theirs) {
                append.push(Inst::Reload(theirs, theirs));
            }
        }

        self.connected.insert((pred, succ), append);
    }

    fn my_names(&self, tmp: Temp, from: NodeId, to: NodeId, f: &mut FnMut(Temp)) {
        match self.renamings.get(&(from, to)).and_then(|m| m.get(&tmp)) {
            Some(ret) => {
                for &t in ret.iter() {
                    f(t)
                }
                if self.next_use[&to].contains_key(&tmp) {
                    f(tmp)
                }
            }
            None => { f(tmp) }
        }
    }

    fn their_name(&self, tmp: Temp, from: NodeId, to: NodeId) -> Temp {
        self.phis[&to].get(&tmp).map(|m| m[&from]).unwrap_or(tmp)
    }
}

#[cfg(test)]
fn set(v: Vec<i32>) -> TempSet {
    let mut set = HashSet::new();
    for &i in v.iter() {
        set.insert(i as Temp);
    }
    return set;
}

#[test]
fn test_sort_works1() {
    let mut map: NextUse = HashMap::new();
    map.insert(4, 5);
    map.insert(5, 6);
    let sorted = sort(&set(vec![4, 5, 6]), &map);
    assert!(sorted[0] == 4);
    assert!(sorted[1] == 5);
    assert!(sorted[2] == 6);
}

#[test]
fn test_sort_works2() {
    let mut map: NextUse = HashMap::new();
    map.insert(4, 5);
    map.insert(5, 6);
    let sorted = sort(&set(vec![4, 5]), &map);
    assert!(sorted[0] == 4);
    assert!(sorted[1] == 5);
}
