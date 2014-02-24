/**
 * TODO: dox;
 */

use collections::{HashSet, HashMap};
use std::mem::replace;

use middle::ssa::{CFG, Statement};
use middle::ir;
use utils::graph::{NodeId, NodeSet};

pub fn simplify(p: &mut ir::Program) {
    fn resolve(map: &HashMap<NodeId, NodeId>, mut id: NodeId) -> NodeId {
        let orig = id;
        while map.contains_key(&id) {
            id = *map.get(&id);
        }
        debug!("resolved {:?} to {:?}", orig, id);
        return id;
    }

    /* TODO: this may need to be integrated with constant folding as part of it?
       to see this, look at ../tests1/kestrel-logical01.l2 */
    for f in p.funs.mut_iter() {
        /* Take out all the dead branches/edges */
        eliminate_dead(&mut f.cfg);
        /* Remove all unreachable nodes */
        prune(&mut f.cfg, f.root);
        /* Fix all phis or remove them from the previous operation */
        fix_phis(&mut f.cfg);
        /* Finally merge nodes together if we can */
        let (newroot, changes) = merge(&mut f.cfg, f.root);

        /* After merging, we need to update the 'loops' array metadata which
           maintains information about what's a loop header and where its loop body
           and ending node both start. */
        let changes = changes;
        let loops = replace(&mut f.loops, HashMap::new());
        for (cond, (body, end)) in loops.move_iter() {
            let cond = resolve(&changes, cond);
            let body = resolve(&changes, body);
            let end  = resolve(&changes, end);
            if f.cfg.contains(cond) && f.cfg.contains(body) {
                f.loops.insert(cond, (body, end));
            }
        }
        f.root = newroot;
    }
}

/**
 * Given the root node of the control flow graph, removes all unreachable
 * nodes by doing a DFS traversal of the graph and seeing whatever wasn't
 * reached during the traversal.
 */
pub fn prune<T>(cfg: &mut CFG<T>, root: NodeId) {
    fn visit<T>(cfg: &CFG<T>, n: NodeId, visited: &mut NodeSet) {
        visited.insert(n);
        for succ in cfg.succ(n) {
            if !visited.contains(&succ) {
                visit(cfg, succ, visited);
            }
        }
    }
    let mut visited = HashSet::new();
    visit(cfg, root, &mut visited);
    let mut to_delete = ~[];
    for (id, _) in cfg.nodes() {
        if !visited.contains(&id) {
            to_delete.push(id);
        }
    }

    for id in to_delete.move_iter() {
        cfg.remove_node(id);
    }
}

/**
 * Eliminate all critical edges in the graph by splitting them and placing a
 * basic block on the edge. The fact that there are no critical edges in the
 * graph is leveraged when spilling registers and removing phi nodes.
 */
pub fn eliminate_critical<T, S: Statement<T>>(cfg: &mut CFG<T>, info: &S) {
    /* can't modify the graph during traversal */
    let mut critical = ~[];
    for (n1, n2) in cfg.edges() {
        /* critical edges are defined as those whose source has multiple out edges
           and whose target has multiple in edges */
        if cfg.num_succ(n1) > 1 && cfg.num_pred(n2) > 1 {
            critical.push((n1, n2));
        }
    }
    for &(n1, n2) in critical.iter() {
        debug!("splitting critical edge {:?} {:?}", n1, n2);
        let edge = cfg.remove_edge(n1, n2);
        let new = cfg.new_id();
        cfg.add_node(new, ~[]);
        cfg.add_edge(n1, new, edge);
        cfg.add_edge(new, n2, ir::Always);

        /* Be sure to fix the predecessor of each phi node in our successor */
        cfg.map_consume_node(n2, |stms| stms.move_iter().map(|stm| {
            match info.phi_unwrap(stm) {
                Ok((def, map)) => {
                    let mut map = map;
                    let prev = map.pop(&n1).unwrap();
                    map.insert(new, prev);
                    info.phi(def, map)
                }
                Err(stm) => stm
            }
        }).collect());
    }
}

/**
 * Attempts to merge nodes in the control flow graph
 *
 * Node B is merged into node A if A has only one successor and B has only one
 * predecessor
 */
pub fn merge<T>(cfg: &mut CFG<T>,
root: NodeId) -> (NodeId, HashMap<NodeId, NodeId>) {
    fn domerge<T>(cfg: &mut CFG<T>, visited: &mut NodeSet,
                  changes: &mut HashMap<NodeId, NodeId>,
                  mut root: NodeId,
                  n: NodeId) -> NodeId {
        visited.insert(n);
        let mut preds = 0;
        let mut pred = 0;
        for p in cfg.preds(n) {
            preds += 1;
            pred = p;
        }
        /* Try to merge n's predecessor into it */
        if preds == 1 && cfg.num_succ(pred) == 1 {
            debug!("merging {:?} down into {:?}", pred, n);

            /* Add all of pred's incoming edges as incoming edges to n */
            let mut edges = ~[];
            for (pred, &edge) in cfg.pred_edges(pred) { edges.push((pred, edge)); }
            for &(pred, edge) in edges.iter() { cfg.add_edge(pred, n, edge); }

            /* merge the two blocks of statements */
            let mut blk = cfg.remove_node(pred);
            blk.push_all_move(cfg.pop_node(n));
            cfg.update_node(n, blk);

            changes.insert(pred, n);
            if pred == root {
                root = n
            }
        }
        let mut succ = ~[];
        for s in cfg.succ(n) {
            succ.push(s);
        }
        for &succ in succ.iter() {
            if cfg.contains(succ) && !visited.contains(&succ) {
                root = domerge(cfg, visited, changes, root, succ);
            }
        }
        return root;
    }

    let mut visited = HashSet::new();
    let mut changes = HashMap::new();
    return (domerge(cfg, &mut visited, &mut changes, root, root), changes);
}

/**
 * Eliminates all dead control flow paths in a CFG
 *
 * This takes care of constant branches by removing one half of the branch and
 * modifying the other edge to be and 'Always' or a 'Branch' as appropriate.
 */
fn eliminate_dead(cfg: &mut ir::CFG) {
    /* figure out which nodes are constant, modifying them if necessary */
    let mut constant = ~[];
    cfg.map_nodes(|n, mut stms| {
        let pop = match stms.last() {
            Some(&~ir::Condition(~ir::Const(c, _))) => {
                constant.push((n, c));
                true
            }
            _ => false
        };
        if pop { stms.pop(); }
        stms
    });

    /* figure out what to do with each constant node */
    let mut to_remove = ~[];
    let mut to_add = ~[];
    for &(node, c) in constant.iter() {
        for (succ, edge) in cfg.succ_edges(node) {
            let to_update = match *edge {
                ir::False if c == 0 => ir::Always,
                ir::FBranch | ir::FLoopOut if c == 0 => ir::Branch,
                ir::True if c != 0 => ir::Always,
                ir::TBranch if c != 0 => ir::Branch,
                _ => {
                    debug!("removing edge {:?} {:?}", node, succ);
                    to_remove.push((node, succ));
                    continue
                }
            };
            to_add.push((node, succ, to_update));
        }
    }

    /* Actually apply all the changes */
    for &(n, s) in to_remove.iter() { cfg.remove_edge(n, s); }
    for &(n, s, e) in to_add.iter() { cfg.add_edge(n, s, e); }
}

/**
 * Fixes all phi functions in a CFG after we've eliminated predecessors and
 * probably broken most of the functions. This will remove arguments from any
 * deleted predecessors, and it will delete the phi function entirely if
 * there's only one argument now.
 */
fn fix_phis(cfg: &mut ir::CFG) {
    /* need cfg to be immutable inside, so we can't use map_nodes */
    let mut ids = ~[];
    for (n, _) in cfg.nodes() { ids.push(n); }

    for n in ids.move_iter() {
        let stms = cfg.pop_node(n);

        let stms = stms.move_iter().map(|s| {
            match s {
                ~ir::Phi(def, ref map) => {
                    /* TODO: shouldn't have to make a dup */
                    let mut dup = HashMap::new();
                    let mut predtmp = def;
                    for (&pred, &tmp) in map.iter() {
                        if cfg.contains_edge(pred, n) {
                            dup.insert(pred, tmp);
                            predtmp = tmp;
                        }
                    }
                    if dup.len() == 1 {
                        ~ir::Move(def, ~ir::Temp(predtmp))
                    } else {
                        ~ir::Phi(def, dup)
                    }
                }
                _ => s
            }
        }).collect();

        cfg.add_node(n, stms);
    }
}
