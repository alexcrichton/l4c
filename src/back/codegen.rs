use std::collections::{HashMap, HashSet};
use std::mem;

use middle::{ir, temp, ssa, label};
use back::{assem, arch};

pub struct CodeGenerator {
    temps: temp::Allocator,
    sizes: HashMap<temp::Temp, assem::Size>,
    stms: Vec<Box<assem::Instruction>>,
    tmap: HashMap<temp::Temp, temp::Temp>,
    oldtypes: HashMap<temp::Temp, ir::Type>,
}

pub fn codegen(ir::Program{funs}: ir::Program) -> assem::Program {
    let mut cg = CodeGenerator{
        stms: Vec::new(),
        temps: temp::new(),
        tmap: HashMap::new(),
        sizes: HashMap::new(),
        oldtypes: HashMap::new(),
    };

    let funs = funs.move_iter().map(|f| {
        let f = cg.run(f);
        cg.reset();
        f
    }).collect();
    assem::Program{ funs: funs }
}

impl CodeGenerator {
    fn run(&mut self, f: ir::Function) -> assem::Function {
        /* extract relevant information from the function */
        let ir::Function {root, name, cfg, loops, types, ..} = f;
        mem::replace(&mut self.oldtypes, types);

        /* Map over the cfg into a new one */
        let cfg = cfg.map(|id, stms| {
            debug!("block {}", id);
            for s in stms.move_iter() {
                self.stm(s);
            }
            mem::replace(&mut self.stms, Vec::new())
        }, |e| e);

        /* Move our calculated sizes into the assem::Function instance */
        let sizes = mem::replace(&mut self.sizes, HashMap::new());

        info!("codegen of {} done", name);
        assem::Function {
            name: name,
            cfg: cfg,
            root: root,
            temps: self.temps.cnt(),
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

    fn cond(&self, c: ir::Binop) -> assem::Cond {
        match c {
            ir::Lt  => assem::Lt,
            ir::Lte => assem::Lte,
            ir::Gt  => assem::Gt,
            ir::Gte => assem::Gte,
            ir::Eq  => assem::Eq,
            ir::Neq => assem::Neq,
            ir::Xor => assem::Neq,
            _       => fail!("'{}' not a condition", c)
        }
    }

    fn op(&self, c: ir::Binop) -> assem::Binop {
        match c {
            ir::Add => assem::Add,
            ir::Sub => assem::Sub,
            ir::Mul => assem::Mul,
            ir::Div => assem::Div,
            ir::Mod => assem::Mod,
            ir::And => assem::And,
            ir::Or  => assem::Or,
            ir::Xor => assem::Xor,
            ir::Lsh => assem::Lsh,
            ir::Rsh => assem::Rsh,
            _       => assem::Cmp(self.cond(c))
        }
    }

    fn half(&mut self, e: Box<ir::Expression>) -> Box<assem::Operand> {
        let size = e.size(&self.oldtypes);
        match *e {
            ir::Temp(t) => box assem::Temp(self.tmp(t)),
            ir::Const(c, size) => box assem::Immediate(c, size),
            ir::LabelExp(l) => box assem::LabelOp(l),
            ir::BinaryOp(op, e1, e2) => {
                let out = self.tmpnew(size);
                let op = self.op(op);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(box assem::BinaryOp(op, out.clone(), e1, e2));
                return out;
            }
        }
    }

    fn addr(&mut self, e: Box<ir::Expression>) -> Box<assem::Address> {
        use M = back::assem::Multiplier;
        use middle::ir::{BinaryOp, Mul, Const, Add};

        /* When optimizations are turned on, constants are favored on the
           left-hand side of binops, so that assumption is made here to test for
           fewer cases and make things all-around easier */
        debug!("{}", e);
        let offsetify = |e: Box<ir::Expression>, cg: &mut CodeGenerator| {
            match e {
                box BinaryOp(Add, e1, e2) => {
                    match e2 {
                        box BinaryOp(Mul, box Const(c, s), e2) => {
                            if M::valid(c) {
                                (e1, Some((cg.half(e2), M::from_int(c))))
                            } else {
                                (e1, Some((cg.half(box BinaryOp(Mul, box Const(c, s), e2)),
                                           assem::One)))
                            }
                        }
                        e2 => (e1, Some((cg.half(e2), assem::One)))
                    }
                }
                e => (e, None)
            }
        };
        match e {
            box BinaryOp(Add, box Const(c, _), e) => {
                let (e, mulpart) = offsetify(e, self);
                box assem::MOp(self.half(e), Some(c as uint), mulpart)
            }

            e => {
                let (e, mulpart) = offsetify(e, self);
                box assem::MOp(self.half(e), None, mulpart)
            }
        }
    }

    fn stm(&mut self, s: Box<ir::Statement>) {
        match *s {
            ir::Arguments(ref tmps) => {
                for (i, &tmp) in tmps.iter().enumerate() {
                    let tmp = self.tmp(tmp);
                    if i < arch::arg_regs {
                        self.push(box assem::Arg(tmp, i));
                    } else {
                        let loc = box assem::StackArg(i - arch::arg_regs);
                        self.push(box assem::Load(box assem::Temp(tmp), loc));
                    }
                }
            }
            ir::Phi(tmp, ref map) => {
                let mut map2 = HashMap::new();
                for (&k, &v) in map.iter() {
                    map2.insert(k, self.tmp(v));
                }
                let tmp = self.tmp(tmp);
                self.push(box assem::Phi(tmp, map2));
            }
            ir::Move(tmp, box ir::BinaryOp(op, e1, e2)) => {
                let tmp = self.tmp(tmp);
                let op = self.op(op);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(box assem::BinaryOp(op, box assem::Temp(tmp), e1, e2));
            }
            ir::Move(tmp, e) => {
                let tmp = self.tmp(tmp);
                let e = self.half(e);
                self.push(box assem::Move(box assem::Temp(tmp), e));
            }
            ir::Cast(t1, t2) => {
                let t1 = self.tmp(t1);
                let t2 = self.tmp(t2);
                self.push(box assem::Move(box assem::Temp(t1), box assem::Temp(t2)));
            }
            ir::Load(tmp, e) => {
                let tmp = self.tmp(tmp);
                let e = self.addr(e);
                self.push(box assem::Load(box assem::Temp(tmp), e));
            }
            ir::Store(e1, e2) => {
                let e1 = self.addr(e1);
                let e2 = self.half(e2);
                self.push(box assem::Store(e1, e2));
            }
            ir::Condition(box ir::BinaryOp(cond, e1, e2)) => {
                let cond = self.cond(cond);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(box assem::Condition(cond, e1, e2));
            }
            ir::Condition(e) => {
                let e = self.half(e);
                self.push(box assem::Condition(assem::Neq,
                          box assem::Immediate(0, ir::Int),
                e));
            }
            ir::Die(box ir::BinaryOp(cond, e1, e2)) => {
                let cond = self.cond(cond);
                let e1 = self.half(e1);
                let e2 = self.half(e2);
                self.push(box assem::Die(cond, e1, e2));
            }
            ir::Die(box ir::Const(0, _)) => (),
            ir::Die(box ir::Const(..)) =>
                self.push(box assem::Raw(format!("jmp {}raise_segv", label::prefix()))),
            ir::Die(_) => fail!("invalid die"),
            ir::Return(e) => {
                let e = self.half(e);
                self.push(box assem::Return(e));
            }
            ir::Call(tmp, fun, args) => {
                let fun = self.half(fun);
                let args = args.move_iter().map(|arg| {
                    self.half(arg)
                }).collect();
                let tmp = self.tmp(tmp);
                self.push(box assem::Call(tmp, fun, args));
            }
        }
    }

    /* Push the instruction into our basic block being built, while at the same
     * time constraining it for the x86-64 architecture */
    fn push(&mut self, ins: Box<assem::Instruction>) {
        match ins {
            box assem::Condition(c, o1, o2) => {
                let (c, o1, o2) = self.constrain_cmp(c, o1, o2);
                self.stms.push(box assem::Condition(c, o1, o2));
            }
            box assem::Die(c, o1, o2) => {
                let (c, o1, o2) = self.constrain_cmp(c, o1, o2);
                self.stms.push(box assem::Die(c, o1, o2));
            }

            /* the cmp instruction can only have immediates in a few places */
            box assem::BinaryOp(assem::Cmp(c), d, s1, s2) => {
                let (c, s1, s2) = self.constrain_cmp(c, s1, s2);
                self.stms.push(box assem::BinaryOp(assem::Cmp(c), d, s1, s2));
            }

            /* div/mod can't operate on immediates, only registers */
            box assem::BinaryOp(op @ assem::Div, d, s1, s2) |
                box assem::BinaryOp(op @ assem::Mod, d, s1, s2) => {
                    let s1 = if s1.imm() {
                        let tmp = self.tmpnew(ir::Int);
                        self.stms.push(box assem::Move(tmp.clone(), s1));
                        tmp
                    } else { s1 };
                    let s2 = if s2.imm() {
                        let tmp = self.tmpnew(ir::Int);
                        self.stms.push(box assem::Move(tmp.clone(), s2));
                        tmp
                    } else { s2 };
                    self.stms.push(box assem::BinaryOp(op, d, s1, s2));
                }

            /* When invoking functions, all argument registers must be actual
               registers, not immediates. Also the same register can't be an
               argument twice because it has to be in two different places */
            box assem::Call(dst, fun, args) => {
                let mut temps = HashSet::new();
                let mut args2 = Vec::new();
                for (i, arg) in args.move_iter().enumerate() {
                    let arg = match arg {
                        /* If we have first saw this temp, or the
                           immediates/labels need to be stored on the stack,
                           then no copy is needed */
                        box assem::Temp(t) if temps.insert(t) => arg,
                        box assem::Immediate(..) |
                            box assem::LabelOp(..) if i >= arch::arg_regs => arg,

                        /* Otherwise we need to create a temp to store this
                           argument */
                        _ if i < arch::arg_regs => {
                            let size = match arg {
                                box assem::Temp(t) => *self.sizes.get(&t),
                                _ => arg.size()
                            };
                            let tmp = self.tmpnew(size);
                            self.stms.push(box assem::Move(tmp.clone(), arg));
                            tmp
                        }
                        _ => arg
                    };
                    args2.push(arg);
                };
                self.stms.push(box assem::Call(dst, fun, args2));
            }

            /* The return value must be a register, so ensure that it's in a temp */
            box assem::Return(op) => match op {
                box assem::Temp(t) => self.stms.push(box assem::Return(box assem::Temp(t))),
                op => {
                    let tmp = self.tmpnew(op.size());
                    self.stms.push(box assem::Move(tmp.clone(), op));
                    self.stms.push(box assem::Return(tmp));
                }
            },

            /* x86 can't load/store to immediate addresses */
            box assem::Store(a, e) => {
                let a = self.constrain_addr(a);
                self.stms.push(box assem::Store(a, e));
            }
            box assem::Load(e, a) => {
                let a = self.constrain_addr(a);
                self.stms.push(box assem::Load(e, a));
            }

            ins => self.stms.push(ins)
        }
    }

    fn constrain_addr(&mut self, a: Box<assem::Address>) -> Box<assem::Address> {
        let unimm = |o: Box<assem::Operand>| {
            match o {
                box assem::Immediate(..) => {
                    let tmp = self.tmpnew(ir::Pointer);
                    self.stms.push(box assem::Move(tmp.clone(), o));
                    tmp
                }
                _ => o
            }
        };
        match a {
            box assem::MOp(base, disp, off) => {
                let base = unimm(base);
                let off = off.map(|(o, m)| (unimm(o), m));
                box assem::MOp(base, disp, off)
            }
            a => a
        }
    }

    fn constrain_cmp(&mut self,
                     c: assem::Cond,
                     o1: Box<assem::Operand>,
                     o2: Box<assem::Operand>)
        -> (assem::Cond, Box<assem::Operand>, Box<assem::Operand>)
        {
            match (o1, o2) {
                (box assem::Immediate(i1, s1), box assem::Immediate(i2, s2)) => {
                    let tmp = self.tmpnew(ir::Int);
                    self.stms.push(box assem::Move(tmp.clone(),
                                                   box assem::Immediate(i1, s1)));
                    (c, tmp, box assem::Immediate(i2, s2))
                }
                (box assem::Immediate(i1, s1), o2) =>
                    (c.flip(), o2, box assem::Immediate(i1, s1)),
                    (o1, o2) => (c, o1, o2)
            }
        }

    fn tmp(&mut self, t: temp::Temp) -> temp::Temp {
        match self.tmap.find(&t) {
            Some(&t) => return t,
            None => ()
        }
        let ret = self.temps.new();
        self.tmap.insert(t, ret);
        self.sizes.insert(ret, *self.oldtypes.get(&t));
        return ret;
    }

    fn tmpnew(&mut self, s: ir::Type) -> Box<assem::Operand> {
        let tmp = self.temps.new();
        self.sizes.insert(tmp, s);
        box assem::Temp(tmp)
    }
}
