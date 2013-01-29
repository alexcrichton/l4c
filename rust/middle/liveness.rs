use core::hashmap::linear::{LinearMap, LinearSet};

use either::*;
use middle::temp::{Temp, TempSet};
use middle::ssa::{CFG, Statement};
use utils::graph::*;

pub type LiveMap = LinearMap<NodeId, TempSet>;
pub type DeltaMap = LinearMap<NodeId, ~[Delta]>;
pub type Delta = ~[Either<Temp, Temp>];

pub struct Analysis {
  in: LiveMap,
  out: LiveMap,
  deltas: DeltaMap,
}

struct Liveness<T> {
  a : &mut Analysis,
  cfg : &CFG<T>,
  phi_out : LinearMap<NodeId, ~TempSet>,
}

pub fn Analysis() -> Analysis {
  Analysis { in: LinearMap::new(), out: LinearMap::new(),
             deltas: LinearMap::new() }
}

pub fn calculate<S : Statement>(cfg : &CFG<S>, root : NodeId,
                                result: &mut Analysis) {
  debug!("calculating liveness");
  let mut l = Liveness { a: result, phi_out: LinearMap::new(), cfg: cfg };
  l.run(root);
}

impl<T : Statement> Liveness<T> {
  fn run(&mut self, root: NodeId) {
    /* TODO: why can't this be in the calculate() function above */
    for self.cfg.each_node |id, _| {
      self.phi_out.insert(id, ~LinearSet::new());
    }
    for self.cfg.each_node |id, _| {
      self.lookup_phis(id);
    }

    /* perform liveness analysis until nothing changes */
    let mut changed = true;
    while changed {
      changed = false;
      for self.cfg.each_postorder(root) |&id| {
        changed = self.liveness(id) || changed;
      }
    }
  }

  fn lookup_phis(&mut self, n : NodeId) {
    for self.cfg[n].each |&stm| {
      debug!("phi map");
      match stm.phi_map() {
        Some(map) => {
          for map.each |pred, tmp| {
            let mut set = self.phi_out.pop(&pred).unwrap();
            set.insert(tmp);
            self.phi_out.insert(pred, set);
          }
        }
        None => ()
      }
      debug!("phi mapdone");
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
    let mut live_out = LinearSet::new();
    for live.each |&t| { live_out.insert(t); }
    self.a.out.insert(n, live_out);
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
