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
  pub fn new_id() -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.succ.insert(ret, map::HashMap());
    self.pred.insert(ret, map::HashMap());
    ret
  }

  pub pure fn node(id : NodeId) -> N {
    self.nodes[id]
  }

  pub fn add_node(id : NodeId, n : N) {
    assert(!self.nodes.contains_key(id));
    assert(self.succ.contains_key(id));
    self.nodes.insert(id, n);
  }

  pub fn update_node(id : NodeId, n : N) {
    assert(self.nodes.contains_key(id));
    assert(self.succ.contains_key(id));
    self.nodes.insert(id, n);
  }

  pub fn remove_node(n : NodeId) {
    self.nodes.remove(n);
    for self.succ[n].each_key |k| {
      set::remove(self.pred[k], n);
    }
    for self.pred[n].each_key |k| {
      self.succ[k].remove(n);
    }
  }

  pub fn add_edge(n1 : NodeId, n2 : NodeId, e : E) {
    self.succ[n1].insert(n2, e);
    set::add(self.pred[n2], n1);
  }

  pub fn each_edge(n : NodeId, f : &fn(NodeId, &E) -> bool) {
    self.succ[n].each_ref(|&a, b| f(a, b))
  }

  pub fn each_node(f : &fn(NodeId, &N) -> bool) {
    self.nodes.each_ref(|&a, b| f(a, b));
  }

  pub fn each_pred(n : NodeId, f : &fn(NodeId) -> bool) {
    self.pred[n].each_key(f)
  }

  pub fn each_succ(n : NodeId, f : &fn(NodeId) -> bool) {
    self.succ[n].each_key(f)
  }

  pub fn dot(out : io::Writer,
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
  for g.each_edge(n1) |&n, &e| {
    assert n == n2 && e == 3;
  }
  for g.each_node |&id, &n| {
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
