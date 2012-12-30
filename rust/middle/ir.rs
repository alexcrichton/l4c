use io::WriterUtil;
use std::map;

pub struct Program {
  funs : ~[Function]
}

pub struct Function {
  name : ~str,
  cfg : graph::Graph<@~[@Statement], Edge>,
  mut root : graph::NodeId,
  idoms : map::HashMap<graph::NodeId, graph::NodeId>,
  mut postorder : @~[graph::NodeId], // TODO: iterate mutable vector?
  mut args : @~[temp::Temp],         // TODO: same as above
}

pub type Temp = (temp::Temp, Type);

pub enum Statement {
  Move(Temp, @Expression),
  Load(Temp, @Expression),
  Phi(Temp, map::HashMap<graph::NodeId, temp::Temp>),
  Store(@Expression, Type, @Expression),
  Condition(@Expression),
  Return(@Expression),
  Die(@Expression),
}

pub enum Expression {
  Temp(Temp),
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
  Function{ cfg: graph::Graph(),
            name: name,
            root: 0,
            idoms: map::HashMap(),
            postorder: @~[],
            args: @~[] }
}

impl Program {
  fn dot(out : io::Writer) {
    out.write_str(~"digraph {\n");
    for self.funs.each |f| {
      f.cfg.dot(out,
        |id| fmt!("%s_n%d", f.name, id as int),
        |id, &stms|
          ~"label=\"" + str::connect(stms.map(|s| s.pp()), "\\n") +
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
}

impl Expression {
  pub fn size() -> Type {
    match self {
      Temp((_, size)) | Const(_, size) | Call(_, size, _) => size,
      LabelExp(_) => Pointer,
      BinaryOp(_, e1, e2) => {
        match e1.size() {
          Int => e2.size(),
          Pointer => Pointer
        }
      }
    }
  }
}

impl Program : PrettyPrint {
  pure fn pp() -> ~str {
    str::connect(self.funs.map(|f| f.pp()), "\n\n")
  }
}

impl Function : PrettyPrint {
  pure fn pp() -> ~str {
    // TODO: graph traversal
    ~"foo"
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
  pure fn pp() -> ~str {
    match self {
      Move(tmp, e) => tmp.pp() + ~" <- " + e.pp(),
      Load(tmp, e) => ~"load " + tmp.pp() + ~" <- " + e.pp(),
      Store(e1, t, e2) => ~"store" + t.pp() + ~" " + e1.pp() + " <- " + e2.pp(),
      Condition(e) => ~"cond " + e.pp(),
      Return(e) => ~"return " + e.pp(),
      Die(e) => ~"die if " + e.pp(),
      Phi(tmp, ref map) => {
        let mut s = tmp.pp() + ~" <- phi(";
        for map.each |id, tmp| {
          s += fmt!("[ %s - n%d ] ", tmp.pp(), id as int);
        }
        s + ~")"
      }
    }
  }
}

impl Temp : PrettyPrint {
  pure fn pp() -> ~str {
    let (tmp, t) = self;
    tmp.pp() + t.pp()
  }
}

impl Expression : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      Temp(ref t) => t.pp(),
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
  pure fn pp() -> ~str {
    match self {
      ir::Int => ~":i",
      ir::Pointer => ~":p"
    }
  }
}

impl Binop : PrettyPrint {
  pure fn pp() -> ~str {
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
