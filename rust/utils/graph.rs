use core::hashmap::{HashMap, HashSet};

use core::io::WriterUtil;

pub type NodeId = uint;
pub type NodeSet = HashSet<NodeId>;

pub struct Graph<N, E> {
  priv nodes: HashMap<NodeId, N>,
  priv succ:  HashMap<NodeId, ~HashMap<NodeId, E>>,
  priv pred:  HashMap<NodeId, ~NodeSet>,
  priv next:  NodeId
}

pub fn Graph<N, E>() -> Graph<N, E>{
  Graph{ nodes: HashMap::new(),
         succ:  HashMap::new(),
         pred:  HashMap::new(),
         next:  0 }
}

pub impl<N, E> Graph<N, E> {
  fn num_nodes(&self) -> uint {
    self.nodes.len()
  }
  fn num_pred(&self, n: NodeId) -> uint {
    self.pred.get(&n).len()
  }
  fn num_succ(&self, n: NodeId) -> uint {
    self.succ.get(&n).len()
  }

  fn new_id(&mut self) -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.succ.insert(ret, ~HashMap::new());
    self.pred.insert(ret, ~HashSet::new());
    ret
  }

  fn contains(&self, id: NodeId) -> bool {
    self.nodes.contains_key(&id)
  }

  fn contains_edge(&self, a: NodeId, b: NodeId) -> bool {
    match self.succ.find(&a) { Some(m) => m.contains_key(&b), None => false }
  }

  fn nodes(&self) -> ~[NodeId] {
    let mut ret = ~[];
    for self.nodes.each_key |&n| {
      ret.push(n);
    }
    return ret;
  }

  fn node<'a>(&'a self, id: NodeId) -> &'a N {
    self.nodes.get(&id)
  }

  fn edge<'a>(&'a self, a: NodeId, b: NodeId) -> &'a E {
    self.succ.get(&a).get(&b)
  }

  fn add_node(&mut self, id: NodeId, n: N) {
    assert!(!self.nodes.contains_key(&id));
    assert!(self.succ.contains_key(&id));
    self.nodes.insert(id, n);
  }

  fn update_node(&mut self, id: NodeId, n: N) {
    /* may not be in 'nodes' due to 'pop_node' */
    assert!(self.succ.contains_key(&id));
    self.nodes.insert(id, n);
  }

  fn pop_node(&mut self, n: NodeId) -> N {
    self.nodes.pop(&n).unwrap()
  }

  fn remove_node(&mut self, n: NodeId) -> N {
    let ret = self.nodes.pop(&n);
    assert!(ret.is_some());
    let ret = ret.unwrap();
    let succ = self.succ.pop(&n).unwrap();
    let pred = self.pred.pop(&n).unwrap();
    for succ.each_key |k| {
      self.pred.find_mut(k).unwrap().remove(&n);
    }
    for pred.each |k| {
      self.succ.find_mut(k).unwrap().remove(&n);
    }
    return ret;
  }

  fn remove_edge(&mut self, n1: NodeId, n2: NodeId) -> E {
    self.pred.find_mut(&n2).unwrap().remove(&n1);
    return self.succ.find_mut(&n1).unwrap().pop(&n2).unwrap();
  }

  fn add_edge(&mut self, n1: NodeId, n2: NodeId, e: E) {
    self.succ.find_mut(&n1).unwrap().insert(n2, e);
    self.pred.find_mut(&n2).unwrap().insert(n1);
  }

  fn each_edge(&self, f: &fn(NodeId, NodeId) -> bool) {
    for self.succ.each |&a, map| {
      map.each_key(|&b| f(a, b));
    }
  }

  fn each_node(&self, f: &fn(NodeId, &N) -> bool) {
    self.succ.each(|&a, _| {
      match self.nodes.find(&a) {
        Some(b) => f(a, b),
        None => true
      }
    });
  }

  fn each_pred(&self, n: NodeId, f: &fn(NodeId) -> bool) {
    self.pred.get(&n).each(|&k| f(k));
  }

  fn each_pred_edge(&self, n: NodeId, f: &fn(NodeId, &E) -> bool) {
    self.pred.get(&n).each(|&k| f(k, self.edge(k, n)));
  }

  fn each_succ(&self, n: NodeId, f: &fn(NodeId) -> bool) {
    self.succ.get(&n).each_key(|&k| f(k));
  }

  fn each_succ_edge(&self, n: NodeId, f: &fn(NodeId, E) -> bool) {
    self.succ.get(&n).each(|&n, &e| f(n, e));
  }

  fn each_postorder(&self, root: NodeId, f: &fn(&NodeId) -> bool) {
    self.postorder(root).first().each(f)
  }

  fn each_rev_postorder(&self, root: NodeId, f: &fn(&NodeId) -> bool) {
    self.postorder(root).first().each_reverse(f);
  }

  fn map_nodes(&mut self, f: &fn(NodeId, N) -> N) {
    let mut keys = ~[];
    for self.nodes.each_key |&k| { keys.push(k); }
    for keys.each |&k| {
      self.map_consume_node(k, |n| f(k, n));
    }
  }

  fn map_consume_node(&mut self, id: NodeId, f: &fn(N) -> N) {
    let node = self.nodes.pop(&id).unwrap();
    self.nodes.insert(id, f(node));
  }

  fn map<N2, E2>(&self, n: &fn(NodeId, &N) -> N2,
                 e: &fn(&E) -> E2) -> Graph<N2, E2> {
    let mut g2 = Graph();
    g2.next = self.next;
    for self.nodes.each |&k, v| {
      g2.nodes.insert(k, n(k, v));
    }
    for self.pred.each |&k, v| {
      let mut set = ~HashSet::new();
      for v.each |&value| {
        set.insert(value);
      }
      g2.pred.insert(k, set);
    }
    for self.succ.each |&k, v| {
      let mut map = ~HashMap::new();
      for v.each |&k, v| {
        map.insert(k, e(v));
      }
      g2.succ.insert(k, map);
    }
    return g2;
  }

  fn dot(&self, out: @io::Writer,
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

  fn postorder(&self, root: NodeId) -> (~[NodeId], HashMap<NodeId, int>) {
    let mut ordering = HashMap::new();
    self.traverse(&mut ordering, root, 0);
    let mut v = ~[];
    vec::grow(&mut v, ordering.len(), &root);
    for ordering.each |&id, &pos| {
      v[pos] = id;
    }
    return (v, ordering);
  }

  fn traverse(&self, o: &mut HashMap<NodeId, int>, n: NodeId, i: int) -> int {
    match o.find(&n) {
      Some(_) => return i,
      None => ()
    }
    o.insert(n, -1);
    let mut next = i;
    for self.succ.get(&n).each |&id, _| {
      next = self.traverse(o, id, next);
    }
    o.insert(n, next);
    return next + 1;
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
    assert!(n == n2 && e == 3);
  }
  for g.each_node |id, &n| {
    if id == n1 {
      assert!(n == 1);
    } else if id == n2 {
      assert!(n == 2);
    } else {
      fail!(~"bad id provided");
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
