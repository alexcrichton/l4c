/**
 * TODO: dox;
 */

use core::hashmap::linear::{LinearSet, LinearMap};

use middle::ssa::{CFG, Statement};
use middle::ir;
use utils::graph::{NodeId, NodeSet};

pub fn simplify(p: &mut ir::Program) {
  for vec::each_mut(p.funs) |f| {
    prune(&mut f.cfg, f.root);
    merge(&mut f.cfg, f.root);
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

  /* TODO: if this is 'consume', there's a segfault... */
  for to_delete.each |&id| {
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
    cfg.map_consume_node(n2, |stms| vec::map_consume(stms, |ins| {
      match Statement::phi_info(ins) {
        Some((def, map)) => {
          /* TODO: shouldn't need dup */
          let mut dup = LinearMap::new();
          for map.each |&(&k, &v)| {
            dup.insert(k, v);
          }
          dup.insert(new, *map.get(&n1));
          dup.remove(&n1);
          Statement::phi(def, dup)
        }
        None => ins
      }
    }));
  }
}

pub fn merge<T>(cfg: &mut CFG<T>, root: NodeId) {
  fn domerge<T>(cfg: &mut CFG<T>, visited: &mut NodeSet,
                root: NodeId, mut n: NodeId) {
    visited.insert(n);
    let mut preds = 0;
    let mut pred = 0;
    for cfg.each_pred(n) |p| {
      preds += 1;
      pred = p;
    }
    /* Try to merge 'n' up to its predecessor */
    if n != root && preds == 1 && cfg.num_succ(pred) == 1 {
      /* Add all of n's outgoing edges as outgoing edges of pred */
      for cfg.each_succ_edge(n) |succ, edge| {
        cfg.add_edge(pred, succ, edge);
      }
      let blk = cfg.remove_node(n);
      do cfg.map_consume_node(pred) |s| {
        s + blk
      }
      n = pred; /* don't recurse on a non-existent node */
    }
    for cfg.each_succ(n) |succ| {
      if !visited.contains(&succ) {
        domerge(cfg, visited, root, succ);
      }
    }
  }

  let mut visited = LinearSet::new();
  domerge(cfg, &mut visited, root, root);
}
