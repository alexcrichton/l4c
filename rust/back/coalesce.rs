use std::map;
use middle::{ir, ssa, liveness};
use middle::temp::Temp;
use graph::NodeId;
use std::priority_queue::PriorityQueue;

type Location = (NodeId, int);
type TempSet = map::Set<Temp>;
type NodeSet = map::Set<NodeId>;
type Affinities = map::HashMap<Temp, map::HashMap<Temp, uint>>;
struct Affinity(Temp, Temp, uint);
struct Chunk(TempSet, uint);

struct Coalescer {
  defs : map::HashMap<Temp, Location>,
  uses : map::HashMap<Temp, map::Set<Location>>,
  f : &assem::Function,
  fixed : TempSet,
  affinities : Affinities,
  colors : map::HashMap<Temp, uint>,
  old_color : map::HashMap<Temp, uint>,
  precolored : TempSet,
  constraints : map::HashMap<Temp, assem::Constraint>,
}

pub fn optimize(f: &assem::Function,
                colors: alloc::ColorMap,
                precolored: TempSet,
                constraints: map::HashMap<Temp, assem::Constraint>) {
  let c = Coalescer { defs: map::HashMap(),
                      uses: map::HashMap(),
                      f: f,
                      fixed: map::HashMap(),
                      affinities: map::HashMap(),
                      colors: colors,
                      old_color: map::HashMap(),
                      precolored: precolored,
                      constraints: constraints, };
  for f.cfg.each_node |id, &ins| {
    c.build_use_def(id, ins);
  }
  c.coalesce();
}

macro_rules! find_set(
  ($map:expr, $key:expr) =>
  (
    match $map.find($key) {
      Some(s) => s,
      None => {
        let m = map::HashMap();
        ignore(m); /* TODO: is this a bad rust thing? */
        $map.insert($key, m);
        m
      }
    }
  )
)

impl Coalescer {
  fn build_use_def(n : NodeId, ins: @~[@assem::Instruction]) {
    for ins.eachi |i, &ins| {
      for ins.each_def |tmp| {
        assert self.defs.insert(tmp, (n, i as int));
      }
      for ins.each_use |tmp| {
        set::add(find_set!(self.uses, tmp), (n, i as int));
      }
      match ins.phi_map() {
        None => (),
        Some(m) => {
          for m.each |pred, tmp| {
            set::add(find_set!(self.uses, tmp), (pred, int::max_value));
          }
        }
      }
    }
  }

  /* Algorithm 4.3 */
  fn coalesce() {
    let mut pq = self.build_chunks();
    while !pq.is_empty() {
      let chunk = pq.pop();
      self.recolor_chunk(chunk, &mut pq);
    }
  }

  fn recolor_chunk(Chunk(tmps, cost): Chunk, pq: &mut PriorityQueue<Chunk>) {
    assert tmps.size() > 0;
    debug!("-------------------------------------------------------------");
    info!("coloring chunk %s %?", set::to_str(tmps), cost);
    let mut best_cost = 0;
    let mut best_color = -1;
    let mut best_set = map::HashMap();
    macro_rules! docolor(
      ($set:expr, $color:expr) =>
      ({
        /* Unfix all temps */
        for set::each($set) |tmp| { set::remove(self.fixed, tmp); }
        for set::each($set) |tmp| {
          self.recolor(tmp, $color);
          set::add(self.fixed, tmp);
        }
      })
    );

    for arch::each_reg |r| {
      debug!("trying %?", r);
      docolor!(tmps, r);
      match self.best_subset(tmps, r) {
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
      info!("utterly impossible %s", set::to_str(best_set));
      return;
    }
    debug!("-------------------------------------------------------------");
    info!("selected %? for %s", best_color, set::to_str(best_set));
    docolor!(best_set, best_color);
    set::difference(tmps, best_set);
    if tmps.size() > 0 {
      debug!("re-adding %?", set::to_str(tmps));
      pq.push(Chunk(tmps, cost - best_cost));
    }
    debug!("-------------------------------------------------------------");
  }

  fn best_subset(s: TempSet, c: uint) -> Option<(TempSet, uint)> {
    let mut maxweight = 0;
    let mut maxset = map::HashMap();
    let left = map::HashMap();
    for set::each(s) |tmp| {
      if self.colors[tmp] == c {
        set::add(left, tmp);
      }
    }
    debug!("best of %s in %s for %?", set::to_str(left), set::to_str(s), c);

    /* Iterate over the set of temps and partition as we go */
    while left.size() > 0 {
      let subset = map::HashMap();
      let mut qweight = 1;
      /* pop off the first temp and build its entire subset */
      for set::each(left) |tmp| {
        let mut queue = ~[tmp];
        while queue.len() > 0 {
          debug!("%?", queue);
          let tmp = queue.pop();
          assert set::add(subset, tmp);
          assert self.affinities.contains_key(tmp);
          for self.affinities[tmp].each |next, weight| {
            debug!("%? affine with %? cost %?", tmp, next, weight);
            if set::contains(left, next) && !set::contains(subset, next) {
              debug!("adding %?", next);
              queue.push(next);
              qweight += weight;
            }
          }
        }
        break;
      }

      assert subset.size() > 0;
      set::difference(left, subset);
      if qweight > maxweight {
        maxweight = qweight;
        maxset = subset;
      }
    }
    if maxweight == -1 {
      debug!("no good subset");
      return None;
    }
    debug!("found %s %?", set::to_str(maxset), maxweight);
    return Some((maxset, maxweight));
  }

  /* Algorithm 4.4 */
  fn recolor(t: Temp, c: uint) {
    if !self.admissible(t, c) { debug!("not admissible %? %?", t, c); return }
    if set::contains(self.fixed, t) { debug!("fixed %?", t); return }
    let changed = map::HashMap();
    self.set_color(t, c, changed);
    debug!("recoloring %? to %?", t, c);

    let others = self.interferences(t);
    for set::each(others) |tmp| {
      debug!("recoloring %? interfering with %?", tmp, t);
      if !self.avoid_color(tmp, c, changed) {
        for set::each(changed) |tmp| {
          assert self.old_color.contains_key(tmp);
          self.colors.insert(tmp, self.old_color[tmp]);
        }
      }
    }
    for set::each(changed) |tmp| {
      assert set::remove(self.fixed, tmp);
    }
  }

  fn set_color(t: Temp, c: uint, changed: TempSet) {
    debug!("setting %? to %?", t, c);
    assert set::add(self.fixed, t);
    self.old_color.insert(t, self.colors[t]);
    assert set::add(changed, t);
    self.colors.insert(t, c);
  }

  fn avoid_color(t: Temp, c: uint, changed: TempSet) -> bool {
    if self.colors[t] != c { debug!("pre avoided %? %?", t, c); return true }
    if set::contains(self.fixed, t) { debug!("fixed %?", t); return false }
    if set::contains(self.precolored, t) && c != self.colors[t] {
      debug!("%? fixed elsewhere (%? %?)", t, c, self.colors[t]);
      return false
    }
    let color = if set::contains(self.precolored, t) {
      c
    } else {
      self.min_color(t, c)
    };
    self.set_color(t, color, changed);
    for set::each(self.interferences(t)) |tmp| {
      if !self.avoid_color(tmp, color, changed) {
        debug!("failed to avoid on interference %?", tmp);
        return false;
      }
    }
    return true;
  }

  fn min_color(t: Temp, ignore: uint) -> uint {
    let mut cnts = vec::from_elem(arch::num_regs, uint::max_value);
    for arch::each_reg |r| {
      if r != ignore && self.admissible(t, r) {
        cnts[r - 1] = 0;
      }
    }

    for set::each(self.interferences(t)) |tmp| {
      let idx = self.colors[tmp] - 1;
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

  fn admissible(t: Temp, color: uint) -> bool {
    if set::contains(self.precolored, t) { return color == self.colors[t] }
    match self.constraints.find(t) {
      None => true,
      Some(c) => c.allows(arch::num_reg(color))
    }
  }

  /* Algorithm 4.5 */
  fn build_chunks() -> PriorityQueue<Chunk> {
    let mut pq = PriorityQueue::new();
    self.find_affinities(self.f.root, 1, &mut pq, map::HashMap());
    let empty = Chunk(map::HashMap(), 0);
    let chunks = map::HashMap();

    while !pq.is_empty() {
      let Affinity(x, y, w) = pq.pop();
      let Chunk(xs, xw) = chunks.find(x).get_default(empty);
      let Chunk(ys, yw) = chunks.find(y).get_default(empty);
      let mut interferes = false;
      /* v.chunk = x.chunk */
      for set::each(xs) |v| {
        /* w.chunk = y.chunk */
        for set::each(ys) |w| {
          interferes = interferes || self.interferes(v, w);
        }
      }
      if interferes { loop }

      /* no element of the two chunks interfere, merge the chunks */
      let merge = map::HashMap();
      set::add(merge, x);
      set::add(merge, y);
      set::union(merge, xs);
      set::union(merge, ys);
      for set::each(merge) |tmp| {
        chunks.insert(tmp, Chunk(merge, xw + yw + w));
      }
    }

    /* Finally insert all chunks into a priority queue */
    let mut ret = PriorityQueue::new();
    while chunks.size() > 0 {
      for chunks.each |_, c| {
        let Chunk(tmps, _) = c;
        for set::each(tmps) |t| {
          chunks.remove(t);
        }
        ret.push(c);
        break;
      }
    }
    return ret;
  }

  fn find_affinities(n: NodeId, weight: uint, pq: &mut PriorityQueue<Affinity>,
                     visited: NodeSet) {
    macro_rules! affine(
      ($a:expr, $b:expr) =>
      ({
        (find_set!(self.affinities, $a)).insert($b, weight);
        (find_set!(self.affinities, $b)).insert($a, weight);
        pq.push(Affinity($a, $b, weight));
      })
    );

    set::add(visited, n);
    let weight = weight + if self.f.loops.contains_key(n) { 1 } else { 0 };
    for self.f.cfg[n].each |&ins| {
      match ins {
        @assem::Phi(def, map) => {
          for map.each_value |tmp| {
            affine!(def, tmp);
          }
        }
        @assem::PCopy(ref copies) => {
          for copies.each |&(a, b)| {
            affine!(a, b);
          }
        }
        _ => ()
      }
    }

    for self.f.cfg.each_succ_edge(n) |succ, edge| {
      if set::contains(visited, succ) { loop }
      let weight = match edge {
        ir::FLoopOut | ir::LoopOut => weight - 1, _ => weight
      };
      self.find_affinities(succ, weight, pq, visited);
    }
  }

  /* Algorithm 4.6 */
  fn interferes(x: Temp, y: Temp) -> bool {
    let xdef = self.defs[x];
    let ydef = self.defs[y];
    let (t, b) = if self.dominates(ydef, xdef) {
      (y, x)
    } else if self.dominates(xdef, ydef) {
      (x, y)
    } else {
      return false;
    };

    let (bdef, bline) = self.defs[b];
    if set::contains(self.f.liveness.out[bdef], t) {
      return true;
    }

    for set::each(self.uses[t]) |loc| {
      if self.dominates((bdef, bline), loc) {
        return true;
      }
    }
    return false;
  }

  /* Algorithm 4.7 */
  fn interferences(t: Temp) -> TempSet {
    let set = map::HashMap();
    let visited = map::HashMap();
    for set::each(self.uses[t]) |(block, _)| {
      self.find_interferences(t, block, set, visited);
    }
    set::remove(set, t);
    return set;
  }

  fn find_interferences(x: Temp, n: NodeId, set: TempSet, visited: NodeSet) {
    set::add(visited, n);
    let L = set::clone(self.f.liveness.out[n]);
    for vec::rev_each(*self.f.cfg[n]) |&ins| {
      if set::contains(L, x) {
        set::union(set, L);
      }
      for ins.each_def |tmp| { set::remove(L, tmp); }
      for ins.each_use |tmp| { set::add(L, tmp); }
    }
    let def = self.defs[x];
    for self.f.cfg.each_pred(n) |pred| {
      if !set::contains(visited, pred) && self.dominates(def, (pred, 0)) {
        self.find_interferences(x, pred, set, visited);
      }
    }
  }

  fn dominates((a, aline): Location, (b, bline): Location) -> bool {
    if a == b {
      return aline < bline;
    }
    let mut cur = b;
    while cur != self.f.ssa.idominator[cur] {
      cur = self.f.ssa.idominator[cur];
      if cur == a { return true; }
    }
    return false;
  }
}

/* sort in descending order */
impl Affinity : cmp::Ord {
  pure fn lt(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a >= b }
  }
  pure fn le(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a > b }
  }
  pure fn gt(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a <= b }
  }
  pure fn ge(&self, other: &Affinity) -> bool {
    match (self, other) { (&Affinity(_, _, a), &Affinity(_, _, b)) => a < b }
  }
}
impl Chunk : cmp::Ord {
  pure fn lt(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a >= b }
  }
  pure fn le(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a > b }
  }
  pure fn gt(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a <= b }
  }
  pure fn ge(&self, other: &Chunk) -> bool {
    match (self, other) { (&Chunk(_, a), &Chunk(_, b)) => a < b }
  }
}
