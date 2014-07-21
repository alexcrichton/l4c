use std::cell::{RefCell, Cell};
use std::collections::{HashSet, HashMap};
use std::fmt;
use std::io;
use std::mem;

use front::die;
use front::mark;
use front::mark::Marked;

pub struct Program {
    pub decls: Vec<Box<GDecl>>,
    pub mainid: Ident,
    symbols: Vec<String>,
    positions: Vec<mark::Coords>,
    errored: Cell<bool>,
}

struct Elaborator<'a> {
    efuns:   HashSet<Ident>,
    funs:    HashSet<Ident>,
    structs: HashSet<Ident>,
    types:   HashMap<Ident, Type>,
    program: &'a mut Program,
}

#[deriving(Hash, Clone, Eq, PartialEq, Show)]
pub struct Ident(pub uint);

pub type GDecl = Marked<gdecl>;

#[deriving(PartialEq)]
#[allow(non_camel_case_types)]
pub enum gdecl {
    Typedef(Ident, Type),
    StructDef(Ident, Vec<(Ident, Type)>),
    StructDecl(Ident),
    Function(Type, Ident, Vec<(Ident, Type)>, Box<Statement>),
    FunIDecl(Type, Ident, Vec<(Ident, Type)>),
    FunEDecl(Type, Ident, Vec<(Ident, Type)>)
}

pub type Statement = Marked<stmt>;

#[deriving(Clone, PartialEq)]
#[allow(non_camel_case_types)]
pub enum stmt {
    Assign(Box<Expression>, Option<Binop>, Box<Expression>),
    If(Box<Expression>, Box<Statement>, Box<Statement>),
    While(Box<Expression>, Box<Statement>),
    For(Box<Statement>, Box<Expression>, Box<Statement>, Box<Statement>),
    Express(Box<Expression>),
    Continue,
    Break,
    Nop,
    Return(Box<Expression>),
    Seq(Box<Statement>, Box<Statement>),
    Declare(Ident, Type, Option<Box<Expression>>, Box<Statement>),
}

pub type Expression = Marked<expr>;

#[deriving(Clone, PartialEq)]
#[allow(non_camel_case_types)]
pub enum expr {
    Var(Ident),
    Boolean(bool),
    Const(i32),
    BinaryOp(Binop, Box<Expression>, Box<Expression>),
    UnaryOp(Unop, Box<Expression>),
    Ternary(Box<Expression>, Box<Expression>, Box<Expression>, RefCell<Option<Type>>),
    Call(Box<Expression>, Vec<Box<Expression>>, RefCell<Option<Type>>),
    Deref(Box<Expression>, RefCell<Option<Type>>),
    Field(Box<Expression>, Ident, RefCell<Option<Ident>>),
    ArrSub(Box<Expression>, Box<Expression>, RefCell<Option<Type>>),
    Alloc(Type),
    AllocArray(Type, Box<Expression>),
    Null,
}

#[deriving(Clone, Eq, Show)]
pub enum Type {
    Int, Bool, Alias(Ident), Pointer(Box<Type>), Array(Box<Type>),
    Struct(Ident), Nullp, Fun(Box<Type>, Vec<Type>)
}

#[deriving(PartialEq, Eq, Clone)]
pub enum Binop {
    Plus, Minus, Times, Divide, Modulo, Less, LessEq, Greater, GreaterEq,
    Equals, NEquals, LAnd, LOr, BAnd, BOr, Xor, LShift, RShift
}

#[deriving(PartialEq, Eq, Clone)]
pub enum Unop {
    Negative, Invert, Bang
}

impl Program {
    pub fn new(decls: Vec<Box<GDecl>>, mut syms: Vec<String>,
               p: Vec<mark::Coords>) -> Program {
        let main = &"main".to_string();
        let mainid = match syms.iter().position(|s| s.eq(main)) {
            Some(i) => Ident(i),
            None => {
                syms.push("main".to_string());
                Ident(syms.len() - 1)
            }
        };
        Program{ decls: decls, symbols: syms, mainid: mainid, positions: p,
        errored: Cell::new(false) }
    }

    pub fn elaborate(&mut self) {
        let prev = mem::replace(&mut self.decls, Vec::new());
        let decls;
        {
            let mut e = Elaborator{ efuns:   HashSet::new(),
            funs:    HashSet::new(),
            structs: HashSet::new(),
            types:   HashMap::new(),
            program: self };
            decls = e.run(prev);
        }
        self.decls = decls;
    }

    pub fn str<'a>(&'a self, id: Ident) -> &'a str {
        let Ident(n) = id;
        self.symbols[n].as_slice()
    }

    pub fn error<T: Str>(&self, m: mark::Mark, msg: T) {
        let mut out = io::stderr();
        if m == mark::dummy {
            out.write_str(format!("error: {}\n", msg.as_slice()).as_slice()).unwrap();
        } else {
            match self.positions[m] {
                mark::Coords(((l1, c1), (l2, c2)), ref file) => {
                    out.write_str(format!("{}:{}.{}-{}.{}:error: {}\n",
                                          *file, l1, c1, l2,
                                          c2, msg.as_slice()).as_slice()).unwrap();
                }
            }
        }
        self.errored.set(true);
    }

    pub fn die<T: Str>(&self, m: mark::Mark, msg: T) -> ! {
        self.error(m, msg);
        die()
    }

    pub fn check(&self) {
        if self.errored.get() {
            die()
        }
    }
}

impl PartialEq for Program {
    fn eq(&self, other: &Program) -> bool { self.decls == other.decls }
}

impl fmt::Show for Program {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        use front::pp::WithAST;
        for decl in self.decls.iter() {
            try!(write!(f, "{}\n", WithAST(decl, self)));
        }
        Ok(())
    }
}

impl<'a> Elaborator<'a> {
    fn run(&mut self, decls: Vec<Box<GDecl>>) -> Vec<Box<GDecl>> {
        let decls = decls.move_iter().map(|x| self.elaborate(x)).collect();
        self.program.check();
        return decls;
    }
    fn elaborate(&mut self, g: Box<GDecl>) -> Box<GDecl> {
        /* TODO(#4653): in this macro, it should be $id instead of 'id' */
        macro_rules! check_set (
            ($set:expr, $id:expr, $name:expr, $span:expr) => {
                if $set.contains(&$id) {
                    self.program.error($span, format!("'{}' already a {}",
                                                      self.program.str($id),
                                                      $name).as_slice());
                }
            }
        );
        let span = g.span;
        let node = match g.unwrap() {
            FunEDecl(typ, id, args) => {
                self.check_id(span, id);
                self.efuns.insert(id);
                FunEDecl(self.resolve(span, typ), id,
                         self.resolve_pairs(span, args))
            }
            FunIDecl(typ, id, args) => {
                self.check_id(span, id);
                FunIDecl(self.resolve(span, typ), id,
                         self.resolve_pairs(span, args))
            }
            Typedef(id, typ) => {
                self.check_id(span, id);
                check_set!(self.efuns, id, "function", span);
                check_set!(self.efuns, id, "function", span);
                check_set!(self.funs, id, "function", span);
                let typ = self.resolve(span, typ);
                self.types.insert(id, typ.clone());
                Typedef(id, typ)
            }
            StructDef(id, fields) => {
                check_set!(self.structs, id, "struct", span);
                self.structs.insert(id);
                StructDef(id, self.resolve_pairs(span, fields))
            }
            Function(ret, id, args, body) => {
                self.check_id(span, id);
                check_set!(self.efuns, id, "function", span);
                check_set!(self.funs, id, "function", span);
                self.funs.insert(id);
                Function(self.resolve(span, ret), id,
                         self.resolve_pairs(span, args),
                         self.elaborate_stm(body))
            }
            StructDecl(id) => StructDecl(id),
        };
        return box Marked::new(node, span);
    }

    fn elaborate_stm(&mut self, s: Box<Statement>) -> Box<Statement> {
        let span = s.span;
        let node = match s.unwrap() {
            Continue => Continue,
            Break => Break,
            Nop => Nop,
            Declare(id, typ, init, rest) => {
                let rest = self.elaborate_stm(rest);
                self.declare(id, span, typ, init, rest)
            }
            For(box Marked{ node: Declare(id, typ, init, s1), span: dspan},
                e1, s2, s3) => {
                let f = box Marked::new(For(s1, e1, s2, s3), span);
                let d = box Marked::new(Declare(id, typ, init, f), dspan);
                return self.elaborate_stm(d);
            }
            For(s1, e1, s2, s3) => {
                match s2 {
                    box Marked{ node: Declare(..), span } => {
                        self.program.error(span, "declarations not allowed in \
                                                  for-loop steps")
                    }
                    _ => {}
                }
                For(self.elaborate_stm(s1), self.elaborate_exp(e1),
                    self.elaborate_stm(s2), self.elaborate_stm(s3))
            }
            If(e, s1, s2) =>
                If(self.elaborate_exp(e), self.elaborate_stm(s1),
                    self.elaborate_stm(s2)),
            While(e, s) => While(self.elaborate_exp(e), self.elaborate_stm(s)),
            Return(e) => Return(self.elaborate_exp(e)),
            Express(e) => Express(self.elaborate_exp(e)),
            Seq(s1, s2) => Seq(self.elaborate_stm(s1), self.elaborate_stm(s2)),
            Assign(box Marked{ node: Var(id), span: e1span }, Some(o), e2) => {
                let e2span = e2.span;
                let v = box Marked::new(Var(id), e1span);
                let b = box Marked::new(BinaryOp(o, v.clone(), e2), e2span);
                let e = box Marked::new(Assign(v, None, b), span);
                return self.elaborate_stm(e);
            }
            Assign(e1, o, e2) =>
                Assign(self.elaborate_exp(e1), o, self.elaborate_exp(e2)),
        };
        return box Marked::new(node, span);
    }

    fn declare(&mut self, id: Ident, m: mark::Mark, typ: Type,
               init: Option<Box<Expression>>, rest: Box<Statement>) -> stmt {
        self.check_id(m, id);
        Declare(id, self.resolve(m, typ),
        init.map(|x| self.elaborate_exp(x)), rest)
    }

    fn elaborate_exp(&mut self, e: Box<Expression>) -> Box<Expression> {
        let span = e.span;
        let node = match e.unwrap() {
            Var(id) => Var(id),
            Boolean(b) => Boolean(b),
            Const(c) => Const(c),
            Null => Null,
            UnaryOp(o, e) =>
                UnaryOp(o, self.elaborate_exp(e)),
            BinaryOp(o, e1, e2) =>
                BinaryOp(o, self.elaborate_exp(e1), self.elaborate_exp(e2)),
            Ternary(e1, e2, e3, _) =>
                Ternary(self.elaborate_exp(e1), self.elaborate_exp(e2),
                        self.elaborate_exp(e3), RefCell::new(None)),
            Call(id, l, _) =>
                Call(id, l.move_iter().map(|x| self.elaborate_exp(x)).collect(),
                     RefCell::new(None)),
            Deref(e, _) => Deref(self.elaborate_exp(e), RefCell::new(None)),
            Field(e, id, _) => Field(self.elaborate_exp(e), id,
                                     RefCell::new(None)),
            ArrSub(e1, e2, _) =>
                ArrSub(self.elaborate_exp(e1), self.elaborate_exp(e2),
                       RefCell::new(None)),
            Alloc(t) => Alloc(self.resolve(span, t)),
            AllocArray(t, e) => AllocArray(self.resolve(span, t),
                                           self.elaborate_exp(e))
        };
        return box Marked::new(node, span);
    }

    fn check_id(&mut self, m: mark::Mark, s: Ident) {
        if self.types.contains_key(&s) {
            self.program.error(m, format!("'{}' already a type",
                                          self.program.str(s)).as_slice());
        }
    }

    fn resolve(&mut self, m: mark::Mark, t: Type) -> Type {
        match t {
            Int | Bool | Nullp | Struct(_) => t,
            Pointer(t) => Pointer(box self.resolve(m, *t)),
            Array(t) => Array(box self.resolve(m, *t)),
            Alias(sym) => match self.types.find(&sym) {
                Some(t) => t.clone(),
                None    => {
                    self.program.error(m, format!("'{}' is undefined",
                                                  self.program.str(sym))
                                            .as_slice());
                    t
                }
            },
            Fun(t1, l) => Fun(box self.resolve(m, *t1),
                              l.move_iter().map(|t| self.resolve(m, t)).collect())
        }
    }

    fn resolve_pairs(&mut self, m: mark::Mark,
                     pairs: Vec<(Ident, Type)>) -> Vec<(Ident, Type)> {
        pairs.move_iter().map(|(id, typ)| (id, self.resolve(m, typ)))
             .collect()
    }
}

impl expr {
    pub fn lvalue(&self) -> bool {
        match *self {
            Var(_)              => true,
            Field(ref e, _, _)  => e.node.lvalue(),
            Deref(ref e, _)     => e.node.lvalue(),
            ArrSub(ref e, _, _) => e.node.lvalue(),
            _                   => false
        }
    }
}

impl Type {
    pub fn small(&self) -> bool {
        match *self {
            Struct(_) => false,
            _ => true
        }
    }
}

impl PartialEq for Type {
    fn eq(&self, other: &Type) -> bool {
        match (self, other) {
            (&Bool, &Bool) | (&Int, &Int) | (&Nullp, &Nullp) => true,
            (&Nullp, &Pointer(_)) | (&Pointer(_), &Nullp) => true,
            (&Pointer(ref t1), &Pointer(ref t2)) => t1.eq(t2),
            (&Array(ref t1), &Array(ref t2)) => t1.eq(t2),
            (&Struct(ref s1), &Struct(ref s2)) => s1.eq(s2),
            (&Fun(ref t1, ref l1), &Fun(ref t2, ref l2)) =>
                t1 == t2 && l1.len() == l2.len() &&
                l1.iter().zip(l2.iter()).all(|(a, b)| a == b),
            _ => false
        }
    }
}
