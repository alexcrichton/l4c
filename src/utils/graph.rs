use std::iter;
use std::io;
use std::mem;

use hm = collections::hashmap;
use sm = collections::smallintmap;

pub type NodeId = uint;
pub type NodeSet = hm::HashSet<NodeId>;

pub struct Graph<N, E> {
    nodes: sm::SmallIntMap<N>,
    succ:  sm::SmallIntMap<Box<hm::HashMap<NodeId, E>>>,
    pred:  sm::SmallIntMap<Box<NodeSet>>,
    next:  NodeId
}

pub fn Graph<N, E>() -> Graph<N, E>{
    Graph { nodes: sm::SmallIntMap::new(),
            succ:  sm::SmallIntMap::new(),
            pred:  sm::SmallIntMap::new(),
            next:  0, }
}

impl<N, E> Graph<N, E> {
    pub fn num_pred(&self, n: NodeId) -> uint {
        self.pred.get(&n).len()
    }

    pub fn num_succ(&self, n: NodeId) -> uint {
        self.succ.get(&n).len()
    }

    pub fn new_id(&mut self) -> NodeId {
        let ret = self.next;
        self.next += 1;
        self.succ.insert(ret, box hm::HashMap::new());
        self.pred.insert(ret, box hm::HashSet::new());
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

    pub fn nodes<'a>(&'a self) -> sm::Entries<'a, N> {
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

    pub fn each_postorder(&self, root: NodeId, f: |&NodeId|) {
        let (order, _) = self.postorder(root);
        for n in order.iter() { f(n) }
    }

    pub fn map_nodes(&mut self, f: |NodeId, N| -> N) {
        let mut keys = Vec::new();
        for (k, _) in self.nodes.iter() { keys.push(k); }
        for k in keys.move_iter() {
            self.map_consume_node(k, |n| f(k, n));
        }
    }

    pub fn map_consume_node(&mut self, id: NodeId, f: |N| -> N) {
        let node = self.nodes.pop(&id).unwrap();
        self.nodes.insert(id, f(node));
    }

    pub fn map<N2, E2>(self, n: |NodeId, N| -> N2,
                       e: |E| -> E2) -> Graph<N2, E2> {
        let mut this = self;
        let mut g2 = Graph();
        g2.next = this.next;
        for (k, v) in this.nodes.move_iter() {
            g2.nodes.insert(k, n(k, v));
        }
        mem::swap(&mut this.pred, &mut g2.pred);
        for (k, v) in this.succ.move_iter() {
            let mut map = box hm::HashMap::new();
            for (k, v) in v.move_iter() {
                map.insert(k, e(v));
            }
            g2.succ.insert(k, map);
        }
        return g2;
    }

    pub fn dot(&self, out: &mut io::Writer,
               nid: |NodeId| -> String,
               node: |NodeId, &N| -> String,
               edge: |&E| -> String) -> io::IoResult<()> {
        for (id, n) in self.nodes.iter() {
            try!(out.write_str(nid(id)));
            try!(out.write_str(" ["));
            try!(out.write_str(node(id, n)));
            try!(out.write_str("];\n"));
        }
        for (id1, neighbors) in self.succ.iter() {
            for (&id2, e) in neighbors.iter() {
                try!(out.write_str(nid(id1)));
                try!(out.write_str(" -> "));
                try!(out.write_str(nid(id2)));
                try!(out.write_str(" ["));
                try!(out.write_str(edge(e)));
                try!(out.write_str("];\n"));
            }
        }
        Ok(())
    }

    pub fn postorder(&self, root: NodeId) -> (Vec<NodeId>, sm::SmallIntMap<int>) {
        let mut ordering = sm::SmallIntMap::new();
        self.traverse(&mut ordering, root, 0);
        let mut v = Vec::new();
        v.grow(ordering.len(), &root);
        for (id, &pos) in ordering.iter() {
            v[pos as uint] = id;
        }
        return (v, ordering);
    }

    fn traverse(&self, o: &mut sm::SmallIntMap<int>,
                n: NodeId, i: int) -> int {
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

pub struct EdgeIterator<'a, N, E> {
    g: &'a Graph<N, E>,
    iter: sm::Entries<'a, Box<hm::HashMap<NodeId, E>>>,
    cur: Option<(NodeId, hm::Entries<'a, NodeId, E>)>,
}

impl<'a, N, E> Iterator<(NodeId, NodeId)> for EdgeIterator<'a, N, E> {
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

type PredIterator<'a> =
    iter::Map<'a, &'a NodeId, NodeId, hm::SetItems<'a, NodeId>>;
type SuccIterator<'a, E> =
    iter::Map<'a, (&'a NodeId, &'a E), NodeId,
              hm::Entries<'a, NodeId, E>>;
type SuccEdgeIterator<'a, E> =
    iter::Map<'a, (&'a NodeId, &'a E), (NodeId, &'a E),
              hm::Entries<'a, NodeId, E>>;

pub struct PredEdgeIterator<'a, N, E> {
    g: &'a Graph<N, E>,
    src: NodeId,
    iter: hm::SetItems<'a, NodeId>
}

impl<'a, N, E> Iterator<(NodeId, &'a E)> for PredEdgeIterator<'a, N, E> {
    fn next(&mut self) -> Option<(NodeId, &'a E)> {
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
    for (n, &e) in g.succ_edges(n1) {
        assert!(n == n2 && e == 3);
    }
    for (id, &n) in g.nodes() {
        if id == n1 {
            assert!(n == 1);
        } else if id == n2 {
            assert!(n == 2);
        } else {
            fail!("bad id provided");
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
