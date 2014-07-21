use std::collections::HashMap;
use std::fmt;
use std::io;

use middle::{ssa, label};
use middle::temp::Temp;
use utils::{graph, Graphable};

pub struct Program {
    pub funs: Vec<Function>,
}

pub type CFG = ssa::CFG<Statement>;

pub struct Function {
    pub name: String,
    pub cfg: CFG,
    pub types: HashMap<Temp, Type>,
    pub root: graph::NodeId,

    pub loops: HashMap<graph::NodeId, (graph::NodeId, graph::NodeId)>,
    analysis: ssa::Analysis,
}

pub enum Statement {
    Arguments(Vec<Temp>),
    Move(Temp, Box<Expression>),
    Cast(Temp, Temp),
    Load(Temp, Box<Expression>),
    Call(Temp, Box<Expression>, Vec<Box<Expression>>),
    Phi(Temp, ssa::PhiMap),
    Store(Box<Expression>, Box<Expression>),
    Condition(Box<Expression>),
    Return(Box<Expression>),
    Die(Box<Expression>),
}

#[deriving(Clone)]
pub enum Expression {
    Temp(Temp),
    Const(i32, Type),
    BinaryOp(Binop, Box<Expression>, Box<Expression>),
    LabelExp(label::Label),
}

#[deriving(Eq, PartialEq, Clone, Show)]
pub enum Type { Int, Pointer }

#[deriving(Eq, PartialEq, Clone)]
pub enum Binop {
    Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

#[deriving(Show)]
pub enum Edge {
    Always, True, False,      /* fall through if condition holds */
    Branch, TBranch, FBranch, /* branch if condition holds */
    LoopOut, FLoopOut         /* break out of a loop */
}

impl Program {
    pub fn new(f: Vec<Function>) -> Program {
        Program{ funs: f }
    }
}

impl Function {
    pub fn new(name: String) -> Function {
        Function {
            cfg: graph::Graph::new(),
            name: name,
            root: 0,
            types: HashMap::new(),
            loops: HashMap::new(),
            analysis: ssa::Analysis::new(),
        }
    }
}

impl Graphable for Program {
    fn dot(&self, out: &mut io::Writer) -> io::IoResult<()> {
        try!(out.write_str("digraph {\n"));
        for f in self.funs.iter() {
            try!(f.cfg.dot(out,
                           |id| format!("{}_n{}", f.name, id as int),
                           |id, stms|
                             "label=\"".to_string() +
                                stms.iter().map(|s| s.to_string())
                                    .collect::<Vec<String>>().connect("\\n") +
                                format!("\n[node={}]\" shape=box", id as int)
                                    .as_slice(),
                           |&edge| format!("label={}", edge)
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
    pub fn map_temps(self, uses: |Temp| -> Temp,
                     defs: |Temp| -> Temp) -> Box<Statement> {
        box match self {
            Move(tmp, e) => {
                let e = e.map_temps(uses);
                Move(defs(tmp), e)
            }
            Load(tmp, e) => {
                let e = e.map_temps(uses);
                Load(defs(tmp), e)
            }
            Store(e1, e2) => Store(e1.map_temps(|x| uses(x)), e2.map_temps(uses)),
            Condition(e) => Condition(e.map_temps(uses)),
            Return(e) => Return(e.map_temps(uses)),
            Die(e) => Die(e.map_temps(uses)),
            Call(tmp, e, args) => {
                let e = e.map_temps(|x| uses(x));
                let args = args.move_iter().map(|x| x.map_temps(|x| uses(x)))
                                .collect();
                Call(defs(tmp), e, args)
            }
            Arguments(tmps) => Arguments(tmps.move_iter().map(|t| defs(t))
                                             .collect()),
            Phi(def, map) => {
                let mut newmap = HashMap::new();
                for (k, v) in map.move_iter() {
                    newmap.insert(k, uses(v));
                }
                Phi(defs(def), newmap)
            }
            Cast(t1, t2) => {
                assert!(t1 != t2);
                Cast(defs(t1), uses(t2))
            }
        }
    }

    pub fn each_def(&self, f: |Temp|) {
        match *self {
            Load(tmp, _) | Move(tmp, _) | Call(tmp, _, _) | Phi(tmp, _) |
                Cast(tmp, _) => { f(tmp) }
            Arguments(ref tmps) => { tmps.iter().all(|&t| { f(t); true }); }
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
    fn phi(&self, t: Temp, map: ssa::PhiMap) -> Box<Statement> { box Phi(t, map) }

    fn map_temps(&self, s: Box<Statement>, uses: |Temp| -> Temp,
                 defs: |Temp| -> Temp) -> Box<Statement> {
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
    fn phi_unwrap(&self, me: Box<Statement>)
                  -> Result<(Temp, ssa::PhiMap), Box<Statement>> {
        match me {
            box Phi(d, m) => Ok((d, m)),
            s => Err(s)
        }
    }
}

impl fmt::Show for Statement {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Move(tmp, ref e) => write!(f, "{} <- {}", tmp, e),
            Cast(t1, t2) => write!(f, "{} < cast - {}", t1, t2),
            Load(tmp, ref e) => write!(f, "load {} <- {}", tmp, e),
            Store(ref e1, ref e2) => write!(f, "store {} <- {}", e1, e2),
            Condition(ref e) => write!(f, "cond {}", e),
            Return(ref e) => write!(f, "return {}", e),
            Die(ref e) => write!(f, "die if {}", e),
            Call(t, ref e, ref args) => write!(f, "{} <- {}({:#})", t, e, args),
            Phi(tmp, ref map) => {
                try!(write!(f, "{} <- phi(", tmp));
                for (&id, &tmp) in map.iter() {
                    try!(write!(f, "[ {} - n{} ] ", tmp, id));
                }
                write!(f, ")")
            }
            Arguments(ref tmps) => write!(f, "args {}", tmps),
        }
    }
}

impl Expression {
    pub fn map_temps(self, f: |Temp| -> Temp) -> Box<Expression> {
        box match self {
            BinaryOp(op, e1, e2) =>
                BinaryOp(op, e1.map_temps(|x| f(x)), e2.map_temps(f)),
            Temp(tmp) => Temp(f(tmp)),
            /* TODO: shouldn't have to re-build */
            Const(c, s) => Const(c, s),
            LabelExp(l) => LabelExp(l),
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

impl fmt::Show for Expression {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Temp(ref t) => write!(f, "{}", t),
            Const(c, _) => write!(f, "0x{:x}", c as uint),
            BinaryOp(op, ref e1, ref e2) => write!(f, "({} {} {})", op, e1, e2),
            LabelExp(ref l) => write!(f, "{}", l),
        }
    }
}

impl fmt::Show for Binop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Add => "+".fmt(f),
            Sub => "-".fmt(f),
            Mul => "*".fmt(f),
            Div => "/".fmt(f),
            Mod => "%".fmt(f),
            Lt  => "<".fmt(f),
            Lte => "<=".fmt(f),
            Gt  => ">".fmt(f),
            Gte => ">=".fmt(f),
            Eq  => "==".fmt(f),
            Neq => "!=".fmt(f),
            And => "&".fmt(f),
            Or  => "|".fmt(f),
            Xor => "^".fmt(f),
            Lsh => "<<".fmt(f),
            Rsh => ">>".fmt(f),
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
