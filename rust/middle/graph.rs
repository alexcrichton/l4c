use io::WriterUtil;
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
  }

  pub fn dot(out : io::Writer,
             nid : &fn(&NodeId) -> ~str,
             node : &fn(&N) -> ~str,
             edge : &fn(&E) -> ~str) {
    for self.nodes.each_ref |id, n| {
      out.write_str(nid(id));
      out.write_str(~" [");
      out.write_str(node(n));
      out.write_str(~"];\n");
    }
    for self.adj.each_ref |id1, neighbors| {
      for neighbors.each_ref |id2, e| {
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
