use std::collections::{HashMap, HashSet};
use std::fmt;
use std::io;

use back::arch;
use middle::ssa;
use middle::temp;
use middle::{label, ir};
use utils::{graph, Graphable};

pub type Label = label::Label;
pub type Edge = ir::Edge;
pub type Size = ir::Type;
pub type Tag = temp::Temp;
pub type CFG = ssa::CFG<Instruction>;

pub struct Program {
    pub funs: Vec<Function>,
}

pub struct Function {
    pub name: String,
    pub root: graph::NodeId,
    pub cfg: CFG,
    pub sizes: HashMap<temp::Temp, Size>,
    pub temps: uint,
    pub ssa: ssa::Analysis,

    pub loops: HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
}

pub enum Instruction {
    BinaryOp(Binop, Box<Operand>, Box<Operand>, Box<Operand>),
    Move(Box<Operand>, Box<Operand>),
    Load(Box<Operand>, Box<Address>),
    Store(Box<Address>, Box<Operand>),
    Condition(Cond, Box<Operand>, Box<Operand>),
    Die(Cond, Box<Operand>, Box<Operand>),
    Return(Box<Operand>),
    Call(temp::Temp, Box<Operand>, Vec<Box<Operand>>),
    Raw(String),

    /* pseudo-instructions that are just use for analysis/coloring/spilling */
    Phi(temp::Temp, ssa::PhiMap),
    MemPhi(Tag, ssa::PhiMap),
    Reload(temp::Temp, Tag),
    Spill(temp::Temp, Tag),
    Use(temp::Temp),              /* used when constraining non-commutative ops */
    PCopy(Vec<(temp::Temp, temp::Temp)>), /* parallel copy of temps */
    Arg(temp::Temp, uint),        /* nth argument is wired to this temp */
}

#[deriving(Clone)]
pub enum Operand {
    Immediate(i32, Size),
    Register(Register, Size),
    Temp(temp::Temp),
    LabelOp(Label)
}

#[deriving(Clone)]
pub enum Address {
    /*   base      offset         multplier reg    multiplier size */
    MOp(Box<Operand>, Option<uint>, Option<(Box<Operand>, Multiplier)>),
    Stack(uint),
    StackArg(uint),
}

#[deriving(Clone)]
pub enum Multiplier {
    One, Two, Four, Eight
}

#[deriving(Eq, PartialEq, Clone)]
pub enum Binop {
    Add, Sub, Mul, Div, Mod, Cmp(Cond), And, Or, Xor, Lsh, Rsh
}

#[deriving(Eq, PartialEq, Clone)]
pub enum Cond {
    Lt, Lte, Gt, Gte, Eq, Neq
}

#[deriving(Eq, PartialEq, Clone, Show)]
pub enum Register {
    EAX, EBX, ECX, EDX, EDI, ESI, ESP, EBP,
    R8D, R9D, R10D, R11D, R12D, R13D, R14D, R15D
}

pub enum Constraint { Caller, Idiv }

// These two structures are used to parameterize the reconstruction of SSA form
// after the spilling phase has happened. RegisterInfo looks as all temps which
// need to be in registers while StackInfo looks at stack spill slots.
pub struct RegisterInfo;
pub struct StackInfo;

impl Constraint {
    pub fn allows(self, r: Register) -> bool{
        match (self, r) {
            (Idiv, EAX) | (Idiv, EDX) => false,
            (Idiv, _) => true,
            (Caller, _) => arch::callee_reg(r),
        }
    }
}

impl Instruction {
    #[inline(always)]
    pub fn each_def(&self, f: |temp::Temp|) {
        match *self {
            BinaryOp(_, box Temp(t), _, _) |
            Move(box Temp(t), _) |
            Phi(t, _) |
            Load(box Temp(t), _) |
            Call(t, _, _) |
            Reload(t, _) |
            Arg(t, _)
                => { f(t) }

            PCopy(ref copies) => for &(def, _) in copies.iter() { f(def) },

            _ => ()
        }
    }

  #[inline(always)]
    pub fn each_use(&self, f: |temp::Temp|) {
        match *self {
            Condition(_, box Temp(t1), box Temp(t2)) |
            Die(_, box Temp(t1), box Temp(t2)) |
            BinaryOp(_, _, box Temp(t1), box Temp(t2))
                => { f(t1); f(t2) }

            Condition(_, box Temp(t), _) |
            Condition(_, _, box Temp(t)) |
            Die(_, box Temp(t), _) |
            Die(_, _, box Temp(t)) |
            BinaryOp(_, _, box Temp(t), _) |
            BinaryOp(_, _, _, box Temp(t)) |
            Move(_, box Temp(t)) |
            Spill(t, _) |
            Use(t) |
            Return(box Temp(t))
                => { f(t) }

            Store(ref addr, ref src) => {
                addr.each_temp(|x| f(x));
                src.each_temp(f);
            }
            Load(_, ref addr) => { addr.each_temp(f) }

            Call(_, ref fun, ref args) => {
                match *fun {
                    box Temp(t) => { f(t) }
                    _ => ()
                };
                for arg in args.iter() {
                    match *arg {
                        box Temp(t) => { f(t) }
                        _ => ()
                    }
                }
            }

            PCopy(ref copies) => for &(_, t) in copies.iter() { f(t) },

            _ => ()
        }
    }

    pub fn phi_info<'a>(&'a self) -> Option<(temp::Temp, &'a ssa::PhiMap)> {
        match *self {
            Phi(d, ref m) => Some((d, m)),
            _ => None
        }
    }

    pub fn is_phi(&self) -> bool { match *self { Phi(..) => true, _ => false } }
}

impl ssa::Statement<Instruction> for RegisterInfo {
    fn phi(&self, t: temp::Temp, map: ssa::PhiMap) -> Box<Instruction> {
        box Phi(t, map)
    }

    fn each_def(&self, i: &Instruction, f: |temp::Temp|) {
        i.each_def(f)
    }
    fn each_use(&self, i: &Instruction, f: |temp::Temp|) {
        i.each_use(f)
    }
    fn phi_info<'r>(&self, me: &'r Instruction)
                    -> Option<(temp::Temp, &'r ssa::PhiMap)>
    {
        me.phi_info()
    }
    fn phi_unwrap(&self, me: Box<Instruction>)
                  -> Result<(temp::Temp, ssa::PhiMap), Box<Instruction>> {
        match me {
            box Phi(d, m) => Ok((d, m)),
            i          => Err(i)
        }
    }

    fn map_temps(&self, i: Box<Instruction>, uses: |temp::Temp| -> temp::Temp,
                 defs: |temp::Temp| -> temp::Temp) -> Box<Instruction> {
        box match *i {
            BinaryOp(op, o1, o2, o3) => {
                let (o2, o3) = (o2.map_temps(|x| uses(x)), o3.map_temps(uses));
                BinaryOp(op, o1.map_temps(defs), o2, o3)
            }
            Move(dest, src) => {
                let src = src.map_temps(uses);
                Move(dest.map_temps(defs), src)
            }
            Load(dest, src) => {
                let src = src.map_temps(uses);
                Load(dest.map_temps(defs), src)
            }
            Store(dest, src) => Store(dest.map_temps(|x| uses(x)),
                                      src.map_temps(|x| uses(x))),
            Die(c, o1, o2) => Die(c, o1.map_temps(|x| uses(x)),
                                  o2.map_temps(|x| uses(x))),
            Condition(c, o1, o2) =>
                Condition(c, o1.map_temps(|x| uses(x)), o2.map_temps(|x| uses(x))),
            Spill(t, tag) => Spill(uses(t), tag),
            Reload(dest, tag) => Reload(defs(dest), tag),
            Phi(t, map) => Phi(defs(t), map),
            Call(dst, fun, args) => {
                let fun = fun.map_temps(|x| uses(x));
                let args = args.move_iter().map(|arg|
                                                arg.map_temps(|x| uses(x))
                                               ).collect();
                Call(defs(dst), fun, args)
            }
            Use(t) => Use(uses(t)),
            Return(t) => Return(t.map_temps(uses)),
            Arg(t, n) => Arg(defs(t), n),
            PCopy(copies) => {
                PCopy(copies.move_iter().map(|(dst, src)| {
                    let src = uses(src);
                    (defs(dst), src)
                }).collect())
            }
            s => s
        }
    }
}

impl ssa::Statement<Instruction> for StackInfo {
    fn phi(&self, t: temp::Temp, map: ssa::PhiMap) -> Box<Instruction> {
        box MemPhi(t, map)
    }

    fn each_def(&self, i: &Instruction, f: |temp::Temp|) {
        match *i {
            Spill(_, t) | MemPhi(t, _) => f(t),
            _ => ()
        }
    }
    fn each_use(&self, i: &Instruction, f: |temp::Temp|) {
        match *i {
            Reload(_, t) => f(t),
            _ => ()
        }
    }
    fn phi_info<'r>(&self, me: &'r Instruction)
                    -> Option<(temp::Temp, &'r ssa::PhiMap)>
    {
        match *me {
            MemPhi(t, ref m) => Some((t, m)),
            _ => None
        }
    }
    fn phi_unwrap(&self, me: Box<Instruction>)
        -> Result<(temp::Temp, ssa::PhiMap), Box<Instruction>> {
            match me {
                box MemPhi(d, m) => Ok((d, m)),
                i => Err(i)
            }
        }

    fn map_temps(&self, i: Box<Instruction>, uses: |temp::Temp| -> temp::Temp,
                 defs: |temp::Temp| -> temp::Temp) -> Box<Instruction> {
        box match *i {
            MemPhi(t, map) => MemPhi(defs(t), map),
            Spill(r, t) => Spill(r, defs(t)),
            Reload(r, t) => Reload(r, uses(t)),
            i => i,
        }
    }
}

impl fmt::Show for Instruction {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Raw(ref s) => write!(f, "{}", s),
            Arg(t, i) => write!(f, "{} = arg[{}]", t, i),
            Return(ref t) => write!(f, "ret # {}", t),
            Use(t) => write!(f, "use {}", t),
            Die(c, ref o1, ref o2) =>
                write!(f, "cmp {}, {}; j{} {}raise_segv",
                       o2, o1,
                       c.suffix(), label::prefix()),
            Condition(c, ref o1, ref o2) =>
                write!(f, "cmp {}, {} # {}", o2, o1, c.suffix()),
            Load(ref dst, ref addr) =>
                write!(f, "mov {}, {}", addr, dst),
            Store(ref addr, ref src) => match **src {
                Immediate(_, ir::Pointer) => write!(f, "movq {}, {}", src, addr),
                Immediate(_, ir::Int)     => write!(f, "movl {}, {}", src, addr),
                _                         => write!(f, "mov {}, {}", src, addr),
            },
            Move(ref o1, ref o2) =>
                if o1.size() != o2.size() && !o2.imm() {
                    write!(f, "movslq {}, {}", o2, o1)
                } else {
                    write!(f, "mov {}, {}", o2, o1)
                },
            BinaryOp(binop, ref dest, ref s1, ref s2) => match binop {
                /* multiplications can have third operand if it's an immediate */
                Mul if s2.imm() && !s1.imm() => {
                    write!(f, "imul {}, {}, {}", s2, s1, dest)
                }
                /* division/mod are both weird */
                Div | Mod => write!(f, "cltd; idiv {} # {} <- {} {} {}", s2, dest,
                                    s1, binop, s2),

                /* Shifting by immediates can only use lower 5 bits */
                Lsh | Rsh if s1.imm() =>
                    write!(f, "{} {}, {}", binop, s1.mask(0x1f), dest),
                Lsh | Rsh if s1.reg() =>
                    write!(f, "{} %cl, {}", binop, dest),

                Cmp(cond) => {
                    let dstsmall = match **dest {
                        Register(r, _) => r.byte().to_string(),
                        _ => dest.to_string(),
                    };
                    write!(f, "cmp {}, {}; set{} {}; movzbl {}, {}",
                           s2, s1, cond.suffix(), dstsmall, dstsmall, dest)
                }

                _ => write!(f, "{} {}, {} # {}", binop, s1, dest, s2),
            },
            Call(dst, ref e, ref args) =>
                write!(f, "call {} # {} <- ({:#})", e, dst, args),
            Phi(tmp, ref map) => {
                try!(write!(f, "# {} <- phi(", tmp));
                for (&id, &tmp) in map.iter() {
                    try!(write!(f, " [ {} - n{} ] ", tmp, id));
                }
                write!(f, ")")
            }
            MemPhi(tag, ref map) => {
                try!(write!(f, "# m{} <- phi(", tag));
                for (&id, &tag) in map.iter() {
                    try!(write!(f, " [ m{} - n{} ] ", tag, id));
                }
                write!(f, ")")
            }
            Spill(t, tag) => write!(f, "SPILL {} -> {}", t, tag),
            Reload(t, tag) => write!(f, "RELOAD {} <= {}", t, tag),
            PCopy(ref copies) => {
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
    pub fn imm(&self) -> bool { match *self { Immediate(..) => true, _ => false } }
    pub fn reg(&self) -> bool { match *self { Register(..) => true, _ => false } }

    fn mask(&self, mask: i32) -> Box<Operand> {
        match *self {
            Immediate(n, s) => box Immediate(n & mask, s),
            _ => fail!("can't mask non-immediate")
        }
    }

    pub fn size(&self) -> Size {
        match *self {
            Immediate(_, s) | Register(_, s) => s,
            LabelOp(..) => ir::Pointer,
            Temp(..) => ir::Int
        }
    }

    pub fn each_temp(&self, f: |temp::Temp|) {
        match *self {
            Temp(t) => { f(t) }
            _ => ()
        }
    }

    pub fn map_temps(self, f: |temp::Temp| -> temp::Temp) -> Box<Operand> {
        match self {
            Temp(t) => box Temp(f(t)),
            o => box o
        }
    }
}

impl fmt::Show for Operand {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Immediate(c, _) => write!(f, "${}", c as int),
            Register(reg, s) => write!(f, "{}", reg.size(s)),
            Temp(t) => write!(f, "{}", t),
            LabelOp(ref l) => write!(f, "{}", l),
        }
    }
}

impl PartialEq for Operand {
    fn eq(&self, other: &Operand) -> bool {
        match (self, other) {
            (&Register(a, _), &Register(b, _)) => a == b,
            (&Temp(a), &Temp(b)) => a == b,
            _ => false
        }
    }
}

impl Address {
    fn map_temps(self, f: |temp::Temp| -> temp::Temp) -> Box<Address> {
        match self {
            MOp(t, disp, off) =>
                box MOp(t.map_temps(|x| f(x)), disp,
                        off.map(|(x, m)| (x.map_temps(|x| f(x)), m))),
            a => box a
        }
    }

    fn each_temp(&self, f: |temp::Temp|) {
        match *self {
            MOp(ref o, _, ref off) => {
                o.each_temp(|x| f(x));
                for &(ref x, _) in off.iter() {
                    x.each_temp(|x| f(x))
                }
            }
            Stack(..) | StackArg(..) => ()
        }
    }
}

impl fmt::Show for Address {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            MOp(ref o, disp, ref off) => {
                for &d in disp.iter() {
                    try!(write!(f, "{}", d));
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
            Stack(i) => write!(f, "{}(%rsp)", i),
            StackArg(i) => write!(f, "arg[{}]", i),
        }
    }
}

impl Cond {
    pub fn flip(&self) -> Cond {
        match *self {
            Lt  => Gt,
            Lte => Gte,
            Gt  => Lt,
            Gte => Lte,
            Eq  => Eq,
            Neq => Neq
        }
    }
    pub fn negate(&self) -> Cond {
        match *self {
            Lt  => Gte,
            Lte => Gt,
            Gt  => Lte,
            Gte => Lt,
            Eq  => Neq,
            Neq => Eq
        }
    }
    pub fn suffix(&self) -> &'static str {
        match *self {
            Lt  => "l",
            Lte => "le",
            Gt  => "g",
            Gte => "ge",
            Eq  => "e",
            Neq => "ne"
        }
    }
}

impl Binop {
    pub fn commutative(&self) -> bool {
        match *self { Add | Mul | And | Or | Xor => true, _ => false }
    }

    pub fn constrained(&self) -> bool {
        match *self { Div | Mod | Lsh | Rsh => true, _ => false }
    }
}

impl fmt::Show for Binop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Add => "add".fmt(f),
            Sub => "sub".fmt(f),
            Mul => "imul".fmt(f),
            Div => "div".fmt(f),
            Mod => "mod".fmt(f),
            And => "and".fmt(f),
            Or  => "or".fmt(f),
            Xor => "xor".fmt(f),
            Lsh => "sal".fmt(f),
            Rsh => "sar".fmt(f),
            Cmp(_) => "cmp".fmt(f),
        }
    }
}

impl Register {
    pub fn byte(&self) -> &'static str {
        match *self {
            EAX  => "%al",
            EBX  => "%bl",
            ECX  => "%cl",
            EDX  => "%dl",
            ESI  => "%sil",
            EDI  => "%dil",
            ESP  => "%spl",
            EBP  => "%bpl",
            R8D  => "%r8b",
            R9D  => "%r9b",
            R10D => "%r10b",
            R11D => "%r11b",
            R12D => "%r12b",
            R13D => "%r13b",
            R14D => "%r14b",
            R15D => "%r15b",
        }
    }

    pub fn size(&self, t: Size) -> &'static str {
        match (*self, t) {
            (EAX, ir::Int)      => "%eax",
            (EAX, ir::Pointer)  => "%rax",
            (EBX, ir::Int)      => "%ebx",
            (EBX, ir::Pointer)  => "%rbx",
            (ECX, ir::Int)      => "%ecx",
            (ECX, ir::Pointer)  => "%rcx",
            (EDX, ir::Int)      => "%edx",
            (EDX, ir::Pointer)  => "%rdx",
            (EDI, ir::Int)      => "%edi",
            (EDI, ir::Pointer)  => "%rdi",
            (ESI, ir::Int)      => "%esi",
            (ESI, ir::Pointer)  => "%rsi",
            (ESP, ir::Int)      => "%esp",
            (ESP, ir::Pointer)  => "%rsp",
            (EBP, ir::Int)      => "%ebp",
            (EBP, ir::Pointer)  => "%rbp",
            (R8D, ir::Int)      => "%r8d",
            (R8D, ir::Pointer)  => "%r8",
            (R9D, ir::Int)      => "%r9d",
            (R9D, ir::Pointer)  => "%r9",
            (R10D, ir::Int)     => "%r10d",
            (R10D, ir::Pointer) => "%r10",
            (R11D, ir::Int)     => "%r11d",
            (R11D, ir::Pointer) => "%r11",
            (R12D, ir::Int)     => "%r12d",
            (R12D, ir::Pointer) => "%r12",
            (R13D, ir::Int)     => "%r13d",
            (R13D, ir::Pointer) => "%r13",
            (R14D, ir::Int)     => "%r14d",
            (R14D, ir::Pointer) => "%r14",
            (R15D, ir::Int)     => "%r15d",
            (R15D, ir::Pointer) => "%r15",
        }
    }
}

impl Multiplier {
    pub fn valid(i: i32) -> bool {
        i == 1 || i == 2 || i == 4 || i == 8
    }

    pub fn from_int(i: i32) -> Multiplier {
        match i {
            1 => One, 2 => Two, 4 => Four, 8 => Eight,
            _ => fail!("can't make multiplier for {}", i)
        }
    }
}

impl fmt::Show for Multiplier {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            One => "1".fmt(f),
            Two => "2".fmt(f),
            Four => "4".fmt(f),
            Eight => "8".fmt(f),
        }
    }
}

impl Graphable for Program {
    fn dot(&self, out: &mut io::Writer) -> io::IoResult<()> {
        try!(out.write_str("digraph {\n"));
        for f in self.funs.iter() {
            try!(f.cfg.dot(out,
                           |id| format!("{}_n{}", f.name, id as int),
                           |id, ins|
                           "label=\"".to_string() +
                                ins.iter().map(|s| s.to_string())
                                   .collect::<Vec<String>>().connect("\\n").as_slice() +
                                format!("\n[node={}]\" shape=box", id as int)
                                    .as_slice(),
                           |&edge| format!("label={}", edge)
                          ));
        }
        out.write_str("\n}")
    }
}

impl Program {
    pub fn output(&self, out: &mut io::Writer) -> io::IoResult<()> {
        for f in self.funs.iter() {
            try!(f.output(out));
        }
        Ok(())
    }
}

impl Function {
    /**
     * Traverses the cfg and outputs a stream of instructions which can be
     * assembled to the actual program
     */
    fn output(&self, out: &mut io::Writer) -> io::IoResult<()> {
        let base = label::Internal(self.name.clone());
        /* entry label */
        try!(write!(out, ".globl {}\n", base));
        try!(write!(out, "{}:\n", base));
        let lbl = |n: graph::NodeId| format!("{}_bb_{}", base, n as int);

        /* skipped is a stack of nodes that we have yet to visit */
        let mut skipped = vec![self.root];
        let mut visited = HashSet::new();

        loop {
            let block = match skipped.pop() { Some(a) => a, None => break };
            if visited.contains(&block) { continue }

            /* Each block has its own label (so it can be jumped to) */
            visited.insert(block);
            try!(write!(out, "L{}:\n", lbl(block)));

            /* output the actual block */
            let instructions = self.cfg.node(block);
            for ins in instructions.iter() {
                try!(write!(out, "  {}\n", ins));
            }

            /* Collect information about the edges */
            let mut always = None;
            let mut tedge = None;
            let mut fedge = None;
            for (id, &typ) in self.cfg.succ_edges(block) {
                debug!("out of {} ({} - {})", block, id, typ);
                match typ {
                    ir::Always | ir::Branch | ir::LoopOut => {
                        assert!(tedge.is_none() && fedge.is_none() && always.is_none());
                        always = Some((typ, id));
                    }
                    ir::True | ir::TBranch => {
                        assert!(tedge.is_none() && always.is_none());
                        tedge = Some((typ, id));
                    }
                    ir::False | ir::FBranch | ir::FLoopOut => {
                        assert!(fedge.is_none() && always.is_none());
                        fedge = Some((typ, id));
                    }
                }
            }

            /* Emit jumps and alter our stack of nodes to visit */
            match always {
                /* Always branches to unvisited blocks can just fall through */
                Some((ir::Always, id)) if !visited.contains(&id) =>
                { skipped.push(id); }
                /* Otherwise always branches or edges to visited blocks are jumps */
                Some((_, id)) => {
                    skipped.unshift(id);
                    try!(write!(out, "  jmp L{}\n", lbl(id)));
                }

                None => {
                    match (tedge, fedge) {
                        /* If everything is none, then we've reached a termination */
                        (None, None) => (),

                        (Some((tedge, tid)), Some((fedge, fid))) => {
                            /* On a conditional branch, the last ins must be Condition */
                            let cond = match instructions.last() {
                                Some(&box Condition(c, _, _)) => c,
                                _ => fail!("Need a condition with true/false edges")
                            };

                            match (tedge, fedge) {
                                /* If we fall through to the true block, then negate the
                                   condition to jump to the false block and push traversal */
                                (ir::True, _) => {
                                    skipped.push(fid);
                                    skipped.push(tid);
                                    try!(write!(out, "  j{} L{}\n",
                                                cond.negate().suffix(),
                                                lbl(fid)));
                                }

                                /* Otherwise we can use the condition as is and we update the
                                   nodes to visit */
                                (_, ir::False) => {
                                    skipped.push(tid);
                                    skipped.push(fid);
                                    try!(write!(out, "  j{} L{}\n",
                                                cond.suffix(),
                                                lbl(tid)));
                                }

                                _ => fail!("invalidly specified edges")
                            }
                        }
                        _ => fail!("invalid edges")
                    }
                }
            }

            /* and finally, the basic block is done with its emission! */
        }
        Ok(())
    }
}
