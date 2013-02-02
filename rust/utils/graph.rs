use core::hashmap::linear::{LinearMap, LinearSet};

use io::WriterUtil;

pub type NodeId = uint;
pub type NodeSet = LinearSet<NodeId>;

pub struct Graph<N, E> {
  priv nodes: LinearMap<NodeId, N>,
  priv succ:  LinearMap<NodeId, ~mut LinearMap<NodeId, E>>,
  priv pred:  LinearMap<NodeId, ~mut NodeSet>,
  priv next:  NodeId
}

pub fn Graph<N: Copy, E: Copy>() -> Graph<N, E>{
  Graph{ nodes: LinearMap::new(),
         succ:  LinearMap::new(),
         pred:  LinearMap::new(),
         next:  0 }
}

impl<N: Copy, E: Copy> Graph<N, E> {
  pure fn num_nodes(&self, ) -> uint {
    self.nodes.len()
  }
  pure fn num_pred(&self, n: NodeId) -> uint {
    self.pred.get(&n).len()
  }
  pure fn num_succ(&self, n: NodeId) -> uint {
    self.succ.get(&n).len()
  }

  fn new_id(&mut self) -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.succ.insert(ret, ~mut LinearMap::new());
    self.pred.insert(ret, ~mut LinearSet::new());
    ret
  }

  pure fn node(&self, id: NodeId) -> N {
    *self.nodes.get(&id)
  }

  pure fn edge(&self, a: NodeId, b: NodeId) -> E {
    let a_succ = self.succ.get(&a);
    return *a_succ.get(&b);
  }

  fn add_node(&mut self, id: NodeId, n: N) {
    assert(!self.nodes.contains_key(&id));
    assert(self.succ.contains_key(&id));
    self.nodes.insert(id, n);
  }

  fn update_node(&mut self, id: NodeId, n: N) {
    assert(self.nodes.contains_key(&id));
    assert(self.succ.contains_key(&id));
    self.nodes.insert(id, n);
  }

  fn remove_node(&mut self, n: NodeId) {
    assert self.nodes.remove(&n);
    let succ = self.succ.pop(&n).unwrap();
    let pred = self.pred.pop(&n).unwrap();
    for succ.each_key |k| {
      assert self.pred.get(k).remove(&n)
    }
    for pred.each |k| {
      assert self.succ.get(k).remove(&n);
    }
  }

  fn remove_edge(&mut self, n1: NodeId, n2: NodeId) -> E {
    assert self.pred.get(&n2).remove(&n1);
    return self.succ.get(&n1).pop(&n2).unwrap();
  }

  fn add_edge(&mut self, n1: NodeId, n2: NodeId, e: E) {
    self.succ.get(&n1).insert(n2, e);
    self.pred.get(&n2).insert(n1);
  }

  pure fn each_edge(&self, f: fn(NodeId, NodeId) -> bool) {
    for self.succ.each |&a, map| {
      /* TODO(purity): this shouldn't be unsafe */
      unsafe { map.each_key(|&b| f(a, b)); }
    }
  }

  pure fn each_node(&self, f: fn(NodeId, &N) -> bool) {
    self.nodes.each(|&a, b| f(a, b));
  }

  pure fn each_pred(&self, n: NodeId, f: fn(NodeId) -> bool) {
    let preds = self.pred.get(&n);
    /* TODO(purity): this shouldn't be unsafe */
    unsafe { preds.each(|&k| f(k)); }
  }

  pure fn each_succ(&self, n: NodeId, f: fn(NodeId) -> bool) {
    let succ = self.succ.get(&n);
    /* TODO(purity): this shouldn't be unsafe */
    unsafe { succ.each_key(|&k| f(k)); }
  }

  pure fn each_succ_edge(&self, n: NodeId, f: fn(NodeId, E) -> bool) {
    let succ = self.succ.get(&n);
    /* TODO(purity): this shouldn't be unsafe */
    unsafe { succ.each(|&n, &e| f(n, e)); }
  }

  fn each_postorder(&self, root: NodeId, f: fn(&NodeId) -> bool) {
    let (order, _) = self.postorder(root);
    order.each(f);
  }

  fn each_rev_postorder(&self, root: NodeId, f: fn(&NodeId) -> bool) {
    let (order, _) = self.postorder(root);
    vec::rev_each(order, f);
  }

  fn map_nodes(&mut self, f: fn(NodeId, N) -> N) {
    let mut keys = ~[];
    for self.nodes.each_key |&k| { keys.push(k); }
    for keys.each |&k| {
      let new = f(k, *self.nodes.get(&k));
      self.nodes.insert(k, new);
    }
  }

  fn map<N2: Copy, E2: Copy>(&self, n: fn(NodeId, &N) -> N2,
                               e: fn(&E) -> E2) -> Graph<N2, E2> {
    let mut g2 = Graph();
    g2.next = self.next;
    for self.nodes.each |&k, v| {
      g2.nodes.insert(k, n(k, v));
    }
    for self.pred.each |&k, v| {
      let set = ~mut LinearSet::new();
      /* TODO(purity): this shouldn't be unsafe */
      unsafe {
        for v.each |&value| {
          set.insert(value);
        }
      }
      g2.pred.insert(k, set);
    }
    for self.succ.each |&k, v| {
      let map = ~mut LinearMap::new();
      /* TODO(purity): this shouldn't be unsafe */
      unsafe {
        for v.each |&k, v| {
          map.insert(k, e(v));
        }
      }
      g2.succ.insert(k, map);
    }
    return g2;
  }

  fn dot(&self, out: io::Writer,
         nid: &fn(NodeId) -> ~str,
         node: &fn(NodeId, &N) -> ~str,
         edge: &fn(&E) -> ~str) {
    for self.nodes.each |&id, n| {
      out.write_str(nid(id));
      out.write_str(~" [");
      out.write_str(node(id, n));
      out.write_str(~"];\n");
    }
    for self.succ.each |&id1, neighbors| {
      /* TODO(purity): this shouldn't be unsafe */
      unsafe {
        for neighbors.each |&id2, e| {
          out.write_str(nid(id1));
          out.write_str(~" -> ");
          out.write_str(nid(id2));
          out.write_str(~" [");
          out.write_str(edge(e));
          out.write_str(~"];\n");
        }
      }
    }
  }

  fn postorder(&self, root: NodeId) -> (~[NodeId], LinearMap<NodeId, int>) {
    let mut ordering = LinearMap::new();
    self.traverse(&mut ordering, root, 0);
    let mut v = ~[];
    vec::grow(&mut v, ordering.len(), &root);
    for ordering.each |&id, &pos| {
      v[pos] = id;
    }
    return (v, ordering);
  }

  fn traverse(&self, o: &mut LinearMap<NodeId, int>, n: NodeId, i: int) -> int {
    match o.find(&n) {
      Some(_) => i,
      None => {
        o.insert(n, -1);
        let mut next = i;
        let succ = self.succ.get(&n);
        /* TODO(purity): this shouldn't be unsafe */
        unsafe {
          for succ.each |&id, _| {
            next = self.traverse(o, id, next);
          }
        }
        o.insert(n, next);
        return next + 1;
      }
    }
  }
}

impl<N: Copy, E: Copy> Graph<N, E>: Index<NodeId, N> {
  pure fn index(&self, id: NodeId) -> N {
    self.node(id)
  }
}

#[test]
fn test_basic() {
  let mut g = Graph();
  let (n1, n2) = (g.new_id(), g.new_id());
  g.add_node(n1, 1);
  g.add_node(n2, 2);
  g.add_edge(n1, n2, 3);
  for g.each_succ_edge(n1) |n, e| {
    assert n == n2 && e == 3;
  }
  for g.each_node |id, &n| {
    if id == n1 {
      assert n == 1;
    } else if id == n2 {
      assert n == 2;
    } else {
      die!(~"bad id provided");
    }
  }
}

#[test]
#[should_fail]
fn test_random_id_fail() {
  let mut g = Graph::<int, int>();
  g.add_node(1, 1);
}

#[test]
#[should_fail]
fn test_same_id_fail() {
  let mut g = Graph::<int, int>();
  let id = g.new_id();
  g.add_node(id, 1);
  g.add_node(id, 1);
}
