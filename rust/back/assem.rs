use core::io::WriterUtil;
use core::hashmap::linear::LinearMap;

use std::map;

use middle::{label, ir, ssa, liveness};
use middle::temp::Temp;
use back::arch;
use utils::{set, graph, Graphable, PrettyPrint};

pub type Label = label::Label;
pub type Edge = ir::Edge;
pub type Size = ir::Type;
pub type Tag = uint;
pub type CFG = graph::Graph<@~[@Instruction], Edge>;

pub struct Program {
  funs : ~[Function]
}

pub struct Function {
  name : ~str,
  root : graph::NodeId,
  cfg : CFG,
  sizes : LinearMap<Temp, Size>,
  temps : uint,
  ssa: ssa::Analysis,
  liveness: liveness::Analysis,

  loops : LinearMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
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
  Reload(Temp, Tag),
  Spill(Temp, Tag),
  Use(Temp),              /* used when constraining non-commutative ops */
  PCopy(map::HashMap<Temp, Temp>), /* parallel copy of temps */
  Arg(Temp, uint),        /* nth argument is wired to this temp */
}

pub enum Operand {
  Immediate(i32, Size),
  Register(Register, Size),
  Temp(Temp),
  LabelOp(Label)
}

pub enum Address {
  MOp(@Operand),
  Stack(uint),
  StackArg(uint),
}

pub enum Binop {
  Add, Sub, Mul, Div, Mod, Cmp(Cond), And, Or, Xor, Lsh, Rsh
}

pub enum Cond {
  Lt, Lte, Gt, Gte, Eq, Neq
}

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

impl Instruction : ssa::Statement {
  static fn phi(t: Temp, map: ssa::PhiMap) -> @Instruction { @Phi(t, map) }

  fn each_def<T>(f : &fn(Temp) -> T) {
    match self {
      BinaryOp(_, @Temp(t), _, _) |
      Move(@Temp(t), _) |
      Phi(t, _) |
      Load(@Temp(t), _) |
      Call(t, _, _) |
      Reload(t, _) |
      Arg(t, _)
        => { f(t); }

      PCopy(copies) => for copies.each_key |t| { f(t); },

      _ => ()
    }
  }

  fn each_use<T>(f : &fn(Temp) -> T) {
    match self {
      Condition(_, @Temp(t1), @Temp(t2)) |
      Die(_, @Temp(t1), @Temp(t2)) |
      Store(@MOp(@Temp(t1)), @Temp(t2)) |
      BinaryOp(_, _, @Temp(t1), @Temp(t2))
        => { f(t1); f(t2); }

      Load(_, @MOp(@Temp(t))) |
      Store(@MOp(@Temp(t)), _) |
      Store(_, @Temp(t)) |
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

      PCopy(copies) => for copies.each_value |t| { f(t); },

      _ => ()
    }
  }

  fn phi_map() -> Option<ssa::PhiMap> {
    match self {
      Phi(_, m) => Some(m),
      _         => None
    }
  }

  fn map_temps(@self, uses: &fn(Temp) -> Temp,
               defs: &fn(Temp) -> Temp) -> @Instruction {
    match self {
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
      @Phi(t, map) => @Phi(defs(t), map),
      @Call(dst, fun, ref args) => {
        let fun = fun.map_temps(uses);
        let args = args.map(|&arg| arg.map_temps(uses));
        @Call(defs(dst), fun, args)
      }
      @Use(t) => @Use(uses(t)),
      @Return(t) => @Return(t.map_temps(uses)),
      @Raw(*) => self,
      @Arg(t, n) => @Arg(defs(t), n),
      @PCopy(copies) => {
        let map = map::HashMap();
        for copies.each |dst, src| {
          let src = uses(src);
          map.insert(defs(dst), src);
        }
        @PCopy(map)
      }
    }
  }
}

impl Instruction {
  pure fn is_phi() -> bool { match self { Phi(*) => true, _ => false } }
}

impl Instruction : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
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
            _                 => fail(fmt!("expected ecx, not %?", s1))
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
      Phi(tmp, map) => {
        let mut s = ~"//" + tmp.pp() + ~" <- phi(";
        for map.each |id, tmp| {
          s += fmt!("[ %s - n%d ] ", tmp.pp(), id as int);
        }
        s + ~")"
      }
      Spill(t, tag) => fmt!("SPILL %s -> %?", t.pp(), tag),
      Reload(t, tag) => fmt!("RELOAD %s <= %?", t.pp(), tag),
      PCopy(copies) => {
        let mut s = ~"{";
        for copies.each |k, v| {
          s += fmt!("(%? => %?) ", k, v);
        }
        s + ~"}"
      }
    }
  }
}

impl Operand {
  pure fn imm() -> bool { match self { Immediate(*) => true, _ => false } }
  pure fn reg() -> bool { match self { Register(*) => true, _ => false } }

  pure fn mask(mask : i32) -> @Operand {
    match self {
      Immediate(n, s) => @Immediate(n & mask, s),
      _ => fail(~"can't mask non-immediate")
    }
  }

  pure fn size() -> Size {
    match self {
      Immediate(_, s) | Register(_, s) => s,
      LabelOp(*) => ir::Pointer,
      Temp(*) => ir::Int
    }
  }
}

impl @Operand {
  fn map_temps(f : &fn(Temp) -> Temp) -> @Operand {
    match self {
      @Temp(t) => @Temp(f(t)),
      _        => self
    }
  }
}

impl @Address {
  fn map_temps(f : &fn(Temp) -> Temp) -> @Address {
    match self {
      @MOp(t) => @MOp(t.map_temps(f)),
      _        => self
    }
  }
}

impl Operand : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      Immediate(c, _) => fmt!("$%d", c as int),
      Register(reg, s) => reg.size(s),
      Temp(t) => t.pp(),
      LabelOp(ref l) => l.pp()
    }
  }
}

impl Operand : cmp::Eq {
  pure fn eq(&self, other : &Operand) -> bool {
    match (*self, *other) {
      (Register(a, _), Register(b, _)) => a == b,
      (Temp(a), Temp(b)) => a == b,
      _ => false
    }
  }

  pure fn ne(&self, other : &Operand) -> bool { !self.eq(other) }
}

impl Address : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      MOp(o) => ~"(" + o.pp() + ~")",
      Stack(i) => fmt!("%?(%%rsp)", i),
      StackArg(i) => fmt!("arg[%?]", i),
    }
  }
}

impl Cond {
  pure fn flip() -> Cond {
    match self {
      Lt  => Gt,
      Lte => Gte,
      Gt  => Lt,
      Gte => Lte,
      Eq  => Eq,
      Neq => Neq
    }
  }
  pure fn negate() -> Cond {
    match self {
      Lt  => Gte,
      Lte => Gt,
      Gt  => Lte,
      Gte => Lt,
      Eq  => Neq,
      Neq => Eq
    }
  }
  pure fn suffix() -> ~str {
    match self {
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
  pure fn commutative() -> bool {
    match self { Add | Mul | And | Or | Xor => true, _ => false }
  }

  pure fn constrained() -> bool {
    match self { Div | Mod | Lsh | Rsh => true, _ => false }
  }

  pure fn divmod() -> bool {
    match self { Div | Mod => true, _ => false }
  }
}

impl Binop : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
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
  pure fn byte() -> ~str {
    match self {
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

  pure fn size(t : Size) -> ~str {
    match (self, t) {
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

impl Register : cmp::Eq {
  pure fn eq(&self, other : &Register) -> bool {
    match (*self, *other) {
      (EAX, EAX) | (EBX, EBX) | (ECX, ECX) | (EDX, EDX) | (EDI, EDI) |
      (ESI, ESI) | (ESP, ESP) | (EBP, EBP) | (R8D, R8D) | (R9D, R9D) |
      (R10D, R10D) | (R11D, R11D) | (R12D, R12D) | (R13D, R13D) | (R14D, R14D) |
      (R15D, R15D) => true,
      _ => false
    }
  }

  pure fn ne(&self, other : &Register) -> bool { !self.eq(other) }
}

impl Program : Graphable {
  fn dot(out : io::Writer) {
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
  fn output(out : io::Writer) {
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
  fn output(out : io::Writer) {
    let base = label::Internal(copy self.name).pp();
    /* entry label */
    out.write_str(~".globl " + base + ~"\n");
    out.write_str(base + ~":\n");
    let lbl = |n : graph::NodeId| fmt!("%s_bb_%d", base, n as int);

    /* skipped is a stack of nodes that we have yet to visit */
    let mut skipped = ~[self.root];
    let visited = map::HashMap();

    while skipped.len() > 0 {
      let block = skipped.pop();
      if set::contains(visited, block) { loop }

      /* Each block has its own label (so it can be jumped to) */
      set::add(visited, block);
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
        Some((ir::Always, id)) if !set::contains(visited, id) =>
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
                _ => fail(~"Need a condition with true/false edges")
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

                _ => fail(~"invalidly specified edges")
              }
            }
            _ => fail(~"invalid edges")
          }
        }
      }

      /* and finally, the basic block is done with its emission! */
    }
  }
}
