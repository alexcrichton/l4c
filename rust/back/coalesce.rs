use core::util::ignore;
use core::hashmap::linear::{LinearMap, LinearSet};

use std::{map, bitv};
use std::priority_queue::PriorityQueue;

use middle::{ir, ssa, liveness};
use middle::temp::Temp;
use back::{assem, arch, alloc};
use utils::{set, profile};
use utils::graph::{NodeSet, NodeId};

type Location = (NodeId, int);
type TempSet = bitv::Bitv;
type Affinities = LinearMap<Temp, LinearMap<Temp, uint>>;
struct Affinity(Temp, Temp, uint);
struct Chunk(TempSet, uint);

struct Coalescer {
  defs : LinearMap<Temp, Location>,
  uses : LinearMap<Temp, LinearSet<Location>>,
  f : &mut assem::Function,
  fixed : TempSet,
  affinities : Affinities,
  colors : &mut LinearMap<Temp, uint>,
  old_color : LinearMap<Temp, uint>,
  precolored : &TempSet,
  constraints : &LinearMap<Temp, assem::Constraint>,
  interference_cache: LinearMap<Temp, TempSet>,
  interferences_cache: LinearMap<(Temp, Temp), bool>,
  admissible_cache: LinearMap<(Temp, uint), bool>,
  dominates_cache: LinearMap<(Location, Location), bool>,
}

pub fn optimize(f: &mut assem::Function,
                colors: &mut alloc::ColorMap,
                precolored: &TempSet,
                constraints: &LinearMap<Temp, assem::Constraint>) {
  let mut c = Coalescer { defs: LinearMap::new(),
                          uses: LinearMap::new(),
                          fixed: bitv::Bitv(f.ssa.temps, false),
                          f: f,
                          affinities: LinearMap::new(),
                          colors: colors,
                          old_color: LinearMap::new(),
                          precolored: precolored,
                          constraints: constraints,
                          interference_cache: LinearMap::new(),
                          interferences_cache: LinearMap::new(),
                          admissible_cache: LinearMap::new(),
                          dominates_cache: LinearMap::new() };
  do profile::dbg("building use/def") {
    for c.f.cfg.each_node |id, &ins| {
      c.build_use_def(id, ins);
    }
  }
  c.coalesce();
}

macro_rules! find_default(
  ($map:expr, $key:expr, $default:expr) => (
    match $map.find(&$key) {
      Some(s) => s,
      None => {
        $map.insert($key, $default);
        $map.get(&$key)
      }
    }
  )
)

impl Coalescer {
  fn build_use_def(&mut self, n : NodeId, ins: @~[@assem::Instruction]) {
    macro_rules! find_set(($map:expr, $key:expr) =>
      (find_default!($map, $key, ~mut LinearSet::new())))

    let mut uses = LinearMap::new();

    for ins.eachi |i, &ins| {
      for ins.each_def |tmp| {
        assert self.defs.insert(tmp, (n, i as int));
      }
      for ins.each_use |tmp| {
        (find_set!(uses, tmp)).insert((n, i as int));
      }
      match ins.phi_map() {
        None => (),
        Some(m) => {
          for m.each |pred, tmp| {
            (find_set!(uses, tmp)).insert((pred, int::max_value));
          }
        }
      }
    }

    /* TODO: figure out how to mutate a set in a map */
    do uses.consume |k, v| {
      self.uses.insert(k, *v);
    }
  }

  /* Algorithm 4.3 */
  fn coalesce(&mut self) {
    let mut pq = self.build_chunks();
    while !pq.is_empty() {
      do profile::dbg("recoloring chunk") {
        self.recolor_chunk(pq.pop(), &mut pq);
      }
    }
  }

  fn recolor_chunk(&mut self, Chunk(tmps, cost): Chunk,
                   pq: &mut PriorityQueue<Chunk>) {
    debug!("-------------------------------------------------------------");
    /*info!("coloring chunk %s %?", set::to_str(tmps), cost);*/
    let mut best_cost = 0;
    let mut best_color = -1;
    let mut best_set = bitv::Bitv(self.f.ssa.temps, false);
    macro_rules! docolor(
      ($set:expr, $color:expr) =>
      ({
        /* Unfix all temps */
        for $set.ones |tmp| { self.fixed.set(tmp, false); }
        for $set.ones |tmp| {
          self.recolor(tmp, $color);
          self.fixed.set(tmp, true);
        }
      })
    );

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
      /*info!("utterly impossible %s", set::to_str(best_set));*/
      return;
    }

    debug!("-------------------------------------------------------------");
    /*info!("selected %? for %s", best_color, set::to_str(best_set));*/
    docolor!(best_set, best_color);
    tmps.difference(&best_set);
    let mut nonzero = false;
    for tmps.ones |_| { nonzero = true; }
    if nonzero {
      pq.push(Chunk(tmps, cost - best_cost));
    }
    debug!("-------------------------------------------------------------");
  }

  fn best_subset(s: &TempSet, c: uint) -> Option<(TempSet, uint)> {
    let mut maxweight = 0;
    let mut maxset = bitv::Bitv(self.f.ssa.temps, false);
    let left = bitv::Bitv(self.f.ssa.temps, false);
    for s.ones |tmp| {
      if *self.colors.get(&tmp) == c {
        left.set(tmp, true);
      }
    }
    /*debug!("best of %s in %s for %?", set::to_str(left), set::to_str(s), c);*/

    /* Iterate over the set of temps and partition as we go */
    loop {
      let mut any = false;
      for left.ones |_| { any = true; break; }
      if !any { break; }
      let subset = bitv::Bitv(self.f.ssa.temps, false);
      let mut qweight = 1;
      /* pop off the first temp and build its entire subset */
      for left.ones |tmp| {
        let mut queue = ~[tmp];
        while queue.len() > 0 {
          debug!("%?", queue);
          let tmp = queue.pop();
          subset.set(tmp, true);
          assert self.affinities.contains_key(&tmp);
          for self.affinities.get(&tmp).each |&next, &weight| {
            debug!("%? affine with %? cost %?", tmp, next, weight);
            if left.get(next) && !subset.get(next) {
              debug!("adding %?", next);
              queue.push(next);
              qweight += weight;
            }
          }
        }
        break;
      }

      left.difference(&subset);
      if qweight > maxweight {
        maxweight = qweight;
        maxset = subset;
      }
    }
    if maxweight == -1 {
      debug!("no good subset");
      return None;
    }
    /*debug!("found %s %?", set::to_str(maxset), maxweight);*/
    return Some((maxset, maxweight));
  }

  /* Algorithm 4.4 */
  fn recolor(&mut self, t: Temp, c: uint) {
    if !self.admissible(t, c) { debug!("not admissible %? %?", t, c); return }
    if self.fixed.get(t) { debug!("fixed %?", t); return }
    let changed = bitv::Bitv(self.f.ssa.temps, false);
    self.set_color(t, c, &changed);
    debug!("recoloring %? to %?", t, c);

    for self.interferences(t) |tmp| {
      debug!("recoloring %? interfering with %?", tmp, t);
      if !self.avoid_color(tmp, c, &changed) {
        for changed.ones |tmp| {
          assert self.old_color.contains_key(&tmp);
          self.colors.insert(tmp, *self.old_color.get(&tmp));
        }
      }
    }
    for changed.ones |tmp| {
      self.fixed.set(tmp, false);
    }
  }

  fn set_color(&mut self, t: Temp, c: uint, changed: &TempSet) {
    debug!("setting %? to %?", t, c);
    self.fixed.set(t, true);
    self.old_color.insert(t, *self.colors.get(&t));
    changed.set(t, true);
    self.colors.insert(t, c);
  }

  fn avoid_color(&mut self, t: Temp, c: uint, changed: &TempSet) -> bool {
    if *self.colors.get(&t) != c { debug!("avoided %? %?", t, c); return true }
    if self.fixed.get(t) { debug!("fixed %?", t); return false }
    if self.precolored.get(t) && c != *self.colors.get(&t) {
      debug!("%? fixed elsewhere (%? %?)", t, c, self.colors.get(&t));
      return false
    }
    let color = if self.precolored.get(t) {
      c
    } else {
      self.min_color(t, c)
    };
    self.set_color(t, color, changed);
    for self.interferences(t) |tmp| {
      if !self.avoid_color(tmp, color, changed) {
        debug!("failed to avoid on interference %?", tmp);
        return false;
      }
    }
    return true;
  }

  fn min_color(&mut self, t: Temp, ignore: uint) -> uint {
    let mut cnts = vec::from_elem(arch::num_regs, uint::max_value);
    for arch::each_reg |r| {
      if r != ignore && self.admissible(t, r) {
        cnts[r - 1] = 0;
      }
    }

    for self.interferences(t) |tmp| {
      let idx = *self.colors.get(&tmp) - 1;
      if cnts[idx] != uint::max_value {
        cnts[idx] += 1;
      }
    }
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

  fn admissible(&mut self, t: Temp, color: uint) -> bool {
    /* TODO: remove this cache */
    match self.admissible_cache.find(&(t, color)) {
      Some(&a) => return a,
      None => ()
    }
    let b = self.admissible_impl(t, color);
    self.admissible_cache.insert((t, color), b);
    return b;
  }

  fn admissible_impl(t: Temp, color: uint) -> bool {
    if self.precolored.get(t) { return color == *self.colors.get(&t) }
    match self.constraints.find(&t) {
      None => true,
      Some(c) => c.allows(arch::num_reg(color))
    }
  }

  /* Algorithm 4.5 */
  fn build_chunks(&mut self) -> PriorityQueue<Chunk> {
    let mut pq = self.find_affinities();
    let mut chunks = LinearMap::new();
    let mut temp_chunks = LinearMap::new();
    let mut next_chunk = 1;
    chunks.insert(0, Chunk(bitv::Bitv(self.f.ssa.temps, false), 0));

    while !pq.is_empty() {
      let Affinity(x, y, w) = pq.pop();
      let xc, yc;
      {
        /* constrain the immutable_loan of temp_chunks to just this area */
        xc = temp_chunks.find(&x).map_default(0, |&x| *x);
        yc = temp_chunks.find(&y).map_default(0, |&x| *x);
      }
      {
        /* In a separate scope, see if we should skip merging the two chunks of
           these two variables */
        let &Chunk(ref xs, _) = chunks.get(&xc);
        let &Chunk(ref ys, _) = chunks.get(&yc);
        let mut interferes = false;
        /* v.chunk = x.chunk */
        for xs.ones |v| {
          /* w.chunk = y.chunk */
          for ys.ones |w| {
            interferes = interferes || self.interferes(v, w);
            if interferes { break }
          }
          if interferes { break }
        }
        if interferes { loop }
      }
      /* Now in a separate scope (where chunks is mutable), merge the two scopes
         together */
      let Chunk(ref xs, xw) = chunks.pop(&xc).unwrap();
      let Chunk(ref ys, yw) = chunks.pop(&yc).unwrap();

      /* no element of the two chunks interfere, merge the chunks */
      let merge = bitv::Bitv(self.f.ssa.temps, false);
      merge.set(x, true);
      merge.set(y, true);
      merge.union(xs);
      merge.union(ys);
      let num = next_chunk;
      next_chunk += 1;
      for merge.ones |tmp| {
        temp_chunks.insert(tmp, num);
      }
      chunks.insert(num, Chunk(merge, w + xw + yw));
    }

    /* Finally insert all chunks into a priority queue */
    let mut ret = PriorityQueue::new();
    do chunks.consume |_, c| {
      ret.push(c);
    }
    return ret;
  }

  fn find_affinities(&mut self) -> PriorityQueue<Affinity> {
    macro_rules! find_map(($map:expr, $key:expr) =>
      (find_default!($map, $key, ~mut LinearMap::new())));
    macro_rules! affine(
      ($a:expr, $b:expr) => ({
        (find_map!(affinities, $a)).insert($b, weight);
        (find_map!(affinities, $b)).insert($a, weight);
        pq.push(Affinity($a, $b, weight));
      })
    );

    let mut pq = PriorityQueue::new();
    let mut to_visit = ~[(self.f.root, 1)];
    let mut visited = LinearSet::new();
    let mut affinities = LinearMap::new();

    while to_visit.len() > 0 {
      let (n, weight) = to_visit.pop();
      assert visited.insert(n);
      let weight = weight + if self.f.loops.contains_key(n) { 1 } else { 0 };
      for self.f.cfg[n].each |&ins| {
        match ins {
          @assem::Phi(def, map) => {
            for map.each_value |tmp| {
              affine!(def, tmp);
            }
          }
          @assem::PCopy(ref copies) => {
            for copies.each |a, b| {
              affine!(a, b);
            }
          }
          _ => ()
        }
      }

      for self.f.cfg.each_succ_edge(n) |succ, edge| {
        if visited.contains(&succ) { loop }
        let weight = match edge {
          ir::FLoopOut | ir::LoopOut => weight - 1, _ => weight
        };
        to_visit.push((succ, weight));
      }
    }

    /* TODO: figure out how to mutate a set in a map */
    do affinities.consume |k, v| {
      self.affinities.insert(k, *v);
    }

    return pq;
  }

  /* Algorithm 4.6 */
  fn interferes(&mut self, x: Temp, y: Temp) -> bool {
    /* TODO: remove this cache */
    match self.interferences_cache.find(&(x, y)) {
      Some(&b) => return b,
      None => (),
    }
    let b = self.interferes_impl(x, y);
    self.interferences_cache.insert((x, y), b);
    self.interferences_cache.insert((y, x), b);
    return b;
  }

  fn interferes_impl(&mut self, x: Temp, y: Temp) -> bool {
    let &xdef = self.defs.get(&x);
    let &ydef = self.defs.get(&y);
    let (t, b) = if self.dominates(ydef, xdef) {
      (y, x)
    } else if self.dominates(xdef, ydef) {
      (x, y)
    } else {
      return false;
    };

    let &(bdef, bline) = self.defs.get(&b);
    if self.f.liveness.out.get(&bdef).contains(&t) {
      return true;
    }

    for self.uses.get(&t).each |&loc| {
      if self.dominates((bdef, bline), loc) {
        return true;
      }
    }
    return false;
  }

  /* Algorithm 4.7 */
  fn interferences(&mut self, t: Temp, f: &fn(Temp) -> bool) {
    match self.interference_cache.find(&t) {
      Some(ref s) => { s.ones(f); return }
      None => ()
    }
    let set = bitv::Bitv(self.f.ssa.temps, false);
    let mut visited = LinearSet::new();
    assert self.uses.contains_key(&t);
    for self.uses.get(&t).each |&(block, _)| {
      self.find_interferences(t, block, &set, &mut visited);
    }
    set.set(t, false);
    set.ones(f);
    self.interference_cache.insert(t, set);
  }

  fn find_interferences(&mut self, x: Temp, n: NodeId, set: &TempSet,
                        visited: &mut NodeSet) {
    visited.insert(n);
    let L = bitv::Bitv(self.f.ssa.temps, false);
    for self.f.liveness.out.get(&n).each |&tmp| {
      L.set(tmp, true);
    }
    for vec::rev_each(*self.f.cfg[n]) |&ins| {
      if L.get(x) {
        set.union(&L);
      }
      for ins.each_def |tmp| { L.set(tmp, false); }
      for ins.each_use |tmp| { L.set(tmp, true); }
    }
    let &def = self.defs.get(&x);
    for self.f.cfg.each_pred(n) |pred| {
      if !visited.contains(&pred) && self.dominates(def, (pred, 0)) {
        self.find_interferences(x, pred, set, &mut *visited);
      }
    }
  }

  fn dominates(&mut self, a: Location, b:Location) -> bool {
    match self.dominates_cache.find(&(a, b)) {
      Some(&s) => return s,
      None => ()
    }
    let c = self.dominates_impl(a, b);
    self.dominates_cache.insert((a, b), c);
    return c;
  }

  fn dominates_impl((ref a, aline): Location, (ref b, bline): Location) -> bool {
    if a == b {
      return aline < bline;
    }
    let mut cur = b;
    while cur != self.f.ssa.idominator.get(cur) {
      cur = self.f.ssa.idominator.get(cur);
      if cur == a { return true; }
    }
    return false;
  }
}

impl Affinity : cmp::Ord {
  pure fn lt(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a < b }
  }
  pure fn le(&self, other: &Affinity) -> bool { !other.lt(self) }
  pure fn gt(&self, other: &Affinity) -> bool { !self.le(other) }
  pure fn ge(&self, other: &Affinity) -> bool { !self.lt(other) }
}

impl Chunk : cmp::Ord {
  pure fn lt(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a < b }
  }
  pure fn le(&self, other: &Chunk) -> bool { !other.lt(self) }
  pure fn gt(&self, other: &Chunk) -> bool { !self.le(other) }
  pure fn ge(&self, other: &Chunk) -> bool { !self.lt(other) }
}
