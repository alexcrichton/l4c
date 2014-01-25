use std::hashmap::{HashMap, HashSet};

use front::mark::Mark;
use front::ast::*;
use front::pp::PrettyPrintAST;

struct Typechecker<'a> {
  program: &'a Program,
  funs:    HashMap<Ident, (Type, ~[Type])>,
  structs: HashMap<Ident, Option<HashMap<Ident, Type>>>,
  vars:    HashMap<Ident, Type>,
  loops:   int,
  ret:     Type
}

pub fn check(a: &Program) {
  let mut tc = Typechecker{ program: a,
                            funs: HashMap::new(),
                            structs: HashMap::new(),
                            vars: HashMap::new(),
                            loops: 0,
                            ret: Nullp};
  debug!("typechecking");
  tc.run()
}

impl<'a> Typechecker<'a> {
  fn run(&mut self) {
    for x in self.program.decls.iter() {
      self.tc_gdecl(*x)
    }
    self.program.check();
  }

  fn tc_gdecl(&mut self, g: &GDecl) {
    match g.node {
      Typedef(_, _) => (),
      StructDecl(id) => {
        if !self.structs.contains_key(&id) {
          self.structs.insert(id, None);
        }
      }
      StructDef(id, ref fields) => self.bind_struct(id, g.span, *fields),
      FunIDecl(ref ret, id, ref args) => { self.bind_fun(id, g.span, ret, *args); },
      FunEDecl(ref ret, id, ref args) => { self.bind_fun(id, g.span, ret, *args); },
      Function(ref ret, id, ref args, ref body) => {
        if self.bind_fun(id, g.span, ret, *args) {
          self.vars.clear();
          for &(id, ref typ) in args.iter() {
            self.vars.insert(id, typ.clone());
          }
          self.ret = ret.clone();
          self.tc_stm(*body);
        }
      }
    }
  }

  fn tc_stm(&mut self, s: &Statement) {
    let span = s.span;
    match s.node {
      Continue | Break => {
        if self.loops == 0 {
          self.program.error(span, format!("'{}' outside of loops isn't allowed",
                                        s.pp(self.program)));
        }
      },
      Nop => (),
      Seq(ref s1, ref s2) => { self.tc_stm(*s1); self.tc_stm(*s2) },
      Express(ref e) => { self.tc_exp(*e); },
      Return(ref e) => {
        let t = self.ret.clone();
        self.tc_ensure(*e, &t);
      }
      While(ref e, ref s) => {
        self.tc_ensure(*e, &Bool);
        self.loops += 1;
        self.tc_stm(*s);
        self.loops -= 1;
      },
      If(ref e, ref s1, ref s2) => {
        self.tc_ensure(*e, &Bool);
        self.tc_stm(*s1);
        self.tc_stm(*s2);
      },
      For(ref s1, ref e, ref s2, ref s3) => {
        self.tc_ensure(*e, &Bool);
        self.tc_stm(*s1);

        self.loops += 1;
        self.tc_stm(*s2);
        self.tc_stm(*s3);
        self.loops -= 1;
      },
      Assign(ref e1, _, ref e2) => {
        let t1 = self.tc_exp(*e1);
        if !e1.node.lvalue() {
          self.program.error(span, "not an lvalue");
        } else if self.tc_small(span, &t1) {
          self.tc_ensure(*e2, &t1);
        }
      },
      Declare(id, ref typ, ref init, ref stm) => {
        self.tc_small(span, typ);
        for x in init.iter() {
          self.tc_ensure(*x, typ);
        }
        if self.vars.contains_key(&id) {
          self.program.error(s.span, format!("Redeclared var '{}'",
                                          self.program.str(id)));
        } else {
          self.vars.insert(id, typ.clone());
          self.tc_stm(*stm);
          self.vars.remove(&id);
        }
      }
    }
  }

  fn tc_exp(&mut self, e: &Expression) -> Type {
    let span = e.span;
    match e.node {
      Const(_) => Int,
      Boolean(_) => Bool,
      Null => Nullp,
      Var(id) => match self.vars.find(&id) {
        Some(t) => t.clone(),
        None => match self.funs.find(&id) {
          Some(&(ref ret, ref args)) => Pointer(~Fun(~ret.clone(), args.clone())),
          None => self.program.die(e.span, format!("Unknown variable '{}'",
                                                self.program.str(id)))
        }
      },
      Alloc(ref t) => { self.tc_defined(span, t); Pointer(~t.clone()) },
      AllocArray(ref t, ref e) => {
        self.tc_defined(span, t);
        self.tc_ensure(*e, &Int);
        Array(~t.clone())
      },
      BinaryOp(op, ref e1, ref e2) => match op {
        Less | LessEq | Greater | GreaterEq => {
          self.tc_ensure(*e1, &Int);
          self.tc_ensure(*e2, &Int);
          Bool
        },
        Equals | NEquals => {
          let t1 = self.tc_exp(*e1);
          self.tc_small(e1.span, &t1);
          self.tc_ensure(*e2, &t1);
          Bool
        },
        LAnd | LOr => {
          self.tc_ensure(*e1, &Bool);
          self.tc_ensure(*e2, &Bool);
          Bool
        },
        _ => {
          self.tc_ensure(*e1, &Int);
          self.tc_ensure(*e2, &Int);
          Int
        }
      },
      UnaryOp(op, ref e) => match op {
        Bang => { self.tc_ensure(*e, &Bool); Bool },
        _    => { self.tc_ensure(*e, &Int); Int }
      },
      Ternary(ref e1, ref e2, ref e3, ref r) => {
        self.tc_ensure(*e1, &Bool);
        let t = self.tc_exp(*e2);
        self.tc_ensure(*e3, &t);
        *r.borrow_mut().get() = Some(t.clone());
        t
      },
      Deref(ref e, ref r) => match self.tc_exp(*e) {
        Pointer(t) => { *r.borrow_mut().get() = Some((*t).clone()); *t },
        _ => self.program.die(span, "must be a pointer type")
      },
      ArrSub(ref e1, ref e2, ref r) => match self.tc_exp(*e1) {
        Array(t) => {
            self.tc_ensure(*e2, &Int);
            *r.borrow_mut().get() = Some((*t).clone());
            *t
        },
        _ => self.program.die(span, "must be an array type")
      },
      Call(ref e, ref args, ref r) => match self.tc_exp(*e) {
        Pointer(~Fun(ret, argtyps)) => {
          if argtyps.len() != args.len() {
            self.program.error(span, "mismatched number of arguments");
          } else {
            for (e, t2) in args.iter().zip(argtyps.iter()) {
              self.tc_ensure(*e, t2);
            }
          }
          *r.borrow_mut().get() = Some((*ret).clone());
          *ret
        },
        _ => self.program.die(span, "expected a pointer to a function type")
      },
      Field(ref e, id, ref r) => {
        let err = match self.tc_exp(*e) {
          Struct(s) => {
            *r.borrow_mut().get() = Some(s);
            match self.structs.find(&s) {
              Some(&Some(ref t)) => match t.find(&id) {
                Some(t) => { return t.clone(); }
                None => format!("Unknown field '{}'", self.program.str(id))
              },
              _ => format!("Unknown struct '{}'", self.program.str(s))
            }
          }
          _ => format!("must be a struct type")
        };
        self.program.die(span, err);
      }
    }
  }

  fn bind_struct(&mut self, id: Ident, span: Mark, fields: &[(Ident, Type)]) {
    let redefined = match self.structs.find(&id) {
      Some(&Some(_)) => true, _ => false
    };
    if redefined {
      self.program.error(span, "Redefined struct");
      return;
    }

    /* Build up the table of field => type information */
    let mut table = HashMap::new();
    for &(ref field, ref typ) in fields.iter() {
      if table.contains_key(field) {
        self.program.error(span, format!("Duplicate field: '{}'",
                                      self.program.str(*field)));
        continue;
      }
      /* Make sure structs are all defined and not recursive */
      match *typ {
        Struct(id2) =>
          if id == id2 {
            self.program.error(span, "Cannot define a nested structure");
            continue;
          },
        _ => ()
      }
      if self.tc_defined(span, typ) {
        table.insert(*field, typ.clone());
      }
    }
    self.structs.insert(id, Some(table));
  }

  fn bind_fun(&mut self, id: Ident, span: Mark,
              ret: &Type, args: &[(Ident, Type)]) -> bool {
    let mut names = HashSet::new();
    let mut good = true ;
    for &(name, ref typ) in args.iter() {
      if !names.insert(name) {
        self.program.error(span, format!("Duplicate argument: {}",
                                      self.program.str(name)));
        good = false;
      }
      good = self.tc_small(span, typ) && good;
    }
    good = self.tc_small(span, ret) && good;

    let fun = self.funs.find(&id).map(|x| x.clone());
    match fun {
      Some((ref retp, ref argsp)) => {
        good = self.tc_equal(span, retp, ret) && good;
        if argsp.len() != args.len() {
          self.program.error(span, "Different number of arguments than before");
          good = false;
        } else {
          for (expected, &(_, ref got)) in argsp.iter().zip(args.iter()) {
            good = self.tc_equal(span, expected, got) && good;
          }
        }
      }
      None => ()
    }

    if good {
      self.funs.insert(id, (ret.clone(), args.map(|x| x.second())));
    }
    return good;
  }

  fn tc_ensure(&mut self, e: &Expression, t: &Type) {
    let t2 = self.tc_exp(e);
    self.tc_equal(e.span, t, &t2);
  }

  fn tc_defined(&mut self, m: Mark, t: &Type) -> bool {
    match *t {
      Struct(id) => {
        match self.structs.find(&id) {
          Some(&Some(_)) => true,
          _ => {
            self.program.error(m, format!("Struct not defined '{}'",
                                       self.program.str(id)));
            false
          }
        }
      },
      _ => true
    }
  }

  fn tc_equal(&mut self, m: Mark, t1: &Type, t2: &Type) -> bool {
    if t1 != t2 {
      self.program.error(m, format!("Type mismatch: expected {}, got {}",
                                 t1.pp(self.program), t2.pp(self.program)));
      return false;
    }
    return true;
  }

  fn tc_small(&mut self, m: Mark, t: &Type) -> bool {
    if !t.small() {
      self.program.error(m, format!("Type must be small: '{}'",
                                 t.pp(self.program)));
      return false;
    }
    return true;
  }
}
