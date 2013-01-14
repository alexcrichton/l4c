use std::map;
use middle::{ssa, ir, liveness};
use middle::temp::Temp;
use back::assem::*;
use utils::bitv::Bitv;

type CFG = graph::Graph<@~[@assem::Instruction], ir::Edge>;
type ColorMap = map::HashMap<Temp, uint>;

struct Allocator {
  f : &Function,
  colors : ColorMap,
  slots : map::HashMap<Tag, uint>,
  mut max_slot : uint,
  callee_saved : dvec::DVec<uint>,
}

pub fn color(p : &Program) {
  for p.funs.each |f| {
    let a = Allocator{ colors: map::HashMap(),
                       slots: map::HashMap(),
                       f: f,
                       max_slot: 0,
                       callee_saved: dvec::DVec() };

    /* Color the graph completely */
    info!("coloring: %s", f.name);
    let tmpdata = liveness::calculate(&f.cfg, f.root, 0);
                                      /*|ins, f| ins.each_def(f),*/
                                      /*|ins, f| ins.each_use(f));*/
    let slotdata = liveness::calculate(&f.cfg, f.root, 1);
                                       /*|ins, f| ins.each_spill(f),*/
                                       /*|ins, f| ins.each_reload(f));*/

    a.color(f.root, f.idominated, tmpdata, slotdata);
    for a.colors.each |tmp, color| {
      debug!("%s => %?", tmp.to_str(), color);
    }

    /* Finally remove all phi nodes and all temps */
    a.remove_phis();
    a.remove_temps();
  }
}

fn min_vacant(colors : map::Set<uint>) -> uint {
  let mut i = 1;
  while set::contains(colors, i) {
    i += 1;
  }
  return i;
}

impl Allocator {

  /**
   * Color the functions CFG according to the algorithm outlined in the paper
   * "Towards Register Allocation for Programs in SSA-form" by Hack et al.
   * A top-down traversal of the dominator tree is done, coloring all
   * definitions as they are seen with the first available color.
   */
  fn color(n : graph::NodeId, idominated : ssa::Idominated,
           tmpdata : liveness::Data, slotdata : liveness::Data) {
    debug!("coloring %?", n);
    let (tmplive, tmpdelta) = tmpdata;
    let (slotlive, slotdelta) = slotdata;
    let tmplive = tmplive[n];
    let slotlive = slotlive[n];
    let tmpdelta = tmpdelta[n];
    let slotdelta = slotdelta[n];
    let registers = map::HashMap();
    let slots = map::HashMap();
    for set::each(tmplive) |t| {
      set::add(registers, self.colors[t as Temp]);
    }
    for set::each(slotlive) |t| {
      set::add(slots, self.slots[t as Tag]);
    }

    let mut pcopy = None;
    for self.f.cfg[n].eachi |i, &ins| {
      /* examine data for next instruction for last use information */
      debug!("%s", ins.pp());
      debug!("deltas %? %?", tmpdelta[i], slotdelta[i]);
      debug!("before %s %s %s", set::to_str(tmplive), set::to_str(registers),
             set::to_str(slotlive));
      tmplive.apply(&tmpdelta[i]);
      slotlive.apply(&slotdelta[i]);

      /* If we found a pcopy, then we're breaking liveness */
      match ins {
        @PCopy(*) => {
          assert(pcopy.is_none());
          pcopy = Some(ins);
          registers.clear();
          loop;
        }
        /* Be sure spills/reloads are always colored */
        @Spill(_, t) => {
          let slot = match self.slots.find(t) {
            None => {
              let slot = min_vacant(slots);
              self.slots.insert(t, slot);
              self.max_slot = uint::max(slot, self.max_slot) + 1;
              slot
            }
            Some(s) => s
          };
          set::add(slots, slot);
        }
        @Reload(_, t) => {
          if !set::contains(slotlive, t) {
            set::remove(slots, self.slots[t]);
          }
        }
        _ => ()
      }

      /* If we found a pcopy, and we're not constrained, keep going */
      if pcopy.is_some() {
        let banned = map::HashMap();
        let dest = match ins {
          @BinaryOp(op, dst, op1, op2) if op.constrained() => {
            match op {
              Div | Mod => {
                match op1 {
                  @Temp(t) => { self.colors.insert(t, arch::reg_num(EAX)); }
                  _        => fail(fmt!("not tmp op1 %?", dst))
                }
                set::add(banned, arch::reg_num(EDX));
                set::add(banned, arch::reg_num(EAX));
                match dst {
                  @Temp(t) => {
                    let reg = match op { Div => EAX, _ => EDX };
                    self.colors.insert(t, arch::reg_num(reg));
                    t
                  }
                  _ => fail(fmt!("not tmp dst %?", dst))
                }
              }

              Rsh | Lsh => {
                match op2 {
                  @Temp(t) => { self.colors.insert(t, arch::reg_num(ECX)); }
                  _        => fail(~"shouldn't be constrained")
                }
                set::add(banned, arch::reg_num(ECX));
                match dst {
                  @Temp(t) => t,
                  _ => fail(fmt!("not tmp dst %?", dst))
                }
              }

              _ => fail(fmt!("implement %?", op))
            }
          }
          @Call(*) => fail(~"implement call constraints"),
          _ => loop
        };

        let process = |t : Temp, banned : map::Set<uint>, colors : ColorMap| {
          let color = match colors.find(t) {
            Some(c) => c,
            None    => min_vacant(banned)
          };
          debug!("assigning %s %? %s", t.pp(), color, set::to_str(banned));
          assert color <= arch::num_regs;
          colors.insert(t, color);
          set::add(banned, color);
          if set::contains(tmplive, t) {
            set::add(registers, color);
          }
        };

        /* Next, we need to color all of the pcopy destinations, and the rest of
           our own operands (that aren't precolored). After adding in our uses
           (which have the specific interferences), we add in all pcopy
           destinations (preventing them from being our precolored colors).
           Finally we add the destination in whatever register is remaining */
        debug!("processing used temporaries");
        for ins.each_use |tmp| {
          process(tmp, banned, self.colors);
        }
        debug!("processing previous pcopy");
        match pcopy {
          Some(@PCopy(ref copies, _)) => {
            for copies.each |&(dst, src)| {
              assert dst != src;
              process(dst, banned, self.colors);
            }
          }
          _ => unreachable()
        }
        process(dest, registers, self.colors);
        if !set::contains(tmplive, dest) {
          set::remove(registers, self.colors[dest]);
        }
        pcopy = None;
      } else {
        /* normal coloration of each instruction */
        for ins.each_use |tmp| {
          debug!("found use %?", tmp);
          if !set::contains(tmplive, tmp) {
            debug!("removing %?", tmp);
            set::remove(registers, self.colors[tmp]);
          }
        }
        for ins.each_def |tmp| {
          debug!("%? %?", registers.size(), tmplive.size());
          let color = min_vacant(registers);
          assert(color <= arch::num_regs);
          assert(self.colors.insert(tmp, color));
          if set::contains(tmplive, tmp) {
            set::add(registers, color);
          }
        }
      }
      debug!("after %s %s", set::to_str(tmplive), set::to_str(registers));
      assert(registers.size() == tmplive.size());
    }

    for set::each(idominated[n]) |id| {
      self.color(id, idominated, tmpdata, slotdata);
    }
  }

  fn remove_phis() {
    let cfg = &self.f.cfg;
    for cfg.each_node |id, ins| {
      let mut phi_vars = ~[];
      let mut phi_maps = ~[];
      for ins.each |&ins| {
        match ins {
          @Phi(tmp, map) => {
            phi_vars.push(self.colors[tmp]);
            phi_maps.push(map);
          }
          _ => break
        }
      }

      for cfg.each_pred(id) |pred| {
        let mut perm = ~[];
        for phi_maps.each |map| {
          perm.push(self.colors[map[pred]]);
        }
        /* there are no critical edges in the graph, so we can just append */
        let ins = self.resolve_perm(phi_vars, perm);
        if ins.len() == 0 { loop }
        cfg.update_node(pred, @(cfg[pred] + ins));
      }
    }
  }

  fn resolve_perm(result : &[uint], incoming : &[uint]) -> ~[@Instruction] {
    use sim = std::smallintmap;
    /* TODO: remove this once this works */
    let regs = sim::mk();
    for uint::range(1, arch::num_regs + 1) |i| {
      regs.insert(i, i);
    }

    let mkreg = |i : uint| @Register(arch::num_reg(i), ir::Pointer);
    let mut ins = ~[];

    /* build up some small conversion maps */
    let src_dst = sim::mk();
    for vec::each2(result, incoming) |&a, &b| {
      if !src_dst.contains_key(b) {
        src_dst.insert(b, a);
      }
    }

    /* Permute the registers by following cycles */
    for incoming.each |&src| {
      while src_dst.contains_key(src) {
        let dst = src_dst[src];
        if dst != src {
          let tmp = regs[src];
          regs.insert(src, regs[dst]);
          regs.insert(dst, tmp);
          ins.push(@Raw(fmt!("xchg %s, %s", mkreg(dst).pp(), mkreg(src).pp())));
        }
        match src_dst.find(dst) {
          None => { src_dst.remove(src); }
          Some(d) => {
            src_dst.insert(src, d);
            src_dst.remove(dst);
          }
        }
      }
    }

    /* now resolve copies of values */
    src_dst.clear();
    for vec::each2(result, incoming) |&a, &b| {
      if src_dst.contains_key(b) {
        regs.insert(a, b);
        ins.push(@Move(mkreg(a), mkreg(src_dst[b])));
      } else {
        src_dst.insert(b, a);
      }
    }

    info!("perm %? -v", incoming);
    info!("     %?", result);
    info!("     %?", ins);

    for vec::each2(incoming, result) |&a, &b| {
      debug!("%? %? %?", a, b, regs[b]);
      assert regs[b] == a;
    }
    return ins;
  }

  /**
   * Apply the coloring previously generated to all instructions and operands in
   * all basic blocks. This means that the cfg will no longer have any temps,
   * and that it will no longer be in SSA-form.
   *
   * This also converts all three-operand binary ops to two-operand binops
   * because x86 is so awesome.
   */
  fn remove_temps() {
    for self.f.cfg.each_rev_postorder(self.f.root) |&id| {
      let ins = vec::build(|push| {
        if id == self.f.root {
          for self.colors.each |_, color| {
            let reg = arch::num_reg(color);
            if arch::callee_reg(reg) && !self.callee_saved.contains(&color) {
              self.callee_saved.push(color);
              push(@Raw(fmt!("push %s", reg.size(ir::Pointer))));
            }
          }
          push(@BinaryOp(Sub, @Register(ESP, ir::Pointer),
                         @Immediate(self.max_slot * 8 as i32, ir::Pointer),
                         @Register(ESP, ir::Pointer)));
        }
        for self.f.cfg[id].each |&ins| {
          self.alloc_ins(ins, push);
        }
      });
      self.f.cfg.update_node(id, @ins);
    }
  }

  fn alloc_ins(i : @Instruction, push : &pure fn(@Instruction)) {
    match i {
      @Spill(tmp, tag) => {
        let reg = @Register(arch::num_reg(self.colors[tmp]), self.f.sizes[tmp]);
        let slot = @Stack(self.slots[tag] * arch::ptrsize);
        push(@Store(slot, reg));
      }
      @Reload(dst, tag) => {
        let reg = @Register(arch::num_reg(self.colors[dst]), self.f.sizes[dst]);
        let slot = @Stack(self.slots[tag] * arch::ptrsize);
        push(@Load(reg, slot));
      }
      @Load(dst, @MOp(addr)) =>
        push(@Load(self.alloc_op(dst), @MOp(self.alloc_op(addr)))),
      @Load(dst, addr) => push(@Load(self.alloc_op(dst), addr)),
      @Store(@MOp(addr), src) =>
        push(@Store(@MOp(self.alloc_op(addr)), self.alloc_op(src))),
      @Store(addr, src) => push(@Store(addr, self.alloc_op(src))),
      @Raw(*) => push(i),
      @Condition(c, o1, o2) =>
        push(@Condition(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Die(c, o1, o2) =>
        push(@Die(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Move(o1, o2) => push(@Move(self.alloc_op(o1), self.alloc_op(o2))),
      @Use(_) | @Phi(*) => (),

      @Return => {
        push(@BinaryOp(Add, @Register(ESP, ir::Pointer),
                       @Immediate(self.max_slot * 8 as i32, ir::Pointer),
                       @Register(ESP, ir::Pointer)));
        for self.callee_saved.rev_each |&color| {
          push(@Raw(fmt!("pop %s", arch::num_reg(color).size(ir::Pointer))));
        }
        push(i);
      }

      /* x86 imul can have 3 operands if one is an immediate */
      @BinaryOp(Mul, d, s1, s2) if s1.imm() && !s2.imm() =>
        push(@BinaryOp(Mul, self.alloc_op(d), self.alloc_op(s2), s1)),
      @BinaryOp(Mul, d, s1, s2) if s2.imm() && !s1.imm() =>
        push(@BinaryOp(Mul, self.alloc_op(d), self.alloc_op(s1), s2)),

      /* When going through formatting and on x86 -
            BinaryOp(op, d, s1, s2) <=> d = d op s1
         and s2 is put in the commments */
      @BinaryOp(op, d, s1, s2) => {
        let d = self.alloc_op(d);
        let s1 = self.alloc_op(s1);
        let s2 = self.alloc_op(s2);

        match op {
          /* these are all special cases handled elsewhere */
          Div | Mod | Cmp(*) => push(@BinaryOp(op, d, s1, s2)),

          /* d = d op s2, perfect! */
          _ if s1 == d => push(@BinaryOp(op, d, s2, s1)),
          /* d = s1 op d, can commute */
          _ if s2 == d && op.commutative() => push(@BinaryOp(op, d, s1, s2)),
          /* should be handled elsewhere */
          _ if s2 == d => fail(fmt!("shouldn't happen now %?", i)),
          /* catch-all last resort, generate a move */
          _ => {
            push(@Move(d, s1));
            push(@BinaryOp(op, d, s2, s1));
          }

        }
      }
      @Call(dst, fun, ref args) =>
        push(@Call(dst, self.alloc_op(fun),
             args.map(|&arg| self.alloc_op(arg)))),

      @PCopy(ref copies) => {
        debug!("%?", copies);
        let (dsts, srcs) = vec::unzip(vec::map(*copies, |&(d, s)|
          (self.colors[d], self.colors[s])
        ));
        for self.resolve_perm(dsts, srcs).each |&ins| {
          push(ins);
        }
      }
    }
  }

  fn alloc_op(o : @Operand) -> @Operand {
    match o {
      @Immediate(*) | @LabelOp(*) | @Register(*) => o,
      @Temp(tmp) =>
        @Register(arch::num_reg(self.colors[tmp]), self.f.sizes[tmp])
    }
  }
}
