use core::hashmap::linear::{LinearMap, LinearSet};
use core::util::unreachable;
use core::either::*;

use std::{map, bitv};

use middle::{ssa, ir, liveness};
use middle::temp::Temp;
use back::coalesce;
use back::assem::*;
use utils::profile;

type CFG = graph::Graph<@~[@Instruction], ir::Edge>;
type RegisterSet = bitv::Bitv;
pub type ColorMap = LinearMap<Temp, uint>;
/* Left = move(dst, src), Right = xchg(r1, r1) */
type Resolution = Either<(uint, uint), (uint, uint)>;

struct Allocator {
  f: &mut Function,
  colors: ColorMap,
  slots: LinearMap<Tag, uint>,
  max_slot: uint,
  max_call_stack: uint,
  callee_saved: ~[uint],

  /* data needed for coalescing */
  precolored: LinearSet<Temp>,
  constraints: LinearMap<Temp, Constraint>,
}

pub fn color(p: &mut Program) {
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

fn min_vacant(colors: &RegisterSet) -> uint {
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

    do profile::dbg("coalescing") {
      coalesce::optimize(self.f, &mut self.colors,
                         &self.precolored, &self.constraints);
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
  fn color(&mut self, n: graph::NodeId) {
    debug!("coloring %?", n);
    let mut tmplive = LinearSet::new();
    let tmpdelta = self.f.liveness.deltas.get(&n);
    let registers = RegisterSet();
    for self.f.liveness.in.get(&n).each |&t| {
      tmplive.insert(t);
      registers.set(*self.colors.get(&t), true);
    }
    debug!("%s", tmplive.pp())

    let mut pcopy = None;
    for self.f.cfg[n].eachi |i, &ins| {
      /* examine data for next instruction for last use information */
      debug!("%s", ins.pp());
      debug!("deltas %?", tmpdelta[i]);
      debug!("before %s %s", tmplive.pp(), registers.pp());
      liveness::apply(&mut tmplive, &tmpdelta[i]);

      match ins {
        /* If we found a pcopy, then we're breaking liveness */
        @PCopy(*) => {
          assert(pcopy.is_none());
          pcopy = Some(ins);
          registers.clear();
          loop;
        }
        @MemPhi(def, _) => {
          if !self.slots.contains_key(&def) {
            self.slots.insert(def, self.max_slot);
            self.max_slot += 1;
          }
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
              /*debug!("assigning %s %? %s", $t.pp(), color, $regs.pp());*/
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
      debug!("after %s %s", tmplive.pp(), registers.pp());
      /* TODO: size of a bit vector */
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
      let mut mem_vars = ~[];
      let mut mem_maps = ~[];
      for ins.each |&ins| {
        match ins {
          @Phi(tmp, map) => {
            phi_vars.push(*self.colors.get(&tmp));
            phi_maps.push(map);
          }
          @MemPhi(def, map) => {
            mem_vars.push(def);
            mem_maps.push(map);
          }
          _ => break
        }
      }

      for cfg.each_pred(id) |pred| {
        let mut perm = ~[];
        let mut mems = ~[];
        for phi_maps.each |map| { perm.push(*self.colors.get(&map[pred])); }
        for mem_maps.each |map| { mems.push(map[pred]); }
        /* there are no critical edges in the graph, so we can just append */
        let mut ins = self.resolve_perm(phi_vars, perm);

        /* for each MemPhi, we need to move stack slot 'src' to stack slot 'dst'
           without using a register */
        for vec::each2(mem_vars, mems) |&dst, &src| {
          let dst = self.stack_loc(dst);
          let src = self.stack_loc(src);
          ins.push(@Raw(fmt!("pushq %s", Stack(src).pp())));
          ins.push(@Raw(fmt!("popq %s", Stack(dst).pp())));
        }

        if ins.len() == 0 { loop }
        cfg.update_node(pred, @(cfg[pred] + ins));
      }
    }
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
    let (order, _) = self.f.cfg.postorder(self.f.root);
    for vec::rev_each(order) |&id| {
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

  fn alloc_ins(&self, i: @Instruction, push: &pure fn(@Instruction)) {
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
      @MemPhi(*) | @Use(*) | @Phi(*) | @Arg(*) => (),

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

  fn stack_loc(&self, tag: Tag) -> uint {
    *self.slots.get(&tag) * arch::ptrsize + self.max_call_stack
  }

  fn stack_pos(&self, tag: Tag) -> @Address {
    @Stack(self.stack_loc(tag))
  }

  fn stack_size(&self, with_saves: bool) -> uint {
    let slots = self.max_slot * 8;
    let calls = self.max_call_stack;
    let saves = self.callee_saved.len() * arch::ptrsize;
    let alter = if with_saves { 0 } else { saves };
    return arch::align_stack(slots + calls + saves) - alter;
  }

  fn alloc_op(&self, o: @Operand) -> @Operand {
    match o {
      @Immediate(*) | @LabelOp(*) | @Register(*) => o,
      @Temp(tmp) => self.alloc_tmp(tmp)
    }
  }

  fn alloc_tmp(&self, tmp: Temp) -> @Operand {
    @Register(arch::num_reg(*self.colors.get(&tmp)),
              *self.f.sizes.get(&tmp))
  }

  fn resolve_perm(&self, result: &[uint], incoming: &[uint]) -> ~[@Instruction] {
    let mkreg = |i: uint| @Register(arch::num_reg(i), ir::Pointer);
    resolve_perm(result, incoming).map(|&r| {
      match r {
        Left((dst, src)) => @Move(mkreg(dst), mkreg(src)),
        Right((r1, r2)) => @Raw(fmt!("xchg %s, %s", mkreg(r1).pp(),
                                     mkreg(r2).pp()))
      }
    })
  }
}

impl bitv::Bitv: PrettyPrint {
  pure fn pp(&self) -> ~str {
    let mut s = ~"{";
    let mut first = true;
    /* TODO: does this really have to be pure? */
    unsafe {
      for self.ones |i| {
        if first {
          first = false;
        } else {
          s += ~", ";
        }
        s += i.to_str();
      }
    }
    return s + ~"}";
  }
}

/**
 * Perform the actual resolution of moves/exchanges to get from incoming to the
 * result specified.
 */
fn resolve_perm(result: &[uint], incoming: &[uint]) -> ~[Resolution] {
  use sim = std::smallintmap;
  /* maps describing src -> dst and dst -> src */
  let src_dst = sim::mk();
  let dst_src = sim::mk();
  for vec::each2(result, incoming) |&dst, &src| {
    if dst != src {
      src_dst.insert(src, dst);
      dst_src.insert(dst, src);
    }
  }

  let mut ret = ~[];

  /* deal with all move chains first */
  for result.each |&dst| {
    /* if this destination is also a source, it's not the end of a chain */
    if src_dst.contains_key(dst) { loop }

    /* having found the end of a chain, go up the chain moving everything into
       the right spot as we go along */
    let mut cur = dst;
    while dst_src.contains_key(cur) {
      ret.push(Left((cur, dst_src[cur])));
      let nxt = dst_src[cur];
      dst_src.remove(cur);
      cur = nxt;
    }
  }

  /* Next, deal with all loops */
  for result.each |&dst| {
    /* if this isn't a destination any more, it was part of a chain */
    if !dst_src.contains_key(dst) { loop }

    /* Exchange everything through the 'dst' register to resolve the chain */
    let mut cur = dst;
    while src_dst.contains_key(cur) {
      let nxt = src_dst[cur];
      src_dst.remove(cur);
      if nxt == dst { break }
      ret.push(Right((dst, nxt)));
      cur = nxt;
    }
  }

  return ret;
}

#[cfg(test)]
fn resolve_test(from: &[uint], to: &[uint]) {
  use sim = std::smallintmap;
  let perm = resolve_perm(to, from);
  let mut regs = vec::from_fn(10, |i| i);
  for perm.each |&foo| {
    match foo {
      Left((dst, src))  => { regs[dst] = regs[src]; }
      Right((dst, src)) => { regs[dst] <-> regs[src]; }
    }
  }

  let map = sim::mk();
  for uint::range(0, 10) |i| { map.insert(i, ()); }
  for vec::each2(from, to) |&f, &t| {
    map.remove(t);
    if regs[t] != f {
      fail(fmt!("expected %? to be %? but it was %?", t, f, regs[t]));
    }
  }
  debug!("%?", regs);
  for map.each |k, _| {
    if regs[k] != k {
      fail(fmt!("clobbered %? to %?", k, regs[k]));
    }
  }
}

#[test]
fn test_resolve() {
  resolve_test(~[], ~[]);
  resolve_test(~[1], ~[1]);
  resolve_test(~[1, 2], ~[1, 2]);
  resolve_test(~[1], ~[2]);
  resolve_test(~[1, 2], ~[2, 3]);
  resolve_test(~[1, 2], ~[2, 1]);
  resolve_test(~[1, 2, 3, 4], ~[2, 1, 4, 5]);
  resolve_test(~[1, 2, 3], ~[2, 3, 1]);
  resolve_test(~[1, 2, 3, 4, 5, 6, 7, 8], ~[2, 3, 1, 5, 6, 4, 8, 9]);
}
