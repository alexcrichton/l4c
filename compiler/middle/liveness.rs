use std::hashmap::{HashMap, HashSet};
use extra::smallintmap::SmallIntMap;
use extra::treemap::TreeSet;

use middle::temp::{Temp, TempSet};
use middle::ssa::{CFG, Statement};
use utils::graph;
use utils::graph::NodeId;

pub type LiveMap = HashMap<NodeId, TempSet>;
pub type DeltaMap = HashMap<NodeId, ~[Delta]>;
pub type Delta = ~[Either<Temp, Temp>];

pub struct Analysis {
  in_: LiveMap,
  out: LiveMap,
  deltas: DeltaMap,
}

struct Liveness<'self, T, S> {
  a: &'self mut Analysis,
  info: &'self S,
  cfg: &'self CFG<T>,
  phi_out: SmallIntMap<TreeSet<Temp>>,
}

pub fn Analysis() -> Analysis {
  Analysis { in_: HashMap::new(), out: HashMap::new(),
             deltas: HashMap::new() }
}

pub fn calculate<T, S: Statement<T>>(cfg: &CFG<T>, root: NodeId,
                                     result: &mut Analysis,
                                     info: &S) {
  debug!("calculating liveness");
  let mut l = Liveness { a: result, phi_out: SmallIntMap::new(), cfg: cfg,
                         info: info };

  for (id, _) in cfg.nodes() {
    l.phi_out.insert(id, TreeSet::new());
  }
  for (id, _) in cfg.nodes() {
    l.lookup_phis(id);
  }

  /* perform liveness analysis until nothing changes */
  let mut changed = true;
  while changed {
    changed = false;
    do cfg.each_postorder(root) |&id| {
      changed = l.liveness(id) || changed;
    }
  }
}

impl<'self, T, S: Statement<T>> Liveness<'self, T, S> {
  fn lookup_phis(&mut self, n: NodeId) {
    for stm in self.cfg.node(n).iter() {
      debug!("phi map");
      match self.info.phi_info(*stm) {
        Some((_, map)) => {
          for (&pred, &tmp) in map.iter() {
            self.phi_out.find_mut(&pred).unwrap().insert(tmp);
          }
        }
        None => ()
      }
      debug!("phi mapdone");
    }
  }

  fn liveness(&mut self, n: NodeId) -> bool {
    let mut live = HashSet::new();
    for &t in self.phi_out.get(&n).iter() {
      live.insert(t);
    }
    for succ in self.cfg.succ(n) {
      match self.a.in_.find(&succ) {
        Some(ref s) => {
          for &t in s.iter() { live.insert(t); }
        }
        None => ()
      }
    }
    let mut live_out = HashSet::new();
    for &t in live.iter() { live_out.insert(t); }
    self.a.out.insert(n, live_out);
    let mut my_deltas = ~[];
    for ins in self.cfg.node(n).rev_iter() {
      let mut delta = ~[];
      do self.info.each_def(*ins) |def| {
        if live.remove(&def) {
          delta.push(Left(def));
        }
      }
      do self.info.each_use(*ins) |tmp| {
        if live.insert(tmp) {
          delta.push(Right(tmp));
        }
      }
      my_deltas.push(delta);
    }
    /* only return true if something has changed from before */
    my_deltas.reverse();
    match self.a.in_.find(&n) {
      None    => (),
      Some(s) => {
        if &live == s && &my_deltas == self.a.deltas.get(&n) {
          return false;
        }
      }
    }
    self.a.in_.insert(n, live);
    self.a.deltas.insert(n, my_deltas);
    return true;
  }
}

pub fn apply(set: &mut TempSet, delta: &Delta) {
  for &e in delta.iter() {
    match e {
      Right(tmp) => { set.remove(&tmp); }
      Left(tmp)  => { set.insert(tmp); }
    }
  }
}
