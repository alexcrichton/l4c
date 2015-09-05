use std::collections::{HashMap, HashSet};

use front::ast::{self, Expr_, Stmt_, Item_, Type, Unop, Binop};
use utils::{Mark, Errors};

struct Typechecker<'a> {
    program: &'a ast::Program,
    funs: HashMap<ast::Ident, (Type, Vec<Type>)>,
    structs: HashMap<ast::Ident, Option<HashMap<ast::Ident, Type>>>,
    vars: HashMap<ast::Ident, Type>,
    loops: u32,
    ret: Type,
}

pub fn check(a: &ast::Program) {
    let mut tc = Typechecker {
        program: a,
        funs: HashMap::new(),
        structs: HashMap::new(),
        vars: HashMap::new(),
        loops: 0,
        ret: Type::Nullp,
    };
    debug!("typechecking");
    tc.run()
}

impl<'a> Typechecker<'a> {
    fn run(&mut self) {
        for x in self.program.decls.iter() {
            self.tc_gdecl(x)
        }
        self.errors().check();
    }

    fn tc_gdecl(&mut self, g: &ast::Item) {
        match g.node {
            Item_::Typedef(_, _) => (),
            Item_::StructDecl(id) => {
                if !self.structs.contains_key(&id) {
                    self.structs.insert(id, None);
                }
            }
            Item_::StructDef(id, ref fields) => {
                self.bind_struct(id, g.mark, fields);
            }
            Item_::FunIDecl(ref ret, id, ref args) => {
                self.bind_fun(id, g.mark, ret, args);
            }
            Item_::FunEDecl(ref ret, id, ref args) => {
                self.bind_fun(id, g.mark, ret, args);
            }
            Item_::Function(ref ret, id, ref args, ref body) => {
                if self.bind_fun(id, g.mark, ret, args) {
                    self.vars.clear();
                    for &(id, ref typ) in args.iter() {
                        self.vars.insert(id, typ.clone());
                    }
                    self.ret = ret.clone();
                    self.tc_stm(body);
                }
            }
        }
    }

    fn tc_stm(&mut self, s: &ast::Stmt) {
        let mark = s.mark;
        match s.node {
            Stmt_::Continue |
            Stmt_::Break => {
                if self.loops == 0 {
                    self.errors().add(mark, &format!("'{}' outside of loops \
                                                      isn't allowed", s));
                }
            }
            Stmt_::Nop => {}
            Stmt_::Seq(ref s1, ref s2) => {
                self.tc_stm(s1);
                self.tc_stm(s2);
            }
            Stmt_::Express(ref e) => { self.tc_exp(e); }
            Stmt_::Return(ref e) => {
                let t = self.ret.clone();
                self.tc_ensure(e, &t);
            }
            Stmt_::While(ref e, ref s) => {
                self.tc_ensure(e, &Type::Bool);
                self.loops += 1;
                self.tc_stm(s);
                self.loops -= 1;
            },
            Stmt_::If(ref e, ref s1, ref s2) => {
                self.tc_ensure(e, &Type::Bool);
                self.tc_stm(s1);
                self.tc_stm(s2);
            },
            Stmt_::For(ref s1, ref e, ref s2, ref s3) => {
                self.tc_ensure(e, &Type::Bool);
                self.tc_stm(s1);

                self.loops += 1;
                self.tc_stm(s2);
                self.tc_stm(s3);
                self.loops -= 1;
            },
            Stmt_::Assign(ref e1, _, ref e2) => {
                let t1 = self.tc_exp(e1);
                if !e1.node.lvalue() {
                    self.errors().add(mark, "not an lvalue");
                } else if self.tc_small(mark, &t1) {
                    self.tc_ensure(e2, &t1);
                }
            },
            Stmt_::Declare(id, ref typ, ref init, ref stm) => {
                self.tc_small(mark, typ);
                for x in init.iter() {
                    self.tc_ensure(x, typ);
                }
                if self.vars.contains_key(&id) {
                    self.errors().add(s.mark, &format!("Redeclared var '{}'",
                                                       id));
                } else {
                    self.vars.insert(id, typ.clone());
                    self.tc_stm(stm);
                    self.vars.remove(&id);
                }
            }
        }
    }

    fn tc_exp(&mut self, e: &ast::Expr) -> Type {
        let mark = e.mark;
        match e.node {
            Expr_::Const(_) => Type::Int,
            Expr_::Boolean(_) => Type::Bool,
            Expr_::Null => Type::Nullp,
            Expr_::Var(id) => {
                if let Some(t) = self.vars.get(&id) {
                    return t.clone()
                }
                match self.funs.get(&id) {
                    Some(&(ref ret, ref args)) => {
                        Type::Pointer(Box::new(Type::Fun(Box::new(ret.clone()),
                                                         args.clone())))
                    }
                    None => {
                        self.errors().die(e.mark,
                                          &format!("Unknown variable '{}'", id));
                    }
                }
            }
            Expr_::Alloc(ref t) => {
                self.tc_defined(mark, t);
                Type::Pointer(Box::new(t.clone()))
            }
            Expr_::AllocArray(ref t, ref e) => {
                self.tc_defined(mark, t);
                self.tc_ensure(e, &Type::Int);
                Type::Array(Box::new(t.clone()))
            }
            Expr_::BinaryOp(op, ref e1, ref e2) => {
                match op {
                    Binop::Less | Binop::LessEq |
                    Binop::Greater | Binop::GreaterEq => {
                        self.tc_ensure(e1, &Type::Int);
                        self.tc_ensure(e2, &Type::Int);
                        Type::Bool
                    },
                    Binop::Equals | Binop::NEquals => {
                        let t1 = self.tc_exp(e1);
                        self.tc_small(e1.mark, &t1);
                        self.tc_ensure(e2, &t1);
                        Type::Bool
                    },
                    Binop::LAnd | Binop::LOr => {
                        self.tc_ensure(e1, &Type::Bool);
                        self.tc_ensure(e2, &Type::Bool);
                        Type::Bool
                    },
                    _ => {
                        self.tc_ensure(e1, &Type::Int);
                        self.tc_ensure(e2, &Type::Int);
                        Type::Int
                    }
                }
            }
            Expr_::UnaryOp(op, ref e) => match op {
                Unop::Bang => { self.tc_ensure(e, &Type::Bool); Type::Bool },
                _ => { self.tc_ensure(e, &Type::Int); Type::Int }
            },
            Expr_::Ternary(ref e1, ref e2, ref e3, ref r) => {
                self.tc_ensure(e1, &Type::Bool);
                let t = self.tc_exp(e2);
                self.tc_ensure(e3, &t);
                *r.borrow_mut() = Some(t.clone());
                t
            },
            Expr_::Deref(ref e, ref r) => {
                match self.tc_exp(e) {
                    Type::Pointer(t) => {
                        *r.borrow_mut() = Some((*t).clone());
                        *t
                    }
                    _ => self.errors().die(mark, "must be a pointer type")
                }
            }
            Expr_::ArrSub(ref e1, ref e2, ref r) => {
                match self.tc_exp(e1) {
                    Type::Array(t) => {
                        self.tc_ensure(e2, &Type::Int);
                        *r.borrow_mut() = Some((*t).clone());
                        *t
                    },
                    _ => self.errors().die(mark, "must be an array type")
                }
            }
            Expr_::Call(ref e, ref args, ref r) => {
                match self.tc_exp(e) {
                    Type::Pointer(ty) => {
                        let ty = *ty;
                        if let Type::Fun(ret, argtyps) = ty {
                            if argtyps.len() != args.len() {
                                self.errors().add(mark, "mismatched number of \
                                                           arguments");
                            } else {
                                for (e, t2) in args.iter().zip(argtyps.iter()) {
                                    self.tc_ensure(e, t2);
                                }
                            }
                            *r.borrow_mut() = Some((*ret).clone());
                            *ret
                        } else {
                            self.errors().die(mark, "expected pointer to a \
                                                     function")
                        }
                    },
                    _ => self.errors().die(mark, "expected a pointer to a \
                                                  function type")
                }
            }
            Expr_::Field(ref e, id, ref r) => {
                let err = match self.tc_exp(e) {
                    Type::Struct(s) => {
                        *r.borrow_mut() = Some(s);
                        match self.structs.get(&s) {
                            Some(&Some(ref t)) => match t.get(&id) {
                                Some(t) => { return t.clone(); }
                                None => format!("Unknown field '{}'", id),
                            },
                            _ => format!("Unknown struct '{}'", s),
                        }
                    }
                    _ => format!("must be a struct type")
                };
                self.errors().die(mark, &err);
            }
        }
    }

    fn bind_struct(&mut self, id: ast::Ident, mark: Mark,
                   fields: &[(ast::Ident, Type)]) {
        let redefined = match self.structs.get(&id) {
            Some(&Some(_)) => true,
            _ => false
        };
        if redefined {
            self.errors().add(mark, "Redefined struct");
            return
        }

        /* Build up the table of field => type information */
        let mut table = HashMap::new();
        for &(ref field, ref typ) in fields.iter() {
            if table.contains_key(field) {
                self.errors().add(mark, &format!("Duplicate field: '{}'", field));
                continue
            }
            /* Make sure structs are all defined and not recursive */
            if let Type::Struct(id2) = *typ {
                if id == id2 {
                    self.errors().add(mark, "Cannot define a nested \
                                             structure");
                    continue
                }
            }
            if self.tc_defined(mark, typ) {
                table.insert(*field, typ.clone());
            }
        }
        self.structs.insert(id, Some(table));
    }

    fn bind_fun(&mut self, id: ast::Ident, mark: Mark,
                ret: &Type, args: &[(ast::Ident, Type)]) -> bool {
        let mut names = HashSet::new();
        let mut good = true ;
        for &(name, ref typ) in args.iter() {
            if !names.insert(name) {
                self.errors().add(mark, &format!("Duplicate argument: {}", name));
                good = false;
            }
            good = self.tc_small(mark, typ) && good;
        }
        good = self.tc_small(mark, ret) && good;

        let fun = self.funs.get(&id).map(|x| x.clone());
        match fun {
            Some((ref retp, ref argsp)) => {
                good = self.tc_equal(mark, retp, ret) && good;
                if argsp.len() != args.len() {
                    self.errors().add(mark, "Different number of arguments \
                                             than before");
                    good = false;
                } else {
                    for (expected, &(_, ref got)) in argsp.iter().zip(args) {
                        good = self.tc_equal(mark, expected, got) && good;
                    }
                }
            }
            None => ()
        }

        if good {
            self.funs.insert(id, (ret.clone(), args.iter().map(|x| {
                x.1.clone()
            }).collect()));
        }
        return good;
    }

    fn tc_ensure(&mut self, e: &ast::Expr, t: &Type) {
        let t2 = self.tc_exp(e);
        self.tc_equal(e.mark, t, &t2);
    }

    fn tc_defined(&mut self, m: Mark, t: &Type) -> bool {
        match *t {
            Type::Struct(id) => {
                match self.structs.get(&id) {
                    Some(&Some(_)) => true,
                    _ => {
                        self.errors().add(m, &format!("Struct not defined '{}'",
                                                      id));
                        false
                    }
                }
            },
            _ => true
        }
    }

    fn tc_equal(&mut self, m: Mark, t1: &Type, t2: &Type) -> bool {
        if t1 != t2 {
            self.errors().add(m, &format!("Type mismatch: expected {}, got {}",
                                          t1, t2));
            return false;
        }
        return true;
    }

    fn tc_small(&mut self, m: Mark, t: &Type) -> bool {
        if !t.small() {
            self.errors().add(m, &format!("Type must be small: '{}'", t));
            return false;
        }
        return true;
    }

    fn errors(&self) -> &Errors { self.program.errors() }
}
