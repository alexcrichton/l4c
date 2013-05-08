use core::hashmap::{HashMap, HashSet};

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

struct Liveness<'self, T> {
  a: &'self mut Analysis,
  cfg: &'self CFG<T>,
  phi_out: HashMap<NodeId, ~TempSet>,
}

pub fn Analysis() -> Analysis {
  Analysis { in: HashMap::new(), out: HashMap::new(),
             deltas: HashMap::new() }
}

pub fn calculate<S: Statement>(cfg: &CFG<S>, root: NodeId,
                                result: &mut Analysis) {
  debug!("calculating liveness");
  let mut l = Liveness { a: result, phi_out: HashMap::new(), cfg: cfg };

  for cfg.each_node |id, _| {
    l.phi_out.insert(id, ~HashSet::new());
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

impl<'self, T: Statement> Liveness<'self, T> {
  fn lookup_phis(&mut self, n: NodeId) {
    for self.cfg.node(n).each |&stm| {
      debug!("phi map");
      match Statement::phi_info(stm) {
        Some((_, map)) => {
          for map.each |&pred, &tmp| {
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
    for self.phi_out.get(&n).each |&t| {
      live.insert(t);
    }
    for self.cfg.each_succ(n) |succ| {
      match self.a.in.find(&succ) {
        Some(ref s) => {
          for s.each |&t| { live.insert(t); }
        }
        None => ()
      }
    }
    let mut live_out = HashSet::new();
    for live.each |&t| { live_out.insert(t); }
    self.a.out.insert(n, live_out);
    let mut my_deltas = ~[];
    for self.cfg.node(n).each_reverse |ins| {
      let mut delta = ~[];
      for ins.each_def |def| {
        if live.remove(&def) {
          delta.push(Left(def));
        }
      }
      for ins.each_use |tmp| {
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
  for delta.each |&e| {
    match e {
      Right(tmp) => { set.remove(&tmp); }
      Left(tmp)  => { set.insert(tmp); }
    }
  }
}
