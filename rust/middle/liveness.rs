
// http://hal.inria.fr/docs/00/58/53/03/PDF/RR-7503.pdf - ssa liveness?
use either::*;
use std::map;
use graph::*;
use middle::ssa::{CFG, Statement};

pub type Data = (LiveMap, DeltaMap);
pub type LiveMap = map::HashMap<NodeId, LiveIn>;
pub type LiveIn = map::Set<uint>;
pub type DeltaMap = map::HashMap<NodeId, @~[Delta]>;
pub type DeltaList = @~[Delta];
pub type Delta = ~[Either<uint, uint>];
pub type Generator<S> = &fn(@S, &fn(uint));

trait LivenessDelta {
  fn apply(&Delta);
}

struct Liveness<T> {
  live_in : LiveMap,
  deltas : DeltaMap,
  cfg : &CFG<T>,
  phi_out : LiveMap,
}

pub fn calculate<S : Statement>(cfg : &CFG<S>, root : NodeId) -> Data {
  debug!("calculating liveness");
  let l = Liveness { live_in: map::HashMap(),
                     phi_out: map::HashMap(),
                     deltas: map::HashMap(),
                     cfg: cfg };

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

  return (l.live_in, l.deltas);
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
      match self.live_in.find(succ) {
        Some(s) => { set::union(live, s); }
        None    => ()
      }
    }
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
    match self.live_in.find(n) {
      None    => (),
      Some(s) => {
        if set::eq(s, live) && *self.deltas[n] == my_deltas {
          return false;
        }
      }
    }
    debug!("%? %s %?", n, set::to_str(live), my_deltas);
    self.live_in.insert(n, live);
    self.deltas.insert(n, @my_deltas);
    return true;
  }
}

impl LiveIn : LivenessDelta {
  fn apply(delta : &Delta) {
    for delta.each |&e| {
      match e {
        Right(tmp) => { assert set::remove(self, tmp); }
        Left(tmp)  => { assert set::add(self, tmp); }
      }
    }
  }
}
