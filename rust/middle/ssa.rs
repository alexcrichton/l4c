use std::map;
use middle::temp::Temp;
use tmap = std::fun_treemap;

pub trait Statement : PrettyPrint {
  fn each_def<T>(&fn(Temp) -> T);
  fn each_use<T>(&fn(Temp) -> T);
  fn each_spill<T>(&fn(uint) -> T);
  fn each_reload<T>(&fn(uint) -> T);
  fn map_temps(@self, u: &fn(Temp) -> Temp, d: &fn(Temp) -> Temp) -> @self;
  fn phi_map() -> Option<PhiMap>;
}

type TempMap = tmap::Treemap<Temp, Temp>;
type DomFrontiers = map::HashMap<graph::NodeId, graph::NodeSet>;
pub type Idominators = map::HashMap<graph::NodeId, graph::NodeId>;
pub type Idominated = map::HashMap<graph::NodeId, map::Set<graph::NodeId>>;
pub type PhiMap = map::HashMap<graph::NodeId, Temp>;
pub type CFG<T> = graph::Graph<@~[@T], ir::Edge>;

struct Converter<T> {
  cfg : &CFG<T>,
  root : graph::NodeId,

  /* Mapping of temps to the set of nodes that the temp is defined in */
  defs : map::HashMap<Temp, graph::NodeSet>,
  /* Mapping of a node id to the temps which need phis at that node */
  phis : map::HashMap<graph::NodeId, map::Set<Temp>>,
  /* Once a phi is at a node, contains mappings of old temp => new temp */
  phi_temps : map::HashMap<graph::NodeId, map::HashMap<Temp, Temp>>,
  /* Mapping of a node to what temp mappings exist at the end of a node */
  versions : map::HashMap<graph::NodeId, TempMap>,
  /* (re-)Allocator for temps */
  temps : temp::Allocator,
  /* idoms[a] = b => immediate dominator of a is b */
  idoms : Idominators,
  /* idoms[a] = b => all elements of b are immeidately dominated by a */
  idominated : Idominated,

  /* callback to invoke whenever altering a temp's name */
  remap : @fn(Temp, Temp),
  /* callback for creating phi functions */
  phi_maker : @fn(Temp, PhiMap) -> @T,
}

pub fn convert<T : Statement>(cfg : &CFG<T>,
                              root : graph::NodeId, live_in : &[Temp],
                              remap : @fn(Temp, Temp),
                              phi : @fn(Temp, PhiMap) -> @T) -> Idominated {
  let converter = Converter { cfg: cfg,
                              root: root,
                              defs: map::HashMap(),
                              phis: map::HashMap(),
                              phi_temps : map::HashMap(),
                              versions: map::HashMap(),
                              temps: temp::new(),
                              idoms: map::HashMap(),
                              idominated: map::HashMap(),
                              remap: remap,
                              phi_maker: phi };
  converter.convert(live_in);
  return converter.idominated;
}

impl<T : Statement> Converter<T> {
  fn convert(live_in : &[Temp]) {
    /* prepare the graph */
    self.prune_unreachable();

    /* Do all the heavy work of finding where phis go */
    self.find_defs();

    /* perform liveness analysis */
    let (live, _) = liveness::calculate(self.cfg, self.root, 0);
    self.find_phis(live);

    /* Re-number the entire graph */
    let mut map = tmap::init();
    for live_in.each |&tmp| {
      self.bump(&mut map, tmp);
    }
    self.versions.insert(self.root, map);
    for self.cfg.each_rev_postorder(self.root) |&id| {
      self.map_temps(id);
    }
    for self.cfg.each_node |id, _| {
      self.map_phi_temps(id);
    }

    /* Finally place our new phi nodes */
    for self.phi_temps.each |k, v| {
      self.place_phis(k, v);
    }
    info!("ssa finished");
  }

  /**
   * Given the root node of the control flow graph, removes all unreachable
   * nodes by doing a DFS traversal of the graph and seeing whatever wasn't
   * reached during the traversal.
   */
  fn prune_unreachable() {
    let visited = map::HashMap();

    self.visit(visited, self.root);
    /* Can't modify the graph while iterating */
    let mut to_remove = ~[];
    for self.cfg.each_node |id, _| {
      if !set::contains(visited, id) {
        to_remove.push(id);
      }
    }
    for to_remove.each |&id| {
      self.cfg.remove_node(id);
    }
  }

  fn visit(visited : graph::NodeSet, n : graph::NodeId) {
    if !set::contains(visited, n) {
      set::add(visited, n);
      for self.cfg.each_succ(n) |id| {
        self.visit(visited, id);
      }
    }
  }

  /* Build up the 'defs' map */
  fn find_defs() {
    for self.cfg.each_node |id, stms| {
      for stms.each |&s| {
        for s.each_def |tmp| {
          let table = match self.defs.find(tmp) {
            Some(t) => t,
            None => {
              let t = map::HashMap();
              self.defs.insert(tmp, t);
              t
            }
          };
          set::add(table, id);
        }
      }
    }
    info!("found definitions");
  }

  /* Find where all phi functions need to go */
  fn find_phis(live_in : liveness::LiveMap) {
    /* Use the iterated dominance frontier algorithm, shown here:
          http://symbolaris.com/course/Compilers12/11-ssa.pdf
       to determine the optimal placement of phi functions */

    let frontiers = self.dom_frontiers();

    for self.defs.each |tmp, defs| {
      debug!("idf for tmp: %s", tmp.pp());
      let locs = self.idf(frontiers, defs);
      for set::each(locs) |n| {
        if !set::contains(live_in[n], tmp) { loop }
        let set = match self.phis.find(n) {
          Some(s) => s,
          None => {
            let s = map::HashMap();
            self.phis.insert(n, s);
            s
          }
        };
        set::add(set, tmp);
      }
    }
    info!("found phis");
  }

  /* Calculate the immediate dominators of every node */
  pub fn idoms() {
    debug!("calculating idoms");
    let idoms = self.idoms;
    let (order, postorder) = self.cfg.postorder(self.root);
    debug!("%?", order);
    idoms.insert(self.root, self.root);

    /* This code is an implementation of the algorithm found in this paper:
          http://www.cs.rice.edu/~keith/EMBED/dom.pdf
       and obviously adapted for rust */
    let mut changed = true;
    while changed {
      changed = false;
      for vec::rev_each(order) |&b| {
        if b == self.root { loop }
        let mut new_idom = -1;

        for self.cfg.each_pred(b) |p| {
          if !idoms.contains_key(p) { loop }
          if new_idom == -1 {
            new_idom = p;
          } else {
            let mut b1 = p;
            let mut b2 = new_idom;
            while postorder[b1] != postorder[b2] {
              while postorder[b1] < postorder[b2] {
                b1 = idoms[b1];
              }
              while postorder[b2] < postorder[b1] {
                b2 = idoms[b2];
              }
            }
            new_idom = b1;
          }
        }
        assert(new_idom != -1);
        let prev = match idoms.find(b) { Some(dom) => dom, None => -1 };
        if prev != new_idom {
          idoms.insert(b, new_idom);
          changed = true;
        }
      }
    }

    let visited = map::HashMap();
    for order.each |&id| {
      debug!("%? => %?", id, idoms[id]);
      assert(!set::contains(visited, idoms[id]));
      set::add(visited, id);
    }
    for vec::rev_each(order) |&id| {
      if id != id {
        assert(!set::contains(visited, idoms[id]));
      }
      set::remove(visited, id);
    }
    info!("idoms calculated");
  }

  fn dom_frontiers() -> DomFrontiers {
    /* calculate all immediate dominators */
    self.idoms();
    let idominated = self.idominated;
    for self.idoms.each |a, _| {
      idominated.insert(a, map::HashMap());
    }
    for self.idoms.each |a, b| {
      if a != b {
        set::add(idominated[b], a);
      }
    }
    info!("reversed idoms");

    /* Now calculate the dominance frontiers according to the algorithm shown in
       these slides: http://symbolaris.com/course/Compilers12/11-ssa.pdf
       for calculating the dominance frontier of a node */

    let frontiers = map::HashMap();
    for self.cfg.each_postorder(self.root) |&a| {
      let frontier = map::HashMap();

      /* df_local[a] */
      debug!("df_local[%d]...", a as int);
      for self.cfg.each_succ(a) |b| {
        if self.idoms[b] != a {
          set::add(frontier, b);
        }
      }

      /* for all c where idom[c] = a */
      for set::each(idominated[a]) |c| {
        if a == c { loop }
        debug!("df_up[%d, %d]...", a as int, c as int);

        /* df_up[a, c] */
        for set::each(frontiers[c]) |b| {
          if self.idoms[b] != a {
            set::add(frontier, b);
          }
        }
      }
      debug!("calculated df[%d]", a as int);

      frontiers.insert(a, frontier);
    }
    debug!("calculated dominance frontiers");
    return frontiers;
  }

  /* Calculate the iterated dominance frontier on a set of nodes */
  fn idf(dfs : DomFrontiers, set : graph::NodeSet) -> graph::NodeSet {
    let mut ret = set;
    /* loop until we find a fixed point */
    loop {
      let tmp = map::HashMap();
      for set::each(set) |id| {
        for dfs.find(id).each |&x| {
          set::union(tmp, x);
        }
      }
      for set::each(ret) |id| {
        for dfs.find(id).each |&x| {
          set::union(tmp, x);
        }
      }
      if set::eq(tmp, ret) {
        return ret;
      }
      ret = tmp;
    }
  }

  /**
   * Modify all temps in the graph to new temps based on what they were before
   * but now taking SSA into account. This function does not place phi functions
   * anywhere because the version of temps in all predecessors to phi functions
   * must be determined first.
   *
   * This function does, however, prepare for phi functions to be placed
   */
  fn map_temps(n : graph::NodeId) {
    let mut map = self.versions[self.idoms[n]];

    /* Bump all temp numbers which have phi functions at this location */
    debug!("bumping temps for phis at %d", n as int);
    match self.phis.find(n) {
      None => (),
      Some(temps) => {
        /* Keep track of what we changed our temps to so the phi functions can
           be placed correctly in the next step */
        let mapping = map::HashMap();
        for set::each(temps) |tmp| {
          mapping.insert(tmp, self.bump(&mut map, tmp));
        }
        self.phi_temps.insert(n, mapping);
      }
    }

    /* Process all statements in this block (possibly bumping versions) */
    debug!("mapping statements at %d", n as int);
    let stms = self.cfg[n].map(|&s| {
      debug!("%s", s.pp());
      s.map_temps(|usage| tmap::find(map, usage).get(),
                  |def|   self.bump(&mut map, def))
    });
    self.versions.insert(n, map);

    /* Update our node with our altered statements */
    self.cfg.update_node(n, @stms);
  }

  /* Alter the temp mapping for a specified non-ssa temp */
  fn bump(vars : &mut TempMap, t : Temp) -> Temp {
    let ret = self.temps.new();
    /* TODO: will rust make this able to be one line? */
    let foo = self.remap;
    foo(t, ret);
    *vars = tmap::insert(*vars, t, ret);
    return ret;
  }

  /**
   * Re-map all existing phi instructions to use the new temps located on all of
   * their predecessor's edges
   */
  fn map_phi_temps(n : graph::NodeId) {
    for self.cfg[n].each |&stm| {
      match stm.phi_map() {
        None => (),
        Some(map) => {
          let mut new = ~[];
          for map.each |pred, tmp| {
            new.push((pred, tmap::find(self.versions[pred], tmp).get()));
          }
          map.clear();
          for new.each |&(a, b)| {
            map.insert(a, b);
          }
        }
      }
    }
  }

  /**
   * Places phi functions into the CFG. This assumes that all temps have already
   * been renumbered/renamed and the last thing to do is to actually put the phi
   * functions in place
   */
  fn place_phis(n : graph::NodeId, temps : map::HashMap<Temp, Temp>) {
    debug!("generating %? phis at %?", temps.size(), n);
    let mut block = ~[];
    for temps.each |tmp_before, tmp_after| {
      debug!("placing phi for %? at %?", tmp_before, n);
      let preds = map::HashMap();
      /* Our phi function operates on the last known ssa-temp for this node's
         non-ssa temp at each of our predecessors */
      for self.cfg.each_pred(n) |p| {
        match tmap::find(self.versions[p], tmp_before) {
          Some(t) => { preds.insert(p, t); }
          None => ()
        }
      }

      assert(preds.size() == self.cfg.num_pred(n));
      /* The result of the phi node is the ssa-temp, not the non-ssa temp */
      let maker = self.phi_maker;
      block.push(maker(tmp_after, preds));
    }

    /* Update our node with the phi nodes */
    self.cfg.update_node(n, @(block + *self.cfg[n]));
  }
}
