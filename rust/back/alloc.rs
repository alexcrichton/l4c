use core::hashmap::linear::{LinearMap, LinearSet};

use std::bitv;
use std::smallintmap::SmallIntMap;

use middle::{ssa, ir, liveness};
use middle::temp::Temp;
use back::arch;
use back::assem::*;
use back::coalesce;
use utils::{profile, graph, PrettyPrint};

type RegisterSet = bitv::Bitv;
pub type ColorMap = SmallIntMap<uint>;
pub type ConstraintMap = SmallIntMap<Constraint>;
/* Left = move(dst, src), Right = xchg(r1, r1) */
type Resolution = Either<(uint, uint), (uint, uint)>;

struct Allocator {
  f: &'self mut Function,
  colors: ColorMap,
  slots: LinearMap<Tag, uint>,
  max_slot: uint,
  max_call_stack: uint,
  callee_saved: ~[uint],

  /* data needed for coalescing */
  precolored: LinearSet<Temp>,
  constraints: ConstraintMap,
}

pub fn color(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    liveness::calculate(&f.cfg, f.root, &mut f.liveness);

    let mut a = Allocator{ colors: SmallIntMap::new(),
                           precolored: LinearSet::new(),
                           constraints: SmallIntMap::new(),
                           slots: LinearMap::new(),
                           f: f,
                           max_slot: 0,
                           max_call_stack: 0,
                           callee_saved: ~[] };
    a.run();
  }
}

fn RegisterSet() -> RegisterSet {
  bitv::Bitv::new(arch::num_regs + 1, false)
}

fn min_vacant(colors: &RegisterSet) -> uint {
  debug!("min vacant %s", colors.pp());
  let mut i = 1;
  while colors.get(i) {
    i += 1;
  }
  debug!("%?", i);
  return i;
}

impl Allocator<'self> {
  fn run(&mut self) {
    /* TODO: why can't this be above */
    /* Color the graph completely */
    info!("coloring: %s", self.f.name);

    do profile::dbg("coloring") { self.color(self.f.root); }
    for self.colors.each |&(tmp, color)| {
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
    let mut registers = RegisterSet();
    for self.f.liveness.in.get(&n).each |&t| {
      tmplive.insert(t);
      registers.set(*self.colors.get(&t), true);
    }
    debug!("%s", tmplive.pp())

    let mut pcopy = None;
    for self.f.cfg[n].eachi |i, ins| {
      /* examine data for next instruction for last use information */
      debug!("%s", ins.pp());
      debug!("deltas %?", tmpdelta[i]);
      debug!("before %s %s", tmplive.pp(), registers.pp());
      liveness::apply(&mut tmplive, &tmpdelta[i]);

      match *ins {
        /* If we found a pcopy, then we're breaking liveness */
        ~PCopy(copy copies) => {
          fail_unless!(pcopy.is_none());
          pcopy = Some(copies);
          registers.clear();
          loop;
        }
        /* Be sure we always assign stack slots. It should be noted that these
         * are currently not in SSA form. */
        ~MemPhi(def, _) => {
          if !self.slots.contains_key(&def) {
            self.slots.insert(def, self.max_slot);
            self.max_slot += 1;
          }
        }
        ~Spill(_, t) => {
          if !self.slots.contains_key(&t) {
            self.slots.insert(t, self.max_slot);
            self.max_slot += 1;
          }
        }
        /* Keep track of the maximum number of args passed to called funs */
        ~Store(~Stack(pos), _) => {
          self.max_call_stack = uint::max(pos + arch::ptrsize,
                                          self.max_call_stack);
        }
        /* do simple precoloring of args up front */
        ~Arg(tmp, i) => {
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
        let mut banned = RegisterSet();
        macro_rules! precolor(
          ($o:expr, $r:expr) => (
            match *$o {
              ~Temp(t) => {
                fail_unless!(self.colors.insert(t, arch::reg_num($r)));
                fail_unless!(self.precolored.insert(t));
              }
              _ => fail!(fmt!("not a tmp %?", $o))
            }
          )
        );

        match *ins {
          ~BinaryOp(op, ref dst, ref op1, ref op2) if op.constrained() => {
            match op {
              /* div/mod both clobber eax/edx, and have the result in one */
              Div | Mod => {
                precolor!(op1, EAX);
                precolor!(dst, match op { Div => EAX, _ => EDX });
                banned.set(arch::reg_num(EDX), true);
                banned.set(arch::reg_num(EAX), true);
                for tmplive.each |&tmp| {
                  fail_unless!(self.constraints.insert(tmp, Idiv));
                }
                match *op2 {
                  ~Temp(t) => { self.constraints.insert(t, Idiv); }
                  _ => fail!(~"not a tmp")
                }
              }

              /* shifting is easy, the second op is just in ecx */
              Rsh | Lsh => {
                precolor!(op2, ECX);
                banned.set(arch::reg_num(ECX), true);
              }
              _ => fail!(fmt!("implement %?", op))
            }
          }

          /* Calls precolor the result and arguments, and the caller-saved
             registers are all banned for this instruction */
          ~Call(dst, _, ref args) => {
            self.colors.insert(dst, arch::reg_num(EAX));
            fail_unless!(self.precolored.insert(dst));
            for args.eachi |i, arg| {
              precolor!(arg, arch::arg_reg(i));
            }
            for arch::each_caller |r| {
              banned.set(arch::reg_num(r), true);
            }
            for tmplive.each |&tmp| {
              fail_unless!(self.constraints.insert(tmp, Caller));
            }
          }

          /* returns just have their argument precolored to EAX */
          ~Return(ref op) => {
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
              fail_unless!($regs.get(*self.colors.get(&$t)));
            } else {
              let color = min_vacant(&$regs);
              /*debug!("assigning %s %? %s", $t.pp(), color, $regs.pp());*/
              fail_unless!(color <= arch::num_regs);
              fail_unless!(self.colors.insert($t, color));
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
        let copies = pcopy.swap_unwrap();
        let mut regstmp = RegisterSet();
        for copies.each |&(dst, src)| {
          fail_unless!(dst != src);
          match self.colors.find(&dst) {
            Some(&c) => { regstmp.set(c, true); }
            None    => ()
          }
        }
        for copies.each |&(dst, _)| {
          process!(dst, regstmp);
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
          fail_unless!(color <= arch::num_regs);
          fail_unless!(self.colors.insert(tmp, color));
          if tmplive.contains(&tmp) {
            registers.set(color, true);
          }
        }
      }
      debug!("after %s %s", tmplive.pp(), registers.pp());
    }

    for self.f.ssa.idominated.get(&n).each |&id| {
      self.color(id);
    }
  }

  fn remove_phis(&self) {
    let cfg = &mut self.f.cfg;
    for cfg.each_node |id, ins| {
      let mut phi_vars = ~[];
      let mut phi_maps = LinearMap::new();
      let mut mem_vars = ~[];
      let mut mem_maps = LinearMap::new();
      for cfg.each_pred(id) |pred| {
        phi_maps.insert(pred, ~[]);
        mem_maps.insert(pred, ~[]);
      }

      for ins.each |&ins| {
        match ins {
          ~Phi(tmp, ref map) => {
            debug!("phi var %? %?", tmp, *self.colors.get(&tmp));
            phi_vars.push(*self.colors.get(&tmp));
            for map.each |&(&pred, &tmp)| {
              let mut L = phi_maps.pop(&pred).unwrap();
              L.push(tmp);
              phi_maps.insert(pred, L);
            }
          }
          ~MemPhi(def, ref map) => {
            mem_vars.push(def);
            for map.each |&(&pred, &slot)| {
              let mut L = mem_maps.pop(&pred).unwrap();
              L.push(slot);
              mem_maps.insert(pred, L);
            }
          }
          _ => break
        }
      }

      for cfg.each_pred(id) |pred| {
        let mut perm = phi_maps.pop(&pred).unwrap();
        let mut mems = mem_maps.pop(&pred).unwrap();
        perm = perm.map(|&tmp| *self.colors.get(&tmp));

        debug!("resolving phi for %? <= %?", id, pred);
        let mut ins = self.resolve_perm(phi_vars, perm);

        /* for each MemPhi, we need to move stack slot 'src' to stack slot 'dst'
           without using a register */
        for mems.eachi |i, &src| {
          let src = self.stack_loc(src);
          ins.push(~Raw(fmt!("pushq %s", Stack(src + i * arch::ptrsize).pp())));
        }
        for mem_vars.eachi_reverse |i, &dst| {
          let dst = self.stack_loc(dst);
          ins.push(~Raw(fmt!("popq %s", Stack(dst + i * arch::ptrsize).pp())));
        }

        if ins.len() == 0 { loop }
        /* there are no critical edges in the graph, so we can just append */
        cfg.map_consume_node(pred, |stms| stms + ins);
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
    for order.each_reverse |&id| {
      let ins = vec::build(|push| {
        if id == self.f.root {
          for self.colors.each |&(_, &color)| {
            let reg = arch::num_reg(color);
            if arch::callee_reg(reg) && !self.callee_saved.contains(&color) {
              self.callee_saved.push(color);
              push(~Raw(fmt!("push %s", reg.size(ir::Pointer))));
            }
          }
          if self.stack_size(false) != 0 {
            push(~BinaryOp(Sub, ~Register(ESP, ir::Pointer),
                           ~Immediate(self.stack_size(false) as i32, ir::Pointer),
                           ~Register(ESP, ir::Pointer)));
          }
        }
        for self.f.cfg[id].each |&ins| {
          self.alloc_ins(ins, push);
        }
      });
      self.f.cfg.update_node(id, ins);
    }
  }

  fn alloc_ins(&self, i: ~Instruction, push: &fn(~Instruction)) {
    match i {
      ~Spill(t, tag) => push(~Store(self.stack_pos(tag), self.alloc_tmp(t))),
      ~Reload(t, tag) => push(~Load(self.alloc_tmp(t), self.stack_pos(tag))),
      ~Load(dst, addr) =>
        push(~Load(self.alloc_op(dst), self.alloc_addr(addr))),
      ~Store(addr, src) => push(~Store(self.alloc_addr(addr),
                                       self.alloc_op(src))),
      ~Raw(s) => push(~Raw(s)),
      ~Condition(c, o1, o2) =>
        push(~Condition(c, self.alloc_op(o1), self.alloc_op(o2))),
      ~Die(c, o1, o2) =>
        push(~Die(c, self.alloc_op(o1), self.alloc_op(o2))),
      ~Move(o1, o2) => push(~Move(self.alloc_op(o1), self.alloc_op(o2))),
      ~MemPhi(*) | ~Use(*) | ~Phi(*) | ~Arg(*) => (),

      ~Return(op) => {
        if self.stack_size(false) != 0 {
          push(~BinaryOp(Add, ~Register(ESP, ir::Pointer),
                         ~Immediate(self.stack_size(false) as i32, ir::Pointer),
                         ~Register(ESP, ir::Pointer)));
        }
        for self.callee_saved.each_reverse |&color| {
          push(~Raw(fmt!("pop %s", arch::num_reg(color).size(ir::Pointer))));
        }
        push(~Return(op));
      }

      /* When going through formatting and on x86 -
            BinaryOp(op, d, s1, s2) <=> d = d op s1
         and s2 is put in the commments */
      ~BinaryOp(op, d, s1, s2) => {
        let d = self.alloc_op(d);
        let s1 = self.alloc_op(s1);
        let s2 = self.alloc_op(s2);

        match op {
          /* these are all special cases handled elsewhere */
          Div | Mod | Cmp(*) => push(~BinaryOp(op, d, s1, s2)),

          /* x86 imul can have 3 operands if one is an immediate */
          Mul if s1.imm() && !s2.imm() => push(~BinaryOp(Mul, d, s2, s1)),
          Mul if s2.imm() && !s1.imm() => push(~BinaryOp(Mul, d, s1, s2)),

          /* d = d op s2, perfect! */
          _ if s1 == d => push(~BinaryOp(op, d, s2, s1)),
          /* d = s1 op d, can commute */
          _ if s2 == d && op.commutative() => push(~BinaryOp(op, d, s1, s2)),
          /* should be handled elsewhere */
          _ if s2 == d => fail!(~"invalid instruction in alloc"),
          /* catch-all last resort, generate a move */
          _ => {
            push(~Move(copy d, copy s1));
            push(~BinaryOp(op, d, s2, s1));
          }

        }
      }
      ~Call(dst, fun, args) =>
        push(~Call(dst, self.alloc_op(fun),
                   vec::map_consume(args, |arg| self.alloc_op(arg)))),

      ~PCopy(ref copies) => {
        debug!("%?", copies);
        let mut dsts = ~[];
        let mut srcs = ~[];
        for copies.each |&(dst, src)| {
          dsts.push(*self.colors.get(&dst));
          srcs.push(*self.colors.get(&src));
        }
        debug!("resolving pcopy");
        for self.resolve_perm(dsts, srcs).each |&ins| {
          push(ins);
        }
      }
    }
  }

  fn alloc_addr(&self, addr: ~Address) -> ~Address {
    match addr {
      ~Stack(i) => ~Stack(i),
      ~StackArg(idx) =>
        ~Stack((idx + 1) * arch::ptrsize + self.stack_size(true)),
      ~MOp(base, disp, off) =>
        ~MOp(self.alloc_op(base), disp,
             off.map_consume(|(x, mult)| (self.alloc_op(x), mult)))
    }
  }

  fn stack_loc(&self, tag: Tag) -> uint {
    if !self.slots.contains_key(&tag) {
      fail!(fmt!("no spill for %?", tag));
    }
    *self.slots.get(&tag) * arch::ptrsize + self.max_call_stack
  }

  fn stack_pos(&self, tag: Tag) -> ~Address {
    ~Stack(self.stack_loc(tag))
  }

  fn stack_size(&self, with_saves: bool) -> uint {
    let slots = self.max_slot * 8;
    let calls = self.max_call_stack;
    let saves = self.callee_saved.len() * arch::ptrsize;
    let alter = if with_saves { 0 } else { saves };
    return arch::align_stack(slots + calls + saves) - alter;
  }

  fn alloc_op(&self, o: ~Operand) -> ~Operand {
    match o {
      ~Immediate(*) | ~LabelOp(*) | ~Register(*) => o,
      ~Temp(tmp) => self.alloc_tmp(tmp)
    }
  }

  fn alloc_tmp(&self, tmp: Temp) -> ~Operand {
    ~Register(arch::num_reg(*self.colors.get(&tmp)), *self.f.sizes.get(&tmp))
  }

  fn resolve_perm(&self, result: &[uint], incoming: &[uint]) -> ~[~Instruction] {
    let mkreg = |i: uint| ~Register(arch::num_reg(i), ir::Pointer);
    resolve_perm(result, incoming).map(|&r| {
      match r {
        Left((dst, src)) => ~Move(mkreg(dst), mkreg(src)),
        Right((r1, r2)) => ~Raw(fmt!("xchg %s, %s", mkreg(r1).pp(),
                                     mkreg(r2).pp()))
      }
    })
  }
}

impl PrettyPrint for bitv::Bitv {
  fn pp(&self) -> ~str {
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
  use std::smallintmap::SmallIntMap;
  let mut ret = ~[];

  /* maps describing src -> dst and dst -> src */
  let mut src_dst = LinearMap::new(); /* TODO: can sim become better? */
  let mut dst_src = SmallIntMap::new();
  for vec::each2(result, incoming) |&dst, &src| {
    if dst == src { loop }
    fail_unless!(dst_src.insert(dst, src));
    let mut L; L = match src_dst.pop(&src) { None => ~[], Some(l) => l };
    L.push(dst);
    src_dst.insert(src, L);
  }

  /* deal with all move chains first */
  for result.each |&dst| {
    /* if this destination is also a source, it's not the end of a chain */
    if src_dst.contains_key(&dst) { loop }

    /* having found the end of a chain, go up the chain moving everything into
       the right spot as we go along */
    let mut cur = dst;
    while dst_src.contains_key(&cur) {
      let nxt; nxt = *dst_src.get(&cur); /* TODO(#4666): sanity */
      ret.push(Left((cur, nxt)));
      dst_src.remove(&cur);
      let L = vec::filter(src_dst.pop(&nxt).unwrap(), |&x| x != cur);
      if L.len() > 0 {
        src_dst.insert(nxt, L);
      }
      cur = nxt;
      if src_dst.contains_key(&cur) { break }
    }
  }

  /* Next, deal with all loops */
  for result.each |&dst| {
    /* if this isn't a destination any more, it was part of a chain */
    if !dst_src.contains_key(&dst) { loop }

    /* Exchange everything through the 'dst' register to resolve the chain */
    let mut cur = dst;
    while src_dst.contains_key(&cur) {
      let L = vec::filter(src_dst.pop(&cur).unwrap(),
                          |&x| dst_src.contains_key(&x));
      debug!("%?", L);
      fail_unless!(L.len() == 1);
      let nxt = L[0];
      if nxt == dst { break }
      ret.push(Right((dst, nxt)));
      cur = nxt;
    }
  }

  return ret;
}
#[cfg(test)]
fn resolve_test(from: &[uint], to: &[uint]) {
  use std::smallintmap::SmallIntMap;
  let perm = resolve_perm(to, from);
  let mut regs = vec::from_fn(10, |i| i);
  for perm.each |&foo| {
    match foo {
      Left((dst, src))  => { regs[dst] = regs[src]; }
      Right((dst, src)) => { regs[dst] <-> regs[src]; }
    }
  }

  let mut map = SmallIntMap::new();
  for uint::range(0, 10) |i| { map.insert(i, ()); }
  for vec::each2(from, to) |&f, &t| {
    map.remove(&t);
    if regs[t] != f {
      fail!(fmt!("expected %? to be %? but it was %?", t, f, regs[t]));
    }
  }
  debug!("%?", regs);
  for map.each |&(k, _)| {
    if regs[k] != k {
      fail!(fmt!("clobbered %? to %?", k, regs[k]));
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
  resolve_test(~[1, 1, 2], ~[2, 3, 1]);
  resolve_test(~[7, 1, 7], ~[2, 7, 1]);
}
