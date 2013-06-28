use std::hashmap::HashMap;
use std::io::WriterUtil;
use std::io;
use std::vec;

use middle::{ssa, label};
use middle::temp::Temp;
use utils::{graph, PrettyPrint, Graphable};

pub struct Program {
  funs: ~[Function]
}

pub type CFG = ssa::CFG<Statement>;

pub struct Function {
  name: ~str,
  cfg: CFG,
  root: graph::NodeId,
  types: HashMap<Temp, Type>,

  loops: HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
  analysis: ssa::Analysis,
}

pub enum Statement {
  Arguments(~[Temp]),
  Move(Temp, ~Expression),
  Cast(Temp, Temp),
  Load(Temp, ~Expression),
  Call(Temp, ~Expression, ~[~Expression]),
  Phi(Temp, ssa::PhiMap),
  Store(~Expression, ~Expression),
  Condition(~Expression),
  Return(~Expression),
  Die(~Expression),
}

pub enum Expression {
  Temp(Temp),
  Const(i32, Type),
  BinaryOp(Binop, ~Expression, ~Expression),
  LabelExp(label::Label),
}

#[deriving(Eq)]
pub enum Type { Int, Pointer }

#[deriving(Eq)]
pub enum Binop {
  Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

pub enum Edge {
  Always, True, False,      /* fall through if condition holds */
  Branch, TBranch, FBranch, /* branch if condition holds */
  LoopOut, FLoopOut         /* break out of a loop */
}

pub fn Program(f: ~[Function]) -> Program {
  Program{ funs: vec::map_consume(f, |f| f) }
}

pub fn Function(name: ~str) -> Function {
  Function{ cfg: graph::Graph(),
            name: name,
            root: 0,
            types: HashMap::new(),
            loops: HashMap::new(),
            analysis: ssa::Analysis() }
}

impl Graphable for Program {
  fn dot(&self, out: @io::Writer) {
    out.write_str("digraph {\n");
    for self.funs.iter().advance |f| {
      f.cfg.dot(out,
        |id| fmt!("%s_n%d", f.name, id as int),
        |id, &stms|
          ~"label=\"" + stms.map(|s| s.pp()).connect("\\n") +
          fmt!("\\n[node=%d]\" shape=box", id as int),
        |&edge| fmt!("label=%?", edge)
      )
    }
    out.write_str("\n}");
  }
}

impl Binop {
  pub fn associative(&self) -> bool {
    match *self {
      Add | Mul | And | Or | Xor => true,
      _ => false
    }
  }

  pub fn commutative(&self) -> bool {
    match *self {
      Add | Mul | Eq | Neq | And | Or | Xor => true,
      _ => false
    }
  }
}

impl Statement {
  pub fn map_temps(~self, uses: &fn(Temp) -> Temp,
               defs: &fn(Temp) -> Temp) -> ~Statement {
    match self {
      ~Move(tmp, e) => {
        let e = e.map_temps(uses);
        ~Move(defs(tmp), e)
      }
      ~Load(tmp, e) => {
        let e = e.map_temps(uses);
        ~Load(defs(tmp), e)
      }
      ~Store(e1, e2) => ~Store(e1.map_temps(uses), e2.map_temps(uses)),
      ~Condition(e) => ~Condition(e.map_temps(uses)),
      ~Return(e) => ~Return(e.map_temps(uses)),
      ~Die(e) => ~Die(e.map_temps(uses)),
      ~Call(tmp, e, args) => {
        let e = e.map_temps(uses);
        let args = vec::map_consume(args, |x| x.map_temps(uses));
        ~Call(defs(tmp), e, args)
      }
      ~Arguments(tmps) => ~Arguments(vec::map_consume(tmps, |t| defs(t))),
      ~Phi(def, map) => {
        let mut map = map;
        let mut newmap = HashMap::new();
        do map.consume |k, v| {
          newmap.insert(k, uses(v));
        }
        ~Phi(defs(def), newmap)
      }
      ~Cast(t1, t2) => {
        assert!(t1 != t2);
        ~Cast(defs(t1), uses(t2))
      }
    }
  }

  pub fn each_def(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      Load(tmp, _) | Move(tmp, _) | Call(tmp, _, _) | Phi(tmp, _) |
        Cast(tmp, _) => { f(tmp) }
      Arguments(ref tmps) => tmps.iter().advance(|&t| f(t)),
      _ => true
    }
  }

  pub fn each_use(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      Move(_, ref e) | Load(_, ref e) | Condition(ref e) |
        Return(ref e) | Die(ref e) => e.each_temp(f),
      Store(ref e1, ref e2) => { e1.each_temp(f) && e2.each_temp(f) }
      Call(_, ref e, ref args) => {
        e.each_temp(f) && args.iter().advance(|e| e.each_temp(f))
      }
      Phi(_, ref map) => { map.each_value(|&t| f(t)) }
      Cast(_, t) => { f(t) }
      Arguments(*) => true
    }
  }
}

pub struct Info;

impl ssa::Statement<Statement> for Info {
  fn phi(&self, t: Temp, map: ssa::PhiMap) -> ~Statement { ~Phi(t, map) }

  fn map_temps(&self, s: ~Statement, uses: &fn(Temp) -> Temp,
               defs: &fn(Temp) -> Temp) -> ~Statement {
    s.map_temps(uses, defs)
  }

  fn each_def(&self, s: &Statement, f: &fn(Temp) -> bool) -> bool {
    s.each_def(f)
  }
  fn each_use(&self, s: &Statement, f: &fn(Temp) -> bool) -> bool {
    s.each_use(f)
  }

  fn phi_info<'r>(&self, me: &'r Statement) -> Option<(Temp, &'r ssa::PhiMap)> {
    match *me {
      Phi(d, ref m) => Some((d, m)),
      _             => None
    }
  }
  fn phi_unwrap(&self, me: ~Statement) -> Either<~Statement, (Temp, ssa::PhiMap)> {
    match me {
      ~Phi(d, m) => Right((d, m)),
      s          => Left(s)
    }
  }
}

impl PrettyPrint for Statement {
  fn pp(&self) -> ~str {
    match *self {
      Move(tmp, ref e) => tmp.pp() + " <- " + e.pp(),
      Cast(t1, t2) => t1.pp() + " < cast - " + t2.pp(),
      Load(tmp, ref e) => ~"load " + tmp.pp() + " <- " + e.pp(),
      Store(ref e1, ref e2) => ~"store" + " " + e1.pp() + " <- " + e2.pp(),
      Condition(ref e) => ~"cond " + e.pp(),
      Return(ref e) => ~"return " + e.pp(),
      Die(ref e) => ~"die if " + e.pp(),
      Call(t, ref e, ref E) =>
        fmt!("%s <- %s(%s)", t.pp(), e.pp(),
             E.map(|e| e.pp()).connect(", ")),
      Phi(tmp, ref map) => {
        let mut s = tmp.pp() + " <- phi(";
        for map.iter().advance |(&id, &tmp)| {
          s.push_str(fmt!("[ %s - n%d ] ", tmp.pp(), id as int));
        }
        s + ")"
      }
      Arguments(ref tmps) =>
        fmt!("args %s", tmps.map(|&t| t.pp()).connect(", ")),
    }
  }
}

impl Expression {
  pub fn map_temps(~self, f: &fn(Temp) -> Temp) -> ~Expression {
    match self {
      ~BinaryOp(op, e1, e2) =>
        ~BinaryOp(op, e1.map_temps(f), e2.map_temps(f)),
      ~Temp(tmp) => ~Temp(f(tmp)),
      /* TODO: shouldn't have to re-build */
      ~Const(c, s) => ~Const(c, s),
      ~LabelExp(l) => ~LabelExp(l),
    }
  }

  pub fn each_temp(&self, f: &fn(Temp) -> bool) -> bool {
    match *self {
      Const(*) | LabelExp(*) => true,
      BinaryOp(_, ref e1, ref e2) => { e1.each_temp(f) && e2.each_temp(f) }
      Temp(tmp) => { f(tmp) }
    }
  }

  pub fn size(&self, tmps: &HashMap<Temp, Type>) -> Type {
    match *self {
      Const(_, size) => size,
      LabelExp(_) => Pointer,
      BinaryOp(Eq, _, _) | BinaryOp(Neq, _, _) => Int,
      BinaryOp(_, ref e1, ref e2) => {
        let left = e1.size(tmps);
        assert!(left == e2.size(tmps));
        return left;
      },
      Temp(ref t) => *tmps.get(t)
    }
  }
}

impl PrettyPrint for Expression {
  fn pp(&self) -> ~str {
    match *self {
      Temp(ref t) => t.pp(),
      Const(c, _) => fmt!("0x%x", c as uint),
      BinaryOp(op, ref e1, ref e2) =>
        ~"(" + e1.pp() + " " + op.pp() + " " + e2.pp() + ")",
      LabelExp(ref l) => l.pp()
    }
  }
}

impl PrettyPrint for Binop {
  fn pp(&self) -> ~str {
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
  for p.funs.mut_iter().advance |f| {
    ssa_fun(f);
  }
}

priv fn ssa_fun(f: &mut Function) {
  /* tables/metadata altered through temp remapping */
  let mut newtypes = HashMap::new();

  /* And, convert! */
  let mapping = ssa::convert(&mut f.cfg, f.root, &mut f.analysis, &Info);
  for mapping.iter().advance |(&new, old)| {
    newtypes.insert(new, *f.types.get(old));
  }
  /* update all type information for the new temps */
  f.types.clear();
  do newtypes.consume |k, v| {
    f.types.insert(k, v);
  }
}
