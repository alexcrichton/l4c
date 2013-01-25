use core::hashmap::linear::{LinearMap, LinearSet};

// http://hal.inria.fr/docs/00/58/53/03/PDF/RR-7503.pdf - ssa liveness?
use either::*;
use std::map;
use middle::temp::TempSet;
use middle::ssa::{CFG, Statement};
use utils::graph::*;

pub type LiveMap = LinearMap<NodeId, TempSet>;
pub type DeltaMap = LinearMap<NodeId, ~[Delta]>;
pub type DeltaList = ~[Delta];
pub type Delta = ~[Either<uint, uint>];

pub struct Analysis {
  in: LiveMap,
  out: LiveMap,
  deltas: DeltaMap,
}

trait LivenessDelta {
  fn apply(&mut self, &Delta);
}

struct Liveness<T> {
  a : &mut Analysis,
  cfg : &CFG<T>,
  /* TODO: figure out how to modify a set in a map */
  phi_out : LinearMap<NodeId, ~mut TempSet>,
}

pub fn Analysis() -> Analysis {
  Analysis { in: LinearMap::new(), out: LinearMap::new(),
             deltas: LinearMap::new() }
}

pub fn calculate<S : Statement>(cfg : &CFG<S>, root : NodeId,
                                result: &mut Analysis) {
  debug!("calculating liveness");
  let mut l = Liveness { a: result, phi_out: LinearMap::new(), cfg: cfg };
  for cfg.each_node |id, _| {
    l.phi_out.insert(id, ~mut LinearSet::new());
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

impl<T : Statement> Liveness<T> {
  fn lookup_phis(&mut self, n : NodeId) {
    for self.cfg[n].each |&stm| {
      match stm.phi_map() {
        Some(map) => {
          for map.each |pred, tmp| {
            self.phi_out.get(&pred).insert(tmp);
          }
        }
        None => ()
      }
    }
  }

  fn liveness(&mut self, n : NodeId) -> bool {
    let mut live = LinearSet::new();
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
    let mut dup = LinearSet::new();
    for live.each |&t| { dup.insert(t); }
    self.a.out.insert(n, dup);
    let mut my_deltas = ~[];
    for vec::rev_each(*self.cfg[n]) |&ins| {
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
        /* TODO: why can't this be '==' */
        if live.eq(s) && my_deltas.eq(self.a.deltas.get(&n)) {
          return false;
        }
      }
    }
    self.a.in.insert(n, live);
    self.a.deltas.insert(n, my_deltas);
    return true;
  }
}

impl TempSet : LivenessDelta {
  fn apply(&mut self, delta: &Delta) {
    for delta.each |&e| {
      match e {
        Right(tmp) => { self.remove(&tmp); }
        Left(tmp)  => { self.insert(tmp); }
      }
    }
  }
}
