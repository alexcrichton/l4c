use std::hashmap::{HashMap, HashSet};
use std::vec;
use std::uint;

use extra::bitv;
use extra::smallintmap::SmallIntMap;

use middle::{ir, liveness};
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
  colors: ColorMap,
  slots: ColorMap,
  max_slot: uint,
  max_call_stack: uint,
  callee_saved: ~[uint],

  /* data needed for coalescing */
  precolored: HashSet<Temp>,
  constraints: ConstraintMap,
}

pub fn color(p: &mut Program) {
  for p.funs.mut_iter().advance |f| {
    let mut live_regs = liveness::Analysis();
    let mut live_stack = liveness::Analysis();
    liveness::calculate(&f.cfg, f.root, &mut live_regs, &RegisterInfo);
    liveness::calculate(&f.cfg, f.root, &mut live_stack, &StackInfo);

    let mut a = Allocator{ colors: SmallIntMap::new(),
                           precolored: HashSet::new(),
                           constraints: SmallIntMap::new(),
                           slots: SmallIntMap::new(),
                           max_slot: 1,
                           max_call_stack: 0,
                           callee_saved: ~[] };

    /* Color the graph completely */
    info!("coloring: %s", f.name);
    do profile::dbg("coloring") { a.color(f, &live_regs, f.root); }
    for a.colors.each |tmp, color| {
      debug!("%s => %?", tmp.to_str(), color);
    }

    do profile::dbg("coalescing registers") {
      coalesce::optimize(f, &live_regs, &mut a.colors, &a.precolored,
                         &a.constraints, &RegisterInfo, true, arch::num_regs);
    }
    do profile::dbg("coalescing stack slots") {
      info!("stack slots");
      /* no precolored slots or constraints, yay! */
      let max = a.slots.len();
      coalesce::optimize(f, &live_stack, &mut a.slots, &HashSet::new(),
                         &SmallIntMap::new(), &StackInfo, false, max);
    }

    /* Finally remove all phi nodes and all temps */
    do profile::dbg("removing phis") { a.remove_phis(f); }
    do profile::dbg("removing tmps") { a.remove_temps(f); }
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

impl Allocator {
  /**
   * Color the functions CFG according to the algorithm outlined in the paper
   * "Towards Register Allocation for Programs in SSA-form" by Hack et al.
   * A top-down traversal of the dominator tree is done, coloring all
   * definitions as they are seen with the first available color.
   */
  fn color(&mut self, f: &Function, live: &liveness::Analysis,
           n: graph::NodeId) {
    debug!("coloring %?", n);
    let mut tmplive = HashSet::new();
    let mut registers = RegisterSet();
    for live.in.get(&n).each |&t| {
      tmplive.insert(t);
      registers.set(*self.colors.get(&t), true);
    }
    debug!("%s", tmplive.pp())

    let mut pcopy = None;
    for f.cfg.node(n).eachi |i, ins| {
      /* examine data for next instruction for last use information */
      {
        let delta = &live.deltas.get(&n)[i];
        debug!("%s", ins.pp());
        debug!("deltas %?", delta);
        debug!("before %s %s", tmplive.pp(), registers.pp());
        liveness::apply(&mut tmplive, delta);
      }

      match *ins {
        /* If we found a pcopy, then we're breaking liveness */
        ~PCopy(ref copies) => {
          assert!(pcopy.is_none());
          pcopy = Some(copy *copies);
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

        match *ins {
          ~BinaryOp(op, ref dst, ref op1, ref op2) if op.constrained() => {
            match op {
              /* div/mod both clobber eax/edx, and have the result in one */
              Div | Mod => {
                self.precolor(*op1, EAX);
                self.precolor(*dst, match op { Div => EAX, _ => EDX });
                banned.set(arch::reg_num(EDX), true);
                banned.set(arch::reg_num(EAX), true);
                for tmplive.each |&tmp| {
                  assert!(self.constraints.insert(tmp, Idiv));
                }
                match *op2 {
                  ~Temp(t) => { self.constraints.insert(t, Idiv); }
                  _ => fail!(~"not a tmp")
                }
              }

              /* shifting is easy, the second op is just in ecx */
              Rsh | Lsh => {
                self.precolor(*op2, ECX);
                banned.set(arch::reg_num(ECX), true);
              }
              _ => fail!(fmt!("implement %?", op))
            }
          }

          /* Calls precolor the result and arguments, and the caller-saved
             registers are all banned for this instruction */
          ~Call(dst, _, ref args) => {
            self.colors.insert(dst, arch::reg_num(EAX));
            assert!(self.precolored.insert(dst));
            for args.eachi |i, arg| {
              self.precolor(*arg, arch::arg_reg(i));
            }
            for arch::each_caller |r| {
              banned.set(arch::reg_num(r), true);
            }
            for tmplive.each |&tmp| {
              assert!(self.constraints.insert(tmp, Caller));
            }
          }

          /* returns just have their argument precolored to EAX */
          ~Return(ref op) => {
            self.precolor(*op, EAX);
            banned.set(arch::reg_num(EAX), true);
          }

          /* All unconstrained instructions between a pcopy and the constrained
             instruction are spills/reloads and we can ignore them (we'll color
             them later */
          _ => loop
        };

        /* TODO: cleanup? */
        debug!("coloring uses");
        for ins.each_use |tmp| {
          self.process(tmp, &mut banned);
        }
        debug!("processing live-out temporaries");
        for tmplive.each |&tmp| {
          self.process(tmp, &mut banned);
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
          assert!(dst != src);
          match self.colors.find(&dst) {
            Some(&c) => { regstmp.set(c, true); }
            None    => ()
          }
        }
        for copies.each |&(dst, _)| {
          self.process(dst, &mut regstmp);
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
            self.process(tmp, &mut registers);
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
          assert!(color <= arch::num_regs);
          assert!(self.colors.insert(tmp, color));
          if tmplive.contains(&tmp) {
            registers.set(color, true);
          }
        }
      }
      debug!("after %s %s", tmplive.pp(), registers.pp());
    }

    for f.ssa.idominated.get(&n).each |&id| {
      self.color(f, live, id);
    }
  }

  fn precolor(&mut self, o: &Operand, r: Register) {
    match *o {
      Temp(t) => {
        assert!(self.colors.insert(t, arch::reg_num(r)));
        assert!(self.precolored.insert(t));
      }
      _ => fail!(fmt!("not a tmp %?", o))
    }
  }

  fn process(&mut self, t: Temp, regs: &mut RegisterSet) {
    if self.colors.contains_key(&t) {
      assert!(regs.get(*self.colors.get(&t)));
    } else {
      let color = min_vacant(regs);
      /*debug!("assigning %s %? %s", $t.pp(), color, $regs.pp());*/
      assert!(color <= arch::num_regs);
      assert!(self.colors.insert(t, color));
      regs.set(color, true);
    }
  }

  fn remove_phis(&self, f: &mut Function) {
    let mut to_append = ~[];

    for f.cfg.each_node |id, ins| {
      let mut phi_vars = ~[];
      let mut phi_maps = HashMap::new();
      let mut mem_vars = ~[];
      let mut mem_maps = HashMap::new();
      for f.cfg.each_pred(id) |pred| {
        phi_maps.insert(pred, ~[]);
        mem_maps.insert(pred, ~[]);
      }

      for ins.each |ins| {
        match *ins {
          ~Phi(tmp, ref map) => {
            debug!("phi var %? %?", tmp, *self.colors.get(&tmp));
            phi_vars.push(*self.colors.get(&tmp));
            for map.each |pred, tmp| {
              phi_maps.find_mut(pred).unwrap().push(*self.colors.get(tmp));
            }
          }
          ~MemPhi(def, ref map) => {
            mem_vars.push(self.stack_loc(def));
            for map.each |pred, &slot| {
              mem_maps.find_mut(pred).unwrap().push(self.stack_loc(slot));
            }
          }
          _ => {}
        }
      }

      for f.cfg.each_pred(id) |pred| {
        let perm = phi_maps.pop(&pred).unwrap();
        let mems = mem_maps.pop(&pred).unwrap();

        debug!("resolving phi for %? <= %?", id, pred);
        // First, resolve all register permutations
        let mut ins = ~[];
        do self.resolve_perm(phi_vars, perm) |i| {
          ins.push(i);
        }

        // Second, resolve the memory phi permutations. To do so, each
        // move needs a scratch register, and each exchange needs two registers.
        // We can get these by just pushing some known registers to the stack.
        // Not exactly the best solution, but it works.
        let mut pushed = 0;
        let eax = Register(EAX, ir::Pointer);
        let ebx = Register(EBX, ir::Pointer);
        do resolve_perm(mem_vars, mems) |i| {
          if pushed == 0 {
            pushed = 1;
            ins.push(~Raw(fmt!("pushq %s", eax.pp())));
          }
          match i {
            Left((dst, src)) => { // move
              ins.push(~Load(~copy eax, ~Stack(src + pushed * arch::ptrsize)));
              ins.push(~Store(~Stack(dst + pushed * arch::ptrsize), ~copy eax));
            }

            Right((l1, l2)) => { // xchg
              if pushed == 1 {
                pushed = 2;
                ins.push(~Raw(fmt!("pushq %s", ebx.pp())));
              }
              ins.push(~Load(~copy eax, ~Stack(l1 + 2 * arch::ptrsize)));
              ins.push(~Load(~copy ebx, ~Stack(l2 + 2 * arch::ptrsize)));
              ins.push(~Store(~Stack(l1 + 2 * arch::ptrsize), ~copy ebx));
              ins.push(~Store(~Stack(l2 + 2 * arch::ptrsize), ~copy eax));
            }
          }
        }
        if pushed > 1 {
          ins.push(~Raw(fmt!("popq %s", ebx.pp())));
        }
        if pushed > 0 {
          ins.push(~Raw(fmt!("popq %s", eax.pp())));
        }

        if ins.len() > 0 {
          to_append.push((pred, ins));
        }
      }
    }

    do vec::consume(to_append) |_, (pred, ins)| {
      /* there are no critical edges in the graph, so we can just append */
      f.cfg.map_consume_node(pred, |stms| stms + ins);
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
  fn remove_temps(&mut self, f: &mut Function) {
    let (order, _) = f.cfg.postorder(f.root);

    for order.rev_iter().advance |&id| {
      let prev = f.cfg.pop_node(id);
      let mut newins = ~[];
      /* If we're the root node, set up the stack after saving the callee
         saved registers */
      if id == f.root {
        for self.colors.each |_, &color| {
          let reg = arch::num_reg(color);
          if arch::callee_reg(reg) && !self.callee_saved.contains(&color) {
            self.callee_saved.push(color);
            newins.push(~Raw(fmt!("push %s", reg.size(ir::Pointer))));
          }
        }
        if self.stack_size(false) != 0 {
          newins.push(~BinaryOp(Sub, ~Register(ESP, ir::Pointer),
                                ~Immediate(self.stack_size(false) as i32,
                                           ir::Pointer),
                                ~Register(ESP, ir::Pointer)));
        }
      }

      do vec::consume(prev) |_, ins| {
        self.alloc_ins(f, ins, |i| newins.push(i));
      }
      f.cfg.add_node(id, newins);
    }
  }

  fn alloc_ins(&mut self, f: &Function, i: ~Instruction,
               push: &fn(~Instruction))
  {
    match i {
      ~Spill(t, tag) => push(~Store(self.stack_pos(tag), self.alloc_tmp(f, t))),
      ~Reload(t, tag) => push(~Load(self.alloc_tmp(f, t), self.stack_pos(tag))),
      ~Load(dst, addr) =>
        push(~Load(self.alloc_op(f, dst), self.alloc_addr(f, addr))),
      ~Store(addr, src) => push(~Store(self.alloc_addr(f, addr),
                                       self.alloc_op(f, src))),
      ~Raw(s) => push(~Raw(s)),
      ~Condition(c, o1, o2) =>
        push(~Condition(c, self.alloc_op(f, o1), self.alloc_op(f, o2))),
      ~Die(c, o1, o2) =>
        push(~Die(c, self.alloc_op(f, o1), self.alloc_op(f, o2))),
      ~Move(o1, o2) => push(~Move(self.alloc_op(f, o1), self.alloc_op(f, o2))),
      ~MemPhi(*) | ~Use(*) | ~Phi(*) | ~Arg(*) => (),

      ~Return(op) => {
        if self.stack_size(false) != 0 {
          push(~BinaryOp(Add, ~Register(ESP, ir::Pointer),
                         ~Immediate(self.stack_size(false) as i32, ir::Pointer),
                         ~Register(ESP, ir::Pointer)));
        }
        for self.callee_saved.rev_iter().advance |&color| {
          push(~Raw(fmt!("pop %s", arch::num_reg(color).size(ir::Pointer))));
        }
        push(~Return(op));
      }

      /* When going through formatting and on x86 -
            BinaryOp(op, d, s1, s2) <=> d = d op s1
         and s2 is put in the commments */
      ~BinaryOp(op, d, s1, s2) => {
        let d = self.alloc_op(f, d);
        let s1 = self.alloc_op(f, s1);
        let s2 = self.alloc_op(f, s2);

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
        push(~Call(dst, self.alloc_op(f, fun),
                   vec::map_consume(args, |arg| self.alloc_op(f, arg)))),

      ~PCopy(ref copies) => {
        debug!("%?", copies);
        let mut dsts = ~[];
        let mut srcs = ~[];
        for copies.each |&(dst, src)| {
          dsts.push(*self.colors.get(&dst));
          srcs.push(*self.colors.get(&src));
        }
        debug!("resolving pcopy");
        do self.resolve_perm(dsts, srcs) |ins| {
          push(ins);
        }
      }
    }
  }

  fn alloc_addr(&mut self, f: &Function, addr: ~Address) -> ~Address {
    match addr {
      ~Stack(i) => ~Stack(i),
      ~StackArg(idx) =>
        ~Stack((idx + 1) * arch::ptrsize + self.stack_size(true)),
      ~MOp(base, disp, off) =>
        ~MOp(self.alloc_op(f, base), disp,
             off.map_consume(|(x, mult)| (self.alloc_op(f, x), mult)))
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

  fn alloc_op(&mut self, f: &Function, o: ~Operand) -> ~Operand {
    match o {
      ~Immediate(*) | ~LabelOp(*) | ~Register(*) => o,
      ~Temp(tmp) => self.alloc_tmp(f, tmp)
    }
  }

  fn alloc_tmp(&mut self, f: &Function, tmp: Temp) -> ~Operand {
    let size = f.sizes.get_copy(&tmp);
    ~Register(arch::num_reg(*self.colors.get(&tmp)), size)
  }

  fn resolve_perm(&self, result: &[uint], incoming: &[uint],
                  f: &fn(~Instruction) ){
    let mkreg = |i: uint| ~Register(arch::num_reg(i), ir::Pointer);
    do resolve_perm(result, incoming) |r| {
      match r {
        Left((dst, src)) => f(~Move(mkreg(dst), mkreg(src))),
        Right((r1, r2)) => f(~Raw(fmt!("xchg %s, %s", mkreg(r1).pp(),
                                       mkreg(r2).pp())))
      }
    }
  }
}

impl PrettyPrint for bitv::Bitv {
  fn pp(&self) -> ~str {
    let mut s = ~"{";
    let mut first = true;
    for self.ones |i| {
      if first {
        first = false;
      } else {
        s += ", ";
      }
      s += i.to_str();
    }
    return s + "}";
  }
}

/**
 * Perform the actual resolution of moves/exchanges to get from incoming to the
 * result specified.
 */
fn resolve_perm(result: &[uint], incoming: &[uint], f: &fn(Resolution)) {
  use extra::smallintmap::SmallIntMap;

  /* maps describing src -> dst and dst -> src */
  let mut src_dst: SmallIntMap<~[uint]> = SmallIntMap::new();
  let mut dst_src = SmallIntMap::new();
  for result.iter().zip(incoming.iter()).advance |(&dst, &src)| {
    if dst == src { loop }
    assert!(dst_src.insert(dst, src));
    match src_dst.find_mut(&src) {
      Some(l) => { l.push(dst); loop }
      None => ()
    }
    src_dst.insert(src, ~[dst]);
  }

  /* deal with all move chains first */
  for result.each |&dst| {
    /* if this destination is also a source, it's not the end of a chain */
    if src_dst.contains_key(&dst) { loop }

    /* having found the end of a chain, go up the chain moving everything into
       the right spot as we go along */
    let mut cur = dst;
    while dst_src.contains_key(&cur) {
      let nxt = *dst_src.get(&cur);
      f(Left((cur, nxt)));
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
      assert!(L.len() == 1);
      let nxt = L[0];
      if nxt == dst { break }
      f(Right((dst, nxt)));
      cur = nxt;
    }
  }
}

#[cfg(test)]
fn resolve_test(from: &[uint], to: &[uint]) {
  use extra::smallintmap::SmallIntMap;
  let mut regs = vec::from_fn(10, |i| i);

  do resolve_perm(to, from) |foo| {
    match foo {
      Left((dst, src))  => { regs[dst] = regs[src]; }
      Right((dst, src)) => { vec::swap(regs, dst, src); }
    }
  }

  let mut map = SmallIntMap::new();
  for uint::range(0, 10) |i| { map.insert(i, ()); }
  for from.iter().zip(to.iter()).advance |(&f, &t)| {
    map.remove(&t);
    if regs[t] != f {
      fail!(fmt!("expected %? to be %? but it was %?", t, f, regs[t]));
    }
  }
  debug!("%?", regs);
  for map.each |&k, _| {
    if regs[k] != k {
      fail!(fmt!("clobbered %? to %?", k, regs[k]));
    }
  }
}

#[test]
fn test_resolve() {
  resolve_test([], []);
  resolve_test([1], [1]);
  resolve_test([1, 2], [1, 2]);
  resolve_test([1], [2]);
  resolve_test([1, 2], [2, 3]);
  resolve_test([1, 2], [2, 1]);
  resolve_test([1, 2, 3, 4], [2, 1, 4, 5]);
  resolve_test([1, 2, 3], [2, 3, 1]);
  resolve_test([1, 2, 3, 4, 5, 6, 7, 8], [2, 3, 1, 5, 6, 4, 8, 9]);
  resolve_test([1, 1, 2], [2, 3, 1]);
  resolve_test([7, 1, 7], [2, 7, 1]);
}
