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
  mut temps : uint,

  idoms : map::HashMap<graph::NodeId, graph::NodeId>,
  idominated : map::HashMap<graph::NodeId, graph::NodeSet>,
  postorder : @~[graph::NodeId],
}

pub enum Instruction {
  BinaryOp(Binop, @Operand, @Operand, @Operand),
  Move(@Operand, @Operand),
  Condition(Cond, @Operand, @Operand),
  Die(Cond, @Operand, @Operand),
  Return,
  Call(@Operand, uint),
  Raw(~str),
  Comment(~str),
  Phi(temp::Temp, Size, map::HashMap<graph::NodeId, temp::Temp>)
}

pub enum Operand {
  Immediate(i32, Size),
  Register(Register, Size),
  Temp(temp::Temp, Size),
  Memory(@Address, Size),
  LabelOp(Label)
}

pub enum Address {
  MOp(@Operand),
  Stack(uint),
  StackArg(int),
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
      BinaryOp(_, @Temp(t, _), _, _) | Move(@Temp(t, _), _) | Phi(t, _, _) =>
        { f(t); }
      _ => ()
    }
  }

  fn each_use(f : &fn(temp::Temp) -> bool) {
    match self {
      Call(o, _) => o.each_temp(f),
      Condition(_, o1, o2) | Die(_, o1, o2) =>
        { o1.each_temp(f); o2.each_temp(f); }
      BinaryOp(_, dest, o1, o2) => {
        o1.each_temp(f);
        o2.each_temp(f);
        match dest {
          @Temp(_, _) => (),
          o => o.each_temp(f)
        }
      }
      Move(dest, src) => {
        src.each_temp(f);
        match dest {
          @Temp(_, _) => (),
          o => o.each_temp(f)
        }
      }
      Phi(_, _, _) | Raw(_) | Comment(_) | Return => ()
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
        fmt!("die%s %s, %s", c.suffix(), o1.pp(), o2.pp()),
      Condition(c, o1, o2) =>
        fmt!("cmp %s, %s // %s", o1.pp(), o2.pp(), c.suffix()),
      Move(o1, o2) => ~"mov " + o2.pp() + ~", " + o1.pp(),
      BinaryOp(binop, dest, s1, s2) =>
        fmt!("%s %s, %s // %s = %s %s %s",
             binop.pp(), dest.pp(), s2.pp()
             dest.pp(), s1.pp(), binop.pp(), s2.pp()),
      Call(e, _) => fmt!("call %s", e.pp()),
      Phi(tmp, _, map) => {
        let mut s = tmp.pp() + ~" <- phi(";
        for map.each |id, tmp| {
          s += fmt!("[ %s - n%d ] ", tmp.pp(), id as int);
        }
        s + ~")"
      }
    }
  }
}

impl Operand {
  fn each_temp(f : &fn(temp::Temp) -> bool) {
    match self {
      Temp(t, _) => { f(t); }
      Memory(@MOp(o), _) => { o.each_temp(f); }
      _ => ()
    }
  }

  fn imm() -> bool { match self { Immediate(*) => true, _ => false } }
  fn mem() -> bool { match self { Memory(*) => true, _ => false } }

  fn size() -> Size {
    match self {
      Immediate(_, s) | Register(_, s) | Temp(_, s) | Memory(_, s) => s,
      LabelOp(_) => ir::Pointer
    }
  }
}

impl Operand : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      Immediate(c, _) => fmt!("$%d", c as int),
      Register(reg, s) => reg.size(s),
      Temp(t, _) => t.pp(),
      Memory(o, _) => o.pp(),
      LabelOp(ref l) => l.pp()
    }
  }
}

impl Operand : cmp::Eq {
  pure fn eq(&self, other : &Operand) -> bool {
    match (*self, *other) {
      (Register(a, _), Register(b, _)) => a == b,
      (Temp(a, _), Temp(b, _)) => a == b,
      _ => false
    }
  }

  pure fn ne(&self, other : &Operand) -> bool { !self.eq(other) }
}

impl Address : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      MOp(o) => ~"(" + o.pp() + ~")",
      Stack(i) => fmt!("%%rsp(%u)", i),
      StackArg(i) => fmt!("arg[%d]", i),
      StackLoc(i) => fmt!("stack[%d]", i)
    }
  }
}

impl Cond {
  pure fn rev() -> Cond {
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
      Mul => ~"mul",
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
        |&edge|
          match edge {
            ir::Always => ~"",
            ir::True => ~"label=true",
            ir::False => ~"label=false",
            ir::Branch => ~"label=branch",
            ir::TBranch => ~"label=tbranch",
            ir::FBranch => ~"label=fbranch"
          }
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
  fn output(out : io::Writer) {
    let base = label::Internal(copy self.name).pp();
    out.write_str(base + ~":\n");
    let lbl = |n : graph::NodeId| fmt!("%s_bb_%d", base, n as int);
    let mut skipped = ~[self.root];
    let visited = map::HashMap();
    while skipped.len() > 0 {
      let block = skipped.pop();
      if set::contains(visited, block) { loop }
      set::add(visited, block);
      out.write_str(lbl(block) + ~":\n");

      let instructions = self.cfg[block];
      for instructions.each |&ins| {
        out.write_str(~"  ");
        out.write_str(ins.pp());
        out.write_char('\n');
      }
      let mut always = None;
      let mut tedge = None;
      let mut fedge = None;
      for self.cfg.each_edge(block) |id, &typ| {
        debug!("out of %? (%? - %?)", block, id, typ);
        match typ {
          ir::Always | ir::Branch => {
            assert(tedge.is_none() && fedge.is_none() && always.is_none());
            always = Some((typ, id));
          }
          ir::True | ir::TBranch => {
            assert(tedge.is_none() && always.is_none());
            tedge = Some((typ, id));
          }
          ir::False | ir::FBranch => {
            assert(fedge.is_none() && always.is_none());
            fedge = Some((typ, id));
          }
        }
      }

      match always {
        Some((ir::Always, id)) if !set::contains(visited, id) =>
          { skipped.push(id); }
        Some((_, id)) => { out.write_str(fmt!("  jmp %s\n", lbl(id))); }
        None => {
          match (tedge, fedge) {
            (None, None) => (),
            (Some((tedge, tid)), Some((fedge, fid))) => {
              let cond = match instructions.last() {
                @Condition(c, _, _) => c,
                _ => fail(~"Need a condition with true/false edges")
              };
              match (tedge, fedge) {
                (ir::True, _) => {
                  skipped.push(fid);
                  skipped.push(tid);
                  out.write_str(fmt!("  j%s %s\n", cond.negate().suffix(),
                                     lbl(fid)));
                }
                (_, ir::False) => {
                  skipped.push(tid);
                  skipped.push(fid);
                  out.write_str(fmt!("  jmp%s %s\n", cond.suffix(), lbl(fid)));
                }
                _ => fail(~"invalidly specified edges")
              }
            }
            _ => fail(~"invalid edges")
          }
        }
      }

    }
  }
}
