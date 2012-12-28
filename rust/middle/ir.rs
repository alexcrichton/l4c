use io::WriterUtil;

pub struct Program {
  funs : ~[Function]
}

pub struct Function {
  name : ~str,
  cfg : graph::Graph<@~[@Statement], Edge>
}

pub type Temp = (temp::Temp, Type);

pub enum Statement {
  Move(Temp, @Expression),
  Load(Temp, @Expression),
  Store(@Expression, Type, @Expression),
  Condition(@Expression),
  Return(@Expression),
  Die(@Expression),
}

pub enum Expression {
  Temp(Temp),
  Phi(~[temp::Temp]),
  Const(i32, Type),
  BinaryOp(Binop, @Expression, @Expression),
  Call(@Expression, Type, ~[@Expression]),
  LabelExp(label::Label)
}

pub enum Type { Int, Pointer }

pub enum Binop {
  Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

pub enum Edge {
  Always, True, False,      /* fall through if condition holds */
  Branch, TBranch, FBranch  /* branch if condition holds */
}

pub fn Program(f : ~[Function]) -> ir::Program {
  Program{ funs : f }
}

pub fn Function(name : ~str) -> Function {
  Function{ cfg : graph::Graph(), name : name }
}

impl Program {
  fn pp(out : io::Writer) {
    out.write_str(~"digraph {\n");
    for self.funs.each |f| {
      f.cfg.dot(out,
        |&id| fmt!("%s_n%d", f.name, id as int),
        |&stms|
          ~"label=\"" + str::connect(stms.map(|s| s.pp()), "\\n") +
          "\" shape=box",
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
}

impl Binop {
  fn associative() -> bool {
    match self {
      Add | Mul | And | Or | Xor => true,
      _ => false
    }
  }

  fn commutative() -> bool {
    match self {
      Add | Mul | Eq | Neq | And | Or | Xor => true,
      _ => false
    }
  }
}

impl Statement : PrettyPrint {
  fn pp() -> ~str {
    match self {
      Move(tmp, e) => tmp.pp() + ~" <- " + e.pp(),
      Load(tmp, e) => ~"load " + tmp.pp() + ~" <- " + e.pp(),
      Store(e1, t, e2) => ~"store" + t.pp() + ~" " + e1.pp() + " <- " + e2.pp(),
      Condition(e) => ~"cond " + e.pp(),
      Return(e) => ~"return " + e.pp(),
      Die(e) => ~"die if " + e.pp()
    }
  }
}

impl Temp : PrettyPrint {
  fn pp() -> ~str {
    let (tmp, t) = self;
    tmp.pp() + t.pp()
  }
}

impl Expression : PrettyPrint {
  fn pp() -> ~str {
    match self {
      Temp(ref t) => t.pp(),
      Phi(_) => ~"phi",
      Const(c, t) => fmt!("0x%x%s", c as uint, t.pp()),
      BinaryOp(op, e1, e2) =>
        ~"(" + e1.pp() + ~" " + op.pp() + ~" " + e2.pp() + ~")",
      Call(e, _, ref E) =>
        e.pp() + ~"(" + str::connect(E.map(|e| e.pp()), ~", ") + ~")",
      LabelExp(ref l) => l.pp()
    }
  }
}

impl Type : PrettyPrint {
  fn pp() -> ~str {
    match self {
      ir::Int => ~":i",
      ir::Pointer => ~":p"
    }
  }
}

impl Binop : PrettyPrint {
  fn pp() -> ~str {
    match self {
      Add => ~"+",
      Sub => ~"-",
      Mul => ~"*",
      Div => ~"/",
      Mod => ~"%",
      Lt  => ~"<",
      Lte => ~"<=",
      Gt  => ~">",
      Gte => ~">=",
      Eq  => ~"==",
      Neq => ~"!=",
      And => ~"&",
      Or  => ~"|",
      Xor => ~"^",
      Lsh => ~"<<",
      Rsh => ~">>",
    }
  }
}
