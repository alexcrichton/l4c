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

  loops : map::HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
}

pub enum Statement {
  Move(Temp, @Expression),
  Load(Temp, @Expression),
  Call(Temp, @Expression, ~[@Expression]),
  Phi(Temp, ssa::PhiMap),
  Store(@Expression, @Expression),
  Condition(@Expression),
  Return(@Expression),
  Die(@Expression),
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
            args: @~[],
            loops: map::HashMap() }
}

impl Program : Graphable {
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

impl Statement : ssa::Statement {
  fn each_def(f : &fn(Temp) -> bool) {
    match self {
      Load(tmp, _) | Move(tmp, _) | Call(tmp, _, _) | Phi(tmp, _) => {f(tmp);}
      _ => ()
    }
  }

  fn each_use(f : &fn(Temp) -> bool) {
    match self {
      Move(_, e) | Load(_, e) | Condition(e) | Return(e) | Die(e) =>
        e.each_temp(f),
      Store(e1, e2) => { e1.each_temp(f); e2.each_temp(f); }
      Call(_, e, ref args) => {
        e.each_temp(f);
        for args.each |&e| { e.each_temp(f); }
      }
      Phi(_, _) => fail(~"shouldn't see phi nodes yet")
    }
  }

  fn map_temps(@self, uses: &fn(Temp) -> Temp,
               defs: &fn(Temp) -> Temp) -> @Statement {
    match self {
      @Move(tmp, e) => {
        let e = e.map_temps(uses);
        @Move(defs(tmp), e)
      }
      @Load(tmp, e) => {
        let e = e.map_temps(uses);
        @Load(defs(tmp), e)
      }
      @Store(e1, e2) => @Store(e1.map_temps(uses), e2.map_temps(uses)),
      @Condition(e) => @Condition(e.map_temps(uses)),
      @Return(e) => @Return(e.map_temps(uses)),
      @Die(e) => @Die(e.map_temps(uses)),
      @Call(tmp, e, ref args) => {
        let e = e.map_temps(uses);
        let args = args.map(|&x| x.map_temps(uses));
        @Call(defs(tmp), e, args)
      }
      @Phi(_, _) => fail(~"shouldn't see phi nodes yet")
    }
  }

  fn phi_map() -> Option<ssa::PhiMap> {
    match self {
      ir::Phi(_, m) => Some(m),
      _             => None
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

  fn each_temp(f: &fn(Temp) -> bool) {
    match self {
      @ir::Const(*) | @ir::LabelExp(*) => (),
      @ir::BinaryOp(_, e1, e2) => { e1.each_temp(f); e2.each_temp(f); }
      @ir::Temp(tmp) => { f(tmp); }
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

pub fn ssa(p : &ir::Program) {
  for p.funs.each |f| {
    ssa_fun(f);
  }
}

priv fn ssa_fun(f : &ir::Function) {
  /* tables/metadata altered through temp remapping */
  let args = map::HashMap();
  let oldtypes = f.types;
  let newtypes = map::HashMap();
  for f.args.each |&tmp| {
    args.insert(tmp, None);
  }

  /* And, convert! */
  ssa::convert(&f.cfg, f.root, *f.args, |old, new| {
    newtypes.insert(new, oldtypes[old]);
    match args.find(old) {
      Some(Some(_)) => (),
      Some(None)    => { args.insert(old, Some(new)); }
      None          => ()
    }
  }, |tmp, map| @ir::Phi(tmp, map));

  /* update all type information for the new temps */
  f.types.clear();
  for newtypes.each |k, v| {
    f.types.insert(k, v);
  }
  /* remap our args */
  f.args = @f.args.map(|&arg| {
    assert args.contains_key(arg) && args[arg].is_some();
    args[arg].get()
  });
}
