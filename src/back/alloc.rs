use std::cmp;
use std::collections::{HashMap, HashSet};

use vec_map::VecMap;

use back::arch;
use back::assem::{Binop, Constraint, StackInfo, RegisterInfo};
use back::assem::{Inst, Program, Function, Operand, Address, Register, Tag};
use back::coalesce;
use middle::ir::Type;
use middle::liveness;
use utils::graph::NodeId;
use utils::profile;
use utils::{Temp, TempSet, TempVecMap, SmallBitVec};

type RegisterSet = SmallBitVec;
pub type ColorMap = TempVecMap<u32>;
pub type ConstraintMap = TempVecMap<Constraint>;
enum Resolution {
    Copy(u32, u32),
    Xchg(u32, u32),
}

struct Allocator {
  colors: ColorMap,
  slots: ColorMap,
  max_slot: u32,
  max_call_stack: u32,
  callee_saved: Vec<u32>,

  // data needed for coalescing
  precolored: TempSet,
  constraints: ConstraintMap,
}

pub fn color(p: &mut Program) {
    for f in p.funs.iter_mut() {
        let mut live_regs = liveness::Analysis::new();
        let mut live_stack = liveness::Analysis::new();
        liveness::calculate(&f.cfg, f.root, &mut live_regs, &RegisterInfo);
        liveness::calculate(&f.cfg, f.root, &mut live_stack, &StackInfo);

        let mut a = Allocator {
            colors: TempVecMap::new(),
            precolored: HashSet::default(),
            constraints: TempVecMap::new(),
            slots: TempVecMap::new(),
            max_slot: 1,
            max_call_stack: 0,
            callee_saved: Vec::new(),
        };

        // Color the graph completely
        info!("coloring: {}", f.name);
        profile::dbg("coloring", || a.color(f, &live_regs, f.root));
        for (tmp, color) in a.colors.iter() {
            debug!("{} => {}", tmp, color);
        }

        profile::dbg("coalescing registers", || {
            coalesce::optimize(f, &live_regs, &mut a.colors, &a.precolored,
                               &a.constraints, &RegisterInfo, true,
                               arch::NUM_REGS);
        });
        profile::dbg("coalescing stack slots", || {
            info!("stack slots");
            // no precolored slots or constraints, yay!
            let max = a.slots.len() as u32;
            coalesce::optimize(f, &live_stack, &mut a.slots,
                               &HashSet::default(),
                               &TempVecMap::new(), &StackInfo, false, max);
        });

        // Finally remove all phi nodes and all temps
        profile::dbg("removing phis", || a.remove_phis(f));
        profile::dbg("removing tmps", || a.remove_temps(f));
    }
}

fn register_set() -> RegisterSet {
    SmallBitVec::new()
}

fn min_vacant(colors: &RegisterSet) -> u32 {
    debug!("min vacant {:?}", colors);
    let mut i = 1;
    while colors.contains(i) {
        i += 1;
    }
    debug!("{}", i);
    return i;
}

impl Allocator {
    /// Color the functions CFG according to the algorithm outlined in the paper
    /// "Towards Register Allocation for Programs in SSA-form" by Hack et al.
    /// A top-down traversal of the dominator tree is done, coloring all
    /// definitions as they are seen with the first available color.
    fn color(&mut self, f: &Function, live: &liveness::Analysis,
             n: NodeId) {
        debug!("coloring {}", n);
        let mut tmplive: TempSet = HashSet::default();
        let mut registers = register_set();
        for t in live.in_[&n].iter() {
            tmplive.insert(*t);
            registers.insert(self.colors[t]);
        }
        debug!("{:?}", tmplive);

        let mut pcopy = None;
        for (i, ins) in f.cfg.node(n).iter().enumerate() {
            // examine data for next instruction for last use information
            {
                let delta = &live.deltas[&n][i];
                debug!("{}", ins);
                debug!("deltas {:?}", delta);
                debug!("before {:?} {:?}", tmplive, registers);
                liveness::apply(&mut tmplive, delta);
            }

            match *ins {
                // If we found a pcopy, then we're breaking liveness
                Inst::PCopy(ref copies) => {
                    assert!(pcopy.is_none());
                    pcopy = Some(copies.clone());
                    registers.clear();
                    continue
                }
                // Be sure we always assign stack slots. It should be noted that
                // these are currently not in SSA form.
                Inst::MemPhi(ref def, _) => {
                    if !self.slots.contains_key(def) {
                        self.slots.insert(*def, self.max_slot);
                        self.max_slot += 1;
                    }
                }
                Inst::Spill(_, t) => {
                    if !self.slots.contains_key(&t) {
                        self.slots.insert(t, self.max_slot);
                        self.max_slot += 1;
                    }
                }
                // Keep track of the maximum number of args passed to called
                // funs
                Inst::Store(Address::Stack(pos), _) => {
                    self.max_call_stack = cmp::max(pos + arch::PTRSIZE,
                                                   self.max_call_stack);
                }
                // do simple precoloring of args up front
                Inst::Arg(tmp, i) => {
                    let color = arch::reg_num(arch::arg_reg(i));
                    self.colors.insert(tmp, color);
                    self.precolored.insert(tmp);
                    if tmplive.contains(&tmp) {
                        registers.insert(color);
                    }
                    continue
                }
                _ => ()
            }

            // If we found a pcopy, we need to think about being constrained
            if pcopy.is_some() {
                let mut banned = register_set();

                match *ins {
                    Inst::BinaryOp(op, ref dst, ref op1, ref op2)
                        if op.constrained() =>
                    {
                        match op {
                            // div/mod both clobber eax/edx, and have the result
                            // in one
                            Binop::Div | Binop::Mod => {
                                self.precolor(op1, Register::EAX);
                                self.precolor(dst, match op {
                                    Binop::Div => Register::EAX,
                                    _ => Register::EDX
                                });
                                banned.insert(arch::reg_num(Register::EDX));
                                banned.insert(arch::reg_num(Register::EAX));
                                let idiv = Constraint::Idiv;
                                for &tmp in tmplive.iter() {
                                    assert!(self.constraints.insert(tmp, idiv));
                                }
                                if let Operand::Temp(t) = *op2 {
                                    self.constraints.insert(t, idiv);
                                }
                            }

                            // shifting is easy, the second op is just in ecx
                            Binop::Rsh | Binop::Lsh => {
                                self.precolor(op2, Register::ECX);
                                banned.insert(arch::reg_num(Register::ECX));
                            }
                            _ => panic!("implement {}", op)
                        }
                    }

                    // Calls precolor the result and arguments, and the
                    // caller-saved registers are all banned for this
                    // instruction
                    Inst::Call(dst, _, ref args) => {
                        self.colors.insert(dst, arch::reg_num(Register::EAX));
                        assert!(self.precolored.insert(dst));
                        for (i, arg) in args.iter().enumerate() {
                            self.precolor(arg, arch::arg_reg(i as u32));
                        }
                        arch::each_caller(&mut |r| {
                            banned.insert(arch::reg_num(r));
                        });
                        for &tmp in tmplive.iter() {
                            assert!(self.constraints.insert(tmp,
                                                            Constraint::Caller));
                        }
                    }

                    // returns just have their argument precolored to EAX
                    Inst::Return(ref op) => {
                        self.precolor(op, arch::RET_REG);
                        banned.insert(arch::reg_num(arch::RET_REG));
                    }

                    // All unconstrained instructions between a pcopy and the
                    // constrained instruction are spills/reloads and we can
                    // ignore them (we'll color them later)
                    _ => continue
                };

                // TODO: cleanup?
                debug!("coloring uses");
                ins.each_use(|tmp| {
                    self.process(tmp, &mut banned);
                });
                debug!("processing live-out temporaries");
                for &tmp in tmplive.iter() {
                    self.process(tmp, &mut banned);
                }
                debug!("pruning dead uses");
                ins.each_use(&mut |tmp| {
                    if !tmplive.contains(&tmp) {
                        debug!("removing {}", tmp);
                        banned.remove(self.colors[tmp]);
                    }
                });
                debug!("processing previous pcopy");
                let copies = pcopy.take().unwrap();
                let mut regstmp = register_set();
                for &(dst, src) in copies.iter() {
                    assert!(dst != src);
                    if let Some(&c) = self.colors.get(&dst) {
                        regstmp.insert(c);
                    }
                }
                for &(dst, _) in copies.iter() {
                    self.process(dst, &mut regstmp);
                }
                debug!("adding in all live-out temps");
                for tmp in tmplive.iter() {
                    if let Some(&c) = self.colors.get(tmp) {
                        registers.insert(c);
                    }
                }
                debug!("processing defs");
                ins.each_def(&mut |tmp| {
                    if !self.colors.contains_key(&tmp) {
                        self.process(tmp, &mut registers);
                        if !tmplive.contains(&tmp) {
                            registers.remove(self.colors[tmp]);
                        }
                    }
                });
                pcopy = None;
            } else {
                // normal coloration of each instruction
                ins.each_use(&mut |tmp| {
                    debug!("found use {}", tmp);
                    if !tmplive.contains(&tmp) {
                        debug!("removing {} {}", tmp, self.colors[tmp]);
                        registers.remove(self.colors[tmp]);
                    }
                });
                ins.each_def(&mut |tmp| {
                    let color = min_vacant(&registers);
                    assert!(color <= arch::NUM_REGS);
                    assert!(self.colors.insert(tmp, color));
                    if tmplive.contains(&tmp) {
                        registers.insert(color);
                    }
                });
            }
            debug!("after {:?} {:?}", tmplive, registers);
        }

        for &id in f.ssa.idominated[&n].iter() {
            self.color(f, live, id);
        }
    }

    fn precolor(&mut self, o: &Operand, r: Register) {
        match *o {
            Operand::Temp(t) => {
                assert!(self.colors.insert(t, arch::reg_num(r)));
                assert!(self.precolored.insert(t));
            }
            _ => panic!("not a tmp {}", o)
        }
    }

    fn process(&mut self, t: Temp, regs: &mut RegisterSet) {
        if self.colors.contains_key(&t) {
            assert!(regs.contains(self.colors[t]));
        } else {
            let color = min_vacant(regs);
            // debug!("assigning {} {} {}", $t, color, $regs);
            assert!(color <= arch::NUM_REGS);
            assert!(self.colors.insert(t, color));
            regs.insert(color);
        }
    }

    fn remove_phis(&self, f: &mut Function) {
        let mut to_append = Vec::new();

        for (id, ins) in f.cfg.nodes() {
            let mut phi_vars = Vec::new();
            let mut phi_maps = HashMap::new();
            let mut mem_vars = Vec::new();
            let mut mem_maps = HashMap::new();
            for pred in f.cfg.preds(id) {
                phi_maps.insert(pred, Vec::new());
                mem_maps.insert(pred, Vec::new());
            }

            for ins in ins.iter() {
                match *ins {
                    Inst::Phi(tmp, ref map) => {
                        debug!("phi var {} {}", tmp, self.colors[tmp]);
                        phi_vars.push(self.colors[tmp]);
                        for (pred, tmp) in map.iter() {
                            phi_maps.get_mut(pred).unwrap()
                                    .push(self.colors[tmp]);
                        }
                    }
                    Inst::MemPhi(def, ref map) => {
                        mem_vars.push(self.stack_loc(def));
                        for (pred, &slot) in map.iter() {
                            mem_maps.get_mut(pred).unwrap()
                                    .push(self.stack_loc(slot));
                        }
                    }
                    _ => {}
                }
            }

            for pred in f.cfg.preds(id) {
                let perm = phi_maps.remove(&pred).unwrap();
                let mems = mem_maps.remove(&pred).unwrap();

                debug!("resolving phi for {} <= {}", id, pred);
                // First, resolve all register permutations
                let mut ins = Vec::new();
                self.resolve_perm(&phi_vars, &perm, &mut |i| {
                    ins.push(i);
                });

                // Second, resolve the memory phi permutations. To do so, each
                // move needs a scratch register, and each exchange needs two
                // registers.  We can get these by just pushing some known
                // registers to the stack.  Not exactly the best solution, but
                // it works.
                let mut pushed = 0;
                let eax = Operand::Reg(Register::EAX, Type::Pointer);
                let ebx = Operand::Reg(Register::EBX, Type::Pointer);
                resolve_perm(&mem_vars, &mems, &mut |i| {
                    if pushed == 0 {
                        pushed = 1;
                        ins.push(Inst::Raw(format!("pushq {}", eax)));
                    }
                    match i {
                        Resolution::Copy(dst, src) => { // move
                            let pushed = pushed * arch::PTRSIZE;
                            let src = Address::Stack(src + pushed);
                            ins.push(Inst::Load(eax, src));
                            let dst = Address::Stack(dst + pushed);
                            ins.push(Inst::Store(dst, eax));
                        }

                        Resolution::Xchg(l1, l2) => { // xchg
                            if pushed == 1 {
                                pushed = 2;
                                ins.push(Inst::Raw(format!("pushq {}", ebx)));
                            }
                            let l1 = Address::Stack(l1 + 2 * arch::PTRSIZE);
                            let l2 = Address::Stack(l2 + 2 * arch::PTRSIZE);
                            ins.push(Inst::Load(eax, l1));
                            ins.push(Inst::Load(ebx, l2));
                            ins.push(Inst::Store(l1, ebx));
                            ins.push(Inst::Store(l2, eax));
                        }
                    }
                });
                if pushed > 1 {
                    ins.push(Inst::Raw(format!("popq {}", ebx)));
                }
                if pushed > 0 {
                    ins.push(Inst::Raw(format!("popq {}", eax)));
                }

                if ins.len() > 0 {
                    to_append.push((pred, ins));
                }
            }
        }

        for (pred, ins) in to_append {
            // there are no critical edges in the graph, so we can just append
            let mut prev = f.cfg.pop_node(pred);
            prev.extend(ins);
            f.cfg.update_node(pred, prev);
        }
    }

    /// Apply the coloring previously generated to all instructions and operands in
    /// all basic blocks. This means that the cfg will no longer have any temps,
    /// and that it will no longer be in SSA-form.
    ///
    /// This also converts all three-operand binary ops to two-operand binops
    /// because x86 is so awesome.
    fn remove_temps(&mut self, f: &mut Function) {
        let (order, _) = f.cfg.postorder(f.root);

        for &id in order.iter().rev() {
            let prev = f.cfg.pop_node(id);
            let mut newins = Vec::new();
            // If we're the root node, set up the stack after saving the callee
            // saved registers
            if id == f.root {
                for (_, &color) in self.colors.iter() {
                    let reg = arch::num_reg(color);
                    if arch::callee_reg(reg) &&
                        self.callee_saved.iter().all(|c| *c != color)
                    {
                        self.callee_saved.push(color);
                        let reg = reg.size(Type::Pointer);
                        newins.push(Inst::Raw(format!("push {}", reg)));
                    }
                }
                let size = self.stack_size(false);
                if size != 0 {
                    let esp = Operand::Reg(Register::ESP, Type::Pointer);
                    newins.push(Inst::BinaryOp(Binop::Sub, esp,
                                               Operand::Imm(size as i32,
                                                            Type::Pointer),
                                               esp));
                }
            }

            for ins in prev.into_iter() {
                self.alloc_ins(f, ins, &mut |i| newins.push(i));
            }
            f.cfg.add_node(id, newins);
        }
    }

    fn alloc_ins(&mut self, f: &Function, i: Inst, push: &mut FnMut(Inst)) {
        match i {
            Inst::Spill(t, tag) => {
                push(Inst::Store(self.stack_pos(tag), self.alloc_tmp(f, t)))
            }
            Inst::Reload(t, tag) => {
                push(Inst::Load(self.alloc_tmp(f, t), self.stack_pos(tag)))
            }
            Inst::Load(dst, addr) => {
                push(Inst::Load(self.alloc_op(f, dst), self.alloc_addr(f, addr)))
            }
            Inst::Store(addr, src) => {
                push(Inst::Store(self.alloc_addr(f, addr),
                                 self.alloc_op(f, src)))
            }
            Inst::Raw(s) => push(Inst::Raw(s)),
            Inst::Condition(c, o1, o2) => {
                push(Inst::Condition(c, self.alloc_op(f, o1),
                                     self.alloc_op(f, o2)))
            }
            Inst::Die(c, o1, o2) => {
                push(Inst::Die(c, self.alloc_op(f, o1), self.alloc_op(f, o2)))
            }
            Inst::Move(o1, o2) => {
                push(Inst::Move(self.alloc_op(f, o1), self.alloc_op(f, o2)))
            }
            Inst::MemPhi(..) |
            Inst::Use(..) |
            Inst::Phi(..) |
            Inst::Arg(..) => (),

            Inst::Return(op) => {
                let size = self.stack_size(false);
                if size != 0 {
                    let esp = Operand::Reg(Register::ESP, Type::Pointer);
                    push(Inst::BinaryOp(Binop::Add, esp,
                                        Operand::Imm(size as i32,
                                                     Type::Pointer),
                                        esp));
                }
                for &color in self.callee_saved.iter().rev() {
                    let reg = arch::num_reg(color).size(Type::Pointer);
                    push(Inst::Raw(format!("pop {}", reg)));
                }
                push(Inst::Return(op));
            }

            // When going through formatting and on x86 -
            // BinaryOp(op, d, s1, s2) <=> d = d op s1
            // and s2 is put in the commments
            Inst::BinaryOp(op, d, s1, s2) => {
                let d = self.alloc_op(f, d);
                let s1 = self.alloc_op(f, s1);
                let s2 = self.alloc_op(f, s2);

                match op {
                    // these are all special cases handled elsewhere
                    Binop::Div |
                    Binop::Mod |
                    Binop::Cmp(..) => push(Inst::BinaryOp(op, d, s1, s2)),

                    // x86 imul can have 3 operands if one is an immediate
                    Binop::Mul if s1.imm() && !s2.imm() => {
                        push(Inst::BinaryOp(Binop::Mul, d, s2, s1))
                    }
                    Binop::Mul if s2.imm() && !s1.imm() => {
                        push(Inst::BinaryOp(Binop::Mul, d, s1, s2))
                    }

                    // d = d op s2, perfect!
                    _ if s1 == d => push(Inst::BinaryOp(op, d, s2, s1)),
                    // d = s1 op d, can commute
                    _ if s2 == d && op.commutative() => {
                        push(Inst::BinaryOp(op, d, s1, s2))
                    }
                    // should be handled elsewhere
                    _ if s2 == d => panic!("invalid instruction in alloc"),
                    // catch-all last resort, generate a move
                    _ => {
                        push(Inst::Move(d, s1));
                        push(Inst::BinaryOp(op, d, s2, s1));
                    }

                }
            }
            Inst::Call(dst, fun, args) => {
                push(Inst::Call(dst, self.alloc_op(f, fun),
                                args.into_iter().map(|arg| self.alloc_op(f, arg))
                                    .collect()))
            }

            Inst::PCopy(ref copies) => {
                debug!("{:?}", copies);
                let mut dsts = Vec::new();
                let mut srcs = Vec::new();
                for &(dst, src) in copies.iter() {
                    dsts.push(self.colors[dst]);
                    srcs.push(self.colors[src]);
                }
                debug!("resolving pcopy");
                self.resolve_perm(&dsts, &srcs, &mut |ins| {
                    push(ins);
                });
            }
        }
    }

    fn alloc_addr(&mut self, f: &Function, addr: Address) -> Address {
        match addr {
            Address::Stack(i) => Address::Stack(i),
            Address::StackArg(idx) => {
                Address::Stack((idx + 1) * arch::PTRSIZE + self.stack_size(true))
            }
            Address::MOp(base, disp, off) => {
                Address::MOp(self.alloc_op(f, base), disp,
                             off.map(|(x, mult)| (self.alloc_op(f, x), mult)))
            }
        }
    }

    fn stack_loc(&self, tag: Tag) -> u32 {
        if !self.slots.contains_key(&tag) {
            panic!("no spill for {}", tag);
        }
        self.slots[tag] * arch::PTRSIZE + self.max_call_stack
    }

    fn stack_pos(&self, tag: Tag) -> Address {
        Address::Stack(self.stack_loc(tag))
    }

    fn stack_size(&self, with_saves: bool) -> u32 {
        let slots = self.max_slot * 8;
        let calls = self.max_call_stack;
        let saves = (self.callee_saved.len() as u32) * arch::PTRSIZE;
        let alter = if with_saves { 0 } else { saves };
        return arch::align_stack(slots + calls + saves) - alter;
    }

    fn alloc_op(&mut self, f: &Function, o: Operand) -> Operand {
        match o {
            Operand::Imm(..) |
            Operand::Label(..) |
            Operand::Reg(..) => o,
            Operand::Temp(tmp) => self.alloc_tmp(f, tmp)
        }
    }

    fn alloc_tmp(&mut self, f: &Function, tmp: Temp) -> Operand {
        let size = f.sizes[&tmp];
        Operand::Reg(arch::num_reg(self.colors[tmp]), size)
    }

    fn resolve_perm(&self, result: &[u32], incoming: &[u32],
                    f: &mut FnMut(Inst)){
        let mkreg = |i: u32| Operand::Reg(arch::num_reg(i), Type::Pointer);
        resolve_perm(result, incoming, &mut |r| {
            match r {
                Resolution::Copy(dst, src) => {
                    f(Inst::Move(mkreg(dst), mkreg(src)))
                }
                Resolution::Xchg(r1, r2) => {
                    f(Inst::Raw(format!("xchg {}, {}", mkreg(r1), mkreg(r2))))
                }
            }
        });
    }
}

/// Perform the actual resolution of moves/exchanges to get from incoming to the
/// result specified.
fn resolve_perm(result: &[u32], incoming: &[u32], f: &mut FnMut(Resolution)) {
    // maps describing src -> dst and dst -> src
    let mut src_dst = VecMap::new();
    let mut dst_src = VecMap::new();
    for (&dst, &src) in result.iter().zip(incoming) {
        if dst == src {
            continue
        }
        let (dst, src) = (dst as usize, src as usize);
        assert!(dst_src.insert(dst, src).is_none());
        src_dst.entry(src).or_insert(Vec::new()).push(dst);
    }

    // deal with all move chains first
    for dst in result.iter().map(|&d| d as usize) {
        // if this destination is also a source, it's not the end of a chain
        if src_dst.contains_key(dst) {
            continue
        }

        // having found the end of a chain, go up the chain moving everything into
        // the right spot as we go along
        let mut cur = dst;
        while dst_src.contains_key(cur) {
            let nxt = dst_src[cur];
            f(Resolution::Copy(cur as u32, nxt as u32));
            dst_src.remove(cur);
            let mut arr = src_dst.remove(nxt).unwrap();
            arr.retain(|&x| x != cur);
            if arr.len() > 0 {
                src_dst.insert(nxt, arr);
            }
            cur = nxt;
            if src_dst.contains_key(cur) {
                break
            }
        }
    }

    // Next, deal with all loops
    for dst in result.iter().map(|&d| d as usize) {
        // if this isn't a destination any more, it was part of a chain
        if !dst_src.contains_key(dst) {
            continue }


        // Exchange everything through the 'dst' register to resolve the chain
        let mut cur = dst;
        while src_dst.contains_key(cur) {
            let mut arr = src_dst.remove(cur).unwrap();
            arr.retain(|x| dst_src.contains_key(*x));
            debug!("{:?}", arr);
            assert!(arr.len() == 1);
            let nxt = arr[0];
            if nxt == dst { break }
            f(Resolution::Xchg(dst as u32, nxt as u32));
            cur = nxt;
        }
    }
}

#[cfg(test)]
mod tests {
    use vec_map::VecMap;
    use super::{resolve_perm, Resolution};

    fn resolve_test(from: &[u32], to: &[u32]) {
        let mut regs = (0..10).collect::<Vec<u32>>();

        resolve_perm(to, from, &mut |foo| {
            match foo {
                Resolution::Copy(dst, src)  => {
                    regs[dst as usize] = regs[src as usize];
                }
                Resolution::Xchg(dst, src) => {
                    regs.swap(dst as usize, src as usize);
                }
            }
        });

        let mut map = VecMap::new();
        for i in 0..10 {
            map.insert(i, ());
        }
        for (&f, &t) in from.iter().zip(to.iter()) {
            map.remove(t as usize);
            if regs[t as usize] != f {
                panic!("expected {} to be {} but it was {}", t, f,
                       regs[t as usize]);
            }
        }
        debug!("{:?}", regs);
        for (k, _) in map.iter() {
            if regs[k] != k as u32 {
                panic!("clobbered {} to {}", k, regs[k as usize]);
            }
        }
    }

    #[test]
    fn test_resolve() {
        resolve_test(&[], &[]);
        resolve_test(&[1], &[1]);
        resolve_test(&[1, 2], &[1, 2]);
        resolve_test(&[1], &[2]);
        resolve_test(&[1, 2], &[2, 3]);
        resolve_test(&[1, 2], &[2, 1]);
        resolve_test(&[1, 2, 3, 4], &[2, 1, 4, 5]);
        resolve_test(&[1, 2, 3], &[2, 3, 1]);
        resolve_test(&[1, 2, 3, 4, 5, 6, 7, 8], &[2, 3, 1, 5, 6, 4, 8, 9]);
        resolve_test(&[1, 1, 2], &[2, 3, 1]);
        resolve_test(&[7, 1, 7], &[2, 7, 1]);
    }
}
