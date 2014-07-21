use collections::HashMap;
use std::io;

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

#[deriving(Clone)]
pub enum Expression {
  Temp(Temp),
  Const(i32, Type),
  BinaryOp(Binop, ~Expression, ~Expression),
  LabelExp(label::Label),
}

#[deriving(Eq, Clone)]
pub enum Type { Int, Pointer }

#[deriving(Eq, Clone)]
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
            types: HashMap::new(),
            loops: HashMap::new(),
            analysis: ssa::Analysis() }
}

impl Graphable for Program {
  fn dot(&self, out: &mut io::Writer) -> io::IoResult<()> {
    try!(out.write_str("digraph {\n"));
    for f in self.funs.iter() {
      try!(f.cfg.dot(out,
        |id| format!("{}_n{}", f.name, id as int),
        |id, stms|
          "label=\"" + stms.iter().map(|s| s.pp()).connect("\\n").collect() +
          format!("\n[node={}]\" shape=box", id as int),
        |&edge| format!("label={:?}", edge)
      ));
    }
    out.write_str("\n}")
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
  pub fn map_temps(~self, uses: |Temp| -> Temp,
               defs: |Temp| -> Temp) -> ~Statement {
    match self {
      ~Move(tmp, e) => {
        let e = e.map_temps(uses);
        ~Move(defs(tmp), e)
      }
      ~Load(tmp, e) => {
        let e = e.map_temps(uses);
        ~Load(defs(tmp), e)
      }
      ~Store(e1, e2) => ~Store(e1.map_temps(|x| uses(x)), e2.map_temps(uses)),
      ~Condition(e) => ~Condition(e.map_temps(uses)),
      ~Return(e) => ~Return(e.map_temps(uses)),
      ~Die(e) => ~Die(e.map_temps(uses)),
      ~Call(tmp, e, args) => {
        let e = e.map_temps(|x| uses(x));
        let args = args.move_iter().map(|x| x.map_temps(|x| uses(x)))
                       .collect();
        ~Call(defs(tmp), e, args)
      }
      ~Arguments(tmps) => ~Arguments(tmps.move_iter().map(|t| defs(t))
                                         .collect()),
      ~Phi(def, map) => {
        let mut newmap = HashMap::new();
        for (k, v) in map.move_iter() {
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

  pub fn each_def(&self, f: |Temp|) {
    match *self {
      Load(tmp, _) | Move(tmp, _) | Call(tmp, _, _) | Phi(tmp, _) |
        Cast(tmp, _) => { f(tmp) }
      Arguments(ref tmps) => { tmps.iter().advance(|&t| { f(t); true }); }
      _ => ()
    }
  }

  pub fn each_use(&self, f: |Temp|) {
    match *self {
      Move(_, ref e) | Load(_, ref e) | Condition(ref e) |
        Return(ref e) | Die(ref e) => e.each_temp(f),
      Store(ref e1, ref e2) => { e1.each_temp(|x| f(x)); e2.each_temp(f) }
      Call(_, ref e, ref args) => {
        e.each_temp(|x| f(x));
        for e in args.iter(){ e.each_temp(|x| f(x)) }
      }
      Phi(_, ref map) => {
        for (_, &v) in map.iter() { f(v) }
      }
      Cast(_, t) => { f(t) }
      Arguments(..) => ()
    }
  }
}

pub struct Info;

impl ssa::Statement<Statement> for Info {
  fn phi(&self, t: Temp, map: ssa::PhiMap) -> ~Statement { ~Phi(t, map) }

  fn map_temps(&self, s: ~Statement, uses: |Temp| -> Temp,
               defs: |Temp| -> Temp) -> ~Statement {
    s.map_temps(uses, defs)
  }

  fn each_def(&self, s: &Statement, f: |Temp|) { s.each_def(f) }
  fn each_use(&self, s: &Statement, f: |Temp|) { s.each_use(f) }

  fn phi_info<'r>(&self, me: &'r Statement) -> Option<(Temp, &'r ssa::PhiMap)> {
    match *me {
      Phi(d, ref m) => Some((d, m)),
      _             => None
    }
  }
  fn phi_unwrap(&self, me: ~Statement) -> Result<(Temp, ssa::PhiMap), ~Statement> {
    match me {
      ~Phi(d, m) => Ok((d, m)),
      s          => Err(s)
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
      Call(t, ref e, ref args) =>
        format!("{} <- {}({})", t.pp(), e.pp(),
                args.iter().map(|e| e.pp()).collect::<~[~str]>().connect(", ")),
      Phi(tmp, ref map) => {
        let mut s = tmp.pp() + " <- phi(";
        for (&id, &tmp) in map.iter() {
          s.push_str(format!("[ {} - n{} ] ", tmp.pp(), id as int));
        }
        s + ")"
      }
      Arguments(ref tmps) =>
        format!("args {}", tmps.iter().map(|&t| t.pp())
                               .collect::<~[~str]>().connect(", ")),
    }
  }
}

impl Expression {
  pub fn map_temps(~self, f: |Temp| -> Temp) -> ~Expression {
    match self {
      ~BinaryOp(op, e1, e2) =>
        ~BinaryOp(op, e1.map_temps(|x| f(x)), e2.map_temps(f)),
      ~Temp(tmp) => ~Temp(f(tmp)),
      /* TODO: shouldn't have to re-build */
      ~Const(c, s) => ~Const(c, s),
      ~LabelExp(l) => ~LabelExp(l),
    }
  }

  pub fn each_temp(&self, f: |Temp|) {
    match *self {
      Const(..) | LabelExp(..) => (),
      BinaryOp(_, ref e1, ref e2) => {
        e1.each_temp(|x| f(x));
        e2.each_temp(f)
      }
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
      Const(c, _) => format!("0x{:x}", c as uint),
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
  for f in p.funs.mut_iter() {
    ssa_fun(f);
  }
}

fn ssa_fun(f: &mut Function) {
  /* tables/metadata altered through temp remapping */
  let mut newtypes = HashMap::new();

  /* And, convert! */
  let mapping = ssa::convert(&mut f.cfg, f.root, &mut f.analysis, &Info);
  for (&new, old) in mapping.iter() {
    newtypes.insert(new, *f.types.get(old));
  }
  /* update all type information for the new temps */
  f.types.clear();
  for (k, v) in newtypes.move_iter() {
    f.types.insert(k, v);
  }
}
