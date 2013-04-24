/**
 * @brief Coalescing of a colored graph to reduce the amount of moves needed
 *        when removing phi functions.
 *
 * This file implements the algorithm described in Sebastian Hack's thesis paper
 * "Register Allocation for Program in SSA Form". One of the main results of the
 * coalescing problem in his paper is that it is NP-complete, so this obviously
 * doesn't impement an ideal solution. He outlines a rough heuristic, however,
 * which performs well a good portion of the time.
 *
 * The basic idea of the algorithm is to take "chunks" of related temps and
 * attempt to recolor them all to the same register. When doing so, some may not
 * be recolorable, so you slowly permanently fix temps in the graph to certain
 * colors while attempting to recolor others at the same time.
 *
 * This process contains quite a bit of computation, and has been attempted to
 * be heavily optimized as a result. Specific information about the algorithm
 * can be found in the comments of the functions. Some important terms used in
 * this implementation:
 *
 * # Affinity
 *
 * Foremost there is the notion of two temps being 'affine' to one another. If
 * temps x and y are affine, then if x and y are coalesced to the same color,
 * some exchange or move will be saved. All affinities are generated by phi
 * functions and PCopy instructions.
 *
 * Each affinity is also associated with a weight. This corresponds to how much
 * 'cost' is saved if the two temps are coalesced to the same color. This
 * implementation considers affinities inside loops to be more costly than those
 * outside of loops.
 *
 * Affinity is considered to be a transitive relation among temps, so temps can
 * be affine even if they're not directly associated with an affinity edge.
 *
 * # Chunk
 *
 * A chunk is just a set of nodes under consideration for coalescing. Each chunk
 * has an associated weight with it, which is just the sum of all the affinity
 * costs of the temps in the chunk. There is a queue of chunks to work on which
 * is a priority queue based on these weights.
 *
 * When coalescing a chunk, the entire chunk may not be recolored, so some of
 * the chunk may go back into the priority queue for re-evaluation later.
 */
use core::hashmap::{HashMap, HashSet};

use std::bitv;
use std::priority_queue::PriorityQueue;
use std::smallintmap::SmallIntMap;

use middle::{ir, liveness};
use middle::temp::{Temp, TempSet};
use back::{assem, arch, alloc};
use utils::{profile, set};
use utils::graph::{NodeSet, NodeId};

type Location = (NodeId, int);
type Affinities = HashMap<Temp, ~HashMap<Temp, uint>>;
struct Affinity(Temp, Temp, uint);
struct Chunk(TempSet, uint);

struct Coalescer<'self> {
  /* set of temps that are precolored */
  precolored: bitv::Bitv,
  /* For all temps with constraints, contains mapping of the constraints. This
     is used when determining the admissible registers for a temp */
  constraints: &'self mut alloc::ConstraintMap,
  /* Actual coloring information that's modified */
  colors: &'self mut alloc::ColorMap,

  /* Set of fixed temps (cannot be changed) */
  fixed: bitv::Bitv,
  /* Map of affine temps, and their weights. The map works both ways, as in
     looking up x then y is the same as looking up y then x */
  affinities: Affinities,
  /* Temporary mapping remembering the old colors of temps for rollbacks */
  old_color: SmallIntMap<uint>,

  info: @mut CFGInfo<'self>,
}

struct CFGInfo<'self> {
  /* Mapping of a temp to where it's defined */
  defs: HashMap<Temp, Location>,
  /* Mapping of a temp to the set of locations in which it is used */
  uses: HashMap<Temp, ~HashSet<Location>>,

  /* find_interferences is an incredibly slow method, and this is a
     precomputation of the input to a more efficient format to be used in that
     method (more information on the method itself) */
  liveness_map: HashMap<NodeId, ~[bitv::Bitv]>,

  /* This algorithm requires a lot of information about the interference graph
     and associated components, and because interference information is very
     costly to generate, there are a number of caches which store the results of
     this computation to facilitate usage later on */
  cache: @mut Cache,

  f: &'self mut assem::Function,
}

struct Cache {
  interference: HashMap<Temp, ~TempSet>,
  interferences: HashMap<(Temp, Temp), bool>,
  admissible: HashMap<(Temp, uint), bool>,
  dominates: HashMap<(NodeId, NodeId), bool>,
}

pub fn optimize(f: &mut assem::Function,
                colors: &mut alloc::ColorMap,
                precolored: &TempSet,
                constraints: &mut alloc::ConstraintMap) {
  let lm = liveness_map(f.cfg, &f.liveness, f.temps);
  let mut pre = bitv::Bitv::new(f.temps, false);
  for precolored.each |&t| {
    pre.set(t, true);
  }
  /* TODO(#5884): this is silly */
  let fixed = bitv::Bitv::new(f.temps, false);
  let affinities = HashMap::new();
  let old_color = SmallIntMap::new();
  {
    let info = CFGInfo {
      liveness_map: lm,
      cache: @mut Cache {
        interference: HashMap::new(),
        interferences: HashMap::new(),
        admissible: HashMap::new(),
        dominates: HashMap::new() },
      defs: HashMap::new(),
      uses: HashMap::new(),
      f: f,
    };
    let mut c = Coalescer { fixed: fixed,
                            affinities: affinities,
                            colors: colors,
                            old_color: old_color,
                            precolored: pre,
                            constraints: constraints,
                            info: @mut info };
    c.run();
  }
}

/**
 * Convert the liveness analysis to a mapping of bit vectors of the live temps
 * at each instruction in the program.
 */
fn liveness_map(cfg: &assem::CFG, live: &liveness::Analysis, max: uint)
      -> HashMap<NodeId, ~[bitv::Bitv]> {
  let mut ret = HashMap::new();
  for cfg.each_node |id, stms| {
    let mut vec = ~[];
    let mut set = HashSet::new();
    for live.in.get(&id).each |&t| { set.insert(t); }

    for stms.eachi |i, &stm| {
      /* we care about 'live-out' variables on an instruction */
      liveness::apply(&mut set, &live.deltas.get(&id)[i]);
      let mut bitv = bitv::Bitv::new(max, false);
      for set.each |&t| { bitv.set(t, true); }
      /* at one instruction, the defined registers interfere with all live out
       * registers, even if the defined register isn't actually used anywhere */
      for stm.each_def |t| { bitv.set(t, true); }

      vec.push(bitv);
    }

    ret.insert(id, vec);
  }
  return ret;
}

impl<'self> Coalescer<'self> {
  fn run(&mut self) {
    /* TODO: why can't this be above */
    do profile::dbg("building use/def") {
      for self.info.f.cfg.each_node |id, ins| {
        self.info.build_use_def(id, ins);
      }
    }
    self.coalesce();
  }

  /**
   * Perform the actual coalescing of the graph.
   */
  fn coalesce(&mut self) {
    /* Algorithm 4.3 */
    let mut pq = self.build_chunks();
    while !pq.is_empty() {
      /* TODO: why can't this be on one line? */
      let chunk = pq.pop();
      self.recolor_chunk(chunk, &mut pq);
    }
  }

  /**
   * Actually attempts to recolor a chunk of temps to the same color
   *
   * Basically just iterates over each register and attemps to set the color of
   * each temp in the set to this color. Afterwards the best affine subset
   * (weighed by the cost of the set) is kept track of. Eventually this best
   * subset's register is assigned to those temps and whatever temps remaining
   * in the chunk are re-added to the priority queue
   */
  fn recolor_chunk(&mut self, Chunk(tmps, cost): Chunk,
                   pq: &mut PriorityQueue<Chunk>) {
    let mut tmps = tmps;
    debug!("-------------------------------------------------------------");
    info!("coloring chunk %s %?", tmps.pp(), cost);
    let mut best_cost = 0;
    let mut best_color = -1;
    let mut best_set = HashSet::new();
    macro_rules! docolor(
      ($set:expr, $color:expr) =>
      ({
        /* Unfix all temps */
        for tmps.each |&tmp| { self.fixed.set(tmp, false); }
        for $set.each |&tmp| {
          self.recolor(tmp, $color);
          self.fixed.set(tmp, true);
        }
      })
    );

    /* Sanity check that we're not coalescing fixed temps */
    for tmps.each |&t| {
      assert!(!self.fixed.get(t));
    }

    /* For each register, attempt to color everything to that register */
    for arch::each_reg |r| {
      debug!("trying %?", r);
      docolor!(tmps, r);
      match self.best_subset(&tmps, r) {
        None => (),
        Some((M, mcost)) => {
          if mcost > best_cost {
            best_color = r;
            best_cost = mcost;
            best_set = M;
          }
        }
      }
    }
    if best_color == -1 {
      info!("utterly impossible %s", best_set.pp());
      return;
    }

    /* If we found a good set, then fix everything to that color and perhaps
       push the remaining temps in the chunk back into the priority queue */
    debug!("-------------------------------------------------------------");
    info!("selected %? for %s", best_color, best_set.pp());
    docolor!(best_set, best_color);
    for best_set.each |t| {
      tmps.remove(t);
    }
    if tmps.len() > 0 {
      pq.push(Chunk(tmps, cost - best_cost));
    }
    debug!("-------------------------------------------------------------");
  }

  /**
   * Calculates the best affine subset of 's'
   *
   * The set 's' can be divided into a number of disjoint subsets, each of which
   * is internally pairwise affinity-related. Among these sets, one of them also
   * has a maximum weight of temps within, and this function calculates and
   * returns that set along with the weight of the set.
   */
  fn best_subset(&self, s: &TempSet, c: uint) -> Option<(TempSet, uint)> {
    fn first(s: &TempSet) -> Temp {
      for s.each |&t| { return t }
      fail!()
    }

    let mut maxweight = 0;
    let mut maxset = None;

    /* Left is a set of temps that haven't yet been processed, and it's
       initially the subset of 's' of all temps with color 'c' */
    let mut left = HashSet::new();
    for s.each |&tmp| {
      /* TODO(purity): why is this unsafe */
      unsafe {
        if *self.colors.get(&tmp) == c {
          left.insert(tmp);
        }
      }
    }
    debug!("best of %s in %s for %?", left.pp(), s.pp(), c);

    /* Iterate over the set of temps and partition as we go */
    loop {
      if left.len() == 0 { break; }
      let mut subset = HashSet::new();
      let mut qweight = 1;

      /* Start with the first temp in 'left', and then iteratively build up
         everything that it's affine to. All of it's affinities get added to
         this queue to be later processed and have all their affinities added as
         well */
      let mut queue = ~[first(&left)];
      while queue.len() > 0 {
        let tmp = queue.pop();
        subset.insert(tmp);
        left.remove(&tmp);
        assert!(self.affinities.contains_key(&tmp));
        for self.affinities.get(&tmp).each |&next, &weight| {
          debug!("%? affine with %? cost %?", tmp, next, weight);
          if left.contains(&next) && !subset.contains(&next) {
            debug!("adding %?", next);
            queue.push(next);
            qweight += weight;
          }
        }
      }

      debug!("found %s %?", subset.pp(), qweight);
      if qweight > maxweight {
        maxweight = qweight;
        maxset = Some(subset);
      }
    }
    if maxweight == 0 {
      debug!("no good subset");
      return None;
    }
    let maxset = maxset.unwrap();
    debug!("found %s %?", maxset.pp(), maxweight);
    return Some((maxset, maxweight));
  }

  /**
   * This set of methods is used to actually recolor a temp to a particular
   * color. It works by fixing a temp at a color, and then attempting to recolor
   * all interfering neighbors of that temp recursively.
   *
   * If this ever fail!s, then the recoloration is rolled back and there's no
   * effect. Before and after an invocation of recolor() the color mapping will
   * be a valid mapping for all temps
   */

  /* Algorithm 4.4 */
  fn recolor(&mut self, t: Temp, c: uint) {
    /* If the color isn't admissible or 't' is fixed, then nothing we can do */
    if !self.admissible(t, c) { debug!("not admissible %? %?", t, c); return }
    if self.fixed.get(t) { debug!("fixed %?", t); return }

    /* Mark 't' as changed, and then attempt to recolor all our interferences */
    let mut changed = ~[];
    self.set_color(t, c, &mut changed);
    debug!("recoloring %? to %?", t, c);

    for self.info.interferences(t) |tmp| {
      debug!("recoloring %? interfering with %?", tmp, t);
      if !self.avoid_color(tmp, c, &mut changed) {
        /* rollback */
        for changed.each |&tmp| {
          assert!(self.old_color.contains_key(&tmp));
          self.colors.insert(tmp, *self.old_color.get(&tmp));
        }
      }
    }
    for changed.each |&tmp| {
      self.fixed.set(tmp, false);
    }
  }

  fn set_color(&mut self, t: Temp, c: uint, changed: &mut ~[Temp]) {
    debug!("setting %? to %?", t, c);
    self.fixed.set(t, true);
    self.old_color.insert(t, *self.colors.get(&t));
    changed.push(t);
    self.colors.insert(t, c);
  }

  fn avoid_color(&mut self, t: Temp, c: uint, changed: &mut ~[Temp]) -> bool {
    /* TODO: silly block */
    let color; { color = *self.colors.get(&t); }
    /* Certainly avoided if it's already not this color */
    if color != c { debug!("avoided %? %?", t, c); return true }
    /* Otherwise if it's fixed, then we're out of luck */
    if self.fixed.get(t) { debug!("fixed %?", t); return false }
    /* If it the color isn't admissible, nothing we can do */
    if self.precolored.get(t) && c != color {
      debug!("%? fixed elsewhere (%? %?)", t, c, self.colors.get(&t));
      return false
    }

    /* After all that, we're in luck! Find a viable color for this temp which is
       used least by the temp's interfering neighbors, fix the color, and then
       recolor all our neighbors (again) */
    let color = if self.precolored.get(t) {
      c
    } else {
      self.min_color(t, c)
    };
    self.set_color(t, color, changed);
    for self.info.interferences(t) |tmp| {
      if !self.avoid_color(tmp, color, changed) {
        debug!("failed to avoid on interference %?", tmp);
        return false;
      }
    }
    return true;
  }

  /**
   * Calculates the minimum color used by t's interference neighbors
   *
   * The 'ignore' parameter is a register to blacklist and never use
   */
  fn min_color(&mut self, t: Temp, ignore: uint) -> uint {
    /* cnts[i] = inft  =>  i can't be used for 't' */
    let mut cnts = vec::from_elem(arch::num_regs, uint::max_value);
    for arch::each_reg |r| {
      if r != ignore && self.admissible(t, r) {
        cnts[r - 1] = 0;
      }
    }

    /* Iterate over our interferences and bump counts for their colors */
    for self.info.interferences(t) |tmp| {
      let idx = *self.colors.get(&tmp) - 1;
      if cnts[idx] != uint::max_value {
        cnts[idx] += 1;
      }
    }

    /* And finally find the minimum index */
    let mut mini = 0;
    let mut min = uint::max_value;
    for cnts.eachi |i, &cnt| {
      if cnt < min {
        min = cnt;
        mini = i;
      }
    }
    return mini + 1;
  }

  /**
   * Determines whether a color is admissible for a temp using the constraints
   * placed on the temp from allocation/precoloring
   *
   * This doesn't look at neighbors to or anything like that, it's purely
   * whether the temp 't' could ever have the color 'color'.
   */
  fn admissible(&self, t: Temp, color: uint) -> bool {
    /* TODO: remove this cache? */
    /*match unsafe { self.cache.admissible.find(&(t, color)) } {*/
    /*  Some(&a) => { return a; }*/
    /*  None => ()*/
    /*}*/
    let b = self.admissible_impl(t, color);
    /*self.cache.admissible.insert((t, color), b);*/
    return b;
  }

  fn admissible_impl(&self, t: Temp, color: uint) -> bool {
    unsafe {
      if self.precolored.get(t) { return color == *self.colors.get(&t) }
      match self.constraints.find(&t) {
        None => true,
        Some(c) => c.allows(arch::num_reg(color))
      }
    }
  }

  /**
   * Computes a priority queue of chunks to be processed for recoloring.
   *
   * A chunk is a set of temps which are all affine to one another, yet have no
   * pairwise interferences among them. The optimal graph would be found if all
   * chunks could be recolored to the same color (within each chunk).
   */
  fn build_chunks(&mut self) -> PriorityQueue<Chunk> {
    /* Algorithm 4.5 */
    let mut pq = self.find_affinities();
    let mut chunks = HashMap::new();
    let mut temp_chunks = HashMap::new();
    let mut next_chunk = 1;
    chunks.insert(0, Chunk(HashSet::new(), 0));

    /* Process the highest cost affine temps first. For the affinity edge (x, y)
       there are two chunks. We attempt to merge x's chunk with y's chunk which
       can only be done if nothing pairwise interferes */
    while !pq.is_empty() {
      let Affinity(x, y, w) = pq.pop();
      let xc = temp_chunks.find(&x).map_default(0, |&x| *x);
      let yc = temp_chunks.find(&y).map_default(0, |&x| *x);
      let mut merge;
      let weight;
      {
        /* In a separate scope, see if we should skip merging the two chunks of
           these two variables */
        /* TODO(#4653): make this sane again */
        /*let &Chunk(ref xs, _) = chunks.get(&xc);*/
        /*let &Chunk(ref ys, _) = chunks.get(&yc);*/
        let a = chunks.get(&xc);
        let b = chunks.get(&yc);
        let (xs, xw) = match *a { Chunk(ref xs, xw) => (xs, xw) };
        let (ys, yw) = match *b { Chunk(ref ys, yw) => (ys, yw) };
        let mut interferes = false;

        /* Here try to find if anything pairwise interfers between the chunks,
         * and if it does we have to break out and just go to the next affinity
         * edge in the graph */
        for xs.each |&v| { /* v.chunk = x.chunk */
          for ys.each |&w| { /* w.chunk = y.chunk */
            interferes = interferes || self.info.interferes(v, w);
            if interferes { break }
          }
          if interferes { break }
        }
        if interferes { loop }

        /* no element of the two chunks interfere, merge the chunks */
        merge = HashSet::new();
        merge.insert(x);
        merge.insert(y);
        for xs.each |&x| { merge.insert(x); }
        for ys.each |&y| { merge.insert(y); }
        weight = w + xw + yw;
      }

      /* In another scope where 'chunks' is mutable, insert/remove chunks */
      let num = next_chunk;
      next_chunk += 1;
      for merge.each |&tmp| {
        temp_chunks.insert(tmp, num);
      }
      chunks.insert(num, Chunk(merge, weight));

      /* remove the old chunks so long as they're not the base ones */
      if xc != 0 { chunks.remove(&xc); }
      if yc != 0 { chunks.remove(&yc); }
    }

    /* Finally insert all chunks into a priority queue now that we've finalized
     * what each chunk is going to be */
    let mut ret = PriorityQueue::new();
    do chunks.consume |i, c| {
      if i != 0 {
        ret.push(c);
      }
    }
    return ret;
  }

  /**
   * Creates a priority queue of all affinity edges in the interference graph
   *
   * This simply traverses the entire CFG looking for phi nodes and PCopy nodes
   * to generate affinity relations
   */
  fn find_affinities(&mut self) -> PriorityQueue<Affinity> {
    macro_rules! add_affine(
      ($a1:expr, $b1:expr, $weight1:expr) => ({
        /* TODO: should be a match */
        if self.affinities.contains_key(&$a1) {
          unsafe {
            self.affinities.find_mut(&$a1).unwrap().insert($b1, $weight1);
          }
        } else {
          let mut m = ~HashMap::new();
          m.insert($b1, $weight1);
          self.affinities.insert($a1, m);
        }
      })
    );
    macro_rules! affine(
      ($a:expr, $b:expr, $weight:expr) => ({
        add_affine!($a, $b, $weight);
        add_affine!($b, $a, $weight);
        pq.push(Affinity($a, $b, $weight));
      })
    );

    let mut pq = PriorityQueue::new();
    let mut to_visit = ~[(self.info.f.root, 1)];
    let mut visited = HashSet::new();

    while to_visit.len() > 0 {
      let (n, weight) = to_visit.pop();
      assert!(visited.insert(n));
      /* We have a more costly weight if we're moving into a loop */
      let weight = weight + unsafe {
        if self.info.f.loops.contains_key(&n) { 1 } else { 0 }
      };
      for self.info.f.cfg.node(n).each |&ins| {
        match ins {
          ~assem::Phi(def, ref map) => {
            for map.each |_, &tmp| {
              /* TODO(#4650): when this ICE is fixed, uncomment */
              /*affine!(def, tmp, weight);*/
              add_affine!(tmp, def, weight);
              add_affine!(def, tmp, weight);
              pq.push(Affinity(tmp, def, weight));
            }
          }
          ~assem::PCopy(ref copies) => {
            for copies.each |&(a, b)| {
              /* TODO(#4650): when ICE is fixed, uncomment */
              /*affine!(a, b, weight);*/
              add_affine!(a, b, weight);
              add_affine!(b, a, weight);
              pq.push(Affinity(a, b, weight));
            }
          }
          _ => ()
        }
      }

      for self.info.f.cfg.each_succ_edge(n) |succ, edge| {
        if visited.contains(&succ) { loop }
        /* If we're moving out of a loop, decrement the weight */
        let weight = match edge {
          ir::FLoopOut | ir::LoopOut => weight - 1, _ => weight
        };
        to_visit.push((succ, weight));
      }
    }

    return pq;
  }
}

impl<'self> CFGInfo<'self> {
  /**
   * Build up the internal maps about use/def information. This precomputes the
   * information about where each temp is defined and the set of uses for each
   * temp.
   */
  fn build_use_def(&mut self, n: NodeId, ins: &~[~assem::Instruction]) {
    macro_rules! add_use(
      ($tmp:expr, $loc:expr) => ({
        match self.uses.find_mut(&$tmp) {
          Some(s) => { s.insert($loc); loop; }
          None => {}
        }
        self.uses.insert($tmp, ~set::singleton($loc));
      })
    );
    for ins.eachi |i, &ins| {
      for ins.each_def |tmp| {
        assert!(self.defs.insert(tmp, (n, i as int)));
      }
      for ins.each_use |tmp| {
        add_use!(tmp, (n, i as int));
      }
      match ins.phi_info() {
        None => (),
        Some((_, m)) => {
          for m.each |&pred, &tmp| {
            add_use!(tmp, (pred, int::max_value));
          }
        }
      }
    }
  }

  /**
   * Tests whether two temps interfere within the interference graph
   *
   * This is done without actually creating the interference graph
   */
  fn interferes(&self, x: Temp, y: Temp) -> bool {
    /* TODO: remove this cache */
    match unsafe { self.cache.interferences.find(&(x, y)) } {
      Some(&b) => return b,
      None => (),
    }
    let b = self.interferes_impl(x, y);
    self.cache.interferences.insert((x, y), b);
    self.cache.interferences.insert((y, x), b);
    return b;
  }

  /**
   * Actual implementation without a cache of the interference of two temps
   */
  fn interferes_impl(&self, x: Temp, y: Temp) -> bool {
    /* Algorithm 4.6 */
    let &xdef = self.defs.get(&x);
    let &ydef = self.defs.get(&y);
    /* Find (t, b) such that t's definition dominates b's */
    let (t, b) = if self.dominates(ydef, xdef) {
      (y, x)
    } else if self.dominates(xdef, ydef) {
      (x, y)
    } else {
      /* if neither dominate each other, no way they can interfere */
      return false;
    };

    /* If 't' is live out in b's definition, then they definitely interfere */
    let &(bdef, bline) = self.defs.get(&b);
    if unsafe { self.f.liveness.out.get(&bdef).contains(&t) } {
      return true;
    }

    /* Otherwise, we need to check each use of 't', and if the use is dominated
     * by b's definition then there's an interference */
    match self.uses.find(&t) {
      None => (),
      Some(m) => {
        for m.each |&loc| {
          if self.dominates((bdef, bline), loc) {
            return true;
          }
        }
      }
    }

    /* If all that passes, then these two variables do not interfere */
    return false;
  }

  /**
   * Iterates over all temps which 't' interferes with using the given closure
   *
   * This is the most costly operation in coalescing. Interference graphs are
   * often very large and there's a reason that the graph itself isn't actually
   * computed ahead of time.
   *
   * To see problems in optimization, see find_interferences
   */
  fn interferences(&self, t: Temp, f: &fn(Temp) -> bool) {
    /* definitely cache information once we've calculated it */
    unsafe {
      match self.cache.interference.find(&t) {
        Some(s) => { s.each(|&t| f(t)); return }
        None => ()
      }
    }

    /* Prelude to Algorithm 4.7 (find_interferences) */
    let mut visited = HashSet::new();
    let mut bitv = bitv::Bitv::new(self.f.temps, false);
    match self.uses.find(&t) {
      Some(uses) => {
        for uses.each |&(block, _)| {
          self.find_interferences(t, block, &mut bitv, &mut visited);
        }
      }
      /* Dead variables never used should only have their point of definition
         processed because those variables live over the instruction of
         definition should be considered as interfering */
      None => {
        let &(block, _) = self.defs.get(&t);
        self.find_interferences(t, block, &mut bitv, &mut visited);
      }
    }
    let mut set = ~HashSet::new();
    for bitv.ones |x| {
      if x != t {
        set.insert(x);
      }
    }
    debug!("%? interferencs: %s", t, set.pp());
    self.cache.interference.insert(t, set);
    self.cache.interference.get(&t).each(|&t| f(t));
  }

  /**
   * Actual grunt work of finding interferences of a variable in a graph
   *
   * I've attempted to heavily optimize this method as much as possible. Normal
   * TempSet structures and things like that aren't used here because they're
   * just too costly. These are the optimizations so far:
   *
   *    1. Use bit vectors instead of HashSet TempSet structures
   *
   *          This ended up being a huge win because the operations needed,
   *          get/set/union are all far faster on a bit vector than on a hash
   *          map or similar
   *
   *    2. Precompute live sets of variables at all instructions
   *
   *          The only goal of this algorithm is to iterate from a usage point
   *          up to the definition, collecting all variables that are
   *          simultaneously live with 'x'. All variables live at all
   *          instructions have already been converted into bit vectors, so the
   *          union operation is nice and cheap.
   *
   * Basially, if this code looks really weird and like it's not using any
   * convention used in the rest of the compiler, it's because it's balls slow,
   * but really useful. This also explains the precomputation done far above
   * this function.
   */
  fn find_interferences(&self, x: Temp, n: NodeId, set: &mut bitv::Bitv,
                        visited: &mut NodeSet) {
    /* Algorithm 4.7 */
    if visited.contains(&n) { return }
    visited.insert(n);

    /* the set of live variables has already been computed at all instructions,
       so we just need to union whatever sets have our variable in question */
    for self.liveness_map.get(&n).each |bitv| {
      if bitv.get(x) {
        set.union(bitv);
      }
    }

    let &def = self.defs.get(&x);
    for self.f.cfg.each_pred(n) |pred| {
      /* Be sure to check the dominance relation relative to the end of the
         predecessor's block as opposed to the start as x could have been
         defined in the block */
      if self.dominates(def, (pred, int::max_value)) {
        self.find_interferences(x, pred, set, visited);
      }
    }
  }

  /**
   * Tests wehther a location dominates another location in the graph
   */
  fn dominates(&self, (a, aline): Location, (b, bline):Location) -> bool {
    /* Same block? well that's easy */
    if a == b {
      return aline < bline;
    }
    match unsafe { self.cache.dominates.find(&(a, b)) } {
      Some(&s) => { return s; }
      None => {}
    }
    /* Otherwise we just walk up b's idominator tree to see if we ever find a,
       if we find the root first, then a doesn't dominate b */
    unsafe {
      let mut cur = &b;
      let mut dominates = false;
      let idominator = &self.f.ssa.idominator;
      loop {
        let nxt = idominator.get(cur);
        if nxt == cur { break }
        if *nxt == a { dominates = true; break; }
        cur = nxt;
      }
      self.cache.dominates.insert((a, b), dominates);
      self.cache.dominates.insert((b, a), !dominates);
      return dominates;
    }
  }
}

impl cmp::Ord for Affinity {
  fn lt(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a < b }
  }
  fn le(&self, other: &Affinity) -> bool { !other.lt(self) }
  fn gt(&self, other: &Affinity) -> bool { !self.le(other) }
  fn ge(&self, other: &Affinity) -> bool { !self.lt(other) }
}

impl cmp::Ord for Chunk {
  fn lt(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a < b }
  }
  fn le(&self, other: &Chunk) -> bool { !other.lt(self) }
  fn gt(&self, other: &Chunk) -> bool { !self.le(other) }
  fn ge(&self, other: &Chunk) -> bool { !self.lt(other) }
}
