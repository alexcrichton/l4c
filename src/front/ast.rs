use std::cell::RefCell;
use std::collections::{HashSet, HashMap};
use std::fmt;
use std::mem;

use utils::{Marked, Mark, Symbol, Errors};

pub struct Program {
    pub decls: Vec<Item>,
    errors: Errors,
}

struct Elaborator<'a> {
    efuns:   HashSet<Ident>,
    funs:    HashSet<Ident>,
    structs: HashSet<Ident>,
    types:   HashMap<Ident, Type>,
    errors: &'a Errors,
}

pub type Ident = Symbol;

pub type Item = Marked<Item_>;

#[derive(PartialEq)]
pub enum Item_ {
    Typedef(Ident, Type),
    StructDef(Ident, Vec<(Ident, Type)>),
    StructDecl(Ident),
    Function(Type, Ident, Vec<(Ident, Type)>, Stmt),
    FunIDecl(Type, Ident, Vec<(Ident, Type)>),
    FunEDecl(Type, Ident, Vec<(Ident, Type)>)
}

pub type Stmt = Marked<Stmt_>;

#[derive(Clone, PartialEq)]
pub enum Stmt_ {
    Assign(Expr, Option<Binop>, Expr),
    If(Expr, Box<Stmt>, Box<Stmt>),
    While(Expr, Box<Stmt>),
    For(Box<Stmt>, Expr, Box<Stmt>, Box<Stmt>),
    Express(Expr),
    Continue,
    Break,
    Nop,
    Return(Expr),
    Seq(Box<Stmt>, Box<Stmt>),
    Declare(Ident, Type, Option<Expr>, Box<Stmt>),
}

pub type Expr = Marked<Expr_>;

#[derive(Clone, PartialEq)]
pub enum Expr_ {
    Var(Ident),
    Boolean(bool),
    Const(i32),
    BinaryOp(Binop, Box<Expr>, Box<Expr>),
    UnaryOp(Unop, Box<Expr>),
    Ternary(Box<Expr>, Box<Expr>, Box<Expr>, RefCell<Option<Type>>),
    Call(Box<Expr>, Vec<Expr>, RefCell<Option<Type>>),
    Deref(Box<Expr>, RefCell<Option<Type>>),
    Field(Box<Expr>, Ident, RefCell<Option<Ident>>),
    ArrSub(Box<Expr>, Box<Expr>, RefCell<Option<Type>>),
    Alloc(Type),
    AllocArray(Type, Box<Expr>),
    Null,
}

#[derive(Clone, Eq, Debug)]
pub enum Type {
    Int, Bool, Alias(Ident), Pointer(Box<Type>), Array(Box<Type>),
    Struct(Ident), Nullp, Fun(Box<Type>, Vec<Type>)
}

#[derive(PartialEq, Eq, Clone, Copy)]
pub enum Binop {
    Plus, Minus, Times, Divide, Modulo, Less, LessEq, Greater, GreaterEq,
    Equals, NEquals, LAnd, LOr, BAnd, BOr, Xor, LShift, RShift
}

#[derive(PartialEq, Eq, Clone, Copy)]
pub enum Unop {
    Negative, Invert, Bang
}

impl Program {
    pub fn new(decls: Vec<Item>, errors: Errors) -> Program {
        Program { decls: decls, errors: errors }
    }

    pub fn elaborate(&mut self) {
        let mut e = Elaborator {
            efuns: HashSet::new(),
            funs: HashSet::new(),
            structs: HashSet::new(),
            types: HashMap::new(),
            errors: &self.errors,
        };
        e.run(&mut self.decls);
    }

    pub fn errors(&self) -> &Errors { &self.errors }
}

impl PartialEq for Program {
    fn eq(&self, other: &Program) -> bool { self.decls == other.decls }
}

impl fmt::Display for Program {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        for decl in self.decls.iter() {
            try!(write!(f, "{}\n", decl));
        }
        Ok(())
    }
}

impl<'a> Elaborator<'a> {
    fn run(&mut self, decls: &mut [Item]) {
        for decl in decls {
            self.elaborate(decl);
        }
        self.errors.check();
    }

    fn elaborate(&mut self, g: &mut Item) {
        macro_rules! check_set (
            ($set:expr, $id:expr, $name:expr, $mark:expr) => {
                if $set.contains(&$id) {
                    self.errors.add($mark, &format!("'{}' already a {}",
                                                    $id, $name));
                }
            }
        );
        match g.node {
            Item_::FunEDecl(ref mut typ, id, ref mut args) => {
                self.check_id(g.mark, id);
                self.efuns.insert(id);
                self.resolve(g.mark, typ);
                self.resolve_pairs(g.mark, args);
            }
            Item_::FunIDecl(ref mut typ, id, ref mut args) => {
                self.check_id(g.mark, id);
                self.resolve(g.mark, typ);
                self.resolve_pairs(g.mark, args);
            }
            Item_::Typedef(id, ref mut typ) => {
                self.check_id(g.mark, id);
                check_set!(self.efuns, id, "function", g.mark);
                check_set!(self.efuns, id, "function", g.mark);
                check_set!(self.funs, id, "function", g.mark);
                self.resolve(g.mark, typ);
                self.types.insert(id, typ.clone());
            }
            Item_::StructDef(id, ref mut fields) => {
                check_set!(self.structs, id, "struct", g.mark);
                self.structs.insert(id);
                self.resolve_pairs(g.mark, fields);
            }
            Item_::Function(ref mut ret, id, ref mut args, ref mut body) => {
                self.check_id(g.mark, id);
                check_set!(self.efuns, id, "function", g.mark);
                check_set!(self.funs, id, "function", g.mark);
                self.funs.insert(id);
                self.resolve(g.mark, ret);
                self.resolve_pairs(g.mark, args);
                self.elaborate_stm(body);
            }
            Item_::StructDecl(..) => {}
        }
    }

    fn elaborate_stm(&mut self, s: &mut Stmt) {
        match s.node {
            Stmt_::Continue |
            Stmt_::Break |
            Stmt_::Nop => {}
            Stmt_::Declare(id, ref mut typ, ref mut init, ref mut rest) => {
                self.elaborate_stm(rest);
                self.check_id(s.mark, id);
                self.resolve(s.mark, typ);
                if let Some(ref mut e) = *init {
                    self.elaborate_exp(e);
                }
            }
            Stmt_::For(..) => {
                let parts = match mem::replace(&mut s.node, Stmt_::Nop) {
                    Stmt_::For(a, b, c, d) => (a, b, c, d),
                    _ => panic!(),
                };
                let (mut s1, mut e1, mut s2, mut s3) = parts;
                self.elaborate_stm(&mut s1);
                self.elaborate_exp(&mut e1);
                self.elaborate_stm(&mut s2);
                self.elaborate_stm(&mut s3);
                if let Stmt_::Declare(..) = s2.node {
                    self.errors.add(s2.mark, "declarations not allowed \
                                              in for-loop steps")
                }
                s.node = match mem::replace(&mut s1.node, Stmt_::Nop) {
                    Stmt_::Declare(id, typ, init, s1_new) => {
                        s1.node = Stmt_::For(s1_new, e1, s2, s3);
                        Stmt_::Declare(id, typ, init, s1)
                    }
                    other => {
                        s1.node = other;
                        Stmt_::For(s1, e1, s2, s3)
                    }
                };
            }
            Stmt_::If(ref mut e, ref mut s1, ref mut s2) => {
                self.elaborate_exp(e);
                self.elaborate_stm(s1);
                self.elaborate_stm(s2);
            }
            Stmt_::While(ref mut e, ref mut s) => {
                self.elaborate_exp(e);
                self.elaborate_stm(s);
            }
            Stmt_::Express(ref mut e) |
            Stmt_::Return(ref mut e) => self.elaborate_exp(e),
            Stmt_::Seq(ref mut s1, ref mut s2) => {
                self.elaborate_stm(s1);
                self.elaborate_stm(s2);
            }
            Stmt_::Assign(ref mut e1, ref mut o, ref mut e2) => {
                self.elaborate_exp(e1);
                self.elaborate_exp(e2);
                if let Expr_::Var(..) = e1.node {
                    if let Some(op) = mem::replace(o, None) {
                        let left = Box::new(e1.clone());
                        let right = mem::replace(&mut e2.node, Expr_::Null);
                        let right = Box::new(Marked::new(right, e2.mark));
                        e2.node = Expr_::BinaryOp(op, left, right);
                    }
                }
            }
        }
    }

    fn elaborate_exp(&mut self, e: &mut Expr) {
        match e.node {
            Expr_::Var(..) |
            Expr_::Boolean(..) |
            Expr_::Const(..) |
            Expr_::Null => {}

            Expr_::Deref(ref mut e, _) |
            Expr_::Field(ref mut e, _, _) |
            Expr_::UnaryOp(_, ref mut e) => {
                self.elaborate_exp(e);
            }

            Expr_::ArrSub(ref mut e1, ref mut e2, _) |
            Expr_::BinaryOp(_, ref mut e1, ref mut e2) => {
                self.elaborate_exp(e1);
                self.elaborate_exp(e2);
            }

            Expr_::Ternary(ref mut e1, ref mut e2, ref mut e3, _) => {
                self.elaborate_exp(e1);
                self.elaborate_exp(e2);
                self.elaborate_exp(e3);
            }

            Expr_::Call(_, ref mut l, _) => {
                for slot in l {
                    self.elaborate_exp(slot);
                }
            }
            Expr_::Alloc(ref mut t) => self.resolve(e.mark, t),
            Expr_::AllocArray(ref mut t, ref mut e) => {
                self.resolve(e.mark, t);
                self.elaborate_exp(e);
            }
        }
    }

    fn check_id(&mut self, m: Mark, s: Ident) {
        if self.types.contains_key(&s) {
            self.errors.add(m, &format!("'{}' already a type", s));
        }
    }

    fn resolve(&mut self, m: Mark, t: &mut Type) {
        match *t {
            Type::Int |
            Type::Bool |
            Type::Nullp |
            Type::Struct(_) => {}
            Type::Pointer(ref mut t) => self.resolve(m, t),
            Type::Array(ref mut t) => self.resolve(m, t),
            Type::Alias(sym) => match self.types.get(&sym) {
                Some(resolved) => *t = resolved.clone(),
                None => {
                    self.errors.add(m, &format!("'{}' is undefined", sym));
                }
            },
            Type::Fun(ref mut t1, ref mut l) => {
                self.resolve(m, t1);
                for slot in l {
                    self.resolve(m, slot);
                }
            }
        }
    }

    fn resolve_pairs(&mut self, m: Mark, pairs: &mut [(Ident, Type)]) {
        for &mut (_, ref mut typ) in pairs {
            self.resolve(m, typ);
        }
    }
}

impl Expr_ {
    pub fn lvalue(&self) -> bool {
        match *self {
            Expr_::Var(_)              => true,
            Expr_::Field(ref e, _, _)  => e.node.lvalue(),
            Expr_::Deref(ref e, _)     => e.node.lvalue(),
            Expr_::ArrSub(ref e, _, _) => e.node.lvalue(),
            _                   => false
        }
    }
}

impl Type {
    pub fn small(&self) -> bool {
        match *self {
            Type::Struct(_) => false,
            _ => true
        }
    }
}

impl PartialEq for Type {
    fn eq(&self, other: &Type) -> bool {
        match (self, other) {
            (&Type::Bool, &Type::Bool) |
            (&Type::Int, &Type::Int) |
            (&Type::Nullp, &Type::Nullp) => true,
            (&Type::Nullp, &Type::Pointer(_)) |
            (&Type::Pointer(_), &Type::Nullp) => true,
            (&Type::Pointer(ref t1), &Type::Pointer(ref t2)) => t1 == t2,
            (&Type::Array(ref t1), &Type::Array(ref t2)) => t1 == t2,
            (&Type::Struct(ref s1), &Type::Struct(ref s2)) => s1 == s2,
            (&Type::Fun(ref t1, ref l1), &Type::Fun(ref t2, ref l2)) => {
                t1 == t2 && l1 == l2
            }
            _ => false
        }
    }
}
