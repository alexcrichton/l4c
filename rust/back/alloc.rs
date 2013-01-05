use std::map;
use middle::{ssa, ir, liveness};
use middle::temp::Temp;
use back::assem::*;
use utils::bitv::Bitv;

type CFG = graph::Graph<@~[@assem::Instruction], ir::Edge>;

struct Allocator {
  f : &Function,
  colors : map::HashMap<Temp, uint>,
  slots : map::HashMap<Tag, uint>,
  mut max_slot : uint
}

pub fn color(p : &Program) {
  for p.funs.each |f| {
    let a = Allocator{ colors: map::HashMap(),
                       slots: map::HashMap(),
                       f: f,
                       max_slot: 0 };

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

    for self.f.cfg[n].eachi |i, &ins| {
      /* examine data for next instruction for last use information */
      debug!("%? %?", tmpdelta[i], slotdelta[i]);
      debug!("%s %s", set::to_str(tmplive), set::to_str(slotlive));
      tmplive.apply(&tmpdelta[i]);
      slotlive.apply(&slotdelta[i]);
      debug!("%s", ins.pp());
      for ins.each_use |tmp| {
        debug!("found use %?", tmp);
        if !set::contains(tmplive, tmp) {
          debug!("removing %?", tmp);
          set::remove(registers, self.colors[tmp]);
        }
      }
      for ins.each_def |tmp| {
        let color = self.min_vacant(registers);
        assert(color <= arch::num_regs);
        assert(self.colors.insert(tmp, color));
        if set::contains(tmplive, tmp) {
          set::add(registers, color);
        }
      }
      match ins {
        @Spill(_, t) => {
          let slot = match self.slots.find(t) {
            None => {
              let slot = self.min_vacant(slots);
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
      debug!("%s %s", set::to_str(tmplive), set::to_str(slotlive));
    }

    for set::each(idominated[n]) |id| {
      self.color(id, idominated, tmpdata, slotdata);
    }
  }

  fn min_vacant(colors : map::Set<uint>) -> uint {
    let mut i = 1;
    while set::contains(colors, i) {
      i += 1;
    }
    return i;
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
        let prev = cfg[pred];
        cfg.update_node(pred, @(prev + ins));
      }
    }
  }

  fn resolve_perm(result : &[uint], incoming : &[uint]) -> ~[@Instruction] {
    /* build up some small conversion maps */
    use sim = std::smallintmap;
    let src_dst = sim::mk();
    for vec::each2(result, incoming) |&a, &b| {
      src_dst.insert(b, a);
    }

    /* Permute the registers by following cycles */
    let mkreg = |i : uint| @Register(arch::num_reg(i), ir::Pointer);
    let mut ins = ~[];
    for incoming.each |&src| {
      while src_dst.contains_key(src) {
        let dst = src_dst[src];
        if dst != src {
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

    info!("perm %? -> %? yielded %?", incoming, result, ins);
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
    for self.f.cfg.each_node |id, ins| {
      let ins = vec::build(|push| {
        if id == self.f.root {
          push(@BinaryOp(Sub, @Register(ESP, ir::Pointer),
                         @Immediate(self.max_slot * 8 as i32, ir::Pointer),
                         @Register(ESP, ir::Pointer)));
        }
        for ins.each |&ins| {
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
      @Raw(*) | @Phi(*) => push(i),
      @Condition(c, o1, o2) =>
        push(@Condition(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Die(c, o1, o2) =>
        push(@Die(c, self.alloc_op(o1), self.alloc_op(o2))),
      @Move(o1, o2) => push(@Move(self.alloc_op(o1), self.alloc_op(o2))),

      @Return => {
        push(@BinaryOp(Add, @Register(ESP, ir::Pointer),
                       @Immediate(self.max_slot * 8 as i32, ir::Pointer),
                       @Register(ESP, ir::Pointer)));
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

        if s1 == d {                             /* d = d op s2, perfect! */
          push(@BinaryOp(op, d, s2, s1));
        } else if s2 == d && op.commutative() {  /* d = s1 op d, must commute */
          push(@BinaryOp(op, d, s1, s2));
        } else if s2 == d {
          match op {
            /* d = s1 - d = -(d - s1) */
            Sub => {
              push(@BinaryOp(op, d, s1, s2));
              push(@Raw(~"neg " + d.pp()));
            }
            _ => fail(fmt!("think about this: %s", i.pp()))
          }
        } else {
          push(@Move(d, s1));
          push(@BinaryOp(op, d, s2, s1));
        }
      }
      @Call(e, n) => push(@Call(self.alloc_op(e), n))
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
