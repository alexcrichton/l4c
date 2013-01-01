use middle::temp;
use middle::label;
use middle::ir;
use std::map;
use io::WriterUtil;

pub type Label = label::Label;
pub type Edge = ir::Edge;
pub type Size = ir::Type;

pub struct Program {
  funs : ~[Function]
}

pub struct Function {
  name : ~str,
  root : graph::NodeId,
  cfg : graph::Graph<@~[@Instruction], Edge>,
  args : ~[temp::Temp],
  sizes : map::HashMap<temp::Temp, Size>,
  mut temps : uint,

  idoms : map::HashMap<graph::NodeId, graph::NodeId>,
  idominated : map::HashMap<graph::NodeId, graph::NodeSet>,
  loops : map::HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
}

pub enum Instruction {
  BinaryOp(Binop, @Operand, @Operand, @Operand),
  Move(@Operand, @Operand),
  Load(@Operand, @Address),
  Store(@Address, @Operand),
  Condition(Cond, @Operand, @Operand),
  Die(Cond, @Operand, @Operand),
  Return,
  Call(@Operand, uint),
  Raw(~str),
  Comment(~str),
  Phi(temp::Temp, map::HashMap<graph::NodeId, temp::Temp>),
  Reload(temp::Temp),
  Spill(temp::Temp),
}

pub enum Operand {
  Immediate(i32, Size),
  Register(Register, Size),
  Temp(temp::Temp),
  LabelOp(Label)
}

pub enum Address {
  MOp(@Operand),
  Stack(uint),
  StackArg(uint),
  StackLoc(int),
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

impl Instruction {
  fn each_def(f : &fn(temp::Temp) -> bool) {
    match self {
      BinaryOp(_, @Temp(t), _, _) |
      Move(@Temp(t), _) |
      Phi(t, _) |
      Load(@Temp(t), _)
        => { f(t); }
      _ => ()
    }
  }

  fn each_use(f : &fn(temp::Temp) -> bool) {
    match self {
      Condition(_, @Temp(t1), @Temp(t2)) |
      Die(_, @Temp(t1), @Temp(t2)) |
      BinaryOp(_, _, @Temp(t1), @Temp(t2)) => { if f(t1) { f(t2); } }

      Condition(_, @Temp(t), _) |
      Condition(_, _, @Temp(t)) |
      Die(_, @Temp(t), _) |
      Die(_, _, @Temp(t)) |
      BinaryOp(_, _, @Temp(t), _) |
      BinaryOp(_, _, _, @Temp(t)) |
      Call(@Temp(t), _) |
      Move(_, @Temp(t)) |
      Spill(t)
        => { f(t); }

      _ => ()
    }
  }
}

impl Instruction : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      Raw(copy s) => s,
      Comment(copy s) => ~"/* " + s + ~" */",
      Return => ~"ret",
      Die(c, o1, o2) =>
        fmt!("cmp %s, %s; j%s %sraise_segv", o2.pp(), o1.pp(),
             c.suffix(), label::prefix()),
      Condition(c, o1, o2) =>
        fmt!("cmp %s, %s // %s", o2.pp(), o1.pp(), c.suffix()),
      Load(dst, addr) =>
        fmt!("mov (%s), %s", addr.pp(), dst.pp()),
      Store(addr, src) =>
        fmt!("mov %s, (%s)", src.pp(), addr.pp()),
      Move(o1, o2) =>
        if o1.size() != o2.size() && !o2.imm() {
          ~"movslq " + o2.pp() + ~", " + o1.pp()
        } else {
          ~"mov " + o2.pp() + ~", " + o1.pp()
        },
      BinaryOp(binop, dest, s1, s2) =>
        fmt!("%s %s, %s // %s"
             binop.pp(), s1.pp(), dest.pp(), s2.pp()),
      Call(@LabelOp(ref l), _) => fmt!("call %s", l.pp()),
      Call(e, _) => fmt!("call *%s", e.pp()),
      Phi(tmp, map) => {
        let mut s = ~"//" + tmp.pp() + ~" <- phi(";
        for map.each |id, tmp| {
          s += fmt!("[ %s - n%d ] ", tmp.pp(), id as int);
        }
        s + ~")"
      }
      Spill(t) => fmt!("spill %s", t.pp()),
      Reload(t) => fmt!("reload %s", t.pp()),
    }
  }
}

impl Operand {
  pure fn imm() -> bool { match self { Immediate(*) => true, _ => false } }

  pure fn size() -> Size {
    match self {
      Immediate(_, s) | Register(_, s) => s,
      LabelOp(*) => ir::Pointer,
      Temp(*) => ir::Int
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
      Stack(i) => fmt!("%%rsp(%?)", i),
      StackArg(i) => fmt!("arg[%?]", i),
      StackLoc(i) => fmt!("stack[%?]", i)
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
  pure fn size(t : assem::Size) -> ~str {
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

impl Program {
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
        Some((_, id)) => { out.write_str(fmt!("  jmp L%s\n", lbl(id))); }

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
                  out.write_str(fmt!("  j%s L%s\n", cond.suffix(), lbl(fid)));
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
