use std::cmp;
use std::io;
use std::io::WriterUtil;
use std::hashmap::{HashMap, HashSet};

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
  fn allows(self, r: Register) -> bool{
    match (self, r) {
      (Idiv, EAX) | (Idiv, EDX) => false,
      (Idiv, _) => true,
      (Caller, _) => {
        for arch::each_caller |reg| {
          if reg == r { return false; }
        }
        return true;
      }
    }
  }
}

impl Instruction {
  #[inline(always)]
  fn each_def(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      BinaryOp(_, ~Temp(t), _, _) |
      Move(~Temp(t), _) |
      Phi(t, _) |
      Load(~Temp(t), _) |
      Call(t, _, _) |
      Reload(t, _) |
      Arg(t, _)
        => { f(t) }

      PCopy(ref copies) => copies.iter().advance(|&(def, _)| f(def)),

      _ => true
    }
  }

  #[inline(always)]
  fn each_use(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      Condition(_, ~Temp(t1), ~Temp(t2)) |
      Die(_, ~Temp(t1), ~Temp(t2)) |
      BinaryOp(_, _, ~Temp(t1), ~Temp(t2))
        => { f(t1) && f(t2) }

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
        addr.each_temp(|x| f(x)) && src.each_temp(f)
      }
      Load(_, ref addr) => { addr.each_temp(f) }

      Call(_, ref fun, ref args) => {
        let cont = match *fun {
          ~Temp(t) => { f(t) }
          _ => true
        };
        cont && args.iter().advance(|arg| {
          match *arg {
            ~Temp(t) => { f(t) }
            _ => true
          }
        })
      }

      PCopy(ref copies) => copies.iter().advance(|&(_, t)| f(t)),

      _ => true
    }
  }
  fn phi_info<'a>(&'a self) -> Option<(Temp, &'a ssa::PhiMap)> {
    match *self {
      Phi(d, ref m) => Some((d, m)),
      _ => None
    }
  }

  fn is_phi(&self) -> bool { match *self { Phi(*) => true, _ => false } }
}

impl ssa::Statement<Instruction> for RegisterInfo {
  fn phi(&self, t: Temp, map: ssa::PhiMap) -> ~Instruction { ~Phi(t, map) }

  fn each_def(&self, i: &Instruction, f: &fn(Temp) -> bool) -> bool {
    i.each_def(f)
  }
  fn each_use(&self, i: &Instruction, f: &fn(Temp) -> bool) -> bool {
    i.each_use(f)
  }
  fn phi_info<'r>(&self, me: &'r Instruction)
      -> Option<(Temp, &'r ssa::PhiMap)>
  {
    me.phi_info()
  }
  fn phi_unwrap(&self, me: ~Instruction)
      -> Either<~Instruction, (Temp, ssa::PhiMap)> {
    match me {
      ~Phi(d, m) => Right((d, m)),
      i          => Left(i)
    }
  }

  fn map_temps(&self, i: ~Instruction, uses: &fn(Temp) -> Temp,
               defs: &fn(Temp) -> Temp) -> ~Instruction {
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
        let args = args.consume_iter().transform(|arg|
          arg.map_temps(|x| uses(x))
        ).collect();
        ~Call(defs(dst), fun, args)
      }
      ~Use(t) => ~Use(uses(t)),
      ~Return(t) => ~Return(t.map_temps(uses)),
      ~Arg(t, n) => ~Arg(defs(t), n),
      ~PCopy(copies) => {
        ~PCopy(copies.consume_iter().transform(|(dst, src)| {
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

  fn each_def(&self, i: &Instruction, f: &fn(Temp) -> bool) -> bool {
    match *i {
      Spill(_, t) | MemPhi(t, _) => f(t),
      _ => true
    }
  }
  fn each_use(&self, i: &Instruction, f: &fn(Temp) -> bool) -> bool {
    match *i {
      Reload(_, t) => f(t),
      _ => true
    }
  }
  fn phi_info<'r>(&self, me: &'r Instruction) -> Option<(Temp, &'r ssa::PhiMap)>
  {
    match *me {
      MemPhi(t, ref m) => Some((t, m)), _ => None
    }
  }
  fn phi_unwrap(&self, me: ~Instruction)
      -> Either<~Instruction, (Temp, ssa::PhiMap)> {
    match me {
      ~MemPhi(d, m) => Right((d, m)),
      i             => Left(i)
    }
  }

  fn map_temps(&self, i: ~Instruction, uses: &fn(Temp) -> Temp,
               defs: &fn(Temp) -> Temp) -> ~Instruction {
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
      Arg(t, i) => fmt!("%s = arg[%?]", t.pp(), i),
      Return(ref t) => fmt!("ret // %s", t.pp()),
      Use(t) => fmt!("use %s", t.pp()),
      Die(c, ref o1, ref o2) =>
        fmt!("cmp %s, %s; j%s %sraise_segv", o2.pp(), o1.pp(),
             c.suffix(), label::prefix()),
      Condition(c, ref o1, ref o2) =>
        fmt!("cmp %s, %s // %s", o2.pp(), o1.pp(), c.suffix()),
      Load(ref dst, ref addr) =>
        fmt!("mov %s, %s", addr.pp(), dst.pp()),
      Store(ref addr, ref src) => match *src {
        ~Immediate(_, ir::Pointer) => fmt!("movq %s, %s", src.pp(), addr.pp()),
        ~Immediate(_, ir::Int)     => fmt!("movl %s, %s", src.pp(), addr.pp()),
        _                          => fmt!("mov %s, %s", src.pp(), addr.pp()),
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
          fmt!("imul %s, %s, %s", s2.pp(), s1.pp(), dest.pp())
        }
        /* division/mod are both weird */
        Div | Mod => fmt!("cltd; idiv %s // %s <- %s %s %s", s2.pp(), dest.pp(),
                          s1.pp(), binop.pp(), s2.pp()),

        /* Shifting by immediates can only use lower 5 bits */
        Lsh | Rsh if s1.imm() =>
          fmt!("%s %s, %s", binop.pp(), s1.mask(0x1f).pp(), dest.pp()),
        Lsh | Rsh if s1.reg() =>
          fmt!("%s %%cl, %s", binop.pp(), dest.pp()),

        Cmp(cond) => {
          let dstsmall = match *dest {
            ~Register(r, _) => r.byte(), _ => dest.pp()
          };
          fmt!("cmp %s, %s; set%s %s; movzbl %s, %s",
               s2.pp(), s1.pp(), cond.suffix(), dstsmall, dstsmall, dest.pp())
        }

        _ => fmt!("%s %s, %s // %s"
                  binop.pp(), s1.pp(), dest.pp(), s2.pp()),
      },
      Call(dst, ref e, ref args) =>
        fmt!("call %s // %s <- %s", e.pp(), dst.pp(),
             ~"(" + args.map(|a| a.pp()).connect(", ") + ")"),
      Phi(tmp, ref map) => {
        let mut s = ~"//" + tmp.pp() + " <- phi(";
        for map.iter().advance |(&id, &tmp)| {
          s.push_str(fmt!("[ %s - n%? ] ", tmp.pp(), id));
        }
        s + ")"
      }
      MemPhi(tag, ref map) => {
        let mut s = fmt!("//m%? <- mphi(", tag);
        for map.iter().advance |(&id, &tag)| {
          s.push_str(fmt!("[ m%? - n%? ] ", tag, id));
        }
        s + ")"
      }
      Spill(t, tag) => fmt!("SPILL %s -> %?", t.pp(), tag),
      Reload(t, tag) => fmt!("RELOAD %s <= %?", t.pp(), tag),
      PCopy(ref copies) => {
        let mut s = ~"{";
        for copies.iter().advance |&(k, v)| {
          s.push_str(fmt!("(%? <= %?) ", k, v));
        }
        s + "}"
      }
    }
  }
}

impl Operand {
  fn imm(&self) -> bool { match *self { Immediate(*) => true, _ => false } }
  fn reg(&self) -> bool { match *self { Register(*) => true, _ => false } }

  fn mask(&self, mask: i32) -> ~Operand {
    match *self {
      Immediate(n, s) => ~Immediate(n & mask, s),
      _ => fail!(~"can't mask non-immediate")
    }
  }

  fn size(&self) -> Size {
    match *self {
      Immediate(_, s) | Register(_, s) => s,
      LabelOp(*) => ir::Pointer,
      Temp(*) => ir::Int
    }
  }

  fn each_temp(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      Temp(t) => { f(t) }
      _ => true
    }
  }

  fn map_temps(~self, f: &fn(Temp) -> Temp) -> ~Operand {
    match self {
      ~Temp(t) => ~Temp(f(t)),
      o        => o
    }
  }
}

impl PrettyPrint for Operand {
  fn pp(&self) -> ~str {
    match *self {
      Immediate(c, _) => fmt!("$%d", c as int),
      Register(reg, s) => reg.size(s),
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
  fn map_temps(~self, f: &fn(Temp) -> Temp) -> ~Address {
    match self {
      ~MOp(t, disp, off) =>
        ~MOp(t.map_temps(|x| f(x)), disp,
             off.map_consume(|(x, m)| (x.map_temps(|x| f(x)), m))),
      a => a
    }
  }

  fn each_temp(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      MOp(ref o, _, ref off) => {
        o.each_temp(|x| f(x)) && off.iter().advance(|&(ref x, _)| {
          x.each_temp(|x| f(x))
        })
      }
      Stack(*) | StackArg(*) => true
    }
  }
}

impl PrettyPrint for Address {
  fn pp(&self) -> ~str {
    match *self {
      MOp(ref o, disp, ref off) => {
        let mut s = ~"";
        for disp.iter().advance |&d| { s.push_str(fmt!("%?", d)); }
        s.push_str("(");
        s.push_str(o.pp());
        match *off {
          None => (),
          Some((ref off, mult)) => {
            s.push_str(fmt!(", %s, %s", off.pp(), mult.pp()));
          }
        }
        s + ")"
      }
      Stack(i) => fmt!("%?(%%rsp)", i),
      StackArg(i) => fmt!("arg[%?]", i),
    }
  }
}

impl Cond {
  fn flip(&self) -> Cond {
    match *self {
      Lt  => Gt,
      Lte => Gte,
      Gt  => Lt,
      Gte => Lte,
      Eq  => Eq,
      Neq => Neq
    }
  }
  fn negate(&self) -> Cond {
    match *self {
      Lt  => Gte,
      Lte => Gt,
      Gt  => Lte,
      Gte => Lt,
      Eq  => Neq,
      Neq => Eq
    }
  }
  fn suffix(&self) -> ~str {
    match *self {
      Lt  => ~"l",
      Lte => ~"le",
      Gt  => ~"g",
      Gte => ~"ge",
      Eq  => ~"e",
      Neq => ~"ne"
    }
  }
}

impl Binop {
  fn commutative(&self) -> bool {
    match *self { Add | Mul | And | Or | Xor => true, _ => false }
  }

  fn constrained(&self) -> bool {
    match *self { Div | Mod | Lsh | Rsh => true, _ => false }
  }

  fn divmod(&self) -> bool {
    match *self { Div | Mod => true, _ => false }
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
  fn byte(&self) -> ~str {
    match *self {
      EAX  => ~"%al",
      EBX  => ~"%bl",
      ECX  => ~"%cl",
      EDX  => ~"%dl",
      ESI  => ~"%sil",
      EDI  => ~"%dil",
      ESP  => ~"%spl",
      EBP  => ~"%bpl",
      R8D  => ~"%r8b",
      R9D  => ~"%r9b",
      R10D => ~"%r10b",
      R11D => ~"%r11b",
      R12D => ~"%r12b",
      R13D => ~"%r13b",
      R14D => ~"%r14b",
      R15D => ~"%r15b",
    }
  }

  fn size(&self, t: Size) -> ~str {
    match (*self, t) {
      (EAX, ir::Int)      => ~"%eax",
      (EAX, ir::Pointer)  => ~"%rax",
      (EBX, ir::Int)      => ~"%ebx",
      (EBX, ir::Pointer)  => ~"%rbx",
      (ECX, ir::Int)      => ~"%ecx",
      (ECX, ir::Pointer)  => ~"%rcx",
      (EDX, ir::Int)      => ~"%edx",
      (EDX, ir::Pointer)  => ~"%rdx",
      (EDI, ir::Int)      => ~"%edi",
      (EDI, ir::Pointer)  => ~"%rdi",
      (ESI, ir::Int)      => ~"%esi",
      (ESI, ir::Pointer)  => ~"%rsi",
      (ESP, ir::Int)      => ~"%esp",
      (ESP, ir::Pointer)  => ~"%rsp",
      (EBP, ir::Int)      => ~"%ebp",
      (EBP, ir::Pointer)  => ~"%rbp",
      (R8D, ir::Int)      => ~"%r8d",
      (R8D, ir::Pointer)  => ~"%r8",
      (R9D, ir::Int)      => ~"%r9d",
      (R9D, ir::Pointer)  => ~"%r9",
      (R10D, ir::Int)     => ~"%r10d",
      (R10D, ir::Pointer) => ~"%r10",
      (R11D, ir::Int)     => ~"%r11d",
      (R11D, ir::Pointer) => ~"%r11",
      (R12D, ir::Int)     => ~"%r12d",
      (R12D, ir::Pointer) => ~"%r12",
      (R13D, ir::Int)     => ~"%r13d",
      (R13D, ir::Pointer) => ~"%r13",
      (R14D, ir::Int)     => ~"%r14d",
      (R14D, ir::Pointer) => ~"%r14",
      (R15D, ir::Int)     => ~"%r15d",
      (R15D, ir::Pointer) => ~"%r15",
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
      _ => fail!(fmt!("can't make multiplier for %?", i))
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
  fn dot(&self, out: @io::Writer) {
    out.write_str("digraph {\n");
    for self.funs.iter().advance |f| {
      f.cfg.dot(out,
        |id| fmt!("%s_n%d", f.name, id as int),
        |id, ins|
          ~"label=\"" + ins.map(|s| s.pp()).connect("\\n") +
          fmt!("\\n[node=%d]\" shape=box", id as int),
        |&edge| fmt!("label=%?", edge)
      )
    }
    out.write_str("\n}");
  }
}

impl Program {
  pub fn output(&self, out: @io::Writer) {
    for self.funs.iter().advance |f| {
      f.output(out);
    }
  }
}

impl Function {
  /**
   * Traverses the cfg and outputs a stream of instructions which can be
   * assembled to the actual program
   */
  fn output(&self, out: @io::Writer) {
    let base = label::Internal(self.name.clone()).pp();
    /* entry label */
    out.write_str(~".globl " + base + "\n");
    out.write_str(base + ":\n");
    let lbl = |n: graph::NodeId| fmt!("%s_bb_%d", base, n as int);

    /* skipped is a stack of nodes that we have yet to visit */
    let mut skipped = ~[self.root];
    let mut visited = HashSet::new();

    while skipped.len() > 0 {
      let block = skipped.pop();
      if visited.contains(&block) { loop }

      /* Each block has its own label (so it can be jumped to) */
      visited.insert(block);
      out.write_str(~"L" + lbl(block) + ":\n");

      /* output the actual block */
      let instructions = self.cfg.node(block);
      for instructions.iter().advance |ins| {
        out.write_str("  ");
        out.write_str(ins.pp());
        out.write_char('\n');
      }

      /* Collect information about the edges */
      let mut always = None;
      let mut tedge = None;
      let mut fedge = None;
      for self.cfg.each_succ_edge(block) |id, &typ| {
        debug!("out of %? (%? - %?)", block, id, typ);
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
          out.write_str(fmt!("  jmp L%s\n", lbl(id)));
        }

        None => {
          match (tedge, fedge) {
            /* If everything is none, then we've reached a termination */
            (None, None) => (),

            (Some((tedge, tid)), Some((fedge, fid))) => {
              /* On a conditional branch, the last ins must be Condition */
              let cond = match *instructions.last() {
                ~Condition(c, _, _) => c,
                _ => fail!(~"Need a condition with true/false edges")
              };

              match (tedge, fedge) {
                /* If we fall through to the true block, then negate the
                   condition to jump to the false block and push traversal */
                (ir::True, _) => {
                  skipped.push(fid);
                  skipped.push(tid);
                  out.write_str(fmt!("  j%s L%s\n", cond.negate().suffix(),
                                     lbl(fid)));
                }

                /* Otherwise we can use the condition as is and we update the
                   nodes to visit */
                (_, ir::False) => {
                  skipped.push(tid);
                  skipped.push(fid);
                  out.write_str(fmt!("  j%s L%s\n", cond.suffix(), lbl(tid)));
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
  }
}
