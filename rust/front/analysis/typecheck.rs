use core::hashmap::linear::{LinearMap, LinearSet};
use core::util::with;

use front::error;
use front::ast::*;

struct Typechecker {
  err:     error::List,
  funs:    LinearMap<Ident, (@Type, @~[@Type])>,
  structs: LinearMap<Ident, Option<LinearMap<Ident, @Type>>>,
  vars:    LinearMap<Ident, @Type>,
  loops:   int,
  ret:     @Type
}

pub fn check(a: &Program) {
  let mut tc = Typechecker{ err: error::new(),
                            funs: LinearMap::new(),
                            structs: LinearMap::new(),
                            vars: LinearMap::new(),
                            loops: 0,
                            ret: @Nullp};
  debug!("typechecking");
  tc.check(a);
  tc.err.check();
}

impl Typechecker {
  fn check(&mut self, a: &Program) {
    for a.decls.each |x| {
      self.tc_gdecl(*x)
    }
  }

  fn tc_gdecl(&mut self, g: @GDecl) {
    match g {
      @Markedg(ref m) => self.err.with(m, |x| self.tc_gdecl(x)),
      @Typedef(_, _) => (),
      @StructDecl(id) => {
        if !self.structs.contains_key(&id) {
          self.structs.insert(id, None);
        }
      }
      @StructDef(id, ref fields) => self.bind_struct(id, fields),
      @FunIDecl(ret, id, ref args) => { self.bind_fun(id, ret, args); },
      @FunEDecl(ret, id, ref args) => { self.bind_fun(id, ret, args); },
      @Function(ret, id, ref args, body) => {
        if self.bind_fun(id, ret, args) {
          self.vars.clear();
          for args.each |&(id, typ)| {
            self.vars.insert(id, typ);
          }
          self.ret = ret;
          self.tc_stm(body);
        }
      }
    }
  }

  fn tc_stm(&mut self, s: @Statement) {
    match s {
      @Markeds(ref m) => self.err.with(m, |x| self.tc_stm(x)),
      @Continue | @Break => {
        if self.loops == 0 {
          self.err.add(fmt!("'%s' outside of loops isn't allowed", s.pp()));
        }
      },
      @Nop => (),
      @Seq(s1, s2) => { self.tc_stm(s1); self.tc_stm(s2) },
      @Express(e) => { self.tc_exp(e); },
      @Return(e) => self.tc_ensure(e, self.ret),
      @While(e, s) => {
        self.tc_ensure(e, @Bool);
        do with(&mut self.loops, self.loops + 1) {
          self.tc_stm(s);
        }
      },
      @If(e, s1, s2) => {
        self.tc_ensure(e, @Bool);
        self.tc_stm(s1);
        self.tc_stm(s2);
      },
      @For(s1, e, s2, s3) => {
        self.tc_ensure(e, @Bool);
        self.tc_stm(s1);
        do with(&mut self.loops, self.loops + 1) {
          self.tc_stm(s2);
          self.tc_stm(s3);
        }
      },
      @Assign(e1, _, e2) => {
        let t1 = self.tc_exp(e1);
        if !e1.lvalue() {
          self.err.add(~"not an lvalue");
        } else if self.tc_small(t1) {
          self.tc_ensure(e2, t1);
        }
      },
      @Declare(id, typ, init, stm) => {
        self.tc_small(typ);
        init.iter(|x| self.tc_ensure(*x, typ));
        if self.vars.contains_key(&id) {
          self.err.add(fmt!("Redeclared var '%s'", id.val));
        } else {
          self.vars.insert(id, typ);
          self.tc_stm(stm);
          self.vars.remove(&id);
        }
      }
    }
  }

  fn tc_exp(&mut self, e: @Expression) -> @Type {
    match e {
      @Marked(ref m) => self.err.with(m, |x| self.tc_exp(x)),
      @Const(_) => @Int,
      @Boolean(_) => @Bool,
      @Null => @Nullp,
      @Var(id) => match self.vars.find(&id) {
        Some(&t) => t,
        None => match self.funs.find(&id) {
          Some(&(ret, args)) => @Pointer(@Fun(ret, args)),
          None => self.err.die(fmt!("Unknown variable '%s'", id.val))
        }
      },
      @Alloc(t) => { self.tc_defined(t); @Pointer(t) },
      @AllocArray(t, e) => {
        self.tc_defined(t);
        self.tc_ensure(e, @Int);
        @Array(t)
      },
      @BinaryOp(op, e1, e2) => match op {
        Less | LessEq | Greater | GreaterEq => {
          self.tc_ensure(e1, @Int);
          self.tc_ensure(e2, @Int);
          @Bool
        },
        Equals | NEquals => {
          let t1 = self.tc_exp(e1);
          self.tc_small(t1);
          self.tc_ensure(e2, t1);
          @Bool
        },
        LAnd | LOr => {
          self.tc_ensure(e1, @Bool);
          self.tc_ensure(e2, @Bool);
          @Bool
        },
        _ => {
          self.tc_ensure(e1, @Int);
          self.tc_ensure(e2, @Int);
          @Int
        }
      },
      @UnaryOp(op, e) => match op {
        Bang => { self.tc_ensure(e, @Bool); @Bool },
        _    => { self.tc_ensure(e, @Int); @Int }
      },
      @Ternary(e1, e2, e3, ref r) => {
        self.tc_ensure(e1, @Bool);
        let t = self.tc_exp(e2);
        self.tc_ensure(e3, t);
        r.set(t);
        t
      },
      @Deref(e, ref r) => match self.tc_exp(e) {
        @Pointer(t) => { r.set(t); t },
        _ => self.err.die(~"must be a pointer type")
      },
      @ArrSub(e1, e2, ref r) => match self.tc_exp(e1) {
        @Array(t) => { self.tc_ensure(e2, @Int); r.set(t); t },
        _ => self.err.die(~"must be an array type")
      },
      @Call(e, ref args, ref r) => match self.tc_exp(e) {
        @Pointer(@Fun(ret, argtyps)) => {
          if argtyps.len() != args.len() {
            self.err.add(~"mismatched number of arguments");
          } else {
            for vec::each2(*args, *argtyps) |&e, &t2| {
              self.tc_ensure(e, t2);
            }
          }
          r.set(ret);
          ret
        },
        _ => self.err.die(~"expected a pointer to a function type")
      },
      @Field(e, id, ref r) => {
        let err = match self.tc_exp(e) {
          @Struct(s) => {
            r.set(s);
            match self.structs.find(&s) {
              Some(&Some(ref t)) => match t.find(&id) {
                Some(&t) => { return t; }
                None => fmt!("Unknown field '%s'", id.val)
              },
              _ => fmt!("Unknown struct '%s'", s.val)
            }
          }
          _ => fmt!("must be a struct type")
        };
        self.err.die(err);
      }
    }
  }

  fn bind_struct(&mut self, id: Ident, fields: &~[(Ident, @Type)]) {
    let redefined = match self.structs.find(&id) {
      Some(&Some(_)) => true, _ => false
    };
    if redefined {
      self.err.add(~"Redefined struct");
      return;
    }

    /* Build up the table of field => type information */
    let mut table = LinearMap::new();
    for fields.each |&(field, typ)| {
      if table.contains_key(&field) {
        self.err.add(fmt!("Duplicate field: '%s'", field.val));
        loop;
      }
      /* Make sure structs are all defined and not recursive */
      match typ {
        @Struct(id2) =>
          if id == id2 {
            self.err.add(~"Cannot define a nested structure"); loop;
          },
        _ => ()
      }
      if self.tc_defined(typ) {
        table.insert(field, typ);
      }
    }
    self.structs.insert(id, Some(table));
  }

  fn bind_fun(&mut self, id: Ident, ret: @Type, args: &~[(Ident, @Type)]) -> bool {
    let prev = self.err.size();
    let mut names = LinearSet::new();
    for args.each |&(name, typ)| {
      if !names.insert(name) {
        self.err.add(fmt!("Duplicate argument: %s", name.val));
      }
      self.tc_small(typ);
    }
    self.tc_small(ret);

    match self.funs.find(&id) {
      Some(&(retp, argsp)) => {
        self.tc_equal(retp, ret);
        if argsp.len() != args.len() {
          self.err.add(~"Different number of arguments than before");
        } else {
          for vec::each2(*argsp, *args) |&expected, &(_, got)| {
            self.tc_equal(expected, got);
          }
        }
      }
      None => ()
    }

    if prev == self.err.size() {
      self.funs.insert(id, (ret, @args.map(|x| x.second())));
    }
    prev == self.err.size()
  }

  fn tc_ensure(&mut self, e: @Expression, t: @Type) {
    self.tc_equal(t, self.tc_exp(e));
  }

  fn tc_defined(&mut self, t: @Type) -> bool {
    match t {
      @Struct(id) => {
        let defined = match self.structs.find(&id) {
          Some(&Some(_)) => true, _ => false
        };
        if !defined {
          self.err.add(fmt!("Struct not defined '%s'", id.val));
        }
        return defined;
      },
      _ => true
    }
  }

  fn tc_equal(&mut self, t1: @Type, t2: @Type) -> bool {
    if t1 != t2 {
      self.err.add(fmt!("Type mismatch: expected %s, got %s", t1.pp(), t2.pp()));
    }
    t1 == t2
  }

  fn tc_small(&mut self, t: @Type) -> bool {
    if !t.small() {
      self.err.add(fmt!("Type must be small: '%s'", t.pp()));
    }
    t.small()
  }

}
