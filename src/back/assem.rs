use std::collections::{HashMap, HashSet};
use std::fmt;
use std::io;

use front::pp::CommaSep;
use back::arch;
use middle::ir::Type;
use middle::label;
use middle::ssa;
use utils::{Temp, Graphable, Symbol};
use utils::graph::NodeId;

pub use middle::label::Label;
pub use middle::ir::Edge;
pub type Size = Type;
pub type Tag = Temp;
pub type CFG = ssa::CFG<Inst>;

pub struct Program {
    pub funs: Vec<Function>,
}

pub struct Function {
    pub name: Symbol,
    pub root: NodeId,
    pub cfg: CFG,
    pub sizes: HashMap<Temp, Size>,
    pub temps: u32,
    pub ssa: ssa::Analysis,

    pub loops: HashMap<NodeId, (NodeId, NodeId)>,
}

pub enum Inst {
    BinaryOp(Binop, Operand, Operand, Operand),
    Move(Operand, Operand),
    Load(Operand, Address),
    Store(Address, Operand),
    Condition(Cond, Operand, Operand),
    Die(Cond, Operand, Operand),
    Return(Operand),
    Call(Temp, Operand, Vec<Operand>),
    Raw(String),

    // pseudo-instructions that are just use for analysis/coloring/spilling
    Phi(Temp, ssa::PhiMap),
    MemPhi(Tag, ssa::PhiMap),
    Reload(Temp, Tag),
    Spill(Temp, Tag),
    Use(Temp),                // used when constraining non-commutative ops
    PCopy(Vec<(Temp, Temp)>), // parallel copy of temps
    Arg(Temp, u32),           // nth argument is wired to this temp
}

#[derive(Clone, Copy)]
pub enum Operand {
    Imm(i32, Size),
    Reg(Register, Size),
    Temp(Temp),
    Label(Label)
}

#[derive(Clone, Copy)]
pub enum Address {
    //   base      offset         multplier reg    multiplier size
    MOp(Operand, Option<u32>, Option<(Operand, Multiplier)>),
    Stack(u32),
    StackArg(u32),
}

#[derive(Clone, Copy)]
pub enum Multiplier {
    One, Two, Four, Eight
}

#[derive(Eq, PartialEq, Clone, Copy)]
pub enum Binop {
    Add, Sub, Mul, Div, Mod, Cmp(Cond), And, Or, Xor, Lsh, Rsh
}

#[derive(Eq, PartialEq, Clone, Copy)]
pub enum Cond {
    Lt, Lte, Gt, Gte, Eq, Neq
}

#[derive(Eq, PartialEq, Clone, Copy, Debug)]
pub enum Register {
    EAX, EBX, ECX, EDX, EDI, ESI, ESP, EBP,
    R8D, R9D, R10D, R11D, R12D, R13D, R14D, R15D
}

#[derive(Copy, Clone)]
pub enum Constraint { Caller, Idiv }

// These two structures are used to parameterize the reconstruction of SSA form
// after the spilling phase has happened. RegisterInfo looks as all temps which
// need to be in registers while StackInfo looks at stack spill slots.
pub struct RegisterInfo;
pub struct StackInfo;

impl Constraint {
    pub fn allows(&self, r: Register) -> bool{
        match (*self, r) {
            (Constraint::Idiv, Register::EAX) |
            (Constraint::Idiv, Register::EDX) => false,
            (Constraint::Idiv, _) => true,
            (Constraint::Caller, _) => arch::callee_reg(r),
        }
    }
}

impl Inst {
    pub fn each_def<F: FnMut(Temp)>(&self, mut f: F) {
        match *self {
            Inst::BinaryOp(_, Operand::Temp(t), _, _) |
            Inst::Move(Operand::Temp(t), _) |
            Inst::Phi(t, _) |
            Inst::Load(Operand::Temp(t), _) |
            Inst::Call(t, _, _) |
            Inst::Reload(t, _) |
            Inst::Arg(t, _) => f(t),

            Inst::PCopy(ref copies) => {
                for &(def, _) in copies.iter() {
                    f(def)
                }
            }

            _ => ()
        }
    }

    pub fn each_use<F: FnMut(Temp)>(&self, mut f: F) {
        match *self {
            Inst::Condition(_, ref o1, ref o2) |
            Inst::Die(_, ref o1, ref o2) |
            Inst::BinaryOp(_, _, ref o1, ref o2) => {
                o1.each_temp(&mut f);
                o2.each_temp(&mut f);
            }

            Inst::Move(_, ref t) |
            Inst::Return(ref t) => t.each_temp(&mut f),
            Inst::Spill(t, _) |
            Inst::Use(t) => f(t),

            Inst::Store(ref addr, ref src) => {
                addr.each_temp(&mut f);
                src.each_temp(&mut f);
            }
            Inst::Load(_, ref addr) => addr.each_temp(&mut f),

            Inst::Call(_, ref fun, ref args) => {
                fun.each_temp(&mut f);
                for arg in args {
                    arg.each_temp(&mut f);
                }
            }

            Inst::PCopy(ref copies) => {
                for &(_, t) in copies.iter() {
                    f(t)
                }
            }

            _ => ()
        }
    }

    pub fn is_phi(&self) -> bool {
        match *self { Inst::Phi(..) => true, _ => false }
    }
}

impl ssa::Statement<Inst> for RegisterInfo {
    fn each_def(&self, i: &Inst, f: &mut FnMut(Temp)) {
        i.each_def(f)
    }
    fn each_use(&self, i: &Inst, f: &mut FnMut(Temp)) {
        i.each_use(f)
    }

    fn new_phi(&self, t: Temp, map: ssa::PhiMap) -> Inst {
        Inst::Phi(t, map)
    }

    fn phi<'r>(&self, me: &'r Inst) -> Option<(Temp, &'r ssa::PhiMap)> {
        match *me {
            Inst::Phi(d, ref m) => Some((d, m)),
            _ => None
        }
    }
    fn phi_mut<'r>(&self, me: &'r mut Inst)
                   -> Option<(Temp, &'r mut ssa::PhiMap)> {
        match *me {
            Inst::Phi(d, ref mut m) => Some((d, m)),
            _ => None
        }
    }
    fn into_phi(&self, me: Inst) -> Result<(Temp, ssa::PhiMap), Inst> {
        match me {
            Inst::Phi(d, m) => Ok((d, m)),
            i => Err(i)
        }
    }

    fn map_temps(&self, i: &mut Inst,
                 uses: &mut FnMut(Temp) -> Temp,
                 defs: &mut FnMut(Temp) -> Temp) {
        match *i {
            Inst::BinaryOp(_, ref mut o1, ref mut o2, ref mut o3) => {
                o2.map_temps(uses);
                o3.map_temps(uses);
                o1.map_temps(defs);
            }
            Inst::Move(ref mut dst, ref mut src) => {
                dst.map_temps(defs);
                src.map_temps(uses);
            }
            Inst::Load(ref mut dst, ref mut addr) => {
                dst.map_temps(defs);
                addr.map_temps(uses);
            }
            Inst::Store(ref mut addr, ref mut op) => {
                op.map_temps(uses);
                addr.map_temps(uses);
            }
            Inst::Die(_, ref mut o1, ref mut o2) |
            Inst::Condition(_, ref mut o1, ref mut o2) => {
                o1.map_temps(uses);
                o2.map_temps(uses);
            }
            Inst::Spill(ref mut t, _) => *t = uses(*t),
            Inst::Reload(ref mut dst, _) => *dst = defs(*dst),
            Inst::Phi(ref mut t, _) => *t = defs(*t),
            Inst::Call(ref mut dst, ref mut fun, ref mut args) => {
                fun.map_temps(uses);
                for arg in args {
                    arg.map_temps(uses);
                }
                *dst = defs(*dst);
            }
            Inst::Use(ref mut t) => *t = uses(*t),
            Inst::Return(ref mut t) => t.map_temps(uses),
            Inst::Arg(ref mut t, _) => *t = defs(*t),
            Inst::PCopy(ref mut copies) => {
                for &mut (ref mut dst, ref mut src) in copies {
                    *src = uses(*src);
                    *dst = defs(*dst);
                }
            }
            _ => {}
        }
    }
}

impl ssa::Statement<Inst> for StackInfo {
    fn each_def(&self, i: &Inst, f: &mut FnMut(Temp)) {
        match *i {
            Inst::Spill(_, t) |
            Inst::MemPhi(t, _) => f(t),
            _ => ()
        }
    }
    fn each_use(&self, i: &Inst, f: &mut FnMut(Temp)) {
        match *i {
            Inst::Reload(_, t) => f(t),
            _ => ()
        }
    }

    fn new_phi(&self, t: Temp, map: ssa::PhiMap) -> Inst {
        Inst::MemPhi(t, map)
    }

    fn phi<'r>(&self, me: &'r Inst) -> Option<(Temp, &'r ssa::PhiMap)> {
        match *me {
            Inst::MemPhi(t, ref m) => Some((t, m)),
            _ => None
        }
    }
    fn phi_mut<'r>(&self, me: &'r mut Inst)
                   -> Option<(Temp, &'r mut ssa::PhiMap)> {
        match *me {
            Inst::MemPhi(t, ref mut m) => Some((t, m)),
            _ => None
        }
    }
    fn into_phi(&self, me: Inst) -> Result<(Temp, ssa::PhiMap), Inst> {
        match me {
            Inst::MemPhi(d, m) => Ok((d, m)),
            i => Err(i)
        }
    }

    fn map_temps(&self, i: &mut Inst,
                 uses: &mut FnMut(Temp) -> Temp,
                 defs: &mut FnMut(Temp) -> Temp) {
        match *i {
            Inst::MemPhi(ref mut t, _) => *t = defs(*t),
            Inst::Spill(_, ref mut t) => *t = defs(*t),
            Inst::Reload(_, ref mut t) => *t = uses(*t),
            _ => {}
        }
    }
}

impl fmt::Display for Inst {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Inst::Raw(ref s) => write!(f, "{}", s),
            Inst::Arg(t, i) => write!(f, "# {} = arg[{}]", t, i),
            Inst::Return(ref t) => write!(f, "ret # {}", t),
            Inst::Use(t) => write!(f, "# use {}", t),
            Inst::Die(c, ref o1, ref o2) => {
                write!(f, "cmp {}, {}; j{} {}raise_segv", o2, o1,
                       c.suffix(), label::prefix())
            }
            Inst::Condition(c, ref o1, ref o2) => {
                write!(f, "cmp {}, {} # {}", o2, o1, c.suffix())
            }
            Inst::Load(ref dst, ref addr) => {
                write!(f, "mov {}, {}", addr, dst)
            }
            Inst::Store(ref addr, ref src) => {
                match *src {
                    Operand::Imm(_, Type::Pointer) => {
                        write!(f, "movq {}, {}", src, addr)
                    }
                    Operand::Imm(_, Type::Int) => {
                        write!(f, "movl {}, {}", src, addr)
                    }
                    _ => write!(f, "mov {}, {}", src, addr),
                }
            }
            Inst::Move(ref o1, ref o2) => {
                if o1.size() != o2.size() && !o2.imm() {
                    write!(f, "movslq {}, {}", o2, o1)
                } else {
                    write!(f, "mov {}, {}", o2, o1)
                }
            }
            Inst::BinaryOp(binop, ref dst, ref s1, ref s2) => match binop {
                // multiplications can have third operand if it's an immediate
                Binop::Mul if s2.imm() && !s1.imm() => {
                    write!(f, "imul {}, {}, {}", s2, s1, dst)
                }
                // division/mod are both weird
                Binop::Div |
                Binop::Mod => {
                    write!(f, "cltd; idiv {} # {} <- {} {} {}", s2, dst,
                           s1, binop, s2)
                }

                // Shifting by immediates can only use lower 5 bits
                Binop::Lsh | Binop::Rsh if s1.imm() => {
                    write!(f, "{} {}, {}", binop, s1.mask(0x1f), dst)
                }
                Binop::Lsh | Binop::Rsh if s1.reg() => {
                    write!(f, "{} %cl, {}", binop, dst)
                }

                Binop::Cmp(cond) => {
                    let dstsmall = match *dst {
                        Operand::Reg(r, _) => r.byte().to_string(),
                        _ => dst.to_string(),
                    };
                    write!(f, "cmp {}, {}; set{} {}; movzbl {}, {}",
                           s2, s1, cond.suffix(), dstsmall, dstsmall, dst)
                }

                _ => write!(f, "{} {}, {} # {}", binop, s1, dst, s2),
            },
            Inst::Call(dst, ref e, ref args) => {
                write!(f, "call {} # {} <- ({})", e, dst, CommaSep(args))
            }
            Inst::Phi(tmp, ref map) => {
                try!(write!(f, "# {} <- phi(", tmp));
                for (&id, &tmp) in map.iter() {
                    try!(write!(f, " [ {} - n{} ] ", tmp, id));
                }
                write!(f, ")")
            }
            Inst::MemPhi(tag, ref map) => {
                try!(write!(f, "# m{} <- phi(", tag));
                for (&id, &tag) in map.iter() {
                    try!(write!(f, " [ m{} - n{} ] ", tag, id));
                }
                write!(f, ")")
            }
            Inst::Spill(t, tag) => write!(f, "SPILL {} -> {}", t, tag),
            Inst::Reload(t, tag) => write!(f, "RELOAD {} <= {}", t, tag),
            Inst::PCopy(ref copies) => {
                try!(write!(f, "{{"));
                for &(k, v) in copies.iter() {
                    try!(write!(f, "({} <= {}) ", k, v));
                }
                write!(f, "}}")
            }
        }
    }
}

impl Operand {
    pub fn imm(&self) -> bool {
        match *self { Operand::Imm(..) => true, _ => false }
    }

    pub fn reg(&self) -> bool {
        match *self { Operand::Reg(..) => true, _ => false }
    }

    fn mask(&self, mask: i32) -> Operand {
        match *self {
            Operand::Imm(n, s) => Operand::Imm(n & mask, s),
            _ => panic!("can't mask non-immediate")
        }
    }

    pub fn size(&self) -> Size {
        match *self {
            Operand::Imm(_, s) | Operand::Reg(_, s) => s,
            Operand::Label(..) => Type::Pointer,
            Operand::Temp(..) => Type::Int
        }
    }

    pub fn each_temp(&self, f: &mut FnMut(Temp)) {
        match *self {
            Operand::Temp(t) => { f(t) }
            _ => ()
        }
    }

    pub fn map_temps(&mut self, f: &mut FnMut(Temp) -> Temp) {
        match *self {
            Operand::Temp(ref mut t) => *t = f(*t),
            _ => {}
        }
    }
}

impl fmt::Display for Operand {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Operand::Imm(c, _) => write!(f, "${}", c),
            Operand::Reg(reg, s) => write!(f, "{}", reg.size(s)),
            Operand::Temp(t) => write!(f, "{}", t),
            Operand::Label(ref l) => write!(f, "{}", l),
        }
    }
}

impl PartialEq for Operand {
    fn eq(&self, other: &Operand) -> bool {
        match (self, other) {
            (&Operand::Reg(a, _), &Operand::Reg(b, _)) => a == b,
            (&Operand::Temp(a), &Operand::Temp(b)) => a == b,
            _ => false
        }
    }
}

impl Address {
    fn map_temps(&mut self, f: &mut FnMut(Temp) -> Temp) {
        match *self {
            Address::MOp(ref mut t, _, ref mut off) => {
                t.map_temps(f);
                if let Some((ref mut x, _)) = *off {
                    x.map_temps(f);
                }
            }
            _ => {}
        }
    }

    fn each_temp(&self, f: &mut FnMut(Temp)) {
        match *self {
            Address::MOp(ref o, _, ref off) => {
                o.each_temp(f);
                for &(ref x, _) in off.iter() {
                    x.each_temp(f);
                }
            }
            Address::Stack(..) |
            Address::StackArg(..) => ()
        }
    }
}

impl fmt::Display for Address {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Address::MOp(ref o, disp, ref off) => {
                if let Some(d) = disp {
                    try!(write!(f, "{}", d as i32));
                }
                try!(write!(f, "({}", o));
                match *off {
                    Some((ref off, mult)) => {
                        try!(write!(f, ", {}, {}", off, mult));
                    }
                    None => (),
                }
                write!(f, ")")
            }
            Address::Stack(i) => write!(f, "{}(%rsp)", i as i32),
            Address::StackArg(i) => write!(f, "arg[{}]", i),
        }
    }
}

impl Cond {
    pub fn flip(&self) -> Cond {
        match *self {
            Cond::Lt  => Cond::Gt,
            Cond::Lte => Cond::Gte,
            Cond::Gt  => Cond::Lt,
            Cond::Gte => Cond::Lte,
            Cond::Eq  => Cond::Eq,
            Cond::Neq => Cond::Neq
        }
    }
    pub fn negate(&self) -> Cond {
        match *self {
            Cond::Lt  => Cond::Gte,
            Cond::Lte => Cond::Gt,
            Cond::Gt  => Cond::Lte,
            Cond::Gte => Cond::Lt,
            Cond::Eq  => Cond::Neq,
            Cond::Neq => Cond::Eq
        }
    }
    pub fn suffix(&self) -> &'static str {
        match *self {
            Cond::Lt  => "l",
            Cond::Lte => "le",
            Cond::Gt  => "g",
            Cond::Gte => "ge",
            Cond::Eq  => "e",
            Cond::Neq => "ne"
        }
    }
}

impl Binop {
    pub fn commutative(&self) -> bool {
        match *self {
            Binop::Add |
            Binop::Mul |
            Binop::And |
            Binop::Or |
            Binop::Xor => true,
            _ => false,
        }
    }

    pub fn constrained(&self) -> bool {
        match *self {
            Binop::Div |
            Binop::Mod |
            Binop::Lsh |
            Binop::Rsh => true,
            _ => false,
        }
    }
}

impl fmt::Display for Binop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Binop::Add => "add".fmt(f),
            Binop::Sub => "sub".fmt(f),
            Binop::Mul => "imul".fmt(f),
            Binop::Div => "div".fmt(f),
            Binop::Mod => "mod".fmt(f),
            Binop::And => "and".fmt(f),
            Binop::Or  => "or".fmt(f),
            Binop::Xor => "xor".fmt(f),
            Binop::Lsh => "sal".fmt(f),
            Binop::Rsh => "sar".fmt(f),
            Binop::Cmp(_) => "cmp".fmt(f),
        }
    }
}

impl Register {
    pub fn byte(&self) -> &'static str {
        match *self {
            Register::EAX  => "%al",
            Register::EBX  => "%bl",
            Register::ECX  => "%cl",
            Register::EDX  => "%dl",
            Register::ESI  => "%sil",
            Register::EDI  => "%dil",
            Register::ESP  => "%spl",
            Register::EBP  => "%bpl",
            Register::R8D  => "%r8b",
            Register::R9D  => "%r9b",
            Register::R10D => "%r10b",
            Register::R11D => "%r11b",
            Register::R12D => "%r12b",
            Register::R13D => "%r13b",
            Register::R14D => "%r14b",
            Register::R15D => "%r15b",
        }
    }

    pub fn size(&self, t: Size) -> &'static str {
        match (*self, t) {
            (Register::EAX, Type::Int)      => "%eax",
            (Register::EAX, Type::Pointer)  => "%rax",
            (Register::EBX, Type::Int)      => "%ebx",
            (Register::EBX, Type::Pointer)  => "%rbx",
            (Register::ECX, Type::Int)      => "%ecx",
            (Register::ECX, Type::Pointer)  => "%rcx",
            (Register::EDX, Type::Int)      => "%edx",
            (Register::EDX, Type::Pointer)  => "%rdx",
            (Register::EDI, Type::Int)      => "%edi",
            (Register::EDI, Type::Pointer)  => "%rdi",
            (Register::ESI, Type::Int)      => "%esi",
            (Register::ESI, Type::Pointer)  => "%rsi",
            (Register::ESP, Type::Int)      => "%esp",
            (Register::ESP, Type::Pointer)  => "%rsp",
            (Register::EBP, Type::Int)      => "%ebp",
            (Register::EBP, Type::Pointer)  => "%rbp",
            (Register::R8D, Type::Int)      => "%r8d",
            (Register::R8D, Type::Pointer)  => "%r8",
            (Register::R9D, Type::Int)      => "%r9d",
            (Register::R9D, Type::Pointer)  => "%r9",
            (Register::R10D, Type::Int)     => "%r10d",
            (Register::R10D, Type::Pointer) => "%r10",
            (Register::R11D, Type::Int)     => "%r11d",
            (Register::R11D, Type::Pointer) => "%r11",
            (Register::R12D, Type::Int)     => "%r12d",
            (Register::R12D, Type::Pointer) => "%r12",
            (Register::R13D, Type::Int)     => "%r13d",
            (Register::R13D, Type::Pointer) => "%r13",
            (Register::R14D, Type::Int)     => "%r14d",
            (Register::R14D, Type::Pointer) => "%r14",
            (Register::R15D, Type::Int)     => "%r15d",
            (Register::R15D, Type::Pointer) => "%r15",
        }
    }
}

impl Multiplier {
    pub fn valid(i: i32) -> bool {
        i == 1 || i == 2 || i == 4 || i == 8
    }

    pub fn from_int(i: i32) -> Multiplier {
        match i {
            1 => Multiplier::One,
            2 => Multiplier::Two,
            4 => Multiplier::Four,
            8 => Multiplier::Eight,
            _ => panic!("can't make multiplier for {}", i)
        }
    }
}

impl fmt::Display for Multiplier {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Multiplier::One => "1".fmt(f),
            Multiplier::Two => "2".fmt(f),
            Multiplier::Four => "4".fmt(f),
            Multiplier::Eight => "8".fmt(f),
        }
    }
}

impl Graphable for Program {
    fn dot(&self, out: &mut io::Write) -> io::Result<()> {
        try!(out.write_all(b"digraph {\n"));
        for f in self.funs.iter() {
            try!(f.cfg.dot(out,
                           &mut |id| format!("{}_n{}", f.name, id),
                           &mut |id, ins| {
                                format!("label=\"{}\n[node={}]\" shape=box",
                                        ins.iter().map(|s| s.to_string())
                                           .collect::<Vec<_>>().join("\\n"),
                                        id)
                           },
                           &mut |&edge| format!("label={:?}", edge)
                          ));
        }
        out.write_all(b"\n}")
    }
}

impl Program {
    pub fn output(&self, out: &mut io::Write) -> io::Result<()> {
        for f in self.funs.iter() {
            try!(f.output(out));
        }
        Ok(())
    }
}

impl Function {
    /// Traverses the cfg and outputs a stream of instructions which can be
    /// assembled to the actual program
    fn output(&self, out: &mut io::Write) -> io::Result<()> {
        let base = Label::Internal(self.name.clone());
        // entry label
        try!(write!(out, ".globl {}\n", base));
        try!(write!(out, "{}:\n", base));
        let lbl = |n: NodeId| format!("{}_bb_{}", base, n);

        // skipped is a stack of nodes that we have yet to visit
        let mut skipped = vec![self.root];
        let mut visited = HashSet::new();

        loop {
            let block = match skipped.pop() { Some(a) => a, None => break };
            if visited.contains(&block) { continue }

            // Each block has its own label (so it can be jumped to)
            visited.insert(block);
            try!(write!(out, "L{}:\n", lbl(block)));

            // output the actual block
            let instructions = self.cfg.node(block);
            for ins in instructions.iter() {
                try!(write!(out, "  {}\n", ins));
            }

            // Collect information about the edges
            let mut always = None;
            let mut tedge = None;
            let mut fedge = None;
            for (id, &typ) in self.cfg.succ_edges(block) {
                debug!("out of {} ({} - {:?})", block, id, typ);
                match typ {
                    Edge::Always | Edge::Branch | Edge::LoopOut => {
                        assert!(tedge.is_none() && fedge.is_none() && always.is_none());
                        always = Some((typ, id));
                    }
                    Edge::True | Edge::TBranch => {
                        assert!(tedge.is_none() && always.is_none());
                        tedge = Some((typ, id));
                    }
                    Edge::False | Edge::FBranch | Edge::FLoopOut => {
                        assert!(fedge.is_none() && always.is_none());
                        fedge = Some((typ, id));
                    }
                }
            }

            // Emit jumps and alter our stack of nodes to visit
            match always {
                // Always branches to unvisited blocks can just fall through
                Some((Edge::Always, id)) if !visited.contains(&id) => {
                    skipped.push(id);
                }
                // Otherwise always branches or edges to visited blocks are jumps
                Some((_, id)) => {
                    skipped.insert(0, id);
                    try!(write!(out, "  jmp L{}\n", lbl(id)));
                }

                None => {
                    match (tedge, fedge) {
                        // If everything is none, then we've reached a
                        // termination
                        (None, None) => (),

                        (Some((tedge, tid)), Some((fedge, fid))) => {
                            // On a conditional branch, the last ins must be
                            // Condition
                            let cond = match instructions.last() {
                                Some(&Inst::Condition(c, _, _)) => c,
                                _ => panic!("Need a condition with true/false edges")
                            };

                            match (tedge, fedge) {
                                // If we fall through to the true block, then
                                // negate the condition to jump to the false
                                // block and push traversal
                                (Edge::True, _) => {
                                    skipped.push(fid);
                                    skipped.push(tid);
                                    try!(write!(out, "  j{} L{}\n",
                                                cond.negate().suffix(),
                                                lbl(fid)));
                                }

                                // Otherwise we can use the condition as is and
                                // we update the nodes to visit
                                (_, Edge::False) => {
                                    skipped.push(tid);
                                    skipped.push(fid);
                                    try!(write!(out, "  j{} L{}\n",
                                                cond.suffix(),
                                                lbl(tid)));
                                }

                                _ => panic!("invalidly specified edges")
                            }
                        }
                        _ => panic!("invalid edges")
                    }
                }
            }

            // and finally, the basic block is done with its emission!
        }
        Ok(())
    }
}
