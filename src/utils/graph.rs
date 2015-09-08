use std::collections::{HashMap, HashSet, hash_map, hash_set};
use std::io;
use std::mem;

use vec_map::{self, VecMap};

use utils::FnvState;

pub type NodeId = usize;
pub type NodeSet = HashSet<NodeId, FnvState>;

pub struct Graph<N, E> {
    nodes: VecMap<N>,
    succ:  VecMap<HashMap<NodeId, E>>,
    pred:  VecMap<NodeSet>,
    next:  NodeId
}

impl<N, E> Graph<N, E> {
    pub fn new() -> Graph<N, E>{
        Graph {
            nodes: VecMap::new(),
            succ: VecMap::new(),
            pred: VecMap::new(),
            next: 0,
        }
    }

    pub fn num_pred(&self, n: NodeId) -> usize {
        self.pred[&n].len()
    }

    pub fn num_succ(&self, n: NodeId) -> usize {
        self.succ[&n].len()
    }

    pub fn new_id(&mut self) -> NodeId {
        let ret = self.next;
        self.next += 1;
        self.succ.insert(ret, HashMap::default());
        self.pred.insert(ret, HashSet::default());
        ret
    }

    pub fn contains(&self, id: NodeId) -> bool {
        self.nodes.contains_key(&id)
    }

    pub fn contains_edge(&self, a: NodeId, b: NodeId) -> bool {
        match self.succ.get(&a) {
            Some(m) => m.contains_key(&b),
            None => false,
        }
    }

    pub fn node(&self, id: NodeId) -> &N {
        &self.nodes[&id]
    }

    pub fn node_mut(&mut self, id: NodeId) -> &mut N {
        self.nodes.get_mut(&id).unwrap()
    }

    pub fn edge(&self, a: NodeId, b: NodeId) -> &E {
        &self.succ[&a][&b]
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
        self.nodes.remove(&n).unwrap()
    }

    pub fn remove_node(&mut self, n: NodeId) -> N {
        let ret = self.nodes.remove(&n);
        assert!(ret.is_some());
        let ret = ret.unwrap();
        let succ = self.succ.remove(&n).unwrap();
        let pred = self.pred.remove(&n).unwrap();
        for (k, _) in succ.iter() {
            self.pred.get_mut(k).unwrap().remove(&n);
        }
        for k in pred.iter() {
            self.succ.get_mut(k).unwrap().remove(&n);
        }
        return ret;
    }

    pub fn remove_edge(&mut self, n1: NodeId, n2: NodeId) -> E {
        self.pred.get_mut(&n2).unwrap().remove(&n1);
        self.succ.get_mut(&n1).unwrap().remove(&n2).unwrap()
    }

    pub fn add_edge(&mut self, n1: NodeId, n2: NodeId, e: E) {
        self.succ.get_mut(&n1).unwrap().insert(n2, e);
        self.pred.get_mut(&n2).unwrap().insert(n1);
    }

    pub fn edges(&self) -> Edges<N, E> {
        Edges { _g: self, iter: self.succ.iter(), cur: None }
    }

    pub fn nodes(&self) -> Nodes<N, E> {
        Nodes { _g: self, iter: self.nodes.iter() }
    }

    pub fn preds(&self, n: NodeId) -> Preds<N, E> {
        Preds { _g: self, iter: self.pred[&n].iter() }
    }

    pub fn pred_edges(&self, n: NodeId) -> PredEdges<N, E> {
        PredEdges { g: self, src: n, iter: self.pred[&n].iter() }
    }

    pub fn succ(&self, n: NodeId) -> Succ<N, E> {
        Succ { _g: self, iter: self.succ[&n].iter() }
    }

    pub fn succ_edges(&self, n: NodeId) -> SuccEdges<N, E> {
        SuccEdges { _g: self, iter: self.succ[&n].iter() }
    }

    pub fn each_postorder(&self, root: NodeId, f: &mut FnMut(&NodeId)) {
        let (order, _) = self.postorder(root);
        for n in order.iter() { f(n) }
    }

    pub fn map_nodes(&mut self, f: &mut FnMut(NodeId, N) -> N) {
        let mut keys = Vec::new();
        for (k, _) in self.nodes.iter() {
            keys.push(k as NodeId);
        }
        for k in keys {
            self.map_consume_node(k, &mut |n| f(k, n));
        }
    }

    pub fn map_consume_node(&mut self, id: NodeId, f: &mut FnMut(N) -> N) {
        let node = self.nodes.remove(&id).unwrap();
        self.nodes.insert(id, f(node));
    }

    pub fn map<N2, E2>(self,
                       n: &mut FnMut(NodeId, N) -> N2,
                       e: &mut FnMut(E) -> E2) -> Graph<N2, E2> {
        let mut this = self;
        let mut g2 = Graph::new();
        g2.next = this.next;
        for (k, v) in this.nodes {
            g2.nodes.insert(k, n(k as NodeId, v));
        }
        mem::swap(&mut this.pred, &mut g2.pred);
        for (k, v) in this.succ {
            let mut map = HashMap::new();
            for (k, v) in v {
                map.insert(k, e(v));
            }
            g2.succ.insert(k, map);
        }
        return g2;
    }

    pub fn dot(&self, out: &mut io::Write,
               nid: &mut FnMut(NodeId) -> String,
               node: &mut FnMut(NodeId, &N) -> String,
               edge: &mut FnMut(&E) -> String) -> io::Result<()> {
        for (id, n) in self.nodes.iter() {
            try!(out.write_all(nid(id as NodeId).as_bytes()));
            try!(out.write_all(b" ["));
            try!(out.write_all(node(id as NodeId, n).as_bytes()));
            try!(out.write_all(b"];\n"));
        }
        for (id1, neighbors) in self.succ.iter() {
            for (&id2, e) in neighbors.iter() {
                try!(out.write_all(nid(id1 as NodeId).as_bytes()));
                try!(out.write_all(b" -> "));
                try!(out.write_all(nid(id2).as_bytes()));
                try!(out.write_all(b" ["));
                try!(out.write_all(edge(e).as_bytes()));
                try!(out.write_all(b"];\n"));
            }
        }
        Ok(())
    }

    pub fn postorder(&self, root: NodeId) -> (Vec<NodeId>, VecMap<i32>) {
        let mut ordering = VecMap::new();
        self.traverse(&mut ordering, root, 0);
        let mut v = vec![root; ordering.len()];
        for (id, &pos) in ordering.iter() {
            v[pos as usize] = id as NodeId;
        }
        return (v, ordering);
    }

    fn traverse(&self, o: &mut VecMap<i32>,
                n: NodeId, i: i32) -> i32 {
        match o.get(&n) {
            Some(_) => return i,
            None => ()
        }
        o.insert(n, -1);
        let mut next = i;
        for (&id, _) in self.succ[&n].iter() {
            next = self.traverse(o, id, next);
        }
        o.insert(n, next);
        return next + 1;
    }
}

// Iterators for the graph

pub struct Nodes<'a, N: 'a, E: 'a> {
    _g: &'a Graph<N, E>,
    iter: vec_map::Iter<'a, N>,
}

impl<'a, N, E> Iterator for Nodes<'a, N, E> {
    type Item = (NodeId, &'a N);

    fn next(&mut self) -> Option<(NodeId, &'a N)> {
        self.iter.next().map(|(a, b)| (a as NodeId, b))
    }
}

pub struct Edges<'a, N: 'a, E: 'a> {
    _g: &'a Graph<N, E>,
    iter: vec_map::Iter<'a, HashMap<NodeId, E>>,
    cur: Option<(NodeId, hash_map::Iter<'a, NodeId, E>)>,
}

impl<'a, N, E> Iterator for Edges<'a, N, E> {
    type Item = (NodeId, NodeId);
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
                Some((a, b)) => { self.cur = Some((a as NodeId, b.iter())); }
                None => { return None; }
            }
        }
    }
}

pub struct Preds<'a, N: 'a, E: 'a> {
    _g: &'a Graph<N, E>,
    iter: hash_set::Iter<'a, NodeId>,
}

impl<'a, N, E> Iterator for Preds<'a, N, E> {
    type Item = NodeId;

    fn next(&mut self) -> Option<NodeId> {
        self.iter.next().map(|&k| k)
    }
}

pub struct Succ<'a, N: 'a, E: 'a> {
    _g: &'a Graph<N, E>,
    iter: hash_map::Iter<'a, NodeId, E>,
}

impl<'a, N, E> Iterator for Succ<'a, N, E> {
    type Item = NodeId;

    fn next(&mut self) -> Option<NodeId> {
        self.iter.next().map(|(&k, _)| k)
    }
}

pub struct SuccEdges<'a, N: 'a, E: 'a> {
    _g: &'a Graph<N, E>,
    iter: hash_map::Iter<'a, NodeId, E>,
}

impl<'a, N, E> Iterator for SuccEdges<'a, N, E> {
    type Item = (NodeId, &'a E);

    fn next(&mut self) -> Option<(NodeId, &'a E)> {
        self.iter.next().map(|(&n, e)| (n, e))
    }
}

pub struct PredEdges<'a, N: 'a, E: 'a> {
    g: &'a Graph<N, E>,
    src: NodeId,
    iter: hash_set::Iter<'a, NodeId>
}

impl<'a, N, E> Iterator for PredEdges<'a, N, E> {
    type Item = (NodeId, &'a E);
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
            panic!("bad id provided");
        }
    }
}

#[test]
#[should_panic]
fn test_random_id_fail() {
    let mut g = Graph::<i32, i32>();
    g.add_node(1, 1);
}

#[test]
#[should_panic]
fn test_same_id_fail() {
    let mut g = Graph::<i32, i32>();
    let id = g.new_id();
    g.add_node(id, 1);
    g.add_node(id, 1);
}
