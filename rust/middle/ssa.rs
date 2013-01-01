use std::map;
use middle::temp::Temp;
use tmap = std::fun_treemap;

type TempMap = tmap::Treemap<Temp, Temp>;
type DomFrontiers = map::HashMap<graph::NodeId, graph::NodeSet>;

struct Converter {
  f : &ir::Function,

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
}

pub fn convert(p : &ir::Program) {
  for p.funs.each |f| {
    let converter = Converter { f: f,
                                defs: map::HashMap(),
                                phis: map::HashMap(),
                                phi_temps : map::HashMap(),
                                versions: map::HashMap(),
                                temps: temp::new() };
    converter.convert();
  }
}

impl Converter {
  fn convert() {
    self.prune_unreachable();

    self.find_defs();
    self.find_phis();

    let mut map = tmap::init();
    self.f.args = @self.f.args.map(|&tmp| self.bump(&mut map, tmp));
    self.versions.insert(self.f.root, map);
    for self.f.cfg.each_rev_postorder(self.f.root) |&id| {
      self.map_temps(id);
    }
    for self.phi_temps.each |k, v| {
      self.place_phis(k, v);
    }
  }

  /**
   * Given the root node of the control flow graph, removes all unreachable
   * nodes by doing a DFS traversal of the graph and seeing whatever wasn't
   * reached during the traversal.
   */
  fn prune_unreachable() {
    let visited = map::HashMap();

    self.visit(visited, self.f.root);
    /* Can't modify the graph while iterating */
    let mut to_remove = ~[];
    for self.f.cfg.each_node |id, _| {
      if !set::contains(visited, id) {
        to_remove.push(id);
      }
    }
    for to_remove.each |&id| {
      self.f.cfg.remove_node(id);
    }
  }

  fn visit(visited : graph::NodeSet, n : graph::NodeId) {
    if !set::contains(visited, n) {
      set::add(visited, n);
      for self.f.cfg.each_succ(n) |id| {
        self.visit(visited, id);
      }
    }
  }

  /* Build up the 'defs' map */
  fn find_defs() {
    for self.f.cfg.each_node |id, stms| {
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
    info!("found definitions for: %s", self.f.name);
  }

  /* Find where all phi functions need to go */
  fn find_phis() {
    /* Use the iterated dominance frontier algorithm, shown here:
          http://symbolaris.com/course/Compilers12/11-ssa.pdf
       to determine the optimal placement of phi functions */

    let frontiers = self.dom_frontiers();

    for self.defs.each |tmp, defs| {
      debug!("idf for tmp: %s", tmp.pp());
      let locs = self.idf(frontiers, defs);
      for set::each(locs) |n| {
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
    info!("found phis for: %s", self.f.name);
  }

  /* Calculate the immediate dominators of every node */
  pub fn idoms() {
    debug!("calculating idoms");
    let idoms = self.f.idoms;
    let root = self.f.root;
    let (order, postorder) = self.f.cfg.postorder(root);
    debug!("%?", order);
    idoms.insert(root, root);

    /* This code is an implementation of the algorithm found in this paper:
          http://www.cs.rice.edu/~keith/EMBED/dom.pdf
       and obviously adapted for rust */
    let mut changed = true;
    while changed {
      changed = false;
      for vec::rev_each(order) |&b| {
        if b == root { loop }
        let mut new_idom = -1;

        for self.f.cfg.each_pred(b) |p| {
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
    let idominated = self.f.idominated;
    for self.f.idoms.each |a, _| {
      idominated.insert(a, map::HashMap());
    }
    for self.f.idoms.each |a, b| {
      if a != b {
        set::add(idominated[b], a);
      }
    }
    info!("reversed idoms");

    /* Now calculate the dominance frontiers according to the algorithm shown in
       these slides: http://symbolaris.com/course/Compilers12/11-ssa.pdf
       for calculating the dominance frontier of a node */

    let frontiers = map::HashMap();
    for self.f.cfg.each_postorder(self.f.root) |&a| {
      let frontier = map::HashMap();

      /* df_local[a] */
      debug!("df_local[%d]...", a as int);
      for self.f.cfg.each_succ(a) |b| {
        if self.f.idoms[b] != a {
          set::add(frontier, b);
        }
      }

      /* for all c where idom[c] = a */
      for set::each(idominated[a]) |c| {
        if a == c { loop }
        debug!("df_up[%d, %d]...", a as int, c as int);

        /* df_up[a, c] */
        for set::each(frontiers[c]) |b| {
          if self.f.idoms[b] != a {
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
    let mut map = self.versions[self.f.idoms[n]];

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
    let stms = self.f.cfg[n].map(|&s|
      match s {
        @ir::Move(tmp, e) => {
          let e = self.exp_phi(map, e);
          @ir::Move(self.bump(&mut map, tmp), e)
        }
        @ir::Load(tmp, e) => {
          let e = self.exp_phi(map, e);
          @ir::Load(self.bump(&mut map, tmp), e)
        }
        @ir::Store(e1, e2) =>
          @ir::Store(self.exp_phi(map, e1), self.exp_phi(map, e2)),
        @ir::Condition(e) => @ir::Condition(self.exp_phi(map, e)),
        @ir::Return(e) => @ir::Return(self.exp_phi(map, e)),
        @ir::Die(e) => @ir::Die(self.exp_phi(map, e)),
        @ir::Call(tmp, e, ref args) =>
          @ir::Call(self.bump(&mut map, tmp),
                    self.exp_phi(map, e),
                    args.map(|&x| self.exp_phi(map, x))),
        @ir::Phi(_, _) => fail(~"shouldn't see phi nodes yet")
      }
    );
    self.versions.insert(n, map);

    /* Update our node with our altered statements */
    self.f.cfg.update_node(n, @stms);
  }

  /* Map all temps to new ssa-temps in an expression */
  fn exp_phi(vars : TempMap, e : @ir::Expression) -> @ir::Expression {
    match e {
      @ir::Const(_, _) | @ir::LabelExp(_) => e,
      @ir::BinaryOp(op, e1, e2) =>
        @ir::BinaryOp(op, self.exp_phi(vars, e1), self.exp_phi(vars, e2)),
      @ir::Temp(tmp) => @ir::Temp(tmap::find(vars, tmp).get())
    }
  }

  /* Alter the temp mapping for a specified non-ssa temp */
  fn bump(vars : &mut TempMap, t : Temp) -> Temp {
    let ret = self.temps.new();
    self.f.types.insert(ret, self.f.types[t]);
    *vars = tmap::insert(*vars, t, ret);
    ret
  }

  /* Fetch the ssa-temp for a non-ssa temp */
  fn map(vars : &mut TempMap, t : Temp) -> Temp {
    match tmap::find(*vars, t) {
      Some(t) => t,
      None => self.bump(vars, t)
    }
  }

  /**
   * Places phi functions into the CFG. This assumes that all temps have already
   * been renumbered/renamed and the last thing to do is to actually put the phi
   * functions in place
   */
  fn place_phis(n : graph::NodeId, temps : map::HashMap<Temp, Temp>) {
    debug!("generating %? phis at %?", temps.size(), n);
    let phis = vec::build_sized(temps.size(), |push|
      for temps.each |tmp_before, tmp_after| {
        debug!("placing phi for %? at %?", tmp_before, n);
        let preds = map::HashMap();
        /* Our phi function operates on the last known ssa-temp for this node's
           non-ssa temp at each of our predecessors */
        for self.f.cfg.each_pred(n) |p| {
          match tmap::find(self.versions[p], tmp_before) {
            Some(t) => { preds.insert(p, t); }
            None => ()
          }
        }

        /* If not all our predecessors had a version of tmp_before, then we
           definitely don't need a phi node because this is just a node on the
           dominance frontier that won't end up being needed anyway */
        if preds.size() == self.f.cfg.num_pred(n) {
          /* The result of the phi node is the ssa-temp, not the non-ssa temp */
          push(@ir::Phi(tmp_after, preds));
        }
      }
    );

    /* Update our node with the phi nodes */
    self.f.cfg.update_node(n, @vec::append(phis, *self.f.cfg[n]));
  }
}
