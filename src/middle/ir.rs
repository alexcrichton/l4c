use std::collections::HashMap;
use std::fmt;
use std::io;

use front::pp::CommaSep;
use middle::ssa;
use middle::label::Label;
use utils::{Temp, Graphable, Symbol};
use utils::graph::{Graph, NodeId};

pub struct Program {
    pub funs: Vec<Function>,
}

pub type CFG = ssa::CFG<Stmt>;

pub struct Function {
    pub name: Symbol,
    pub cfg: CFG,
    pub types: HashMap<Temp, Type>,
    pub root: NodeId,

    pub loops: HashMap<NodeId, (NodeId, NodeId)>,
    analysis: ssa::Analysis,
}

pub enum Stmt {
    Arguments(Vec<Temp>),
    Move(Temp, Expr),
    Cast(Temp, Temp),
    Load(Temp, Expr),
    Call(Temp, Expr, Vec<Expr>),
    Phi(Temp, ssa::PhiMap),
    Store(Expr, Expr),
    Condition(Expr),
    Return(Expr),
    Die(Expr),
}

#[derive(Clone)]
pub enum Expr {
    Temp(Temp),
    Const(i32, Type),
    BinaryOp(Binop, Box<Expr>, Box<Expr>),
    Label(Label),
}

#[derive(Eq, PartialEq, Clone, Debug, Copy)]
pub enum Type { Int, Pointer }

#[derive(Eq, PartialEq, Clone, Copy)]
pub enum Binop {
    Add, Sub, Mul, Div, Mod, Lt, Lte, Gt, Gte, Eq, Neq, And, Or, Xor, Lsh, Rsh
}

#[derive(Debug, Clone, Copy)]
pub enum Edge {
    Always, True, False,      // fall through if condition holds
    Branch, TBranch, FBranch, // branch if condition holds
    LoopOut, FLoopOut         // break out of a loop
}

impl Program {
    pub fn new(f: Vec<Function>) -> Program {
        Program{ funs: f }
    }
}

impl Function {
    pub fn new(name: Symbol) -> Function {
        Function {
            cfg: Graph::new(),
            name: name,
            root: 0,
            types: HashMap::new(),
            loops: HashMap::new(),
            analysis: ssa::Analysis::new(),
        }
    }
}

impl Graphable for Program {
    fn dot(&self, out: &mut io::Write) -> io::Result<()> {
        try!(out.write_all(b"digraph {\n"));
        for f in self.funs.iter() {
            try!(f.cfg.dot(out,
                           &mut |id| format!("{}_n{}", f.name, id),
                           &mut |id, stms| {
                               format!("label=\"{}\n[node={}]\" shape=box",
                                       stms.iter().map(|s| s.to_string())
                                           .collect::<Vec<_>>().join("\\n"),
                                       id)
                           },
                           &mut |edge| format!("label={:?}", edge)
                          ));
        }
        out.write_all(b"\n}")
    }
}

impl Binop {
    pub fn associative(&self) -> bool {
        match *self {
            Binop::Add |
            Binop::Mul |
            Binop::And |
            Binop::Or |
            Binop::Xor => true,
            _ => false
        }
    }

    pub fn commutative(&self) -> bool {
        match *self {
            Binop::Add |
            Binop::Mul |
            Binop::Eq |
            Binop::Neq |
            Binop::And |
            Binop::Or |
            Binop::Xor => true,
            _ => false
        }
    }
}

impl Stmt {
    pub fn map_temps(&mut self,
                     uses: &mut FnMut(Temp) -> Temp,
                     defs: &mut FnMut(Temp) -> Temp) {
        match *self {
            Stmt::Load(ref mut tmp, ref mut e) |
            Stmt::Move(ref mut tmp, ref mut e) => {
                e.map_temps(uses);
                *tmp = defs(*tmp);
            }
            Stmt::Store(ref mut e1, ref mut e2) => {
                e1.map_temps(uses);
                e2.map_temps(uses);
            }
            Stmt::Condition(ref mut e) |
            Stmt::Return(ref mut e) |
            Stmt::Die(ref mut e) => e.map_temps(uses),
            Stmt::Call(ref mut tmp, ref mut e, ref mut args) => {
                e.map_temps(uses);
                for arg in args {
                    arg.map_temps(uses);
                }
                *tmp = defs(*tmp);
            }
            Stmt::Arguments(ref mut tmps) => {
                for tmp in tmps {
                    *tmp = defs(*tmp);
                }
            }
            Stmt::Phi(ref mut def, ref mut map) => {
                for (_, v) in map {
                    *v = uses(*v);
                }
                *def = defs(*def);
            }
            Stmt::Cast(ref mut t1, ref mut t2) => {
                assert!(t1 != t2);
                *t1 = defs(*t1);
                *t2 = uses(*t2);
            }
        }
    }

    pub fn each_def(&self, f: &mut FnMut(Temp)) {
        match *self {
            Stmt::Load(tmp, _) |
            Stmt::Move(tmp, _) |
            Stmt::Call(tmp, _, _) |
            Stmt::Phi(tmp, _) |
            Stmt::Cast(tmp, _) => { f(tmp) }
            Stmt::Arguments(ref tmps) => {
                for tmp in tmps {
                    f(*tmp);
                }
            }
            _ => ()
        }
    }

    pub fn each_use(&self, f: &mut FnMut(Temp)) {
        match *self {
            Stmt::Move(_, ref e) |
            Stmt::Load(_, ref e) |
            Stmt::Condition(ref e) |
            Stmt::Return(ref e) |
            Stmt::Die(ref e) => e.each_temp(f),
            Stmt::Store(ref e1, ref e2) => {
                e1.each_temp(f);
                e2.each_temp(f);
            }
            Stmt::Call(_, ref e, ref args) => {
                e.each_temp(f);
                for e in args {
                    e.each_temp(f) ;
                }
            }
            Stmt::Phi(_, ref map) => {
                for (_, &v) in map.iter() {
                    f(v)
                }
            }
            Stmt::Cast(_, t) => { f(t) }
            Stmt::Arguments(..) => ()
        }
    }
}

pub struct Info;

impl ssa::Statement<Stmt> for Info {
    fn map_temps(&self, s: &mut Stmt,
                 uses: &mut FnMut(Temp) -> Temp,
                 defs: &mut FnMut(Temp) -> Temp) {
        s.map_temps(uses, defs)
    }

    fn each_def(&self, s: &Stmt, f: &mut FnMut(Temp)) { s.each_def(f) }
    fn each_use(&self, s: &Stmt, f: &mut FnMut(Temp)) { s.each_use(f) }

    fn new_phi(&self, t: Temp, map: ssa::PhiMap) -> Stmt {
        Stmt::Phi(t, map)
    }

    fn phi<'r>(&self, me: &'r Stmt) -> Option<(Temp, &'r ssa::PhiMap)> {
        match *me {
            Stmt::Phi(d, ref m) => Some((d, m)),
            _ => None
        }
    }
    fn phi_mut<'r>(&self, me: &'r mut Stmt)
                   -> Option<(Temp, &'r mut ssa::PhiMap)> {
        match *me {
            Stmt::Phi(d, ref mut m) => Some((d, m)),
            _ => None
        }
    }
    fn into_phi(&self, me: Stmt) -> Result<(Temp, ssa::PhiMap), Stmt> {
        match me {
            Stmt::Phi(d, m) => Ok((d, m)),
            _ => Err(me)
        }
    }
}

impl fmt::Display for Stmt {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Stmt::Move(tmp, ref e) => write!(f, "{} <- {}", tmp, e),
            Stmt::Cast(t1, t2) => write!(f, "{} < cast - {}", t1, t2),
            Stmt::Load(tmp, ref e) => write!(f, "load {} <- {}", tmp, e),
            Stmt::Store(ref e1, ref e2) => write!(f, "store {} <- {}", e1, e2),
            Stmt::Condition(ref e) => write!(f, "cond {}", e),
            Stmt::Return(ref e) => write!(f, "return {}", e),
            Stmt::Die(ref e) => write!(f, "die if {}", e),
            Stmt::Call(t, ref e, ref args) => {
                write!(f, "{} <- {}({})", t, e, CommaSep(args))
            }
            Stmt::Phi(tmp, ref map) => {
                try!(write!(f, "{} <- phi(", tmp));
                for (&id, &tmp) in map.iter() {
                    try!(write!(f, "[ {} - n{} ] ", tmp, id));
                }
                write!(f, ")")
            }
            Stmt::Arguments(ref tmps) => write!(f, "args {}", CommaSep(tmps)),
        }
    }
}

impl Expr {
    pub fn map_temps(&mut self, f: &mut FnMut(Temp) -> Temp) {
        match *self {
            Expr::BinaryOp(_, ref mut e1, ref mut e2) => {
                e1.map_temps(f);
                e2.map_temps(f);
            }
            Expr::Temp(ref mut tmp) => *tmp = f(*tmp),
            Expr::Const(..) |
            Expr::Label(..) => {}
        }
    }

    pub fn each_temp(&self, f: &mut FnMut(Temp)) {
        match *self {
            Expr::Const(..) |
            Expr::Label(..) => (),
            Expr::BinaryOp(_, ref e1, ref e2) => {
                e1.each_temp(f);
                e2.each_temp(f);
            }
            Expr::Temp(tmp) => { f(tmp) }
        }
    }

    pub fn size(&self, tmps: &HashMap<Temp, Type>) -> Type {
        match *self {
            Expr::Const(_, size) => size,
            Expr::Label(_) => Type::Pointer,
            Expr::BinaryOp(Binop::Eq, _, _) |
            Expr::BinaryOp(Binop::Neq, _, _) => Type::Int,
            Expr::BinaryOp(_, ref e1, ref e2) => {
                let left = e1.size(tmps);
                assert!(left == e2.size(tmps));
                left
            }
            Expr::Temp(ref t) => tmps[t]
        }
    }
}

impl fmt::Display for Expr {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Expr::Temp(ref t) => write!(f, "{}", t),
            Expr::Const(c, _) => write!(f, "0x{:x}", c),
            Expr::Label(ref l) => write!(f, "{}", l),
            Expr::BinaryOp(op, ref e1, ref e2) => {
                write!(f, "({} {} {})", e1, op, e2)
            }
        }
    }
}

impl fmt::Display for Binop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Binop::Add => "+".fmt(f),
            Binop::Sub => "-".fmt(f),
            Binop::Mul => "*".fmt(f),
            Binop::Div => "/".fmt(f),
            Binop::Mod => "%".fmt(f),
            Binop::Lt  => "<".fmt(f),
            Binop::Lte => "<=".fmt(f),
            Binop::Gt  => ">".fmt(f),
            Binop::Gte => ">=".fmt(f),
            Binop::Eq  => "==".fmt(f),
            Binop::Neq => "!=".fmt(f),
            Binop::And => "&".fmt(f),
            Binop::Or  => "|".fmt(f),
            Binop::Xor => "^".fmt(f),
            Binop::Lsh => "<<".fmt(f),
            Binop::Rsh => ">>".fmt(f),
        }
    }
}

pub fn ssa(p: &mut Program) {
    for f in p.funs.iter_mut() {
        ssa_fun(f);
    }
}

fn ssa_fun(f: &mut Function) {
    // tables/metadata altered through temp remapping
    let mut newtypes = HashMap::new();

    // And, convert!
    let mapping = ssa::convert(&mut f.cfg, f.root, &mut f.analysis, &Info);
    for (&new, old) in mapping.iter() {
        newtypes.insert(new, f.types[old]);
    }
    // update all type information for the new temps
    f.types.clear();
    for (k, v) in newtypes {
        f.types.insert(k, v);
    }
}
