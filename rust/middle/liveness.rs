
// http://hal.inria.fr/docs/00/58/53/03/PDF/RR-7503.pdf - ssa liveness?
use either::*;
use std::map;
use graph::*;
use middle::ssa::{CFG, Statement};

pub type Data = (LiveMap, DeltaMap);
pub type LiveMap = map::HashMap<NodeId, LiveIn>;
pub type LiveIn = map::Set<uint>;
pub type DeltaMap = map::HashMap<NodeId, @~[Delta]>;
pub type Delta = ~[Either<uint, uint>];
pub type Generator<S> = &fn(@S, &fn(uint));

trait LivenessDelta {
  fn apply(&Delta);
}

/* TODO: if 'f' is passed as callbacks, the generated binary segfaults? */
pub fn calculate<S : Statement>(cfg : &CFG<S>, root : NodeId, f : uint) -> Data {
  let live_in = map::HashMap();
  let deltas = map::HashMap();

  /* perform liveness analysis until nothing changes */
  let mut changed = true;
  while changed {
    changed = false;
    for cfg.each_postorder(root) |&id| {
      changed = liveness(cfg, live_in, deltas, f, id) || changed;
    }
  }

  return (live_in, deltas);
}

fn liveness<S : Statement>(cfg : &CFG<S>, live_in : LiveMap, deltas : DeltaMap,
                           f : uint,
                           n : graph::NodeId) -> bool {
  let live = map::HashMap();
  for cfg.each_succ(n) |succ| {
    match live_in.find(succ) {
      Some(s) => { set::union(live, s); }
      None    => ()
    }
  }
  let mut my_deltas = ~[];
  for vec::rev_each(*cfg[n]) |&ins| {
    let mut delta = ~[];
    if f == 0 {
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
    } else {
      for ins.each_spill |def| {
        if set::remove(live, def) {
          delta.push(Left(def));
        }
      }
      for ins.each_reload |tmp| {
        if set::add(live, tmp) {
          delta.push(Right(tmp));
        }
      }
    }
    my_deltas.push(delta);
  }
  /* only return true if something has changed from before */
  vec::reverse(my_deltas);
  match live_in.find(n) {
    None    => (),
    Some(s) => {
      if set::eq(s, live) && *deltas[n] == my_deltas {
        return false;
      }
    }
  }
  live_in.insert(n, live);
  deltas.insert(n, @my_deltas);
  return true;
}

impl LiveIn : LivenessDelta {
  fn apply(delta : &Delta) {
    for delta.each |&e| {
      match e {
        Left(tmp)  => { assert set::add(self, tmp); }
        Right(tmp) => { assert set::remove(self, tmp); }
      }
    }
  }
}
