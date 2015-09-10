use std::collections::{HashMap, HashSet, BTreeSet};

use vec_map::VecMap;

use middle::ssa::{CFG, Statement};
use utils::{Temp, TempSet, FnvState};
use utils::graph::NodeId;

pub type LiveMap = HashMap<NodeId, TempSet, FnvState>;
pub type DeltaMap = HashMap<NodeId, Vec<Delta>, FnvState>;
pub type Delta = Vec<DeltaOp>;

#[derive(Eq, PartialEq, Debug, Copy, Clone)]
pub enum DeltaOp {
    Remove(Temp),
    Add(Temp),
}

pub struct Analysis {
    pub in_: LiveMap,
    pub out: LiveMap,
    pub deltas: DeltaMap,
}

struct Liveness<'a, T: 'a, S: 'a> {
    a: &'a mut Analysis,
    info: &'a S,
    cfg: &'a CFG<T>,
    phi_out: VecMap<BTreeSet<Temp>>,
}

impl Analysis {
    pub fn new() -> Analysis {
        Analysis {
            in_: HashMap::with_hash_state(FnvState),
            out: HashMap::with_hash_state(FnvState),
            deltas: HashMap::with_hash_state(FnvState),
        }
    }
}

pub fn calculate<T, S: Statement<T>>(cfg: &CFG<T>, root: NodeId,
                                     result: &mut Analysis,
                                     info: &S) {
    debug!("calculating liveness");
    let mut l = Liveness {
        a: result,
        phi_out: VecMap::new(),
        cfg: cfg,
        info: info,
    };

    for (id, _) in cfg.nodes() {
        l.phi_out.insert(id, BTreeSet::new());
    }
    for (id, _) in cfg.nodes() {
        l.lookup_phis(id);
    }

    /* perform liveness analysis until nothing changes */
    let mut changed = true;
    while changed {
        changed = false;
        cfg.each_postorder(root, &mut |&id| {
            changed = l.liveness(id) || changed;
        })
    }
}

impl<'a, T, S: Statement<T>> Liveness<'a, T, S> {
    fn lookup_phis(&mut self, n: NodeId) {
        for stm in self.cfg.node(n).iter() {
            debug!("phi map");
            if let Some((_, map)) = self.info.phi(stm) {
                for (pred, &tmp) in map {
                    self.phi_out.get_mut(pred).unwrap().insert(tmp);
                }
            }
            debug!("phi mapdone");
        }
    }

    fn liveness(&mut self, n: NodeId) -> bool {
        let mut live = HashSet::with_hash_state(FnvState);
        live.extend(&self.phi_out[&n]);
        for succ in self.cfg.succ(n) {
            if let Some(s) = self.a.in_.get(&succ) {
                live.extend(s);
            }
        }
        self.a.out.insert(n, live.clone());
        let mut my_deltas = Vec::new();
        for ins in self.cfg.node(n).iter().rev() {
            let mut delta = Vec::new();
            self.info.each_def(ins, &mut |def| {
                if live.remove(&def) {
                    delta.push(DeltaOp::Add(def));
                }
            });
            self.info.each_use(ins, &mut |tmp| {
                if live.insert(tmp) {
                    delta.push(DeltaOp::Remove(tmp));
                }
            });
            my_deltas.push(delta);
        }
        /* only return true if something has changed from before */
        my_deltas.reverse();
        if let Some(s) = self.a.in_.get(&n) {
            if &live == s && my_deltas == self.a.deltas[&n] {
                return false;
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
            DeltaOp::Remove(tmp) => { set.remove(&tmp); }
            DeltaOp::Add(tmp)  => { set.insert(tmp); }
        }
    }
}
