use std::hashmap::{HashMap, HashSet};
use std::vec;
use extra::smallintmap::SmallIntMap;
use extra::treemap::TreeSet;

use middle::temp::{Temp, TempSet};
use middle::ssa::{CFG, Statement};
use utils::graph::*;

pub type LiveMap = HashMap<NodeId, TempSet>;
pub type DeltaMap = HashMap<NodeId, ~[Delta]>;
pub type Delta = ~[Either<Temp, Temp>];

pub struct Analysis {
  in: LiveMap,
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
  Analysis { in: HashMap::new(), out: HashMap::new(),
             deltas: HashMap::new() }
}

pub fn calculate<T, S: Statement<T>>(cfg: &CFG<T>, root: NodeId,
                                     result: &mut Analysis,
                                     info: &S) {
  debug!("calculating liveness");
  let mut l = Liveness { a: result, phi_out: SmallIntMap::new(), cfg: cfg,
                         info: info };

  for cfg.each_node |id, _| {
    l.phi_out.insert(id, TreeSet::new());
  }
  for cfg.each_node |id, _| {
    l.lookup_phis(id);
  }

  /* perform liveness analysis until nothing changes */
  let mut changed = true;
  while changed {
    changed = false;
    for cfg.each_postorder(root) |&id| {
      changed = l.liveness(id) || changed;
    }
  }
}

impl<'self, T, S: Statement<T>> Liveness<'self, T, S> {
  fn lookup_phis(&mut self, n: NodeId) {
    for self.cfg.node(n).iter().advance |&stm| {
      debug!("phi map");
      match self.info.phi_info(stm) {
        Some((_, map)) => {
          for map.iter().advance |(&pred, &tmp)| {
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
    for self.phi_out.get(&n).iter().advance |&t| {
      live.insert(t);
    }
    for self.cfg.each_succ(n) |succ| {
      match self.a.in.find(&succ) {
        Some(ref s) => {
          for s.iter().advance |&t| { live.insert(t); }
        }
        None => ()
      }
    }
    let mut live_out = HashSet::new();
    for live.iter().advance |&t| { live_out.insert(t); }
    self.a.out.insert(n, live_out);
    let mut my_deltas = ~[];
    for self.cfg.node(n).rev_iter().advance |ins| {
      let mut delta = ~[];
      for self.info.each_def(*ins) |def| {
        if live.remove(&def) {
          delta.push(Left(def));
        }
      }
      for self.info.each_use(*ins) |tmp| {
        if live.insert(tmp) {
          delta.push(Right(tmp));
        }
      }
      my_deltas.push(delta);
    }
    /* only return true if something has changed from before */
    vec::reverse(my_deltas);
    match self.a.in.find(&n) {
      None    => (),
      Some(s) => {
        if &live == s && &my_deltas == self.a.deltas.get(&n) {
          return false;
        }
      }
    }
    self.a.in.insert(n, live);
    self.a.deltas.insert(n, my_deltas);
    return true;
  }
}

pub fn apply(set: &mut TempSet, delta: &Delta) {
  for delta.iter().advance |&e| {
    match e {
      Right(tmp) => { set.remove(&tmp); }
      Left(tmp)  => { set.insert(tmp); }
    }
  }
}
