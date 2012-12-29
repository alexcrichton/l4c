use std::map;
use middle::temp::Temp;
use tmap = std::fun_treemap;

type TempMap = tmap::Treemap<Temp, Temp>;
pub type DomFrontiers = map::HashMap<graph::NodeId, graph::NodeSet>;

struct Converter {
  f : &ir::Function,

  /* Mapping of temps to the set of nodes that the temp is defined in */
  defs : map::HashMap<Temp, (ir::Type, graph::NodeSet)>,
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
    /*self.prune_unreachable();*/
    self.find_defs();
    self.find_phis();

    self.versions.insert(self.f.root, tmap::init());
    for vec::rev_each(*self.f.postorder) |&id| {
      self.map_temps(id);
    }
    for self.phi_temps.each |k, v| {
      self.place_phis(k, v);
    }
  }

  /* Remove all unreachable nodes from the root */
  fn prune_unreachable() {
    let visited = map::HashMap();
    self.visit(self.f.root, visited);
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

  fn visit(n : graph::NodeId, s : graph::NodeSet) {
    if set::contains(s, n) {
      return;
    }
    set::add(s, n);
    for self.f.cfg.each_succ(n) |x| {
      self.visit(x, s);
    }
  }

  /* Build up the 'defs' map */
  fn find_defs() {
    for self.f.cfg.each_node |id, stms| {
      for stms.each |&s| {
        match s {
          /* Only loads and moves can define temps */
          @ir::Load((tmp, size), _) | @ir::Move((tmp, size), _) => {
            let table = match self.defs.find(tmp) {
              Some((_, t)) => t,
              None => map::HashMap()
            };
            set::add(table, id);
            self.defs.insert(tmp, (size, table));
          }
          _ => ()
        }
      }
    }
    info!("found definitions for: %s", self.f.name);
  }

  /* Find where all phi functions need to go */
  fn find_phis() {
    let frontiers = self.dom_frontiers();

    for self.defs.each |tmp, (_, defs)| {
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
    self.f.postorder = @order;
    idoms.insert(root, root);
    // http://www.cs.rice.edu/~keith/EMBED/dom.pdf
    let mut changed = true;
    while changed {
      changed = false;
      for vec::rev_each(*self.f.postorder) |&b| {
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
    info!("idoms calculated");
  }

  fn dom_frontiers() -> DomFrontiers {
    /* calculate all immediate dominators */
    self.idoms();
    /* idom_rev[a] = b implies a immediately dominates nodes in b */
    let idom_rev = map::HashMap();
    for self.f.idoms.each |a, b| {
      let set = match idom_rev.find(b) {
        Some(s) => s,
        None => {
          let set = map::HashMap();
          idom_rev.insert(b, set);
          set
        }
      };
      set::add(set, a);
    }
    info!("reversed idoms");

    /* Now calculate the dominance frontiers */
    let frontiers = map::HashMap();
    for self.f.postorder.each |&a| {
      let frontier = map::HashMap();

      /* df_local[a] */
      debug!("df_local[%d]...", a as int);
      for self.f.cfg.each_succ(a) |b| {
        if self.f.idoms[b] != a {
          set::add(frontier, b);
        }
      }

      /* not all nodes dominate some other node */
      if idom_rev.contains_key(a) {
        /* for all c where idom[c] = a */
        for set::each(idom_rev[a]) |c| {
          if a == c { loop }
          debug!("df_up[%d, %d]...", a as int, c as int);

          /* df_up[a, c] */
          for set::each(frontiers[c]) |b| {
            if self.f.idoms[b] != a {
              set::add(frontier, b);
            }
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

  /* Insert all phi functions into the graph */
  fn map_temps(n : graph::NodeId) {
    let mut map = self.versions[self.f.idoms[n]];

    /* Bump all temp numbers which have phi functions at this location */
    debug!("bumping temps for phis at %d", n as int);
    match self.phis.find(n) {
      None => (),
      Some(temps) => {
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
        @ir::Move((tmp, size), e) => {
          let e = self.exp_phi(map, e);
          @ir::Move((self.bump(&mut map, tmp), size), e)
        }
        @ir::Load((tmp, size), e) => {
          let e = self.exp_phi(map, e);
          @ir::Load((self.bump(&mut map, tmp), size), e)
        }
        @ir::Store(e1, typ, e2) =>
          @ir::Store(self.exp_phi(map, e1), typ, self.exp_phi(map, e2)),
        @ir::Condition(e) => @ir::Condition(self.exp_phi(map, e)),
        @ir::Return(e) => @ir::Return(self.exp_phi(map, e)),
        @ir::Die(e) => @ir::Die(self.exp_phi(map, e)),
        @ir::Phi(_, _) => fail(~"shouldn't see phi nodes yet")
      }
    );
    self.versions.insert(n, map);

    /* Update our node with our altered statements */
    self.f.cfg.update_node(n, @stms);
  }

  fn place_phis(n : graph::NodeId, temps : map::HashMap<Temp, Temp>) {
    /* Bump all temp numbers which have phi functions at this location */
    debug!("generating phis at %d", n as int);
    let phis = vec::build_sized(temps.size(), |push|
      for temps.each |tmp_before, tmp_after| {
        let preds = map::HashMap();
        for self.f.cfg.each_pred(n) |p| {
          match self.versions.find(p) {
            None => (),
            Some(v) => { preds.insert(p, tmap::find(v, tmp_before).get()); }
          }
        }
        let size = self.defs[tmp_before].first();
        let phi = @ir::Phi((tmp_after, size), preds);
        push(phi);
      }
    );

    /* Update our node with the phi nodes */
    self.f.cfg.update_node(n, @vec::append(phis, *self.f.cfg[n]));
  }

  /* Map all temps to new ssa-temps in an expression */
  fn exp_phi(vars : TempMap, e : @ir::Expression) -> @ir::Expression {
    match e {
      @ir::Const(_, _) | @ir::LabelExp(_) => e,
      @ir::BinaryOp(op, e1, e2) =>
        @ir::BinaryOp(op, self.exp_phi(vars, e1), self.exp_phi(vars, e2)),
      @ir::Call(e, typ, ref args) =>
        @ir::Call(self.exp_phi(vars, e), typ,
                  args.map(|&x| self.exp_phi(vars, x))),
      @ir::Temp((tmp, size)) => @ir::Temp((tmap::find(vars, tmp).get(), size))
    }
  }

  /* Alter the temp mapping for a specified non-ssa temp */
  fn bump(vars : &mut TempMap, t : Temp) -> Temp {
    let ret = self.temps.new();
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
}
