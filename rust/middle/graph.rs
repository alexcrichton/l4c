use std::map;

pub type NodeId = uint;

pub struct Graph<N, E> {
  priv nodes : map::HashMap<NodeId, N>,
  priv adj   : map::HashMap<NodeId, map::HashMap<NodeId, E>>,
  priv mut next : NodeId
}

pub fn Graph<N : Copy, E : Copy>() -> Graph<N, E>{
  Graph{ nodes: map::HashMap(),
         adj:   map::HashMap(),
         next:  0 }
}

impl<N : Copy, E : Copy> Graph<N, E> {
  pub fn new_id() -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.adj.insert(ret, map::HashMap());
    ret
  }

  pub fn add_node(id : NodeId, n : N) {
    assert(!self.nodes.contains_key(id));
    assert(self.adj.contains_key(id));
    self.nodes.insert(id, n);
  }

  pub fn add_edge(n1 : NodeId, n2 : NodeId, e : E) {
    self.adj.get(n1).insert(n2, e);
    self.adj.get(n2).insert(n1, e);
  }

  pub fn each_edge(n : NodeId, f : &fn(id : &NodeId, e : &E) -> bool) {
    self.adj.get(n).each_ref(f);
  }

  pub fn each_node(f : &fn(id : &NodeId, n : &N) -> bool) {
    self.nodes.each_ref(f);
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
