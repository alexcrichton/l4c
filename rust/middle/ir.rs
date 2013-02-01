use core::hashmap::linear::LinearMap;

use io::WriterUtil;
use middle::{ssa, label};
use middle::temp::Temp;
use utils::{graph, PrettyPrint, Graphable};

pub struct Program {
  funs: ~[Function]
}

pub struct Function {
  name: ~str,
  cfg: graph::Graph<@~[@Statement], Edge>,
  root: graph::NodeId,
  types: LinearMap<Temp, Type>,

  loops: LinearMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
  analysis: ssa::Analysis,
}

pub enum Statement {
  Arguments(~[Temp]),
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

#[deriving_eq]
pub enum Type { Int, Pointer }

#[deriving_eq]
pub enum Binop {
  Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

pub enum Edge {
  Always, True, False,      /* fall through if condition holds */
  Branch, TBranch, FBranch, /* branch if condition holds */
  LoopOut, FLoopOut         /* break out of a loop */
}

pub fn Program(f: ~[Function]) -> Program {
  Program{ funs: f }
}

pub fn Function(name: ~str) -> Function {
  Function{ cfg: graph::Graph(),
            name: name,
            root: 0,
            types: LinearMap::new(),
            loops: LinearMap::new(),
            analysis: ssa::Analysis() }
}

impl Program: Graphable {
  fn dot(&self, out: io::Writer) {
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

pub impl Type {
  static fn max(t1: Type, t2: Type) -> Type {
    match (t1, t2) { (Int, Int) => Int, _ => Pointer }
  }
}

impl Function {
  pure fn size(&self, e: @Expression) -> Type {
    match e {
      @Const(_, size) => size,
      @LabelExp(_) => Pointer,
      @BinaryOp(Eq, _, _) | @BinaryOp(Neq, _, _) => Int,
      @BinaryOp(_, e1, e2) => {
        match self.size(e1) {
          Int => self.size(e2),
          Pointer => Pointer
        }
      },
      @Temp(ref t) => *self.types.get(t)
    }
  }
}

impl Binop {
  fn associative(&self) -> bool {
    match *self {
      Add | Mul | And | Or | Xor => true,
      _ => false
    }
  }

  fn commutative(&self) -> bool {
    match *self {
      Add | Mul | Eq | Neq | And | Or | Xor => true,
      _ => false
    }
  }
}

impl Statement: ssa::Statement {
  static fn phi(t: Temp, map: ssa::PhiMap) -> @Statement { @Phi(t, map) }

  fn each_def<T>(&self, f: &fn(Temp) -> T) {
    match *self {
      Load(tmp, _) | Move(tmp, _) | Call(tmp, _, _) | Phi(tmp, _) => {f(tmp);}
      Arguments(ref tmps) => {
        for tmps.each |&t| { f(t); }
      }
      _ => ()
    }
  }

  fn each_use<T>(&self, f: &fn(Temp) -> T) {
    match *self {
      Move(_, e) | Load(_, e) | Condition(e) | Return(e) | Die(e) =>
        e.each_temp(f),
      Store(e1, e2) => { e1.each_temp(f); e2.each_temp(f); }
      Call(_, e, ref args) => {
        e.each_temp(f);
        for args.each |&e| { e.each_temp(f); }
      }
      Phi(_, _) => fail(~"shouldn't see phi nodes yet"),
      Arguments(*) => ()
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
      @Phi(_, _) => fail(~"shouldn't see phi nodes yet"),
      @Arguments(ref tmps) => @Arguments(tmps.map(|&t| defs(t)))
    }
  }

  fn phi_map(&self) -> Option<ssa::PhiMap> {
    match *self {
      Phi(_, m) => Some(m),
      _             => None
    }
  }
}

impl Statement: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
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
      Arguments(ref tmps) =>
        fmt!("args %s", str::connect(tmps.map(|&t| t.pp()), ", ")),
    }
  }
}

impl Expression {
  fn map_temps(@self, f: &fn(Temp) -> Temp) -> @Expression {
    match self {
      @Const(*) | @LabelExp(*) => self,
      @BinaryOp(op, e1, e2) =>
        @BinaryOp(op, e1.map_temps(f), e2.map_temps(f)),
      @Temp(tmp) => @Temp(f(tmp))
    }
  }

  fn each_temp<T>(&self, f: &fn(Temp) -> T) {
    match *self {
      Const(*) | LabelExp(*) => (),
      BinaryOp(_, e1, e2) => { e1.each_temp(f); e2.each_temp(f); }
      Temp(tmp) => { f(tmp); }
    }
  }
}

impl Expression: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
      Temp(ref t) => t.pp(),
      Const(c, _) => fmt!("0x%x", c as uint),
      BinaryOp(op, e1, e2) =>
        ~"(" + e1.pp() + ~" " + op.pp() + ~" " + e2.pp() + ~")",
      LabelExp(ref l) => l.pp()
    }
  }
}

impl Binop: PrettyPrint {
  pure fn pp(&self) -> ~str {
    match *self {
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

pub fn ssa(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    ssa_fun(f);
  }
}

priv fn ssa_fun(f: &mut Function) {
  /* tables/metadata altered through temp remapping */
  let mut newtypes = LinearMap::new();

  /* And, convert! */
  let mapping = ssa::convert(&mut f.cfg, f.root, &mut f.analysis);
  for mapping.each |&new, old| {
    newtypes.insert(new, *f.types.get(old));
  }
  /* update all type information for the new temps */
  f.types.clear();
  do newtypes.consume |k, v| {
    f.types.insert(k, v);
  }
}
