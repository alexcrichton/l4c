/**
 * TODO: dox;
 */

use core::hashmap::linear::{LinearSet, LinearMap};

use middle::ssa::{CFG, Statement};
use middle::ir;
use utils::graph::{NodeId, NodeSet};

pub fn simplify(p: &mut ir::Program) {
  fn resolve(map: &LinearMap<NodeId, NodeId>, mut id: NodeId) -> NodeId {
    let orig = id;
    while map.contains_key(&id) {
      id = *map.get(&id);
    }
    debug!("resolved %? to %?", orig, id);
    return id;
  }

  /* TODO: this may need to be integrated with constant folding as part of it?
           to see this, look at ../tests1/kestrel-logical01.l2 */
  for vec::each_mut(p.funs) |f| {
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
    let mut changes = changes;
    let mut loops = LinearMap::new();
    loops <-> f.loops;
    do loops.consume |cond, (body, end)| {
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
    for cfg.each_succ(n) |succ| {
      if !visited.contains(&succ) {
        visit(cfg, succ, visited);
      }
    }
  }
  let mut visited = LinearSet::new();
  visit(cfg, root, &mut visited);
  let mut to_delete = ~[];
  for cfg.each_node |id, _| {
    if !visited.contains(&id) {
      to_delete.push(id);
    }
  }

  do vec::consume(to_delete) |_, id| {
    cfg.remove_node(id);
  }
}

/**
 * Eliminate all critical edges in the graph by splitting them and placing a
 * basic block on the edge. The fact that there are no critical edges in the
 * graph is leveraged when spilling registers and removing phi nodes.
 */
pub fn eliminate_critical<T: Statement>(cfg: &mut CFG<T>) {
  /* can't modify the graph during traversal */
  let mut critical = ~[];
  for cfg.each_edge |n1, n2| {
    /* critical edges are defined as those whose source has multiple out edges
       and whose target has multiple in edges */
    if cfg.num_succ(n1) > 1 && cfg.num_pred(n2) > 1 {
      critical.push((n1, n2));
    }
  }
  for critical.each |&(n1, n2)| {
    debug!("splitting critical edge %? %?", n1, n2);
    let edge = cfg.remove_edge(n1, n2);
    let new = cfg.new_id();
    cfg.add_node(new, ~[]);
    cfg.add_edge(n1, new, edge);
    cfg.add_edge(new, n2, ir::Always);

    /* Be sure to fix the predecessor of each phi node in our successor */
    cfg.map_consume_node(n2, |stms| vec::map_consume(stms, |stm| {
      match Statement::phi_unwrap(stm) {
        Right((def, map)) => {
          let mut map = map;
          let prev = map.pop(&n1).unwrap();
          map.insert(new, prev);
          Statement::phi(def, map)
        }
        Left(stm) => stm
      }
    }));
  }
}

/**
 * Attempts to merge nodes in the control flow graph
 *
 * Node B is merged into node A if A has only one successor and B has only one
 * predecessor
 */
pub fn merge<T>(cfg: &mut CFG<T>,
                root: NodeId) -> (NodeId, LinearMap<NodeId, NodeId>) {
  fn domerge<T>(cfg: &mut CFG<T>, visited: &mut NodeSet,
                changes: &mut LinearMap<NodeId, NodeId>,
                mut root: NodeId,
                mut n: NodeId) -> NodeId {
    visited.insert(n);
    let mut preds = 0;
    let mut pred = 0;
    for cfg.each_pred(n) |p| {
      preds += 1;
      pred = p;
    }
    /* Try to merge n's predecessor into it */
    if preds == 1 && cfg.num_succ(pred) == 1 {
      debug!("merging %? down into %?", pred, n);
      /* Add all of pred's incoming edges as incoming edges to n */
      for cfg.each_pred_edge(pred) |pred, &edge| {
        cfg.add_edge(pred, n, edge);
      }
      let mut blk = cfg.remove_node(pred);
      blk.push_all_move(cfg.pop_node(n));
      cfg.update_node(n, blk);
      changes.insert(pred, n);
      if pred == root {
        root = n
      }
    }
    let mut succ = ~[];
    for cfg.each_succ(n) |s| {
      succ.push(s);
    }
    for succ.each |&succ| {
      if cfg.contains(succ) && !visited.contains(&succ) {
        root = domerge(cfg, visited, changes, root, succ);
      }
    }
    return root;
  }

  let mut visited = LinearSet::new();
  let mut changes = LinearMap::new();
  return (domerge(cfg, &mut visited, &mut changes, root, root), changes);
}

/**
 * Eliminates all dead control flow paths in a CFG
 *
 * This takes care of constant branches by removing one half of the branch and
 * modifying the other edge to be and 'Always' or a 'Branch' as appropriate.
 */
fn eliminate_dead(cfg: &mut ir::CFG) {
  let mut constant = ~[];
  for cfg.each_node |n, stms| {
    match vec::last_opt(*stms) {
      Some(~ir::Condition(~ir::Const(c, _))) => { constant.push((n, c)); }
      _ => ()
    }
  }

  for constant.each |&(node, c)| {
    for cfg.each_succ_edge(node) |succ, edge| {
      let to_update = match edge {
        ir::False if c == 0 => ir::Always,
        ir::FBranch | ir::FLoopOut if c == 0 => ir::Branch,
        ir::True if c != 0 => ir::Always,
        ir::TBranch if c != 0 => ir::Branch,
        _ => {
          debug!("removing edge %? %?", node, succ);
          cfg.remove_edge(node, succ);
          loop;
        }
      };
      cfg.add_edge(node, succ, to_update);
    }
    do cfg.map_consume_node(node) |mut stms| {
      stms.pop(); /* remove 'Condition' */
      stms
    }
  }
}

/**
 * Fixes all phi functions in a CFG after we've eliminated predecessors and
 * probably broken most of the functions. This will remove arguments from any
 * deleted predecessors, and it will delete the phi function entirely if
 * there's only one argument now.
 */
fn fix_phis(cfg: &mut ir::CFG) {
  do cfg.map_nodes |n, stms| {
    do vec::map_consume(stms) |s| {
      match s {
        ~ir::Phi(def, ref map) => {
          /* TODO: shouldn't have to make a dup */
          let mut dup = LinearMap::new();
          let mut predtmp = def;
          for map.each |&(&pred, &tmp)| {
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
    }
  }
}
