use io::WriterUtil;
use std::map;
use middle::temp::Temp;

pub struct Program {
  funs : ~[Function]
}

pub struct Function {
  name : ~str,
  cfg : graph::Graph<@~[@Statement], Edge>,
  mut root : graph::NodeId,
  mut args : @~[Temp],         // TODO: iterate mutable vector?
  types : map::HashMap<Temp, Type>,

  /* idoms[a] = b implies the immediate dominator of a is b */
  idoms : map::HashMap<graph::NodeId, graph::NodeId>,
  /* idominated[a] = b implies a immediately dominates nodes in b */
  idominated : map::HashMap<graph::NodeId, graph::NodeSet>,
  /* loop header blocks to loop body and loop exit blocks */
  loops : map::HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
}

pub enum Statement {
  Move(Temp, @Expression),
  Load(Temp, @Expression),
  Phi(Temp, map::HashMap<graph::NodeId, Temp>),
  Store(@Expression, @Expression),
  Condition(@Expression),
  Return(@Expression),
  Die(@Expression),
  Call(Temp, @Expression, ~[@Expression]),
}

pub enum Expression {
  Temp(Temp),
  Const(i32, Type),
  BinaryOp(Binop, @Expression, @Expression),
  LabelExp(label::Label),
}

pub enum Type { Int, Pointer }

pub enum Binop {
  Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

pub enum Edge {
  Always, True, False,      /* fall through if condition holds */
  Branch, TBranch, FBranch, /* branch if condition holds */
  LoopOut, FLoopOut         /* break out of a loop */
}

pub fn Program(f : ~[Function]) -> ir::Program {
  Program{ funs : f }
}

pub fn Function(name : ~str) -> Function {
  Function{ cfg: graph::Graph(),
            name: name,
            root: 0,
            types: map::HashMap(),
            idoms: map::HashMap(),
            idominated: map::HashMap(),
            args: @~[],
            loops: map::HashMap() }
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
        |&edge| fmt!("label=%?", edge)
      )
    }
    out.write_str(~"\n}");
  }
}

impl Type : cmp::Eq {
  pure fn eq(&self, other : &Type) -> bool {
    match (*self, *other) {
      (Int, Int) | (Pointer, Pointer) => true,
      _ => false
    }
  }

  pure fn ne(&self, other : &Type) -> bool { !self.eq(other) }
}

impl Program : PrettyPrint {
  pure fn pp() -> ~str {
    str::connect(self.funs.map(|f| f.pp()), "\n\n")
  }
}

impl Function {
  pure fn size(e : @Expression) -> Type {
    match e {
      @Const(_, size) => size,
      @LabelExp(_) => Pointer,
      @BinaryOp(_, e1, e2) => {
        match self.size(e1) {
          Int => self.size(e2),
          Pointer => Pointer
        }
      },
      @Temp(t) => self.types[t]
    }
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

impl Statement {
  fn each_def(f : &fn(Temp) -> bool) {
    match self {
      Load(tmp, _) | Move(tmp, _) => { f(tmp); }
      _ => ()
    }
  }

  fn map_temps(uses: &fn(Temp) -> Temp, defs: &fn(Temp) -> Temp) -> @Statement {
    match self {
      ir::Move(tmp, e) => {
        let e = e.map_temps(defs);
        @ir::Move(defs(tmp), e)
      }
      ir::Load(tmp, e) => {
        let e = e.map_temps(defs);
        @ir::Load(defs(tmp), e)
      }
      ir::Store(e1, e2) => @ir::Store(e1.map_temps(uses), e2.map_temps(uses)),
      ir::Condition(e) => @ir::Condition(e.map_temps(uses)),
      ir::Return(e) => @ir::Return(e.map_temps(uses)),
      ir::Die(e) => @ir::Die(e.map_temps(uses)),
      ir::Call(tmp, e, ref args) => {
        let e = e.map_temps(uses);
        let args = args.map(|&x| x.map_temps(uses));
        @ir::Call(defs(tmp), e, args)
      }
      ir::Phi(_, _) => fail(~"shouldn't see phi nodes yet")
    }
  }
}

impl Statement : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      Move(tmp, e) => tmp.pp() + ~" <- " + e.pp(),
      Load(tmp, e) => ~"load " + tmp.pp() + ~" <- " + e.pp(),
      Store(e1, e2) => ~"store" + ~" " + e1.pp() + " <- " + e2.pp(),
      Condition(e) => ~"cond " + e.pp(),
      Return(e) => ~"return " + e.pp(),
      Die(e) => ~"die if " + e.pp(),
      Call(t, e, ref E) =>
        fmt!("%s <- %s(%s)", t.pp(), e.pp(),
             str::connect(E.map(|e| e.pp()), ~", ")),
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

impl @Expression {
  fn map_temps(f: &fn(Temp) -> Temp) -> @Expression {
    match self {
      @ir::Const(*) | @ir::LabelExp(*) => self,
      @ir::BinaryOp(op, e1, e2) =>
        @ir::BinaryOp(op, e1.map_temps(f), e2.map_temps(f)),
      @ir::Temp(tmp) => @ir::Temp(f(tmp))
    }
  }
}

impl Expression : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      Temp(ref t) => t.pp(),
      Const(c, _) => fmt!("0x%x", c as uint),
      BinaryOp(op, e1, e2) =>
        ~"(" + e1.pp() + ~" " + op.pp() + ~" " + e2.pp() + ~")",
      LabelExp(ref l) => l.pp()
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
