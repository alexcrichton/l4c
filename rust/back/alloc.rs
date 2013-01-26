use core::hashmap::linear::{LinearMap, LinearSet};
use core::util::unreachable;

use std::{map, bitv};

use middle::{ssa, ir, liveness};
use middle::temp::Temp;
use back::coalesce;
use back::assem::*;
use utils::profile;

type CFG = graph::Graph<@~[@Instruction], ir::Edge>;
type RegisterSet = bitv::Bitv;
pub type ColorMap = LinearMap<Temp, uint>;

struct Allocator {
  f : &mut Function,
  colors : ColorMap,
  slots : LinearMap<Tag, uint>,
  mut max_slot : uint,
  mut max_call_stack : uint,
  callee_saved : ~[uint],

  /* data needed for coalescing */
  precolored : LinearSet<Temp>,
  constraints : LinearMap<Temp, Constraint>,
}

pub fn color(p : &mut Program) {
  for vec::each_mut(p.funs) |f| {
    liveness::calculate(&f.cfg, f.root, &mut f.liveness);

    let mut a = Allocator{ colors: LinearMap::new(),
                           precolored: LinearSet::new(),
                           constraints: LinearMap::new(),
                           slots: LinearMap::new(),
                           f: f,
                           max_slot: 0,
                           max_call_stack: 0,
                           callee_saved: ~[] };
    a.run();
  }
}

fn RegisterSet() -> RegisterSet {
  bitv::Bitv(arch::num_regs + 1, false)
}

fn min_vacant(colors : &RegisterSet) -> uint {
  let mut i = 1;
  while colors.get(i) {
    i += 1;
  }
  return i;
}

impl Allocator {
  fn run(&mut self) {
    /* TODO: why can't this be above */
    /* Color the graph completely */
    info!("coloring: %s", self.f.name);

    do profile::dbg("coloring") { self.color(self.f.root); }
    for self.colors.each |tmp, color| {
      debug!("%s => %?", tmp.to_str(), color);
    }

    let foo = bitv::Bitv(self.f.ssa.temps, false);
    for self.precolored.each |&tmp| {
      foo.set(tmp, true);
    }
    do profile::dbg("coalescing") {
      coalesce::optimize(&mut *self.f, &mut self.colors, &foo, &self.constraints);
    }

    /* Finally remove all phi nodes and all temps */
    do profile::dbg("removing phis") { self.remove_phis(); }
    do profile::dbg("removing tmps") { self.remove_temps(); }
  }

  /**
   * Color the functions CFG according to the algorithm outlined in the paper
   * "Towards Register Allocation for Programs in SSA-form" by Hack et al.
   * A top-down traversal of the dominator tree is done, coloring all
   * definitions as they are seen with the first available color.
   */
  fn color(&mut self, n : graph::NodeId) {
    debug!("coloring %?", n);
    let mut tmplive = LinearSet::new();
    let tmpdelta = self.f.liveness.deltas.get(&n);
    let registers = RegisterSet();
    for self.f.liveness.in.get(&n).each |&t| {
      tmplive.insert(t);
      registers.set(*self.colors.get(&t), true);
    }
    /* TODO: set::to_str */
    /*debug!("%s", set::to_str(tmplive))*/

    let mut pcopy = None;
    for self.f.cfg[n].eachi |i, &ins| {
      /* examine data for next instruction for last use information */
      debug!("%s", ins.pp());
      debug!("deltas %?", tmpdelta[i]);
      /* TODO: set::to_str */
      /*debug!("before %s %s", set::to_str(tmplive), set::to_str(registers));*/
      tmplive.apply(&tmpdelta[i]);

      match ins {
        /* If we found a pcopy, then we're breaking liveness */
        @PCopy(*) => {
          assert(pcopy.is_none());
          pcopy = Some(ins);
          registers.clear();
          loop;
        }
        /* Be sure we always assign stack slots */
        @Spill(_, t) => {
          if !self.slots.contains_key(&t) {
            self.slots.insert(t, self.max_slot);
            self.max_slot += 1;
          }
        }
        /* Keep track of the maximum number of args passed to called funs */
        @Store(@Stack(pos), _) => {
          self.max_call_stack = uint::max(pos + 8, self.max_call_stack);
        }
        /* do simple precoloring of args up front */
        @Arg(tmp, i) => {
          let color = arch::reg_num(arch::arg_reg(i));
          self.colors.insert(tmp, color);
          self.precolored.insert(tmp);
          if tmplive.contains(&tmp) {
            registers.set(color, true);
          }
          loop;
        }
        _ => ()
      }

      /* If we found a pcopy, we need to think about being constrained */
      if pcopy.is_some() {
        let banned = RegisterSet();
        macro_rules! precolor(
          ($o:expr, $r:expr) => (
            match $o {
              @Temp(t) => {
                assert self.colors.insert(t, arch::reg_num($r));
                assert self.precolored.insert(t);
              }
              _ => fail(fmt!("not a tmp %?", $o))
            }
          )
        );

        match ins {
          @BinaryOp(op, dst, op1, op2) if op.constrained() => {
            match op {
              /* div/mod both clobber eax/edx, and have the result in one */
              Div | Mod => {
                precolor!(op1, EAX);
                precolor!(dst, match op { Div => EAX, _ => EDX });
                banned.set(arch::reg_num(EDX), true);
                banned.set(arch::reg_num(EAX), true);
                for tmplive.each |&tmp| {
                  assert self.constraints.insert(tmp, Idiv);
                }
                match op2 {
                  @Temp(t) => { self.constraints.insert(t, Idiv); }
                  _ => fail(~"not a tmp")
                }
              }

              /* shifting is easy, the second op is just in ecx */
              Rsh | Lsh => {
                precolor!(op2, ECX);
                banned.set(arch::reg_num(ECX), true);
              }
              _ => fail(fmt!("implement %?", op))
            }
          }

          /* Calls precolor the result and arguments, and the caller-saved
             registers are all banned for this instruction */
          @Call(dst, _, ref args) => {
            self.colors.insert(dst, arch::reg_num(EAX));
            assert self.precolored.insert(dst);
            for args.eachi |i, &arg| {
              precolor!(arg, arch::arg_reg(i));
            }
            for arch::each_caller |r| {
              banned.set(arch::reg_num(r), true);
            }
            for tmplive.each |&tmp| {
              assert self.constraints.insert(tmp, Caller);
            }
          }

          /* returns just have their argument precolored to EAX */
          @Return(op) => {
            precolor!(op, EAX);
            banned.set(arch::reg_num(EAX), true);
          }

          /* All unconstrained instructions between a pcopy and the constrained
             instruction are spills/reloads and we can ignore them (we'll color
             them later */
          _ => loop
        };

        macro_rules! process(
          ($t:expr, $regs:expr) => (
            if self.colors.contains_key(&$t) {
              assert $regs.get(*self.colors.get(&$t));
            } else {
              let color = min_vacant(&$regs);
              /* TODO: set::to_str */
              /*debug!("assigning %s %? %s", $t.pp(), color, set::to_str(regs));*/
              assert color <= arch::num_regs;
              assert self.colors.insert($t, color);
              $regs.set(color, true);
            }
          )
        );

        /* TODO: cleanup? */
        debug!("coloring uses");
        for ins.each_use |tmp| {
          process!(tmp, banned)
        }
        debug!("processing live-out temporaries");
        for tmplive.each |&tmp| {
          process!(tmp, banned);
        }
        debug!("pruning dead uses");
        for ins.each_use |tmp| {
          if !tmplive.contains(&tmp) {
            debug!("removing %?", tmp);
            banned.set(*self.colors.get(&tmp), false);
          }
        }
        debug!("processing previous pcopy");
        match pcopy {
          Some(@PCopy(copies)) => {
            let regstmp = RegisterSet();
            for copies.each |dst, src| {
              assert dst != src;
              match self.colors.find(&dst) {
                Some(&c) => { regstmp.set(c, true); }
                None    => ()
              }
            }
            for copies.each_key |dst| {
              process!(dst, regstmp);
            }
          }
          _ => unreachable()
        }
        debug!("adding in all live-out temps");
        for tmplive.each |tmp| {
          match self.colors.find(tmp) {
            Some(&c) => { registers.set(c, true); }
            None => ()
          }
        }
        debug!("processing defs");
        for ins.each_def |tmp| {
          if !self.colors.contains_key(&tmp) {
            process!(tmp, registers);
            if !tmplive.contains(&tmp) {
              registers.set(*self.colors.get(&tmp), false);
            }
          }
        }
        pcopy = None;
      } else {
        /* normal coloration of each instruction */
        for ins.each_use |tmp| {
          debug!("found use %?", tmp);
          if !tmplive.contains(&tmp) {
            debug!("removing %? %?", tmp, self.colors.get(&tmp));
            registers.set(*self.colors.get(&tmp), false);
          }
        }
        for ins.each_def |tmp| {
          let color = min_vacant(&registers);
          assert color <= arch::num_regs;
          assert self.colors.insert(tmp, color);
          if tmplive.contains(&tmp) {
            registers.set(color, true);
          }
        }
      }
      /* TODO: set::to_str */
      /*debug!("after %s %s", set::to_str(tmplive), set::to_str(registers));*/
      /*assert(registers.size() == tmplive.size());*/
    }

    for self.f.ssa.idominated.get(&n).each |&id| {
      self.color(id);
    }
  }

  fn remove_phis(&self) {
    let cfg = &mut self.f.cfg;
    for cfg.each_node |id, ins| {
      let mut phi_vars = ~[];
      let mut phi_maps = ~[];
      for ins.each |&ins| {
        match ins {
          @Phi(tmp, map) => {
            phi_vars.push(*self.colors.get(&tmp));
            phi_maps.push(map);
          }
          _ => break
        }
      }

      for cfg.each_pred(id) |pred| {
        let mut perm = ~[];
        for phi_maps.each |map| {
          perm.push(*self.colors.get(&map[pred]));
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
  fn remove_temps(&mut self) {
    for self.f.cfg.each_rev_postorder(self.f.root) |&id| {
      let ins = vec::build(|push| {
        if id == self.f.root {
          for self.colors.each |_, &color| {
            let reg = arch::num_reg(color);
            if arch::callee_reg(reg) && !self.callee_saved.contains(&color) {
              self.callee_saved.push(color);
              push(@Raw(fmt!("push %s", reg.size(ir::Pointer))));
            }
          }
          if self.stack_size(false) != 0 {
            push(@BinaryOp(Sub, @Register(ESP, ir::Pointer),
                           @Immediate(self.stack_size(false) as i32, ir::Pointer),
                           @Register(ESP, ir::Pointer)));
          }
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
      @Spill(t, tag) => push(@Store(self.stack_pos(tag), self.alloc_tmp(t))),
      @Reload(t, tag) => push(@Load(self.alloc_tmp(t), self.stack_pos(tag))),
      @Load(dst, @MOp(addr)) =>
        push(@Load(self.alloc_op(dst), @MOp(self.alloc_op(addr)))),
      @Load(dst, @StackArg(idx)) =>
        push(@Load(self.alloc_op(dst),
             @Stack((idx + 1) * arch::ptrsize + self.stack_size(true)))),
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
      @Use(*) | @Phi(*) | @Arg(*) => (),

      @Return(_) => {
        if self.stack_size(false) != 0 {
          push(@BinaryOp(Add, @Register(ESP, ir::Pointer),
                         @Immediate(self.stack_size(false) as i32, ir::Pointer),
                         @Register(ESP, ir::Pointer)));
        }
        for vec::rev_each(self.callee_saved) |&color| {
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

      @PCopy(copies) => {
        debug!("%?", copies);
        let mut dsts = ~[];
        let mut srcs = ~[];
        for copies.each |dst, src| {
          dsts.push(*self.colors.get(&dst));
          srcs.push(*self.colors.get(&src));
        }
        for self.resolve_perm(dsts, srcs).each |&ins| {
          push(ins);
        }
      }
    }
  }

  fn stack_pos(tag : Tag) -> @Address {
    @Stack(*self.slots.get(&tag) * arch::ptrsize + self.max_call_stack)
  }

  fn stack_size(with_saves : bool) -> uint {
    let slots = self.max_slot * 8;
    let calls = self.max_call_stack;
    let saves = self.callee_saved.len() * arch::ptrsize;
    let alter = if with_saves { 0 } else { saves };
    return arch::align_stack(slots + calls + saves) - alter;
  }

  fn alloc_op(o : @Operand) -> @Operand {
    match o {
      @Immediate(*) | @LabelOp(*) | @Register(*) => o,
      @Temp(tmp) => self.alloc_tmp(tmp)
    }
  }

  fn alloc_tmp(tmp: Temp) -> @Operand {
    @Register(arch::num_reg(*self.colors.get(&tmp)),
              self.f.sizes[tmp])
  }
}
