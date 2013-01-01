use io::WriterUtil;
use std::map;

pub type NodeId = uint;
pub type NodeSet = map::Set<NodeId>;

pub struct Graph<N, E> {
  priv nodes : map::HashMap<NodeId, N>,
  priv succ  : map::HashMap<NodeId, map::HashMap<NodeId, E>>,
  priv pred  : map::HashMap<NodeId, NodeSet>,
  priv mut next : NodeId
}

pub fn Graph<N : Copy, E : Copy>() -> Graph<N, E>{
  Graph{ nodes: map::HashMap(),
         succ:   map::HashMap(),
         pred:  map::HashMap(),
         next:  0 }
}

impl<N : Copy, E : Copy> Graph<N, E> {
  fn num_nodes() -> uint {
    self.nodes.size()
  }
  fn num_pred(n : NodeId) -> uint {
    self.pred[n].size()
  }
  fn num_succ(n : NodeId) -> uint {
    self.succ[n].size()
  }

  fn new_id() -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.succ.insert(ret, map::HashMap());
    self.pred.insert(ret, map::HashMap());
    ret
  }

  pure fn node(id : NodeId) -> N {
    self.nodes[id]
  }

  pure fn edge(a : NodeId, b : NodeId) -> E {
    self.succ[a][b]
  }

  fn add_node(id : NodeId, n : N) {
    assert(!self.nodes.contains_key(id));
    assert(self.succ.contains_key(id));
    self.nodes.insert(id, n);
  }

  fn update_node(id : NodeId, n : N) {
    assert(self.nodes.contains_key(id));
    assert(self.succ.contains_key(id));
    self.nodes.insert(id, n);
  }

  fn remove_node(n : NodeId) {
    assert self.nodes.remove(n);
    for self.succ[n].each_key |k| {
      assert set::remove(self.pred[k], n);
    }
    for self.pred[n].each_key |k| {
      assert self.succ[k].remove(n);
    }
    assert self.succ.remove(n);
    assert self.pred.remove(n);
  }

  fn remove_edge(n1 : NodeId, n2 : NodeId) -> E {
    let e = self.succ[n1][n2];
    assert set::remove(self.pred[n2], n1);
    assert self.succ[n1].remove(n2);
    return e;
  }

  fn add_edge(n1 : NodeId, n2 : NodeId, e : E) {
    self.succ[n1].insert(n2, e);
    set::add(self.pred[n2], n1);
  }

  fn each_edge(f : &fn(NodeId, NodeId) -> bool) {
    for self.succ.each |a, map| {
      for map.each_key |b| {
        f(a, b);
      }
    }
  }

  fn each_node(f : &fn(NodeId, &N) -> bool) {
    self.nodes.each_ref(|&a, b| f(a, b));
  }

  fn each_pred(n : NodeId, f : &fn(NodeId) -> bool) {
    self.pred[n].each_key(f)
  }

  fn each_succ(n : NodeId, f : &fn(NodeId) -> bool) {
    self.succ[n].each_key(f)
  }

  fn each_succ_edge(n : NodeId, f : &fn(NodeId, E) -> bool) {
    self.succ[n].each(f);
  }

  fn each_postorder(root : NodeId, f : &fn(&NodeId) -> bool) {
    let (order, _) = self.postorder(root);
    order.each(f);
  }

  fn each_rev_postorder(root : NodeId, f : &fn(&NodeId) -> bool) {
    let (order, _) = self.postorder(root);
    vec::rev_each(order, f);
  }

  priv fn dup<V : Copy, V2 : Copy>
    (m : map::HashMap<NodeId, V>, f : &fn(&V) -> V2) -> map::HashMap<NodeId, V2>
  {
    let ret = map::HashMap();
    for m.each_ref |&k, v| {
      ret.insert(k, f(v));
    }
    return ret;
  }

  fn map<N2 : Copy, E2 : Copy>(n : &fn(&N) -> N2,
                               e : &fn(&E) -> E2) -> Graph<N2, E2> {
    let g2 = Graph();
    g2.next = self.next;
    for self.nodes.each_ref |&k, v| {
      g2.nodes.insert(k, n(v));
    }
    for self.pred.each |k, v| {
      g2.pred.insert(k, self.dup(v, |&x| x));
    }
    for self.succ.each |k, v| {
      g2.succ.insert(k, self.dup(v, e));
    }
    return g2;
  }

  fn dot(out : io::Writer,
             nid : &fn(NodeId) -> ~str,
             node : &fn(NodeId, &N) -> ~str,
             edge : &fn(&E) -> ~str) {
    for self.nodes.each_ref |&id, n| {
      out.write_str(nid(id));
      out.write_str(~" [");
      out.write_str(node(id, n));
      out.write_str(~"];\n");
    }
    for self.succ.each_ref |&id1, neighbors| {
      for neighbors.each_ref |&id2, e| {
        out.write_str(nid(id1));
        out.write_str(~" -> ");
        out.write_str(nid(id2));
        out.write_str(~" [");
        out.write_str(edge(e));
        out.write_str(~"];\n");
      }
    }
  }

  fn traverse(o : map::HashMap<NodeId, int>, n : NodeId, i : int) -> int {
    match o.find(n) {
      Some(_) => i,
      None => {
        o.insert(n, -1);
        let mut next = i;
        for self.succ[n].each |id, _| {
          next = self.traverse(o, id, next);
        }
        o.insert(n, next);
        return next + 1;
      }
    }
  }

  fn postorder(root : NodeId) -> (~[NodeId], map::HashMap<NodeId, int>) {
    let ordering = map::HashMap();
    self.traverse(ordering, root, 0);
    let mut v = ~[];
    vec::grow(&mut v, ordering.size(), &root);
    for ordering.each |id, pos| {
      v[pos] = id;
    }
    return (v, ordering);
  }
}

impl<N : Copy, E : Copy> Graph<N, E> : Index<graph::NodeId, N> {
  pure fn index(&self, id : graph::NodeId) -> N {
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
  for g.each_edge(n1) |n, &e| {
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
