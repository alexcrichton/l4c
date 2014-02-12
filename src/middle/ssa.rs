use std::hashmap::{HashMap, HashSet};
use collections::SmallIntMap;

use middle::{temp, liveness, ir, opt};
use middle::temp::Temp;
use utils::{graph, set, profile, PrettyPrint};

pub struct Analysis {
    /* idoms[a] = b => all elements of b are immeidately dominated by a */
    idominated: Idominated,
    /* idoms[a] = b => immediate dominator of a is b */
    idominator: Idominators,
}

pub trait Statement<T> {
    fn phi(&self, Temp, PhiMap) -> ~T;
    fn each_def(&self, ins: &T, |Temp|);
    fn each_use(&self, ins: &T, |Temp|);
    fn map_temps(&self, ins: ~T, u: |Temp| -> Temp, d: |Temp| -> Temp) -> ~T;
    fn phi_info<'a>(&self, me: &'a T) -> Option<(Temp, &'a PhiMap)>;
    fn phi_unwrap(&self, me: ~T) -> Result<(Temp, PhiMap), ~T>;
}

type TempMap = HashMap<Temp, Temp>;
type DomFrontiers = HashMap<graph::NodeId, ~graph::NodeSet>;
type Definitions = HashMap<Temp, ~graph::NodeSet>;
type PhiLocations = HashMap<graph::NodeId, ~HashSet<Temp>>;
type PhiMappings = HashMap<graph::NodeId, ~TempMap>;
pub type Idominators = SmallIntMap<graph::NodeId>;
pub type Idominated = SmallIntMap<~HashSet<graph::NodeId>>;
pub type PhiMap = HashMap<graph::NodeId, Temp>;
pub type CFG<T> = graph::Graph<~[~T], ir::Edge>;

struct Converter<'a, T, S> {
    cfg: &'a mut CFG<T>,
    root: graph::NodeId,
    info: &'a S,

    /* Mapping of a node to what temp mappings exist at the end of a node */
    versions: HashMap<graph::NodeId, TempMap>,
    /* (re-)Allocator for temps */
    temps: temp::Allocator,

    frontiers: DomFrontiers,

    /* Keeps track of new => old temp mappings to be returned from conversion */
    remapping: HashMap<Temp, Temp>,

    /* This analysis is filled in prior to conversion and is used throughout */
    analysis: &'a Analysis,
    liveness: liveness::Analysis,
}

pub fn Analysis() -> Analysis {
    Analysis { idominated: SmallIntMap::new(), idominator: SmallIntMap::new() }
}

pub fn convert<T: PrettyPrint, S: Statement<T>>(
    cfg: &mut CFG<T>,
    root: graph::NodeId,
    results: &mut Analysis,
    info: &S) -> HashMap<Temp, Temp>
{
    let mut live = liveness::Analysis();

    profile::dbg("pruning", || opt::cfg::prune(cfg, root));
    profile::dbg("liveness", || liveness::calculate(cfg, root, &mut live, info));
    profile::dbg("dominance", || analyze(cfg, root, results));
    let frontiers = profile::dbg("frontiers", || {
        dom_frontiers(cfg, root, results)
    });

    let mut converter: Converter<T, S> = Converter {
        info: info,
        cfg: cfg,
        root: root,
        versions: HashMap::new(),
        temps: temp::new(),
        frontiers: frontiers,
        analysis: results,
        liveness: live,
        remapping: HashMap::new(),
    };
    converter.convert();
    let Converter { remapping, .. } = converter;
    return remapping;
}

impl<'a, T: PrettyPrint, S: Statement<T>> Converter<'a, T, S> {
    fn convert(&mut self) -> uint {
        /* First, find where all the phi functions need to be */
        let defs = self.find_defs();
        let phis = self.find_phis(defs);

        /* Re-number the entire graph */
        let mut phi_temps = HashMap::new();
        profile::dbg("renumbering temps", || {
            let map = HashMap::new();
            self.versions.insert(self.root, map);
            let (ord, _) = self.cfg.postorder(self.root);
            for &id in ord.rev_iter() {
                profile::dbg(format!("node {:?}", id), || {
                    self.map_temps(id, &phis, &mut phi_temps);
                });
            }
        });
        /* If the graph already has phi functions, those are treated specially */
        profile::dbg("mapping phis", || {
            let nodes = self.cfg.nodes().map(|(id, _)| id).to_owned_vec();
            for &id in nodes.iter() {
                self.map_phi_temps(id);
            }
        });

        /* Finally place our new phi nodes */
        profile::dbg("placing phis", || {
            for (&k, v) in phi_temps.iter() {
                self.place_phis(k, *v);
            }
        });
        info!("ssa finished");
        return self.temps.cnt();
    }

    /* Build up the 'defs' map */
    fn find_defs(&mut self) -> Definitions {
        let mut defs: HashMap<Temp, ~HashSet<graph::NodeId>> = HashMap::new();
        for (id, stms) in self.cfg.nodes() {
            for s in stms.iter() {
                let s: &T = *s;
                self.info.each_def(s, |tmp| {
                    let set = defs.find_or_insert_with(tmp, |_| ~HashSet::new());
                    set.insert(id);
                });
            }
        }
        info!("found definitions");
        return defs;
    }

    /* Find where all phi functions need to go */
    fn find_phis(&mut self, defs: Definitions) -> PhiLocations {
        /* Use the iterated dominance frontier algorithm, shown here:
           http://symbolaris.com/course/Compilers12/11-ssa.pdf
           to determine the optimal placement of phi functions */

        let mut phis: HashMap<Temp, ~HashSet<Temp>> = HashMap::new();

        for (tmp, defs) in defs.move_iter() {
            /* with one definition we can't possibly need a phi node */
            if defs.len() > 1 {
                debug!("idf for tmp: {}", tmp.pp());
                let locs = self.idf(defs);
                for n in locs.iter() {
                    if !self.liveness.in_.get(n).contains(&tmp) { continue }
                    match phis.find_mut(n) {
                        Some(s) => { s.insert(tmp); continue; }
                        None => {}
                    }
                    phis.insert(*n, ~set::singleton(tmp));
                }
            }
        }
        info!("found phis");
        return phis;
    }

    /* Calculate the iterated dominance frontier on a set of nodes */
    fn idf(&mut self, set: ~graph::NodeSet) -> graph::NodeSet {
        let mut ret = HashSet::new();
        for &v in set.iter() {
            ret.insert(v);
        }
        /* loop until we find a fixed point */
        loop {
            let mut tmp = HashSet::new();
            for id in set.iter() {
                match self.frontiers.find(id) {
                    Some(x) => for &t in x.iter() { tmp.insert(t); },
                    None => {}
                }
            }
            for id in ret.iter() {
                match self.frontiers.find(id) {
                    Some(x) => for &t in x.iter() { tmp.insert(t); },
                    None => {}
                }
            }
            if tmp == ret {
                return ret;
            }
            ret = tmp;
        }
    }

    /**
     * Modify all temps in the graph to new temps based on what they were before
     * but now taking SSA into account. This function does not place phi functions
     * anywhere because the version of temps in all predecessors to phi functions
     * must be determined first.
     *
     * This function does, however, prepare for phi functions to be placed
     */
    fn map_temps(&mut self, n: graph::NodeId, phis: &PhiLocations,
                 phi_temps: &mut PhiMappings) {
        let mut map = HashMap::new();
        let idom = self.analysis.idominator.get(&n);
        for (&k, &v) in self.versions.get(idom).iter() {
            map.insert(k, v);
        }

        /* Bump all temp numbers which have phi functions at this location */
        debug!("bumping temps for phis at {}", n as int);
        match phis.find(&n) {
            None => (),
            Some(ref temps) => {
                /* Keep track of what we changed our temps to so the phi functions can
                   be placed correctly in the next step */
                let mut mapping = ~HashMap::new();
                for &tmp in temps.iter() {
                    mapping.insert(tmp, self.bump(&mut map, tmp));
                }
                phi_temps.insert(n, mapping);
            }
        }

        /* Process all statements in this block (possibly bumping versions) */
        debug!("mapping statements at {}", n as int);
        let stms = self.cfg.pop_node(n);
        let stms = stms.move_iter().map(|s| {
            debug!("{}", s.pp());
            self.info.map_temps(s,
                                |usage| *map.get(&usage),
                                |def|   self.bump(&mut map, def))
        }).collect();
        self.versions.insert(n, map);
        self.cfg.add_node(n, stms);
    }

    /* Alter the temp mapping for a specified non-ssa temp */
    fn bump(&mut self, vars: &mut TempMap, t: Temp) -> Temp {
        let ret = self.temps.new();
        self.remapping.insert(ret, t);
        vars.insert(t, ret);
        return ret;
    }

    /**
     * Re-map all existing phi instructions to use the new temps located on all of
     * their predecessor's edges
     */
    fn map_phi_temps(&mut self, n: graph::NodeId) {
        self.cfg.map_consume_node(n, |stms| stms.move_iter().map(|stm|
           match self.info.phi_unwrap(stm) {
               Err(stm) => stm,
               Ok((def, map)) => {
                   let mut new = HashMap::new();
                   for (pred, tmp) in map.move_iter() {
                       new.insert(pred, *self.versions.get(&pred).get(&tmp));
                   }
                   self.info.phi(def, new)
               }
           }
        ).collect());
    }

    /**
     * Places phi functions into the CFG. This assumes that all temps have already
     * been renumbered/renamed and the last thing to do is to actually put the phi
     * functions in place
     */
    fn place_phis(&mut self, n: graph::NodeId, temps: &HashMap<Temp, Temp>) {
        debug!("generating {:?} phis at {:?}", temps.len(), n);
        let mut block = ~[];
        for (tmp_before, &tmp_after) in temps.iter() {
            debug!("placing phi for {:?} at {:?}", tmp_before, n);
            let mut preds = HashMap::new();
            /* Our phi function operates on the last known ssa-temp for this node's
               non-ssa temp at each of our predecessors */
            for p in self.cfg.preds(n) {
                let map = self.versions.get(&p);
                assert!(map.contains_key(tmp_before));
                preds.insert(p, *map.get(tmp_before));
            }

            /* The result of the phi node is the ssa-temp, not the non-ssa temp */
            block.push(self.info.phi(tmp_after, preds));
        }

        /* Update our node with the phi nodes */
        block.push_all_move(self.cfg.pop_node(n));
        self.cfg.update_node(n, block);
    }
}

/* Calculate the immediate dominators of every node, completing the SSA analysis
 * of a graph and filling in the provided structure of information */
fn analyze<T>(cfg: &CFG<T>, root: graph::NodeId, analysis: &mut Analysis) {
    debug!("calculating idoms");
    let idoms = &mut analysis.idominator;
    let (order, postorder) = cfg.postorder(root);
    debug!("{:?}", order);
    idoms.insert(root, root);

    /* This code is an implementation of the algorithm found in this paper:
       http://www.cs.rice.edu/~keith/EMBED/dom.pdf
       and is used to calculate the immeidate dominator of each node */
    let mut changed = true;
    while changed {
        changed = false;
        for &b in order.rev_iter() {
            if b == root { continue }
            let mut new_idom = -1;

            for p in cfg.preds(b) {
                if !idoms.contains_key(&p) { continue }
                if new_idom == -1 {
                    new_idom = p;
                } else {
                    let mut b1 = p;
                    let mut b2 = new_idom;
                    let mut pb1 = postorder.get(&b1);
                    let mut pb2 = postorder.get(&b2);
                    while pb1 != pb2 {
                        while pb1 < pb2 {
                            b1 = *idoms.get(&b1);
                            pb1 = postorder.get(&b1);
                        }
                        while pb2 < pb1 {
                            b2 = *idoms.get(&b2);
                            pb2 = postorder.get(&b1);
                        }
                    }
                    new_idom = b1;
                }
            }
            assert!(new_idom != -1);
            let prev = match idoms.find(&b) { Some(&dom) => dom, None => -1 };
            if prev != new_idom {
                idoms.insert(b, new_idom);
                changed = true;
            }
        }
    }
    info!("idoms calculated");

    /* Afterwards, calculate the set of nodes that each node immediately dominates
     * up front so it doesn't have to be done again */
    for (a, _) in idoms.iter() {
        analysis.idominated.insert(a, ~HashSet::new());
    }
    for (a, &b) in idoms.iter() {
        if a != b {
            let map = analysis.idominated.find_mut(&b).unwrap();
            map.insert(a);
        }
    }
}

/* Calculates the dominance frontier of each node in the graph */
fn dom_frontiers<T>(cfg: &CFG<T>, root: graph::NodeId,
                    analysis: &Analysis) -> DomFrontiers {
    /* calculate all immediate dominators */
    let idoms = &analysis.idominator;
    let idominated = &analysis.idominated;

    /* Calculate the dominance frontiers according to the algorithm shown in
       these slides: http://symbolaris.com/course/Compilers12/11-ssa.pdf
       for calculating the dominance frontier of a node */
    let mut frontiers: DomFrontiers = HashMap::new(); /* TODO: remove type? */
    cfg.each_postorder(root, |&a| {
        let mut frontier = ~HashSet::new();

        /* df_local[a] */
        debug!("df_local[{}]...", a as int);
        for b in cfg.succ(a) {
            if *idoms.get(&b) != a {
                frontier.insert(b);
            }
        }

        /* for all c where idom[c] = a */
        for &c in idominated.get(&a).iter() {
            if a == c { continue }
            debug!("df_up[{}, {}]...", a as int, c as int);

            /* df_up[a, c] */
            for &b in frontiers.get(&c).iter() {
                if *idoms.get(&b) != a {
                    frontier.insert(b);
                }
            }
        }
        debug!("calculated df[{}]", a as int);

        frontiers.insert(a, frontier);
    });
    debug!("calculated dominance frontiers");
    return frontiers;
}
