use core::hashmap::linear::{LinearMap, LinearSet};

use std::bitv;
use std::priority_queue::PriorityQueue;

use middle::{ir, ssa, liveness};
use middle::temp::{Temp, TempSet};
use back::{assem, arch};
use utils::profile;
use utils::graph::{NodeSet, NodeId};

type Location = (NodeId, int);
type Affinities = LinearMap<Temp, ~LinearMap<Temp, uint>>;
struct Affinity(Temp, Temp, uint);
struct Chunk(TempSet, uint);

struct Coalescer {
  defs: LinearMap<Temp, Location>,
  uses: LinearMap<Temp, ~LinearSet<Location>>,
  f: &mut assem::Function,
  fixed: TempSet,
  affinities: Affinities,
  colors: &mut LinearMap<Temp, uint>,
  old_color: LinearMap<Temp, uint>,
  precolored: &TempSet,
  constraints: &LinearMap<Temp, assem::Constraint>,
  interference_cache: LinearMap<Temp, TempSet>,
  interferences_cache: LinearMap<(Temp, Temp), bool>,
  admissible_cache: LinearMap<(Temp, uint), bool>,
  dominates_cache: LinearMap<(Location, Location), bool>,
}

pub fn optimize(f: &mut assem::Function,
                colors: &mut LinearMap<Temp, uint>,
                precolored: &TempSet,
                constraints: &LinearMap<Temp, assem::Constraint>) {
  assert f.ssa.temps > 0;
  let mut c = Coalescer { defs: LinearMap::new(),
                          uses: LinearMap::new(),
                          fixed: LinearSet::new(),
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
  c.run();
}

impl Coalescer {
  fn run(&mut self) {
    /* TODO: why can't this be above */
    do profile::dbg("building use/def") {
      for self.f.cfg.each_node |id, &ins| {
        self.build_use_def(id, ins);
      }
    }
    self.coalesce();
  }

  fn build_use_def(&mut self, n: NodeId, ins: @~[@assem::Instruction]) {
    macro_rules! add_use(
      ($tmp:expr, $loc:expr) => ({
        let mut set = match self.uses.pop(&$tmp) {
          Some(s) => s, None => ~LinearSet::new()
        };
        set.insert($loc);
        self.uses.insert($tmp, set);
      })
    );
    for ins.eachi |i, &ins| {
      for ins.each_def |tmp| {
        assert self.defs.insert(tmp, (n, i as int));
      }
      for ins.each_use |tmp| {
        add_use!(tmp, (n, i as int));
      }
      match ins.phi_map() {
        None => (),
        Some(m) => {
          for m.each |pred, tmp| {
            add_use!(tmp, (pred, int::max_value));
          }
        }
      }
    }
  }

  /* Algorithm 4.3 */
  fn coalesce(&mut self) {
    let mut pq = self.build_chunks();
    while !pq.is_empty() {
      do profile::dbg("recoloring chunk") {
        /* TODO: why can't this be on one line? */
        let chunk = pq.pop();
        self.recolor_chunk(chunk, &mut pq);
      }
    }
  }

  fn recolor_chunk(&mut self, Chunk(tmps, cost): Chunk,
                   pq: &mut PriorityQueue<Chunk>) {
    let mut tmps = tmps;
    debug!("-------------------------------------------------------------");
    info!("coloring chunk %s %?", tmps.pp(), cost);
    let mut best_cost = 0;
    let mut best_color = -1;
    let mut best_set = LinearSet::new();
    macro_rules! docolor(
      ($set:expr, $color:expr) =>
      ({
        /* Unfix all temps */
        for $set.each |&tmp| { self.fixed.remove(&tmp); }
        for $set.each |&tmp| {
          self.recolor(tmp, $color);
          self.fixed.insert(tmp);
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
      info!("utterly impossible %s", best_set.pp());
      return;
    }

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

  fn best_subset(&self, s: &TempSet, c: uint) -> Option<(TempSet, uint)> {
    let mut maxweight = -1;
    let mut maxset = None;
    let mut left = LinearSet::new();
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
      let mut subset = LinearSet::new();
      let mut qweight = 1;
      /* pop off the first temp and build its entire subset */
      for left.each |&tmp| {
        let mut queue = ~[tmp];
        while queue.len() > 0 {
          debug!("%?", queue);
          let tmp = queue.pop();
          subset.insert(tmp);
          assert self.affinities.contains_key(&tmp);
          for self.affinities.get(&tmp).each |&next, &weight| {
            debug!("%? affine with %? cost %?", tmp, next, weight);
            if left.contains(&next) && !subset.contains(&next) {
              debug!("adding %?", next);
              queue.push(next);
              qweight += weight;
            }
          }
        }
        break;
      }

      for subset.each |t| {
        left.remove(t);
      }
      if qweight > maxweight {
        maxweight = qweight;
        maxset = Some(subset);
      }
    }
    if maxweight == -1 {
      debug!("no good subset");
      return None;
    }
    let maxset = maxset.unwrap();
    debug!("found %s %?", maxset.pp(), maxweight);
    return Some((maxset, maxweight));
  }

  /* Algorithm 4.4 */
  fn recolor(&mut self, t: Temp, c: uint) {
    if !self.admissible(t, c) { debug!("not admissible %? %?", t, c); return }
    if self.fixed.contains(&t) { debug!("fixed %?", t); return }
    let mut changed = LinearSet::new();
    self.set_color(t, c, &mut changed);
    debug!("recoloring %? to %?", t, c);

    for self.interferences(t) |tmp| {
      debug!("recoloring %? interfering with %?", tmp, t);
      if !self.avoid_color(tmp, c, &mut changed) {
        for changed.each |&tmp| {
          assert self.old_color.contains_key(&tmp);
          self.colors.insert(tmp, *self.old_color.get(&tmp));
        }
      }
    }
    for changed.each |&tmp| {
      self.fixed.insert(tmp);
    }
  }

  fn set_color(&mut self, t: Temp, c: uint, changed: &mut TempSet) {
    debug!("setting %? to %?", t, c);
    self.fixed.insert(t);
    self.old_color.insert(t, *self.colors.get(&t));
    changed.insert(t);
    self.colors.insert(t, c);
  }

  fn avoid_color(&mut self, t: Temp, c: uint, changed: &mut TempSet) -> bool {
    if *self.colors.get(&t) != c { debug!("avoided %? %?", t, c); return true }
    if self.fixed.contains(&t) { debug!("fixed %?", t); return false }
    if self.precolored.contains(&t) && c != *self.colors.get(&t) {
      debug!("%? fixed elsewhere (%? %?)", t, c, self.colors.get(&t));
      return false
    }
    let color = if self.precolored.contains(&t) {
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

  fn admissible_impl(&self, t: Temp, color: uint) -> bool {
    if self.precolored.contains(&t) { return color == *self.colors.get(&t) }
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
    chunks.insert(0, Chunk(LinearSet::new(), 0));

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
        /* v.chunk = x.chunk */
        for xs.each |&v| {
          /* w.chunk = y.chunk */
          for ys.each |&w| {
            interferes = interferes || self.interferes(v, w);
            if interferes { break }
          }
          if interferes { break }
        }
        if interferes { loop }

        /* no element of the two chunks interfere, merge the chunks */
        merge = LinearSet::new();
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

      if xc != 0 { chunks.remove(&xc); }
      if yc != 0 { chunks.remove(&yc); }
    }

    /* Finally insert all chunks into a priority queue */
    let mut ret = PriorityQueue::new();
    do chunks.consume |_, c| {
      ret.push(c);
    }
    return ret;
  }

  fn find_affinities(&mut self) -> PriorityQueue<Affinity> {
    macro_rules! add_affine(
      ($a1:expr, $b1:expr, $weight1:expr) => ({
        let mut map = match self.affinities.pop(&$a1) {
          Some(m) => m, None => ~LinearMap::new()
        };
        map.insert($b1, $weight1);
        self.affinities.insert($a1, map);
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
    let mut to_visit = ~[(self.f.root, 1)];
    let mut visited = LinearSet::new();

    while to_visit.len() > 0 {
      let (n, weight) = to_visit.pop();
      assert visited.insert(n);
      let weight = weight + if self.f.loops.contains_key(&n) { 1 } else { 0 };
      for self.f.cfg[n].each |&ins| {
        match ins {
          @assem::Phi(def, map) => {
            for map.each_value |tmp| {
              /* TODO(#4650): when this ICE is fixed, uncomment */
              /*affine!(def, tmp, weight);*/
              add_affine!(tmp, def, weight);
              add_affine!(def, tmp, weight);
              pq.push(Affinity(tmp, def, weight));
            }
          }
          @assem::PCopy(ref copies) => {
            for copies.each |a, b| {
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

      for self.f.cfg.each_succ_edge(n) |succ, edge| {
        if visited.contains(&succ) { loop }
        let weight = match edge {
          ir::FLoopOut | ir::LoopOut => weight - 1, _ => weight
        };
        to_visit.push((succ, weight));
      }
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
    return false;
  }

  /* Algorithm 4.7 */
  fn interferences(&mut self, t: Temp, f: &fn(Temp) -> bool) {
    match self.interference_cache.find(&t) {
      Some(ref s) => { s.each(|&t| f(t)); return }
      None => ()
    }
    let mut visited = LinearSet::new();
    let mut bitv = bitv::Bitv(self.f.ssa.temps, false);
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
    let mut set = LinearSet::new();
    for bitv.ones |x| {
      if x != t {
        set.insert(x);
      }
    }
    debug!("%? interferencs: %s", t, set.pp());
    self.interference_cache.insert(t, set);
    self.interference_cache.get(&t).each(|&t| f(t));
  }

  fn find_interferences(&mut self, x: Temp, n: NodeId, set: &mut bitv::Bitv,
                        visited: &mut NodeSet) {
    visited.insert(n);
    let mut L = bitv::Bitv(self.f.ssa.temps, false);
    for self.f.liveness.out.get(&n).each |&tmp| {
      L.set(tmp, true);
    }
    for vec::rev_each(*self.f.cfg[n]) |&ins| {
      /* if the definition is never used, we still interfere with it */
      for ins.each_def |tmp| { L.set(tmp, true); }
      if L.get(x) {
        set.union(&L);
      }
      for ins.each_def |tmp| { L.set(tmp, false); }
      for ins.each_use |tmp| { L.set(tmp, true); }
    }
    let &def = self.defs.get(&x);
    for self.f.cfg.each_pred(n) |pred| {
      /* Be sure to check the dominance relation relative to the end of the
         predecessor's block as opposed to the start as x could have been
         defined in the block */
      if !visited.contains(&pred) && self.dominates(def, (pred, int::max_value)) {
        self.find_interferences(x, pred, set, visited);
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

  /* TODO(4653): make the arguments 'ref a', 'ref b' */
  fn dominates_impl(&self, (a, aline): Location, (b, bline): Location) -> bool {
    if a == b {
      return aline < bline;
    }
    let mut cur = &b;
    while cur != self.f.ssa.idominator.get(cur) {
      /* TODO(purity): this shouldn't have to be unsafe */
      unsafe {
        cur = self.f.ssa.idominator.get(cur);
        if *cur == a { return true; }
      }
    }
    return false;
  }
}

impl Affinity: cmp::Ord {
  pure fn lt(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a < b }
  }
  pure fn le(&self, other: &Affinity) -> bool { !other.lt(self) }
  pure fn gt(&self, other: &Affinity) -> bool { !self.le(other) }
  pure fn ge(&self, other: &Affinity) -> bool { !self.lt(other) }
}

impl Chunk: cmp::Ord {
  pure fn lt(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a < b }
  }
  pure fn le(&self, other: &Chunk) -> bool { !other.lt(self) }
  pure fn gt(&self, other: &Chunk) -> bool { !self.le(other) }
  pure fn ge(&self, other: &Chunk) -> bool { !self.lt(other) }
}
