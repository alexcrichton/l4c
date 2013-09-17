use std::iter;
use std::hashmap::{HashMap, HashSet, HashMapIterator, HashSetIterator};
use std::io::WriterUtil;
use std::io;
use std::util;

use extra::smallintmap::{SmallIntMap, SmallIntMapIterator};

pub type NodeId = uint;
pub type NodeSet = HashSet<NodeId>;

pub struct Graph<N, E> {
  priv nodes: SmallIntMap<N>,
  priv succ:  SmallIntMap<~HashMap<NodeId, E>>,
  priv pred:  SmallIntMap<~NodeSet>,
  priv next:  NodeId
}

pub fn Graph<N, E>() -> Graph<N, E>{
  Graph{ nodes: SmallIntMap::new(),
         succ:  SmallIntMap::new(),
         pred:  SmallIntMap::new(),
         next:  0 }
}

impl<N, E> Graph<N, E> {
  pub fn num_nodes(&self) -> uint {
    self.nodes.len()
  }
  pub fn num_pred(&self, n: NodeId) -> uint {
    self.pred.get(&n).len()
  }
  pub fn num_succ(&self, n: NodeId) -> uint {
    self.succ.get(&n).len()
  }

  pub fn new_id(&mut self) -> NodeId {
    let ret = self.next;
    self.next += 1;
    self.succ.insert(ret, ~HashMap::new());
    self.pred.insert(ret, ~HashSet::new());
    ret
  }

  pub fn contains(&self, id: NodeId) -> bool {
    self.nodes.contains_key(&id)
  }

  pub fn contains_edge(&self, a: NodeId, b: NodeId) -> bool {
    match self.succ.find(&a) { Some(m) => m.contains_key(&b), None => false }
  }

  pub fn node<'a>(&'a self, id: NodeId) -> &'a N {
    self.nodes.get(&id)
  }

  pub fn node_mut<'a>(&'a mut self, id: NodeId) -> &'a mut N {
    self.nodes.find_mut(&id).unwrap()
  }

  pub fn edge<'a>(&'a self, a: NodeId, b: NodeId) -> &'a E {
    self.succ.get(&a).get(&b)
  }

  pub fn add_node(&mut self, id: NodeId, n: N) {
    assert!(!self.nodes.contains_key(&id));
    assert!(self.succ.contains_key(&id));
    self.nodes.insert(id, n);
  }

  pub fn update_node(&mut self, id: NodeId, n: N) {
    /* may not be in 'nodes' due to 'pop_node' */
    assert!(self.succ.contains_key(&id));
    self.nodes.insert(id, n);
  }

  pub fn pop_node(&mut self, n: NodeId) -> N {
    self.nodes.pop(&n).unwrap()
  }

  pub fn remove_node(&mut self, n: NodeId) -> N {
    let ret = self.nodes.pop(&n);
    assert!(ret.is_some());
    let ret = ret.unwrap();
    let succ = self.succ.pop(&n).unwrap();
    let pred = self.pred.pop(&n).unwrap();
    for (k, _) in succ.iter() {
      self.pred.find_mut(k).unwrap().remove(&n);
    }
    for k in pred.iter() {
      self.succ.find_mut(k).unwrap().remove(&n);
    }
    return ret;
  }

  pub fn remove_edge(&mut self, n1: NodeId, n2: NodeId) -> E {
    self.pred.find_mut(&n2).unwrap().remove(&n1);
    return self.succ.find_mut(&n1).unwrap().pop(&n2).unwrap();
  }

  pub fn add_edge(&mut self, n1: NodeId, n2: NodeId, e: E) {
    self.succ.find_mut(&n1).unwrap().insert(n2, e);
    self.pred.find_mut(&n2).unwrap().insert(n1);
  }

  pub fn edges<'a>(&'a self) -> EdgeIterator<'a, N, E> {
    EdgeIterator { g: self, iter: self.succ.iter(), cur: None }
  }

  pub fn nodes<'a>(&'a self) -> SmallIntMapIterator<'a, N> {
    self.nodes.iter()
  }

  pub fn preds<'a>(&'a self, n: NodeId) -> PredIterator<'a> {
    self.pred.get(&n).iter().map(|&k| k)
  }

  pub fn pred_edges<'a>(&'a self, n: NodeId) -> PredEdgeIterator<'a, N, E> {
    PredEdgeIterator { g: self, src: n, iter: self.pred.get(&n).iter() }
  }

  pub fn succ<'a>(&'a self, n: NodeId) -> SuccIterator<'a, E> {
    self.succ.get(&n).iter().map(|(&k, _)| k)
  }

  pub fn succ_edges<'a>(&'a self, n: NodeId) -> SuccEdgeIterator<'a, E> {
    self.succ.get(&n).iter().map(|(&n, e)| (n, e))
  }

  pub fn each_postorder(&self, root: NodeId, f: &fn(&NodeId)) {
    let (order, _) = self.postorder(root);
    for n in order.iter() { f(n) }
  }

  pub fn each_rev_postorder(&self, root: NodeId, f: &fn(&NodeId)) {
    let (ord, _) = self.postorder(root);
    for n in ord.rev_iter() { f(n) }
  }

  pub fn map_nodes(&mut self, f: &fn(NodeId, N) -> N) {
    let mut keys = ~[];
    for (k, _) in self.nodes.iter() { keys.push(k); }
    for k in keys.move_iter() {
      self.map_consume_node(k, |n| f(k, n));
    }
  }

  pub fn map_consume_node(&mut self, id: NodeId, f: &fn(N) -> N) {
    let node = self.nodes.pop(&id).unwrap();
    self.nodes.insert(id, f(node));
  }

  pub fn map<N2, E2>(self, n: &fn(NodeId, N) -> N2,
                     e: &fn(E) -> E2) -> Graph<N2, E2> {
    let mut this = self;
    let mut g2 = Graph();
    g2.next = this.next;
    for (k, v) in this.nodes.move_iter() {
      g2.nodes.insert(k, n(k, v));
    }
    util::swap(&mut this.pred, &mut g2.pred);
    for (k, v) in this.succ.move_iter() {
      let mut map = ~HashMap::new();
      for (k, v) in v.move_iter() {
        map.insert(k, e(v));
      }
      g2.succ.insert(k, map);
    }
    return g2;
  }

  pub fn dot(&self, out: @io::Writer,
             nid: &fn(NodeId) -> ~str,
             node: &fn(NodeId, &N) -> ~str,
             edge: &fn(&E) -> ~str) {
    for (id, n) in self.nodes.iter() {
      out.write_str(nid(id));
      out.write_str(" [");
      out.write_str(node(id, n));
      out.write_str("];\n");
    }
    for (id1, neighbors) in self.succ.iter() {
      for (&id2, e) in neighbors.iter() {
        out.write_str(nid(id1));
        out.write_str(" -> ");
        out.write_str(nid(id2));
        out.write_str(" [");
        out.write_str(edge(e));
        out.write_str("];\n");
      }
    }
  }

  pub fn postorder(&self, root: NodeId) -> (~[NodeId], SmallIntMap<int>) {
    let mut ordering = SmallIntMap::new();
    self.traverse(&mut ordering, root, 0);
    let mut v = ~[];
    v.grow(ordering.len(), &root);
    for (id, &pos) in ordering.iter() {
      v[pos] = id;
    }
    return (v, ordering);
  }

  pub fn traverse(&self, o: &mut SmallIntMap<int>, n: NodeId, i: int) -> int {
    match o.find(&n) {
      Some(_) => return i,
      None => ()
    }
    o.insert(n, -1);
    let mut next = i;
    for (&id, _) in self.succ.get(&n).iter() {
      next = self.traverse(o, id, next);
    }
    o.insert(n, next);
    return next + 1;
  }
}

// Iterators for the graph

struct EdgeIterator<'self, N, E> {
  priv g: &'self Graph<N, E>,
  priv iter: SmallIntMapIterator<'self, ~HashMap<NodeId, E>>,
  priv cur: Option<(NodeId, HashMapIterator<'self, NodeId, E>)>,
}

impl<'self, N, E> Iterator<(NodeId, NodeId)> for EdgeIterator<'self, N, E> {
  fn next(&mut self) -> Option<(NodeId, NodeId)> {
    loop {
      match self.cur {
        Some((src, ref mut iter)) => {
          match iter.next() {
            Some((&dst, _)) => { return Some((src, dst)); }
            None => {}
          }
        }
        None => {}
      }

      match self.iter.next() {
        Some((a, b)) => { self.cur = Some((a, b.iter())); }
        None => { return None; }
      }
    }
  }
}

type PredIterator<'self> =
    iter::Map<'self, &'self NodeId, NodeId, HashSetIterator<'self, NodeId>>;
type SuccIterator<'self, E> =
    iter::Map<'self, (&'self NodeId, &'self E), NodeId,
                  HashMapIterator<'self, NodeId, E>>;
type SuccEdgeIterator<'self, E> =
    iter::Map<'self, (&'self NodeId, &'self E), (NodeId, &'self E),
                  HashMapIterator<'self, NodeId, E>>;
struct PredEdgeIterator<'self, N, E> {
  priv g: &'self Graph<N, E>,
  priv src: NodeId,
  priv iter: HashSetIterator<'self, NodeId>
}

impl<'self, N, E> Iterator<(NodeId, &'self E)> for PredEdgeIterator<'self, N, E> {
  fn next(&mut self) -> Option<(NodeId, &'self E)> {
    match self.iter.next() {
      Some(&k) => Some((k, self.g.edge(k, self.src))),
      None => None
    }
  }
}

#[test]
fn test_basic() {
  let mut g = Graph();
  let (n1, n2) = (g.new_id(), g.new_id());
  g.add_node(n1, 1);
  g.add_node(n2, 2);
  g.add_edge(n1, n2, 3);
  for (n, &e) in g.each_succ_edge(n1) {
    assert!(n == n2 && e == 3);
  }
  for (id, &n) in g.nodes() {
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
