
// http://hal.inria.fr/docs/00/58/53/03/PDF/RR-7503.pdf - ssa liveness?
use either::*;
use std::map;
use middle::ssa::{CFG, Statement};
use utils::set;
use utils::graph::*;

pub type LiveMap = map::HashMap<NodeId, LiveIn>;
pub type LiveIn = map::Set<uint>;
pub type DeltaMap = map::HashMap<NodeId, @~[Delta]>;
pub type DeltaList = @~[Delta];
pub type Delta = ~[Either<uint, uint>];
pub type Generator<S> = &fn(@S, &fn(uint));

pub struct Analysis {
  in: LiveMap,
  out: LiveMap,
  deltas: DeltaMap,
}

trait LivenessDelta {
  fn apply(&Delta);
}

struct Liveness<T> {
  a : &Analysis,
  cfg : &CFG<T>,
  phi_out : LiveMap,
}

pub fn Analysis() -> Analysis {
  Analysis { in: map::HashMap(), out: map::HashMap(), deltas: map::HashMap() }
}

pub fn calculate<S : Statement>(cfg : &CFG<S>, root : NodeId,
                                result: &Analysis) {
  debug!("calculating liveness");
  let l = Liveness { a: result, phi_out: map::HashMap(), cfg: cfg };
  for cfg.each_node |id, _| {
    l.phi_out.insert(id, map::HashMap());
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
  fn lookup_phis(n : NodeId) {
    for self.cfg[n].each |&stm| {
      match stm.phi_map() {
        Some(map) => {
          for map.each |pred, tmp| {
            set::add(self.phi_out[pred], tmp);
          }
        }
        None => ()
      }
    }
  }

  fn liveness(n : NodeId) -> bool {
    let live = map::HashMap();
    set::union(live, self.phi_out[n]);
    for self.cfg.each_succ(n) |succ| {
      match self.a.in.find(succ) {
        Some(s) => { set::union(live, s); }
        None    => ()
      }
    }
    self.a.out.insert(n, set::clone(live));
    let mut my_deltas = ~[];
    for vec::rev_each(*self.cfg[n]) |&ins| {
      let mut delta = ~[];
      for ins.each_def |def| {
        if set::remove(live, def) {
          delta.push(Left(def));
        }
      }
      for ins.each_use |tmp| {
        if set::add(live, tmp) {
          delta.push(Right(tmp));
        }
      }
      my_deltas.push(delta);
    }
    /* only return true if something has changed from before */
    vec::reverse(my_deltas);
    match self.a.in.find(n) {
      None    => (),
      Some(s) => {
        if set::eq(s, live) && *self.a.deltas[n] == my_deltas {
          return false;
        }
      }
    }
    debug!("%? %s %?", n, set::to_str(live), my_deltas);
    self.a.in.insert(n, live);
    self.a.deltas.insert(n, @my_deltas);
    return true;
  }
}

impl LiveIn : LivenessDelta {
  fn apply(delta : &Delta) {
    for delta.each |&e| {
      match e {
        Right(tmp) => { set::remove(self, tmp); }
        Left(tmp)  => { set::add(self, tmp); }
      }
    }
  }
}
