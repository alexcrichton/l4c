use core::hashmap::linear::{LinearMap, LinearSet};

use io::WriterUtil;
use utils::set;

pub type NodeId = uint;
pub type NodeSet = LinearSet<NodeId>;

pub struct Graph<N, E> {
  priv nodes : LinearMap<NodeId, N>,
  priv succ  : LinearMap<NodeId, LinearMap<NodeId, E>>,
  priv pred  : LinearMap<NodeId, NodeSet>,
  priv next : NodeId
}

pub fn Graph<N : Copy, E : Copy>() -> Graph<N, E>{
  Graph{ nodes: LinearMap::new(),
         succ:  LinearMap::new(),
         pred:  LinearMap::new(),
         next:  0 }
}

impl<N : Copy, E : Copy> Graph<N, E> {
  pure fn num_nodes() -> uint {
    self.nodes.len()
  }
  pure fn num_pred(n: NodeId) -> uint {
    self.pred.get(&n).len()
  }
  pure fn num_succ(n: NodeId) -> uint {
    self.succ.get(&n).len()
  }

  fn new_id(&mut self) -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.succ.insert(ret, LinearMap::new());
    self.pred.insert(ret, LinearSet::new());
    ret
  }

  pure fn node(&self, id: NodeId) -> N {
    *self.nodes.get(&id)
  }

  pure fn edge(&self, a: NodeId, b: NodeId) -> E {
    *self.succ.get(&a).get(&b)
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
    for self.succ.get(&n).each_key |k| {
      assert self.pred.get(k).remove(&n)
    }
    for self.pred.get(&n).each |k| {
      assert self.succ.get(k).remove(&n);
    }
    assert self.succ.remove(&n);
    assert self.pred.remove(&n);
  }

  fn remove_edge(&mut self, n1: NodeId, n2: NodeId) -> E {
    assert self.pred.get(&n2).remove(&n1);
    return self.succ.get(&n1).pop(&n1).get();
  }

  fn add_edge(&mut self, n1: NodeId, n2: NodeId, e: E) {
    self.succ.get(&n1).insert(n2, e);
    self.pred.get(&n2).insert(n1);
  }

  pure fn each_edge(&self, f: fn(NodeId, NodeId) -> bool) {
    for self.succ.each |&a, map| {
      map.each_key(|&b| f(a, b));
    }
  }

  pure fn each_node(&self, f: fn(NodeId, &N) -> bool) {
    self.nodes.each(|&a, b| f(a, b));
  }

  pure fn each_pred(&self, n: NodeId, f: fn(NodeId) -> bool) {
    self.pred.get(&n).each(|&k| f(k));
  }

  pure fn each_succ(&self, n: NodeId, f: fn(NodeId) -> bool) {
    self.succ.get(&n).each_key(|&k| f(k));
  }

  pure fn each_succ_edge(&self, n: NodeId, f: fn(NodeId, E) -> bool) {
    self.succ.get(&n).each(|&n, &e| f(n, e));
  }

  fn each_postorder(&self, root: NodeId, f: fn(&NodeId) -> bool) {
    let (order, _) = self.postorder(root);
    order.each(f);
  }

  fn each_rev_postorder(&self, root: NodeId, f: fn(&NodeId) -> bool) {
    let (order, _) = self.postorder(root);
    vec::rev_each(order, f);
  }

  fn map<N2 : Copy, E2 : Copy>(n : fn(NodeId, &N) -> N2,
                               e : fn(&E) -> E2) -> Graph<N2, E2> {
    let g2 = Graph();
    g2.next = self.next;
    for self.nodes.each |&k, v| {
      g2.nodes.insert(k, n(k, v));
    }
    for self.pred.each |&k, v| {
      let set = LinearSet::new();
      for v.each |&value| {
        set.insert(value);
      }
      g2.pred.insert(k, set);
    }
    for self.succ.each |&k, v| {
      let map = LinearMap::new();
      for v.each |&k, v| {
        map.insert(k, e(v));
      }
      g2.succ.insert(k, map);
    }
    return g2;
  }

  fn dot(out : io::Writer,
             nid : &fn(NodeId) -> ~str,
             node : &fn(NodeId, &N) -> ~str,
             edge : &fn(&E) -> ~str) {
    for self.nodes.each |&id, n| {
      out.write_str(nid(id));
      out.write_str(~" [");
      out.write_str(node(id, n));
      out.write_str(~"];\n");
    }
    for self.succ.each |&id1, neighbors| {
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

  fn postorder(root : NodeId) -> (~[NodeId], LinearMap<NodeId, int>) {
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
        for self.succ.get(&n).each |&id, _| {
          next = self.traverse(o, id, next);
        }
        o.insert(n, next);
        return next + 1;
      }
    }
  }
}

impl<N : Copy, E : Copy> Graph<N, E> : Index<NodeId, N> {
  pure fn index(&self, id : NodeId) -> N {
    self.node(id)
  }
}

#[test]
fn test_basic() {
  let g = Graph();
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
      fail(~"bad id provided");
    }
  }
}

#[test]
#[should_fail]
fn test_random_id_fails() {
  let g = Graph::<int, int>();
  g.add_node(1, 1);
}

#[test]
#[should_fail]
fn test_same_id_fails() {
  let g = Graph::<int, int>();
  let id = g.new_id();
  g.add_node(id, 1);
  g.add_node(id, 1);
}
