use std::map;
use middle::{ssa, ir, liveness};
use middle::temp::Temp;
use back::assem::*;
use utils::bitv::Bitv;

type CFG = graph::Graph<@~[@assem::Instruction], ir::Edge>;
pub type ColorMap = map::HashMap<Temp, uint>;

struct Allocator {
  f : &Function,
  colors : ColorMap,
  slots : map::HashMap<Tag, uint>,
  mut max_slot : uint,
  mut max_call_stack : uint,
  callee_saved : dvec::DVec<uint>,

  /* data needed for coalescing */
  precolored : map::Set<Temp>,
  constraints : map::HashMap<Temp, Constraint>,
}

pub fn color(p : &Program) {
  for p.funs.each |f| {
    let a = Allocator{ colors: map::HashMap(),
                       precolored: map::HashMap(),
                       constraints: map::HashMap(),
                       slots: map::HashMap(),
                       f: f,
                       max_slot: 0,
                       max_call_stack: 0,
                       callee_saved: dvec::DVec() };
    liveness::calculate(&f.cfg, f.root, &f.liveness);

    /* Color the graph completely */
    info!("coloring: %s", f.name);

    do profile::dbg("coloring") { a.color(f.root); }
    for a.colors.each |tmp, color| {
      debug!("%s => %?", tmp.to_str(), color);
    }

    do profile::dbg("coalescing") {
      coalesce::optimize(f, a.colors, a.precolored, a.constraints);
    }

    /* Finally remove all phi nodes and all temps */
    do profile::dbg("removing phis") { a.remove_phis(); }
    do profile::dbg("removing tmps") { a.remove_temps(); }
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
  fn color(n : graph::NodeId) {
    debug!("coloring %?", n);
    let tmplive = self.f.liveness.in[n];
    let tmpdelta = self.f.liveness.deltas[n];
    let registers = map::HashMap();
    debug!("%s", set::to_str(tmplive))
    for set::each(tmplive) |t| {
      set::add(registers, self.colors[t as Temp]);
    }

    let mut pcopy = None;
    for self.f.cfg[n].eachi |i, &ins| {
      /* examine data for next instruction for last use information */
      debug!("%s", ins.pp());
      debug!("deltas %?", tmpdelta[i]);
      debug!("before %s %s", set::to_str(tmplive), set::to_str(registers));
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
          if !self.slots.contains_key(t) {
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
          self.colors.insert(tmp, arch::reg_num(arch::arg_reg(i)));
          if set::contains(tmplive, tmp) {
            set::add(registers, self.colors[tmp]);
          }
          loop;
        }
        _ => ()
      }

      /* If we found a pcopy, we need to think about being constrained */
      if pcopy.is_some() {
        let banned = map::HashMap();
        macro_rules! precolor(($o:expr, $r:expr) => (
          match $o {
            @Temp(t) => {
              assert self.colors.insert(t, arch::reg_num($r));
              assert set::add(self.precolored, t);
            }
            _ => fail(fmt!("not a tmp %?", $o))
          }
        ););

        match ins {
          @BinaryOp(op, dst, op1, op2) if op.constrained() => {
            match op {
              /* div/mod both clobber eax/edx, and have the result in one */
              Div | Mod => {
                precolor!(op1, EAX);
                precolor!(dst, match op { Div => EAX, _ => EDX });
                set::add(banned, arch::reg_num(EDX));
                set::add(banned, arch::reg_num(EAX));
                for set::each(tmplive) |tmp| {
                  assert self.constraints.insert(tmp, Idiv);
                }
              }

              /* shifting is easy, the second op is just in ecx */
              Rsh | Lsh => {
                precolor!(op2, ECX);
                set::add(banned, arch::reg_num(ECX));
              }
              _ => fail(fmt!("implement %?", op))
            }
          }

          /* Calls precolor the result and arguments, and the caller-saved
             registers are all banned for this instruction */
          @Call(dst, _, ref args) => {
            self.colors.insert(dst, arch::reg_num(EAX));
            assert set::add(self.precolored, dst);
            for args.eachi |i, &arg| {
              precolor!(arg, arch::arg_reg(i));
            }
            for arch::each_caller |r| {
              set::add(banned, arch::reg_num(r));
            }
            for set::each(tmplive) |tmp| {
              assert self.constraints.insert(tmp, Caller);
            }
          }

          /* returns just have their argument precolored to EAX */
          @Return(op) => {
            precolor!(op, EAX);
            set::add(banned, arch::reg_num(EAX));
          }

          /* All unconstrained instructions between a pcopy and the constrained
             instruction are spills/reloads and we can ignore them (we'll color
             them later */
          _ => loop
        };

        let process = |t : Temp, regs : map::Set<uint>, colors : ColorMap| {
          match colors.find(t) {
            Some(c) => { assert set::contains(regs, c); }
            None => {
              let color = min_vacant(regs);
              debug!("assigning %s %? %s", t.pp(), color, set::to_str(regs));
              assert color <= arch::num_regs;
              assert colors.insert(t, color);
              assert set::add(regs, color);
            }
          }
        };

        /* TODO: cleanup? */
        debug!("coloring uses");
        for ins.each_use |tmp| {
          process(tmp, banned, self.colors);
        }
        debug!("processing live-out temporaries");
        for set::each(tmplive) |tmp| {
          process(tmp, banned, self.colors);
        }
        debug!("pruning dead uses");
        for ins.each_use |tmp| {
          if !set::contains(tmplive, tmp) {
            debug!("removing %?", tmp);
            set::remove(banned, self.colors[tmp]);
          }
        }
        debug!("processing previous pcopy");
        match pcopy {
          Some(@PCopy(ref copies)) => {
            let regstmp = map::HashMap();
            for copies.each |&(dst, src)| {
              assert dst != src;
              match self.colors.find(dst) {
                Some(c) => { set::add(regstmp, c); }
                None    => ()
              }
            }
            for copies.each |&(dst, _)| {
              process(dst, regstmp, self.colors);
            }
          }
          _ => unreachable()
        }
        debug!("adding in all live-out temps");
        for set::each(tmplive) |tmp| {
          match self.colors.find(tmp) {
            Some(c) => { assert set::add(registers, c); }
            None => ()
          }
        }
        debug!("processing defs");
        for ins.each_def |tmp| {
          if !self.colors.contains_key(tmp) {
            process(tmp, registers, self.colors);
            if !set::contains(tmplive, tmp) {
              assert set::remove(registers, self.colors[tmp]);
            }
          }
        }
        pcopy = None;
      } else {
        /* normal coloration of each instruction */
        for ins.each_use |tmp| {
          debug!("found use %?", tmp);
          if !set::contains(tmplive, tmp) {
            debug!("removing %? %?", tmp, self.colors[tmp]);
            set::remove(registers, self.colors[tmp]);
          }
        }
        for ins.each_def |tmp| {
          debug!("%? %?", registers.size(), tmplive.size());
          let color = min_vacant(registers);
          assert color <= arch::num_regs;
          assert self.colors.insert(tmp, color);
          if set::contains(tmplive, tmp) {
            assert set::add(registers, color);
          }
        }
      }
      debug!("after %s %s", set::to_str(tmplive), set::to_str(registers));
      assert(registers.size() == tmplive.size());
    }

    let idominated = self.f.ssa.idominated;
    debug!("%s", set::to_str(idominated[n]));
    for set::each(idominated[n]) |id| {
      self.color(id);
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
      @Spill(tmp, tag) => {
        let reg = @Register(arch::num_reg(self.colors[tmp]), self.f.sizes[tmp]);
        push(@Store(self.stack_pos(tag), reg));
      }
      @Reload(dst, tag) => {
        let reg = @Register(arch::num_reg(self.colors[dst]), self.f.sizes[dst]);
        push(@Load(reg, self.stack_pos(tag)));
      }
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

  fn stack_pos(tag : Tag) -> @Address {
    @Stack(self.slots[tag] * arch::ptrsize + self.max_call_stack)
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
      @Temp(tmp) =>
        @Register(arch::num_reg(self.colors[tmp]), self.f.sizes[tmp])
    }
  }
}
