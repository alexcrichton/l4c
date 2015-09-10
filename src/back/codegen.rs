use std::collections::{HashMap, HashSet};
use std::mem;

use back::arch;
use back::assem::{Program, Function, Inst, Operand, Cond, Address, Binop, Size};
use middle::ir::{self, Type, Stmt, Expr};
use middle::label;
use middle::ssa;
use utils::{Temp, TempAllocator};

pub struct CodeGenerator {
    temps: TempAllocator,
    sizes: HashMap<Temp, Size>,
    stms: Vec<Inst>,
    tmap: HashMap<Temp, Temp>,
    oldtypes: HashMap<Temp, Type>,
}

pub fn codegen(prog: ir::Program) -> Program {
    let mut cg = CodeGenerator{
        stms: Vec::new(),
        temps: TempAllocator::new(),
        tmap: HashMap::new(),
        sizes: HashMap::new(),
        oldtypes: HashMap::new(),
    };

    let funs = prog.funs.into_iter().map(|f| {
        let f = cg.run(f);
        cg.reset();
        f
    }).collect();
    Program { funs: funs }
}

impl CodeGenerator {
    fn run(&mut self, f: ir::Function) -> Function {
        /* extract relevant information from the function */
        let ir::Function { root, name, cfg, loops, types, .. } = f;
        mem::replace(&mut self.oldtypes, types);

        /* Map over the cfg into a new one */
        let cfg = cfg.map(&mut |id, stms| {
            debug!("block {}", id);
            for s in stms.iter() {
                self.stmt(s);
            }
            mem::replace(&mut self.stms, Vec::new())
        }, &mut |e| e);

        /* Move our calculated sizes into the assem::Function instance */
        let sizes = mem::replace(&mut self.sizes, HashMap::new());

        info!("codegen of {} done", name);
        Function {
            name: name,
            cfg: cfg,
            root: root,
            temps: self.temps.count(),
            sizes: sizes,
            loops: loops,
            ssa: ssa::Analysis::new(),
        }
    }

    fn reset(&mut self) {
        self.temps.reset();
        self.stms.clear();
        self.tmap.clear()
    }

    fn cond(&self, c: ir::Binop) -> Cond {
        match c {
            ir::Binop::Lt  => Cond::Lt,
            ir::Binop::Lte => Cond::Lte,
            ir::Binop::Gt  => Cond::Gt,
            ir::Binop::Gte => Cond::Gte,
            ir::Binop::Eq  => Cond::Eq,
            ir::Binop::Neq => Cond::Neq,
            ir::Binop::Xor => Cond::Neq,
            _ => panic!("'{}' not a condition", c)
        }
    }

    fn op(&self, c: ir::Binop) -> Binop {
        match c {
            ir::Binop::Add => Binop::Add,
            ir::Binop::Sub => Binop::Sub,
            ir::Binop::Mul => Binop::Mul,
            ir::Binop::Div => Binop::Div,
            ir::Binop::Mod => Binop::Mod,
            ir::Binop::And => Binop::And,
            ir::Binop::Or  => Binop::Or,
            ir::Binop::Xor => Binop::Xor,
            ir::Binop::Lsh => Binop::Lsh,
            ir::Binop::Rsh => Binop::Rsh,
            _ => Binop::Cmp(self.cond(c))
        }
    }

    fn half(&mut self, e: &Expr) -> Operand {
        let size = e.size(&self.oldtypes);
        match *e {
            Expr::Temp(t) => Operand::Temp(self.tmp(t)),
            Expr::Const(c, size) => Operand::Imm(c, size),
            Expr::Label(l) => Operand::Label(l),
            Expr::BinaryOp(op, ref e1, ref e2) => {
                let out = self.tmpnew(size);
                let op = self.op(op);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(Inst::BinaryOp(op, out.clone(), e1, e2));
                return out;
            }
        }
    }

    fn addr(&mut self, e: &Expr) -> Address {
        use back::assem::Multiplier as M;
        use middle::ir::Binop as B;

        // When optimizations are turned on, constants are favored on the
        // left-hand side of binops, so that assumption is made here to test for
        // fewer cases and make things all-around easier
        debug!("{}", e);
        fn offsetify<'a>(e: &'a Expr, cg: &mut CodeGenerator)
                         -> (&'a Expr, Option<(Operand, M)>) {
            if let Expr::BinaryOp(B::Add, ref e1, ref e2) = *e {
                if let Expr::BinaryOp(B::Mul, ref e3, ref e4) = **e2 {
                    if let Expr::Const(c, _) = **e3 {
                        if M::valid(c) {
                            return (e1, Some((cg.half(e4), M::from_int(c))))
                        }
                    }
                }
                (e1, Some((cg.half(e2), M::One)))
            } else {
                (e, None)
            }
        }
        if let Expr::BinaryOp(B::Add, ref e1, ref e2) = *e {
            if let Expr::Const(c, _) = **e1 {
                let (e, mulpart) = offsetify(e2, self);
                return Address::MOp(self.half(e), Some(c as u32), mulpart)
            }
        }
        let (e, mulpart) = offsetify(e, self);
        Address::MOp(self.half(e), None, mulpart)
    }

    fn stmt(&mut self, s: &Stmt) {
        match *s {
            Stmt::Arguments(ref tmps) => {
                for (i, &tmp) in tmps.iter().enumerate() {
                    let i = i as u32;
                    let tmp = self.tmp(tmp);
                    if i < arch::ARG_REGS {
                        self.push(Inst::Arg(tmp, i));
                    } else {
                        let loc = Address::StackArg(i - arch::ARG_REGS);
                        self.push(Inst::Load(Operand::Temp(tmp), loc));
                    }
                }
            }
            Stmt::Phi(tmp, ref map) => {
                let mut map2 = HashMap::new();
                for (&k, &v) in map.iter() {
                    map2.insert(k, self.tmp(v));
                }
                let tmp = self.tmp(tmp);
                self.push(Inst::Phi(tmp, map2));
            }
            Stmt::Move(tmp, Expr::BinaryOp(op, ref e1, ref e2)) => {
                let tmp = self.tmp(tmp);
                let op = self.op(op);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(Inst::BinaryOp(op, Operand::Temp(tmp), e1, e2));
            }
            Stmt::Move(tmp, ref e) => {
                let tmp = self.tmp(tmp);
                let e = self.half(e);
                self.push(Inst::Move(Operand::Temp(tmp), e));
            }
            Stmt::Cast(t1, t2) => {
                let t1 = self.tmp(t1);
                let t2 = self.tmp(t2);
                self.push(Inst::Move(Operand::Temp(t1), Operand::Temp(t2)));
            }
            Stmt::Load(tmp, ref e) => {
                let tmp = self.tmp(tmp);
                let e = self.addr(e);
                self.push(Inst::Load(Operand::Temp(tmp), e));
            }
            Stmt::Store(ref e1, ref e2) => {
                let e1 = self.addr(e1);
                let e2 = self.half(e2);
                self.push(Inst::Store(e1, e2));
            }
            Stmt::Condition(Expr::BinaryOp(cond, ref e1, ref e2)) => {
                let cond = self.cond(cond);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(Inst::Condition(cond, e1, e2));
            }
            Stmt::Condition(ref e) => {
                let e = self.half(e);
                self.push(Inst::Condition(Cond::Neq,
                                          Operand::Imm(0, Type::Int), e));
            }
            Stmt::Die(Expr::BinaryOp(cond, ref e1, ref e2)) => {
                let cond = self.cond(cond);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(Inst::Die(cond, e1, e2));
            }
            Stmt::Die(Expr::Const(0, _)) => (),
            Stmt::Die(Expr::Const(..)) => {
                self.push(Inst::Raw(format!("jmp {}raise_segv",
                                            label::prefix())))
            }
            Stmt::Die(_) => panic!("invalid die"),
            Stmt::Return(ref e) => {
                let e = self.half(e);
                self.push(Inst::Return(e));
            }
            Stmt::Call(tmp, ref fun, ref args) => {
                let fun = self.half(fun);
                let args = args.iter().map(|arg| {
                    self.half(arg)
                }).collect();
                let tmp = self.tmp(tmp);
                self.push(Inst::Call(tmp, fun, args));
            }
        }
    }

    // Push the instruction into our basic block being built, while at the same
    // time constraining it for the x86-64 architecture
    fn push(&mut self, ins: Inst) {
        match ins {
            Inst::Condition(c, o1, o2) => {
                let (c, o1, o2) = self.constrain_cmp(c, o1, o2);
                self.stms.push(Inst::Condition(c, o1, o2));
            }
            Inst::Die(c, o1, o2) => {
                let (c, o1, o2) = self.constrain_cmp(c, o1, o2);
                self.stms.push(Inst::Die(c, o1, o2));
            }

            // the cmp instruction can only have immediates in a few places
            Inst::BinaryOp(Binop::Cmp(c), d, s1, s2) => {
                let (c, s1, s2) = self.constrain_cmp(c, s1, s2);
                self.stms.push(Inst::BinaryOp(Binop::Cmp(c), d, s1, s2));
            }

            // div/mod can't operate on immediates, only registers
            Inst::BinaryOp(op @ Binop::Div, d, s1, s2) |
            Inst::BinaryOp(op @ Binop::Mod, d, s1, s2) => {
                let s1 = if s1.imm() {
                    let tmp = self.tmpnew(Type::Int);
                    self.stms.push(Inst::Move(tmp, s1));
                    tmp
                } else { s1 };
                let s2 = if s2.imm() {
                    let tmp = self.tmpnew(Type::Int);
                    self.stms.push(Inst::Move(tmp, s2));
                    tmp
                } else { s2 };
                self.stms.push(Inst::BinaryOp(op, d, s1, s2));
            }

            // When invoking functions, all argument registers must be actual
            // registers, not immediates. Also the same register can't be an
            // argument twice because it has to be in two different places
            Inst::Call(dst, fun, args) => {
                let mut temps = HashSet::new();
                let mut args2 = Vec::new();
                for (i, arg) in args.into_iter().enumerate() {
                    let i = i as u32;

                    // If this is the first time we've seen this register, then
                    // we definitely don't need to remap, otherwise we need to
                    // remap everything else so long as we're still in the
                    // register range.
                    let remap = if let Operand::Temp(t) = arg {
                        !temps.insert(t)
                    } else {
                        true
                    };
                    let arg = if remap && i < arch::ARG_REGS {
                        let size = match arg {
                            Operand::Temp(t) => self.sizes[&t],
                            _ => arg.size()
                        };
                        let tmp = self.tmpnew(size);
                        self.stms.push(Inst::Move(tmp, arg));
                        tmp
                    } else {
                        arg
                    };
                    args2.push(arg);
                };
                self.stms.push(Inst::Call(dst, fun, args2));
            }

            // The return value must be a register, so ensure that it's in a
            // temp
            Inst::Return(op) => {
                match op {
                    Operand::Temp(..) => self.stms.push(Inst::Return(op)),
                    op => {
                        let tmp = self.tmpnew(op.size());
                        self.stms.push(Inst::Move(tmp, op));
                        self.stms.push(Inst::Return(tmp));
                    }
                }
            }

            // x86 can't load/store to immediate addresses
            Inst::Store(a, e) => {
                let a = self.constrain_addr(a);
                self.stms.push(Inst::Store(a, e));
            }
            Inst::Load(e, a) => {
                let a = self.constrain_addr(a);
                self.stms.push(Inst::Load(e, a));
            }

            ins => self.stms.push(ins)
        }
    }

    fn constrain_addr(&mut self, a: Address) -> Address {
        let mut unimm = |o: Operand| {
            match o {
                Operand::Imm(..) => {
                    let tmp = self.tmpnew(Type::Pointer);
                    self.stms.push(Inst::Move(tmp.clone(), o));
                    tmp
                }
                _ => o
            }
        };
        match a {
            Address::MOp(base, disp, off) => {
                let base = unimm(base);
                let off = off.map(|(o, m)| (unimm(o), m));
                Address::MOp(base, disp, off)
            }
            a => a
        }
    }

    fn constrain_cmp(&mut self, c: Cond, o1: Operand, o2: Operand)
                     -> (Cond, Operand, Operand) {
        match (o1, o2) {
            (Operand::Imm(i1, s1), Operand::Imm(i2, s2)) => {
                let tmp = self.tmpnew(Type::Int);
                self.stms.push(Inst::Move(tmp, Operand::Imm(i1, s1)));
                (c, tmp, Operand::Imm(i2, s2))
            }
            (Operand::Imm(i1, s1), o2) => {
                (c.flip(), o2, Operand::Imm(i1, s1))
            }
            (o1, o2) => (c, o1, o2)
        }
    }

    fn tmp(&mut self, t: Temp) -> Temp {
        if let Some(&t) = self.tmap.get(&t) {
            return t
        }
        let ret = self.temps.gen();
        self.tmap.insert(t, ret);
        self.sizes.insert(ret, self.oldtypes[&t]);
        return ret;
    }

    fn tmpnew(&mut self, s: Type) -> Operand {
        let tmp = self.temps.gen();
        self.sizes.insert(tmp, s);
        Operand::Temp(tmp)
    }
}
