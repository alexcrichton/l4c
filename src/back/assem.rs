use std::cmp;
use std::io;
use collections::{HashMap, HashSet};

use middle::{label, ir};
pub use middle::ssa;
use middle::temp::Temp;
use back::arch;
use utils::{graph, Graphable, PrettyPrint};

pub type Label = label::Label;
pub type Edge = ir::Edge;
pub type Size = ir::Type;
pub type Tag = uint;
pub type CFG = ssa::CFG<Instruction>;

pub struct Program {
  funs: ~[Function]
}

pub struct Function {
  name: ~str,
  root: graph::NodeId,
  cfg: CFG,
  sizes: HashMap<Temp, Size>,
  temps: uint,
  ssa: ssa::Analysis,

  loops: HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
}

pub enum Instruction {
  BinaryOp(Binop, ~Operand, ~Operand, ~Operand),
  Move(~Operand, ~Operand),
  Load(~Operand, ~Address),
  Store(~Address, ~Operand),
  Condition(Cond, ~Operand, ~Operand),
  Die(Cond, ~Operand, ~Operand),
  Return(~Operand),
  Call(Temp, ~Operand, ~[~Operand]),
  Raw(~str),

  /* pseudo-instructions that are just use for analysis/coloring/spilling */
  Phi(Temp, ssa::PhiMap),
  MemPhi(Tag, ssa::PhiMap),
  Reload(Temp, Tag),
  Spill(Temp, Tag),
  Use(Temp),              /* used when constraining non-commutative ops */
  PCopy(~[(Temp, Temp)]), /* parallel copy of temps */
  Arg(Temp, uint),        /* nth argument is wired to this temp */
}

#[deriving(Clone)]
pub enum Operand {
  Immediate(i32, Size),
  Register(Register, Size),
  Temp(Temp),
  LabelOp(Label)
}

#[deriving(Clone)]
pub enum Address {
  /*   base      offset         multplier reg    multiplier size */
  MOp(~Operand, Option<uint>, Option<(~Operand, Multiplier)>),
  Stack(uint),
  StackArg(uint),
}

#[deriving(Clone)]
pub enum Multiplier {
  One, Two, Four, Eight
}

#[deriving(Eq, Clone)]
pub enum Binop {
  Add, Sub, Mul, Div, Mod, Cmp(Cond), And, Or, Xor, Lsh, Rsh
}

#[deriving(Eq, Clone)]
pub enum Cond {
  Lt, Lte, Gt, Gte, Eq, Neq
}

#[deriving(Eq, Clone)]
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
  pub fn each_def(&self, f: |Temp|) {
    match *self {
      BinaryOp(_, ~Temp(t), _, _) |
      Move(~Temp(t), _) |
      Phi(t, _) |
      Load(~Temp(t), _) |
      Call(t, _, _) |
      Reload(t, _) |
      Arg(t, _)
        => { f(t) }

      PCopy(ref copies) => for &(def, _) in copies.iter() { f(def) },

      _ => ()
    }
  }

  #[inline(always)]
  pub fn each_use(&self, f: |Temp|) {
    match *self {
      Condition(_, ~Temp(t1), ~Temp(t2)) |
      Die(_, ~Temp(t1), ~Temp(t2)) |
      BinaryOp(_, _, ~Temp(t1), ~Temp(t2))
        => { f(t1); f(t2) }

      Condition(_, ~Temp(t), _) |
      Condition(_, _, ~Temp(t)) |
      Die(_, ~Temp(t), _) |
      Die(_, _, ~Temp(t)) |
      BinaryOp(_, _, ~Temp(t), _) |
      BinaryOp(_, _, _, ~Temp(t)) |
      Move(_, ~Temp(t)) |
      Spill(t, _) |
      Use(t) |
      Return(~Temp(t))
        => { f(t) }

      Store(ref addr, ref src) => {
        addr.each_temp(|x| f(x));
        src.each_temp(f);
      }
      Load(_, ref addr) => { addr.each_temp(f) }

      Call(_, ref fun, ref args) => {
        match *fun {
          ~Temp(t) => { f(t) }
          _ => ()
        };
        for arg in args.iter() {
          match *arg {
            ~Temp(t) => { f(t) }
            _ => ()
          }
        }
      }

      PCopy(ref copies) => for &(_, t) in copies.iter() { f(t) },

      _ => ()
    }
  }

  pub fn phi_info<'a>(&'a self) -> Option<(Temp, &'a ssa::PhiMap)> {
    match *self {
      Phi(d, ref m) => Some((d, m)),
      _ => None
    }
  }

  pub fn is_phi(&self) -> bool { match *self { Phi(..) => true, _ => false } }
}

impl ssa::Statement<Instruction> for RegisterInfo {
  fn phi(&self, t: Temp, map: ssa::PhiMap) -> ~Instruction { ~Phi(t, map) }

  fn each_def(&self, i: &Instruction, f: |Temp|) {
    i.each_def(f)
  }
  fn each_use(&self, i: &Instruction, f: |Temp|) {
    i.each_use(f)
  }
  fn phi_info<'r>(&self, me: &'r Instruction)
      -> Option<(Temp, &'r ssa::PhiMap)>
  {
    me.phi_info()
  }
  fn phi_unwrap(&self, me: ~Instruction)
      -> Result<(Temp, ssa::PhiMap), ~Instruction> {
    match me {
      ~Phi(d, m) => Ok((d, m)),
      i          => Err(i)
    }
  }

  fn map_temps(&self, i: ~Instruction, uses: |Temp| -> Temp,
               defs: |Temp| -> Temp) -> ~Instruction {
    match i {
      ~BinaryOp(op, o1, o2, o3) => {
        let (o2, o3) = (o2.map_temps(|x| uses(x)), o3.map_temps(uses));
        ~BinaryOp(op, o1.map_temps(defs), o2, o3)
      }
      ~Move(dest, src) => {
        let src = src.map_temps(uses);
        ~Move(dest.map_temps(defs), src)
      }
      ~Load(dest, src) => {
        let src = src.map_temps(uses);
        ~Load(dest.map_temps(defs), src)
      }
      ~Store(dest, src) => ~Store(dest.map_temps(|x| uses(x)),
                                  src.map_temps(|x| uses(x))),
      ~Die(c, o1, o2) => ~Die(c, o1.map_temps(|x| uses(x)),
                              o2.map_temps(|x| uses(x))),
      ~Condition(c, o1, o2) =>
        ~Condition(c, o1.map_temps(|x| uses(x)), o2.map_temps(|x| uses(x))),
      ~Spill(t, tag) => ~Spill(uses(t), tag),
      ~Reload(dest, tag) => ~Reload(defs(dest), tag),
      ~Phi(t, map) => ~Phi(defs(t), map),
      ~Call(dst, fun, args) => {
        let fun = fun.map_temps(|x| uses(x));
        let args = args.move_iter().map(|arg|
          arg.map_temps(|x| uses(x))
        ).collect();
        ~Call(defs(dst), fun, args)
      }
      ~Use(t) => ~Use(uses(t)),
      ~Return(t) => ~Return(t.map_temps(uses)),
      ~Arg(t, n) => ~Arg(defs(t), n),
      ~PCopy(copies) => {
        ~PCopy(copies.move_iter().map(|(dst, src)| {
          let src = uses(src);
          (defs(dst), src)
        }).collect())
      }
      s => s
    }
  }
}

impl ssa::Statement<Instruction> for StackInfo {
  fn phi(&self, t: Temp, map: ssa::PhiMap) -> ~Instruction { ~MemPhi(t, map) }

  fn each_def(&self, i: &Instruction, f: |Temp|) {
    match *i {
      Spill(_, t) | MemPhi(t, _) => f(t),
      _ => ()
    }
  }
  fn each_use(&self, i: &Instruction, f: |Temp|) {
    match *i {
      Reload(_, t) => f(t),
      _ => ()
    }
  }
  fn phi_info<'r>(&self, me: &'r Instruction) -> Option<(Temp, &'r ssa::PhiMap)>
  {
    match *me {
      MemPhi(t, ref m) => Some((t, m)), _ => None
    }
  }
  fn phi_unwrap(&self, me: ~Instruction)
      -> Result<(Temp, ssa::PhiMap), ~Instruction> {
    match me {
      ~MemPhi(d, m) => Ok((d, m)),
      i             => Err(i)
    }
  }

  fn map_temps(&self, i: ~Instruction, uses: |Temp| -> Temp,
               defs: |Temp| -> Temp) -> ~Instruction {
    match i {
      ~MemPhi(t, map) => ~MemPhi(defs(t), map),
      ~Spill(r, t) => ~Spill(r, defs(t)),
      ~Reload(r, t) => ~Reload(r, uses(t)),
      i => i,
    }
  }
}

impl PrettyPrint for Instruction {
  fn pp(&self) -> ~str {
    match *self {
      Raw(ref s) => s.clone(),
      Arg(t, i) => format!("{} = arg[{:?}]", t.pp(), i),
      Return(ref t) => format!("ret // {}", t.pp()),
      Use(t) => format!("use {}", t.pp()),
      Die(c, ref o1, ref o2) =>
        format!("cmp {}, {}; j{} {}raise_segv", o2.pp(), o1.pp(),
             c.suffix(), label::prefix()),
      Condition(c, ref o1, ref o2) =>
        format!("cmp {}, {} // {}", o2.pp(), o1.pp(), c.suffix()),
      Load(ref dst, ref addr) =>
        format!("mov {}, {}", addr.pp(), dst.pp()),
      Store(ref addr, ref src) => match *src {
        ~Immediate(_, ir::Pointer) => format!("movq {}, {}", src.pp(), addr.pp()),
        ~Immediate(_, ir::Int)     => format!("movl {}, {}", src.pp(), addr.pp()),
        _                          => format!("mov {}, {}", src.pp(), addr.pp()),
      },
      Move(ref o1, ref o2) =>
        if o1.size() != o2.size() && !o2.imm() {
          ~"movslq " + o2.pp() + ", " + o1.pp()
        } else {
          ~"mov " + o2.pp() + ", " + o1.pp()
        },
      BinaryOp(binop, ref dest, ref s1, ref s2) => match binop {
        /* multiplications can have third operand if it's an immediate */
        Mul if s2.imm() && !s1.imm() => {
          format!("imul {}, {}, {}", s2.pp(), s1.pp(), dest.pp())
        }
        /* division/mod are both weird */
        Div | Mod => format!("cltd; idiv {} // {} <- {} {} {}", s2.pp(), dest.pp(),
                          s1.pp(), binop.pp(), s2.pp()),

        /* Shifting by immediates can only use lower 5 bits */
        Lsh | Rsh if s1.imm() =>
          format!("{} {}, {}", binop.pp(), s1.mask(0x1f).pp(), dest.pp()),
        Lsh | Rsh if s1.reg() =>
          format!("{} %cl, {}", binop.pp(), dest.pp()),

        Cmp(cond) => {
          let dstsmall = match *dest {
            ~Register(r, _) => r.byte().to_owned(), _ => dest.pp()
          };
          format!("cmp {}, {}; set{} {}; movzbl {}, {}",
               s2.pp(), s1.pp(), cond.suffix(), dstsmall, dstsmall, dest.pp())
        }

        _ => format!("{} {}, {} // {}",
                  binop.pp(), s1.pp(), dest.pp(), s2.pp()),
      },
      Call(dst, ref e, ref args) =>
        format!("call {} // {} <- ({})", e.pp(), dst.pp(),
             ~"(" + args.iter().map(|a| a.pp()).connect(", ") + ")"),
      Phi(tmp, ref map) => {
        let mut s = ~"//" + tmp.pp() + " <- phi(";
        for (&id, &tmp) in map.iter() {
          s.push_str(format!("[ {} - n{:?} ] ", tmp.pp(), id));
        }
        s + ")"
      }
      MemPhi(tag, ref map) => {
        let mut s = format!("//m{:?} <- mphi(", tag);
        for (&id, &tag) in map.iter() {
          s.push_str(format!("[ m{:?} - n{:?} ] ", tag, id));
        }
        s + ")"
      }
      Spill(t, tag) => format!("SPILL {} -> {:?}", t.pp(), tag),
      Reload(t, tag) => format!("RELOAD {} <= {:?}", t.pp(), tag),
      PCopy(ref copies) => {
        let mut s = ~"{";
        for &(k, v) in copies.iter() {
          s.push_str(format!("({:?} <= {:?}) ", k, v));
        }
        s + "}"
      }
    }
  }
}

impl Operand {
  pub fn imm(&self) -> bool { match *self { Immediate(..) => true, _ => false } }
  pub fn reg(&self) -> bool { match *self { Register(..) => true, _ => false } }

  fn mask(&self, mask: i32) -> ~Operand {
    match *self {
      Immediate(n, s) => ~Immediate(n & mask, s),
      _ => fail!(~"can't mask non-immediate")
    }
  }

  pub fn size(&self) -> Size {
    match *self {
      Immediate(_, s) | Register(_, s) => s,
      LabelOp(..) => ir::Pointer,
      Temp(..) => ir::Int
    }
  }

  pub fn each_temp(&self, f: |Temp|) {
    match *self {
      Temp(t) => { f(t) }
      _ => ()
    }
  }

  pub fn map_temps(~self, f: |Temp| -> Temp) -> ~Operand {
    match self {
      ~Temp(t) => ~Temp(f(t)),
      o        => o
    }
  }
}

impl PrettyPrint for Operand {
  fn pp(&self) -> ~str {
    match *self {
      Immediate(c, _) => format!("${}", c as int),
      Register(reg, s) => reg.size(s).to_owned(),
      Temp(t) => t.pp(),
      LabelOp(ref l) => l.pp()
    }
  }
}

impl cmp::Eq for Operand {
  fn eq(&self, other: &Operand) -> bool {
    match (self, other) {
      (&Register(a, _), &Register(b, _)) => a == b,
      (&Temp(a), &Temp(b)) => a == b,
      _ => false
    }
  }

  fn ne(&self, other: &Operand) -> bool { !self.eq(other) }
}

impl Address {
  fn map_temps(~self, f: |Temp| -> Temp) -> ~Address {
    match self {
      ~MOp(t, disp, off) =>
        ~MOp(t.map_temps(|x| f(x)), disp,
             off.map(|(x, m)| (x.map_temps(|x| f(x)), m))),
      a => a
    }
  }

  fn each_temp(&self, f: |Temp|) {
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

impl PrettyPrint for Address {
  fn pp(&self) -> ~str {
    match *self {
      MOp(ref o, disp, ref off) => {
        let mut s = ~"";
        for &d in disp.iter() { s.push_str(format!("{}", d)); }
        s.push_str("(");
        s.push_str(o.pp());
        match *off {
          None => (),
          Some((ref off, mult)) => {
            s.push_str(format!(", {}, {}", off.pp(), mult.pp()));
          }
        }
        s + ")"
      }
      Stack(i) => format!("{}(%rsp)", i),
      StackArg(i) => format!("arg[{:?}]", i),
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

impl PrettyPrint for Binop {
  fn pp(&self) -> ~str {
    match *self {
      Add => ~"add",
      Sub => ~"sub",
      Mul => ~"imul",
      Div => ~"div",
      Mod => ~"mod",
      And => ~"and",
      Or  => ~"or",
      Xor => ~"xor",
      Lsh => ~"sal",
      Rsh => ~"sar",
      Cmp(_) => ~"cmp",
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
      _ => fail!(format!("can't make multiplier for {:?}", i))
    }
  }
}

impl PrettyPrint for Multiplier {
  fn pp(&self) -> ~str {
    match *self {
      One => ~"1", Two => ~"2", Four => ~"4", Eight => ~"8"
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
          ~"label=\"" + ins.map(|s| s.pp()).connect("\\n") +
          format!("\n[node={}]\" shape=box", id as int),
        |&edge| format!("label={:?}", edge)
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
    let base = label::Internal(self.name.clone()).pp();
    /* entry label */
    try!(out.write_str(~".globl " + base + "\n"));
    try!(out.write_str(base + ":\n"));
    let lbl = |n: graph::NodeId| format!("{}_bb_{}", base, n as int);

    /* skipped is a stack of nodes that we have yet to visit */
    let mut skipped = ~[self.root];
    let mut visited = HashSet::new();

    loop {
      let block = match skipped.pop() { Some(a) => a, None => break };
      if visited.contains(&block) { continue }

      /* Each block has its own label (so it can be jumped to) */
      visited.insert(block);
      try!(out.write_str(~"L" + lbl(block) + ":\n"));

      /* output the actual block */
      let instructions = self.cfg.node(block);
      for ins in instructions.iter() {
        try!(out.write_str("  "));
        try!(out.write_str(ins.pp()));
        try!(out.write_char('\n'));
      }

      /* Collect information about the edges */
      let mut always = None;
      let mut tedge = None;
      let mut fedge = None;
      for (id, &typ) in self.cfg.succ_edges(block) {
        debug!("out of {:?} ({:?} - {:?})", block, id, typ);
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
          try!(out.write_str(format!("  jmp L{}\n", lbl(id))));
        }

        None => {
          match (tedge, fedge) {
            /* If everything is none, then we've reached a termination */
            (None, None) => (),

            (Some((tedge, tid)), Some((fedge, fid))) => {
              /* On a conditional branch, the last ins must be Condition */
              let cond = match instructions.last() {
                Some(&~Condition(c, _, _)) => c,
                _ => fail!(~"Need a condition with true/false edges")
              };

              match (tedge, fedge) {
                /* If we fall through to the true block, then negate the
                   condition to jump to the false block and push traversal */
                (ir::True, _) => {
                  skipped.push(fid);
                  skipped.push(tid);
                  try!(out.write_str(format!("  j{} L{}\n",
                                               cond.negate().suffix(),
                                               lbl(fid))));
                }

                /* Otherwise we can use the condition as is and we update the
                   nodes to visit */
                (_, ir::False) => {
                  skipped.push(tid);
                  skipped.push(fid);
                  try!(out.write_str(format!("  j{} L{}\n", cond.suffix(),
                                               lbl(tid))));
                }

                _ => fail!(~"invalidly specified edges")
              }
            }
            _ => fail!(~"invalid edges")
          }
        }
      }

      /* and finally, the basic block is done with its emission! */
    }
    Ok(())
  }
}
