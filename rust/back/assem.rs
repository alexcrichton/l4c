use core::io::WriterUtil;
use core::hashmap::linear::{LinearMap, LinearSet};

use middle::{label, ir, liveness};
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
  sizes: LinearMap<Temp, Size>,
  temps: uint,
  ssa: ssa::Analysis,
  liveness: liveness::Analysis,

  loops: LinearMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
}

pub enum Instruction {
  BinaryOp(Binop, @Operand, @Operand, @Operand),
  Move(@Operand, @Operand),
  Load(@Operand, @Address),
  Store(@Address, @Operand),
  Condition(Cond, @Operand, @Operand),
  Die(Cond, @Operand, @Operand),
  Return(@Operand),
  Call(Temp, @Operand, ~[@Operand]),
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

pub enum Operand {
  Immediate(i32, Size),
  Register(Register, Size),
  Temp(Temp),
  LabelOp(Label)
}

pub enum Address {
  /*   base      offset         multplier reg    multiplier size */
  MOp(@Operand, Option<uint>, Option<(@Operand, Multiplier)>),
  Stack(uint),
  StackArg(uint),
}

pub enum Multiplier {
  One, Two, Four, Eight
}

#[deriving_eq]
pub enum Binop {
  Add, Sub, Mul, Div, Mod, Cmp(Cond), And, Or, Xor, Lsh, Rsh
}

#[deriving_eq]
pub enum Cond {
  Lt, Lte, Gt, Gte, Eq, Neq
}

#[deriving_eq]
pub enum Register {
  EAX, EBX, ECX, EDX, EDI, ESI, ESP, EBP,
  R8D, R9D, R10D, R11D, R12D, R13D, R14D, R15D
}

pub enum Constraint { Caller, Idiv }

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
  fn each_def(&self, f: fn(Temp) -> bool) {
    match *self {
      BinaryOp(_, @Temp(t), _, _) |
      Move(@Temp(t), _) |
      Phi(t, _) |
      Load(@Temp(t), _) |
      Call(t, _, _) |
      Reload(t, _) |
      Arg(t, _)
        => { f(t); }

      PCopy(ref copies) => copies.each(|&(def, _)| f(def)),

      _ => ()
    }
  }

  #[inline(always)]
  fn each_use(&self, f: fn(Temp) -> bool) {
    match *self {
      Condition(_, @Temp(t1), @Temp(t2)) |
      Die(_, @Temp(t1), @Temp(t2)) |
      BinaryOp(_, _, @Temp(t1), @Temp(t2))
        => { f(t1); f(t2); }

      Condition(_, @Temp(t), _) |
      Condition(_, _, @Temp(t)) |
      Die(_, @Temp(t), _) |
      Die(_, _, @Temp(t)) |
      BinaryOp(_, _, @Temp(t), _) |
      BinaryOp(_, _, _, @Temp(t)) |
      Move(_, @Temp(t)) |
      Spill(t, _) |
      Use(t) |
      Return(@Temp(t))
        => { f(t); }

      Store(addr, src) => { addr.each_temp(f); src.each_temp(f); }
      Load(_, addr) => { addr.each_temp(f); }

      Call(_, fun, ref args) => {
        match fun {
          @Temp(t) => { f(t); }
          _ => ()
        }
        for args.each |&arg| {
          match arg {
            @Temp(t) => { f(t); }
            _ => ()
          }
        }
      }

      PCopy(ref copies) => copies.each(|&(_, t)| f(t)),

      _ => ()
    }
  }
  fn phi_info(&self) -> Option<(Temp, &self/ssa::PhiMap)> {
    match *self {
      Phi(d, ref m) => Some((d, m)),
      _         => None
    }
  }

  pure fn is_phi(&self) -> bool { match *self { Phi(*) => true, _ => false } }
}

impl Instruction: ssa::Statement {
  static fn phi(t: Temp, map: ssa::PhiMap) -> @Instruction { @Phi(t, map) }

  fn each_def(&self, f: fn(Temp) -> bool) { self.each_def(f) }
  fn each_use(&self, f: fn(Temp) -> bool) { self.each_use(f) }
  static fn phi_info(me: &v/Instruction) -> Option<(Temp, &v/ssa::PhiMap)> {
    me.phi_info()
  }

  fn map_temps(@self, uses: fn(Temp) -> Temp,
               defs: fn(Temp) -> Temp) -> @Instruction {
    match self {
      @MemPhi(*) => self,
      @BinaryOp(op, o1, o2, o3) => {
        let (o2, o3) = (o2.map_temps(uses), o3.map_temps(uses));
        @BinaryOp(op, o1.map_temps(defs), o2, o3)
      }
      @Move(dest, src) => {
        let src = src.map_temps(uses);
        @Move(dest.map_temps(defs), src)
      }
      @Load(dest, src) => {
        let src = src.map_temps(uses);
        @Load(dest.map_temps(defs), src)
      }
      @Store(dest, src) => @Store(dest.map_temps(uses), src.map_temps(uses)),
      @Die(c, o1, o2) => @Die(c, o1.map_temps(uses), o2.map_temps(uses)),
      @Condition(c, o1, o2) =>
        @Condition(c, o1.map_temps(uses), o2.map_temps(uses)),
      @Spill(t, tag) => @Spill(uses(t), tag),
      @Reload(dest, tag) => @Reload(defs(dest), tag),
      @Phi(t, ref map) => {
        /* TODO: is the duplicate needed? */
        let mut dup = LinearMap::new();
        for map.each |&(&k, &v)| {
          dup.insert(k, v);
        }
        @Phi(defs(t), dup)
      }
      @Call(dst, fun, ref args) => {
        let fun = fun.map_temps(uses);
        let args = args.map(|&arg| arg.map_temps(uses));
        @Call(defs(dst), fun, args)
      }
      @Use(t) => @Use(uses(t)),
      @Return(t) => @Return(t.map_temps(uses)),
      @Raw(*) => self,
      @Arg(t, n) => @Arg(defs(t), n),
      @PCopy(ref copies) => {
        let mut new = ~[];
        for copies.each |&(dst, src)| {
          let src = uses(src);
          new.push((defs(dst), src));
        }
        @PCopy(new)
      }
    }
  }
}

impl Instruction: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
      Raw(copy s) => s,
      Arg(t, i) => fmt!("%s = arg[%?]", t.pp(), i),
      Return(t) => fmt!("ret // %s", t.pp()),
      Use(t) => fmt!("use %s", t.pp()),
      Die(c, o1, o2) =>
        fmt!("cmp %s, %s; j%s %sraise_segv", o2.pp(), o1.pp(),
             c.suffix(), label::prefix()),
      Condition(c, o1, o2) =>
        fmt!("cmp %s, %s // %s", o2.pp(), o1.pp(), c.suffix()),
      Load(dst, addr) =>
        fmt!("mov %s, %s", addr.pp(), dst.pp()),
      Store(addr, src) => match src {
        @Immediate(_, ir::Pointer) => fmt!("movq %s, %s", src.pp(), addr.pp()),
        @Immediate(_, ir::Int)     => fmt!("movl %s, %s", src.pp(), addr.pp()),
        _                          => fmt!("mov %s, %s", src.pp(), addr.pp()),
      },
      Move(o1, o2) =>
        if o1.size() != o2.size() && !o2.imm() {
          ~"movslq " + o2.pp() + ~", " + o1.pp()
        } else {
          ~"mov " + o2.pp() + ~", " + o1.pp()
        },
      BinaryOp(binop, dest, s1, s2) => match binop {
        /* multiplications can have third operand if it's an immediate */
        Mul if s2.imm() && !s1.imm() => {
          if s1.size() == dest.size() {
            fmt!("imul %s, %s, %s", s2.pp(), s1.pp(), dest.pp())
          } else {
            let larger = match s1 {
              @Register(r, _) => @Register(r, ir::Pointer),
              _ => s1
            };
            fmt!("movslq %s, %s; imul %s, %s, %s", s1.pp(), larger.pp(),
                 s2.pp(), larger.pp(), dest.pp())
          }
        }
        /* division/mod are both weird */
        Div | Mod => fmt!("cltd; idiv %s // %s <- %s %s %s", s2.pp(), dest.pp(),
                          s1.pp(), binop.pp(), s2.pp()),

        /* Shifting by immediates can only use lower 5 bits */
        Lsh | Rsh if s1.imm() =>
          fmt!("%s %s, %s", binop.pp(), s1.mask(0x1f).pp(), dest.pp()),
        Lsh | Rsh if s1.reg() => {
          match s1 {
            @Register(ECX, _) => (),
            _                 => die!(fmt!("expected ecx, not %?", s1))
          }
          fmt!("%s %%cl, %s", binop.pp(), dest.pp())
        }

        Cmp(cond) => {
          let dstsmall = match dest {
            @Register(r, _) => r.byte(), _ => dest.pp()
          };
          fmt!("cmp %s, %s; set%s %s; movzbl %s, %s",
               s2.pp(), s1.pp(), cond.suffix(), dstsmall, dstsmall, dest.pp())
        }

        _ => fmt!("%s %s, %s // %s"
                  binop.pp(), s1.pp(), dest.pp(), s2.pp()),
      },
      Call(dst, e, ref args) =>
        fmt!("call %s // %s <- %s", e.pp(), dst.pp(),
             ~"(" + str::connect(args.map(|a| a.pp()), ~", ") + ~")"),
      Phi(tmp, ref map) => {
        let mut s = ~"//" + tmp.pp() + ~" <- phi(";
        for map.each |&(&id, &tmp)| {
          s += fmt!("[ %s - n%? ] ", tmp.pp(), id);
        }
        s + ~")"
      }
      MemPhi(tag, ref map) => {
        let mut s = fmt!("//m%? <- mphi(", tag);
        for map.each |&(&id, &tag)| {
          s += fmt!("[ m%? - n%? ] ", tag, id);
        }
        s + ~")"
      }
      Spill(t, tag) => fmt!("SPILL %s -> %?", t.pp(), tag),
      Reload(t, tag) => fmt!("RELOAD %s <= %?", t.pp(), tag),
      PCopy(ref copies) => {
        let mut s = ~"{";
        for copies.each |&(k, v)| {
          s += fmt!("(%? <= %?) ", k, v);
        }
        s + ~"}"
      }
    }
  }
}

impl Operand {
  pure fn imm(&self) -> bool { match *self { Immediate(*) => true, _ => false } }
  pure fn reg(&self) -> bool { match *self { Register(*) => true, _ => false } }

  pure fn mask(&self, mask: i32) -> @Operand {
    match *self {
      Immediate(n, s) => @Immediate(n & mask, s),
      _ => die!(~"can't mask non-immediate")
    }
  }

  pure fn size(&self) -> Size {
    match *self {
      Immediate(_, s) | Register(_, s) => s,
      LabelOp(*) => ir::Pointer,
      Temp(*) => ir::Int
    }
  }

  fn each_temp(&self, f: fn(Temp) -> bool) {
    match *self {
      Temp(t) => { f(t); }
      _ => ()
    }
  }

  fn map_temps(@self, f: fn(Temp) -> Temp) -> @Operand {
    match self {
      @Temp(t) => @Temp(f(t)),
      _        => self
    }
  }
}

impl Operand: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
      Immediate(c, _) => fmt!("$%d", c as int),
      Register(reg, s) => reg.size(s),
      Temp(t) => t.pp(),
      LabelOp(ref l) => l.pp()
    }
  }
}

impl Operand: cmp::Eq {
  pure fn eq(&self, other: &Operand) -> bool {
    match (self, other) {
      (&Register(a, _), &Register(b, _)) => a == b,
      (&Temp(a), &Temp(b)) => a == b,
      _ => false
    }
  }

  pure fn ne(&self, other: &Operand) -> bool { !self.eq(other) }
}

impl Address {
  fn map_temps(@self, f: fn(Temp) -> Temp) -> @Address {
    match self {
      @MOp(t, disp, off) =>
        @MOp(t.map_temps(f), disp, off.map(|&(x, m)| (x.map_temps(f), m))),
      _ => self
    }
  }

  fn each_temp(&self, f: fn(Temp) -> bool) {
    match *self {
      MOp(o, _, off) => {
        o.each_temp(f);
        for off.each |&(x, _)| {
          x.each_temp(f);
        }
      }
      Stack(*) | StackArg(*) => ()
    }
  }
}

impl Address: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
      MOp(o, disp, off) => {
        let mut s = ~"";
        for disp.each |&d| { s += fmt!("%?", d); }
        s += ~"(";
        s += o.pp();
        match (off) {
          None => (),
          Some((off, mult)) => {
            s += fmt!(", %s, %s", off.pp(), mult.pp());
          }
        }
        s + ~")"
      }
      Stack(i) => fmt!("%?(%%rsp)", i),
      StackArg(i) => fmt!("arg[%?]", i),
    }
  }
}

impl Cond {
  pure fn flip(&self) -> Cond {
    match *self {
      Lt  => Gt,
      Lte => Gte,
      Gt  => Lt,
      Gte => Lte,
      Eq  => Eq,
      Neq => Neq
    }
  }
  pure fn negate(&self) -> Cond {
    match *self {
      Lt  => Gte,
      Lte => Gt,
      Gt  => Lte,
      Gte => Lt,
      Eq  => Neq,
      Neq => Eq
    }
  }
  pure fn suffix(&self) -> ~str {
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
  pure fn commutative(&self) -> bool {
    match *self { Add | Mul | And | Or | Xor => true, _ => false }
  }

  pure fn constrained(&self) -> bool {
    match *self { Div | Mod | Lsh | Rsh => true, _ => false }
  }

  pure fn divmod(&self) -> bool {
    match *self { Div | Mod => true, _ => false }
  }
}

impl Binop: PrettyPrint {
  pure fn pp(&self) -> ~str {
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
  pure fn byte(&self) -> ~str {
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

  pure fn size(&self, t: Size) -> ~str {
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
  static fn valid(i: i32) -> bool {
    i == 1 || i == 2 || i == 4 || i == 8
  }

  static fn from_int(i: i32) -> Multiplier {
    match i {
      1 => One, 2 => Two, 4 => Four, 8 => Eight,
      _ => die!(fmt!("can't make multiplier for %?", i))
    }
  }
}

impl Multiplier: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
      One => ~"1", Two => ~"2", Four => ~"4", Eight => ~"8"
    }
  }
}

impl Program: Graphable {
  fn dot(&self, out: io::Writer) {
    out.write_str(~"digraph {\n");
    for self.funs.each |f| {
      f.cfg.dot(out,
        |id| fmt!("%s_n%d", f.name, id as int),
        |id, &ins|
          ~"label=\"" + str::connect(ins.map(|s| s.pp()), "\\n") +
          fmt!("\\n[node=%d]\" shape=box", id as int),
        |&edge| fmt!("label=%?", edge)
      )
    }
    out.write_str(~"\n}");
  }
}

impl Program {
  fn output(&self, out: io::Writer) {
    for self.funs.each |f| {
      f.output(out);
    }
  }
}

impl Function {
  /**
   * Traverses the cfg and outputs a stream of instructions which can be
   * assembled to the actual program
   */
  fn output(&self, out: io::Writer) {
    let base = label::Internal(copy self.name).pp();
    /* entry label */
    out.write_str(~".globl " + base + ~"\n");
    out.write_str(base + ~":\n");
    let lbl = |n: graph::NodeId| fmt!("%s_bb_%d", base, n as int);

    /* skipped is a stack of nodes that we have yet to visit */
    let mut skipped = ~[self.root];
    let mut visited = LinearSet::new();

    while skipped.len() > 0 {
      let block = skipped.pop();
      if visited.contains(&block) { loop }

      /* Each block has its own label (so it can be jumped to) */
      visited.insert(block);
      out.write_str(~"L" + lbl(block) + ~":\n");

      /* output the actual block */
      let instructions = self.cfg[block];
      for instructions.each |&ins| {
        out.write_str(~"  ");
        out.write_str(ins.pp());
        out.write_char('\n');
      }

      /* Collect information about the edges */
      let mut always = None;
      let mut tedge = None;
      let mut fedge = None;
      for self.cfg.each_succ_edge(block) |id, typ| {
        debug!("out of %? (%? - %?)", block, id, typ);
        match typ {
          ir::Always | ir::Branch | ir::LoopOut => {
            assert(tedge.is_none() && fedge.is_none() && always.is_none());
            always = Some((typ, id));
          }
          ir::True | ir::TBranch => {
            assert(tedge.is_none() && always.is_none());
            tedge = Some((typ, id));
          }
          ir::False | ir::FBranch | ir::FLoopOut => {
            assert(fedge.is_none() && always.is_none());
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
              let cond = match instructions.last() {
                @Condition(c, _, _) => c,
                _ => die!(~"Need a condition with true/false edges")
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

                _ => die!(~"invalidly specified edges")
              }
            }
            _ => die!(~"invalid edges")
          }
        }
      }

      /* and finally, the basic block is done with its emission! */
    }
  }
}
