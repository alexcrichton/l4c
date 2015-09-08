use std::cell::RefCell;
use std::collections::{HashMap, HashSet};
use std::fmt;
use std::usize;

use vec_map::VecMap;

use middle::ir;
use middle::liveness;
use middle::opt;
use utils::graph::{NodeId, Graph, NodeSet};
use utils::profile;
use utils::{Temp, TempAllocator};

pub struct Analysis {
    // idoms[a] = b => all elements of b are immeidately dominated by a
    pub idominated: Idominated,
    // idoms[a] = b => immediate dominator of a is b
    pub idominator: Idominators,
}

pub trait Statement<T> {
    fn each_def(&self, ins: &T, &mut FnMut(Temp));
    fn each_use(&self, ins: &T, &mut FnMut(Temp));
    fn map_temps(&self, ins: &mut T,
                 u: &mut FnMut(Temp) -> Temp,
                 d: &mut FnMut(Temp) -> Temp);

    fn new_phi(&self, Temp, PhiMap) -> T;
    fn phi<'a>(&self, me: &'a T) -> Option<(Temp, &'a PhiMap)>;
    fn phi_mut<'a>(&self, me: &'a mut T) -> Option<(Temp, &'a mut PhiMap)>;
    fn into_phi(&self, me: T) -> Result<(Temp, PhiMap), T>;
}

type TempMap = HashMap<Temp, Temp>;
type DomFrontiers = HashMap<NodeId, NodeSet>;
type Definitions = HashMap<Temp, NodeSet>;
type PhiLocations = HashMap<NodeId, HashSet<Temp>>;
type PhiMappings = HashMap<NodeId, TempMap>;
pub type Idominators = VecMap<NodeId>;
pub type Idominated = VecMap<HashSet<NodeId>>;
pub type PhiMap = HashMap<NodeId, Temp>;
pub type CFG<T> = Graph<Vec<T>, ir::Edge>;

struct Converter<'a, T: 'a, S: 'a> {
    cfg: &'a mut CFG<T>,
    root: NodeId,
    info: &'a S,

    // Mapping of a node to what temp mappings exist at the end of a node
    versions: HashMap<NodeId, TempMap>,
    // (re-)Allocator for temps
    temps: TempAllocator,

    frontiers: DomFrontiers,

    // Keeps track of new => old temp mappings to be returned from conversion
    remapping: HashMap<Temp, Temp>,

    // This analysis is filled in prior to conversion and is used throughout
    analysis: &'a Analysis,
    liveness: liveness::Analysis,
}

impl Analysis {
    pub fn new() -> Analysis {
        Analysis { idominated: VecMap::new(), idominator: VecMap::new() }
    }
}

pub fn convert<T: fmt::Display, S: Statement<T>>(
    cfg: &mut CFG<T>,
    root: NodeId,
    results: &mut Analysis,
    info: &S) -> HashMap<Temp, Temp>
{
    let mut live = liveness::Analysis::new();

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
        temps: TempAllocator::new(),
        frontiers: frontiers,
        analysis: results,
        liveness: live,
        remapping: HashMap::new(),
    };
    converter.convert();
    let Converter { remapping, .. } = converter;
    return remapping;
}

impl<'a, T: fmt::Display, S: Statement<T>> Converter<'a, T, S> {
    fn convert(&mut self) -> u32 {
        // First, find where all the phi functions need to be
        let defs = self.find_defs();
        let phis = self.find_phis(defs);

        // Re-number the entire graph
        let mut phi_temps = HashMap::new();
        profile::dbg("renumbering temps", || {
            let map = HashMap::new();
            self.versions.insert(self.root, map);
            let (ord, _) = self.cfg.postorder(self.root);
            for &id in ord.iter().rev() {
                profile::dbg(&format!("node {}", id), || {
                    self.map_temps(id, &phis, &mut phi_temps);
                });
            }
        });
        // If the graph already has phi functions, those are treated specially
        profile::dbg("mapping phis", || {
            let nodes = self.cfg.nodes().map(|(id, _)| id).collect::<Vec<_>>();
            for &id in nodes.iter() {
                self.map_phi_temps(id);
            }
        });

        // Finally place our new phi nodes
        profile::dbg("placing phis", || {
            for (&k, v) in phi_temps.iter() {
                self.place_phis(k, v);
            }
        });
        info!("ssa finished");
        return self.temps.count();
    }

    // Build up the 'defs' map
    fn find_defs(&mut self) -> Definitions {
        let mut defs = HashMap::new();
        for (id, stms) in self.cfg.nodes() {
            for s in stms.iter() {
                self.info.each_def(s, &mut |tmp| {
                    defs.entry(tmp).or_insert_with(|| HashSet::default())
                        .insert(id);
                });
            }
        }
        info!("found definitions");
        return defs;
    }

    // Find where all phi functions need to go
    fn find_phis(&mut self, defs: Definitions) -> PhiLocations {
        // Use the iterated dominance frontier algorithm, shown here:
        // http://symbolaris.com/course/Compilers12/11-ssa.pdf
        // to determine the optimal placement of phi functions

        let mut phis: PhiLocations = HashMap::new();

        for (tmp, defs) in defs {
            // with one definition we can't possibly need a phi node
            if defs.len() > 1 {
                debug!("idf for tmp: {}", tmp);
                let locs = self.idf(defs);
                for n in locs {
                    if !self.liveness.in_[&n].contains(&tmp) {
                        continue
                    }
                    phis.entry(n).or_insert_with(|| HashSet::new())
                        .insert(tmp);
                }
            }
        }
        info!("found phis");
        return phis
    }

    // Calculate the iterated dominance frontier on a set of nodes
    fn idf(&mut self, set: NodeSet) -> NodeSet {
        let mut ret = HashSet::default();
        for v in set.iter() {
            ret.insert(*v);
        }
        // loop until we find a fixed point
        loop {
            let mut tmp = HashSet::default();
            for id in set.iter() {
                if let Some(x) = self.frontiers.get(id) {
                    tmp.extend(x);
                }
            }
            for id in ret.iter() {
                if let Some(x) = self.frontiers.get(id) {
                    tmp.extend(x);
                }
            }
            if tmp == ret {
                return ret;
            }
            ret = tmp;
        }
    }

    /// Modify all temps in the graph to new temps based on what they were
    /// before but now taking SSA into account. This function does not place phi
    /// functions anywhere because the version of temps in all predecessors to
    /// phi functions must be determined first.
    ///
    /// This function does, however, prepare for phi functions to be placed
    fn map_temps(&mut self, n: NodeId, phis: &PhiLocations,
                 phi_temps: &mut PhiMappings) {
        let mut map = HashMap::new();
        let idom = self.analysis.idominator[&n];
        for (&k, &v) in self.versions[&idom].iter() {
            map.insert(k, v);
        }

        // Bump all temp numbers which have phi functions at this location
        debug!("bumping temps for phis at {}", n);
        if let Some(temps) = phis.get(&n) {
            // Keep track of what we changed our temps to so the phi
            // functions can be placed correctly in the next step
            let mut mapping = HashMap::new();
            for &tmp in temps {
                mapping.insert(tmp, self.bump(&mut map, tmp));
            }
            phi_temps.insert(n, mapping);
        }

        // Process all statements in this block (possibly bumping versions)
        let map = RefCell::new(map);
        debug!("mapping statements at {}", n);
        // TODO: less movement
        let mut stms = self.cfg.pop_node(n);
        for s in stms.iter_mut() {
            debug!("{}", s);
            self.info.map_temps(s,
                                &mut |usage| map.borrow()[&usage],
                                &mut |def| self.bump(&mut map.borrow_mut(), def))
        }
        self.versions.insert(n, map.into_inner());
        self.cfg.add_node(n, stms);
    }

    // Alter the temp mapping for a specified non-ssa temp
    fn bump(&mut self, vars: &mut TempMap, t: Temp) -> Temp {
        let ret = self.temps.gen();
        self.remapping.insert(ret, t);
        vars.insert(t, ret);
        return ret;
    }

    /// Re-map all existing phi instructions to use the new temps located on all of
    /// their predecessor's edges
    fn map_phi_temps(&mut self, n: NodeId) {
        let info = &self.info;
        let versions = &self.versions;
        // TODO: less movement
        self.cfg.map_consume_node(n, &mut |mut stms| {
            for stm in stms.iter_mut() {
                if let Some((_, map)) = info.phi_mut(stm) {
                    *map = map.iter().map(|(&pred, tmp)| {
                        (pred, versions[&pred][tmp])
                    }).collect();
                }
            }
            stms
        });
    }

    /// Places phi functions into the CFG. This assumes that all temps have already
    /// been renumbered/renamed and the last thing to do is to actually put the phi
    /// functions in place
    fn place_phis(&mut self, n: NodeId, temps: &HashMap<Temp, Temp>) {
        debug!("generating {} phis at {}", temps.len(), n);
        let mut block = Vec::new();
        for (tmp_before, &tmp_after) in temps.iter() {
            debug!("placing phi for {} at {}", tmp_before, n);
            let mut preds = HashMap::new();
            // Our phi function operates on the last known ssa-temp for this
            // node's non-ssa temp at each of our predecessors
            for p in self.cfg.preds(n) {
                let map = &self.versions[&p];
                assert!(map.contains_key(tmp_before));
                preds.insert(p, map[tmp_before]);
            }

            // The result of the phi node is the ssa-temp, not the non-ssa temp
            block.push(self.info.new_phi(tmp_after, preds));
        }

        // Update our node with the phi nodes
        block.extend(self.cfg.pop_node(n));
        self.cfg.update_node(n, block);
    }
}

// Calculate the immediate dominators of every node, completing the SSA analysis
// of a graph and filling in the provided structure of information
fn analyze<T>(cfg: &CFG<T>, root: NodeId, analysis: &mut Analysis) {
    debug!("calculating idoms");
    let idoms = &mut analysis.idominator;
    let (order, postorder) = cfg.postorder(root);
    debug!("{:?}", order);
    idoms.insert(root, root);

    // This code is an implementation of the algorithm found in this paper:
    // http://www.cs.rice.edu/~keith/EMBED/dom.pdf
    // and is used to calculate the immeidate dominator of each node
    let mut changed = true;
    while changed {
        changed = false;
        for &b in order.iter().rev() {
            if b == root { continue }
            let mut new_idom = usize::MAX;

            for p in cfg.preds(b) {
                if !idoms.contains_key(&p) { continue }
                if new_idom == usize::MAX {
                    new_idom = p;
                } else {
                    let mut b1 = p;
                    let mut b2 = new_idom;
                    let mut pb1 = postorder[&b1];
                    let mut pb2 = postorder[&b2];
                    while pb1 != pb2 {
                        while pb1 < pb2 {
                            b1 = idoms[&b1];
                            pb1 = postorder[&b1];
                        }
                        while pb2 < pb1 {
                            b2 = idoms[&b2];
                            pb2 = postorder[&b1];
                        }
                    }
                    new_idom = b1;
                }
            }
            assert!(new_idom != usize::MAX);
            let prev = idoms.get(&b).map(|x| *x).unwrap_or(usize::MAX);
            if prev != new_idom {
                idoms.insert(b, new_idom);
                changed = true;
            }
        }
    }
    info!("idoms calculated");

    // Afterwards, calculate the set of nodes that each node immediately dominates
    // up front so it doesn't have to be done again
    for (a, _) in idoms.iter() {
        analysis.idominated.insert(a, HashSet::new());
    }
    for (a, &b) in idoms.iter() {
        if a != b {
            analysis.idominated.get_mut(&b).unwrap()
                               .insert(a);
        }
    }
}

// Calculates the dominance frontier of each node in the graph
fn dom_frontiers<T>(cfg: &CFG<T>, root: NodeId,
                    analysis: &Analysis) -> DomFrontiers {
    // calculate all immediate dominators
    let idoms = &analysis.idominator;
    let idominated = &analysis.idominated;

    // Calculate the dominance frontiers according to the algorithm shown in
    // these slides: http://symbolaris.com/course/Compilers12/11-ssa.pdf
    // for calculating the dominance frontier of a node
    let mut frontiers: DomFrontiers = HashMap::new(); // TODO: remove type?
    cfg.each_postorder(root, &mut |&a| {
        let mut frontier = HashSet::default();

        // df_local[a]
        debug!("df_local[{}]...", a);
        for b in cfg.succ(a) {
            if idoms[&b] != a {
                frontier.insert(b);
            }
        }

        // for all c where idom[c] = a
        for &c in idominated[&a].iter() {
            if a == c { continue }
            debug!("df_up[{}, {}]...", a, c);

            // df_up[a, c]
            for &b in frontiers[&c].iter() {
                if idoms[&b] != a {
                    frontier.insert(b);
                }
            }
        }
        debug!("calculated df[{}]", a);

        frontiers.insert(a, frontier);
    });
    debug!("calculated dominance frontiers");
    return frontiers;
}
