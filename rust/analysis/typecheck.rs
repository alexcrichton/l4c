use ast::*;
use std::map;

struct Typechecker {
  err :     ~error::List,
  funs :    map::HashMap<@Symbol, (@Type, @~[@Type])>, // TODO: wut
  structs : map::HashMap<@Symbol, Option<map::HashMap<@Symbol, @Type>>>,
  vars :    map::HashMap<@Symbol, @Type>,
  mut loops : int,
  mut ret : @Type
}

pub fn check(a : &Program) {
  let tc = Typechecker{ err: error::new(),
                        funs: map::HashMap(),
                        structs: map::HashMap(),
                        vars: map::HashMap(),
                        loops: 0,
                        ret: @Nullp};
  tc.check(a);
  tc.err.check();
}

impl Typechecker {
  fn check(a : &Program) {
    for a.decls().each |x| {
      self.tc_gdecl(*x)
    }
  }

  fn tc_gdecl(g : @GDecl) {
    match g {
      @Markedg(ref m) => self.err.with(m, |x| self.tc_gdecl(x)),
      @Typedef(_, _) => (),
      @StructDecl(id) =>
        match self.structs.find(id) {
          None => { self.structs.insert(id, None); },
          _ => ()
        },
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

  fn tc_stm(s : @Statement) {
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
      @Declare(id, typ, stm) => {
        self.tc_small(typ);
        match self.vars.find(id) {
          Some(_) => self.err.add(fmt!("Redeclared var '%s'", id.val)),
          None => {
            self.vars.insert(id, typ);
            self.tc_stm(stm);
            self.vars.remove(id);
          }
        }
      }
    }
  }

  fn tc_exp(e : @Expression) -> @Type {
    match e {
      @Marked(ref m) => self.err.with(m, |x| self.tc_exp(x)),
      @Const(_) => @Int,
      @Boolean(_) => @Bool,
      @Null => @Nullp,
      @Var(id) => match self.vars.find(id) {
        Some(t) => t,
        None => self.err.die(fmt!("Unknown variable '%s'", id.val))
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
      @Ternary(e1, e2, e3) => {
        self.tc_ensure(e1, @Bool);
        let t = self.tc_exp(e2);
        self.tc_ensure(e3, t);
        t
      },
      @Deref(e) => match self.tc_exp(e) {
        @Pointer(t) => t,
        _ => self.err.die(~"must be a pointer type")
      },
      @ArrSub(e1, e2) => match self.tc_exp(e1) {
        @Array(t) => { self.tc_ensure(e2, @Int); t },
        _ => self.err.die(~"must be an array type")
      },
      @Call(id, ref args) => {
        if self.vars.contains_key(id) {
          self.err.die(fmt!("'%s' is a variable, not a function", id.val));
        }
        match self.funs.find(id) {
          None => self.err.die(fmt!("Unknown function '%s'", id.val)),
          Some((ret, argt)) => {
            if argt.len() != args.len() {
              self.err.add(~"mismatched number of arguments");
            } else {
              for vec::each2(*args, *argt) |&e, &t| {
                self.tc_ensure(e, t);
              }
            }
            ret
          }
        }
      },
      @Field(e, id) => match self.tc_exp(e) {
        @Struct(s) => match self.structs.find(s) {
          Some(Some(t)) => match t.find(id) {
            Some(t) => t,
            None => self.err.die(fmt!("Unknown field '%s'", id.val))
          },
          _ => self.err.die(fmt!("Unknown struct '%s'", s.val))
        },
        _ => self.err.die(fmt!("must be a struct type"))
      }
    }
  }

  fn bind_struct(id : @Symbol, fields : &~[(Ident, @Type)]) {
    match self.structs.find(id) {
      Some(Some(_)) => {
        self.err.add(~"Redefined struct");
        return;
      },
      _ => ()
    };

    /* Build up the table of field => type information */
    let table = map::HashMap();
    for fields.each |&(id, typ)| {
      if table.contains_key(id) {
        self.err.add(fmt!("Duplicate field: '%s'", id.val));
        loop;
      }
      /* Make sure structs are all defined and not recursive */
      match typ {
        @Struct(id2) =>
          if id.eq(id2) {
            self.err.add(~"Cannot define a nested structure"); loop;
          },
        _ => ()
      }
      if self.tc_defined(typ) {
        table.insert(id, typ);
      }
    }
    self.structs.insert(id, Some(table));
  }

  fn bind_fun(id : @Symbol, ret : @Type, args : &~[(Ident, @Type)]) -> bool {
    let prev = self.err.size();

    match self.funs.find(id) {
      Some((retp, argsp)) => {
        self.tc_equal(retp, ret);
        if argsp.len() != args.len() {
          self.err.add(~"Different number of arguments than before");
        } else {
          for vec::each2(*argsp, *args) |&expected, &(_, got)| {
            self.tc_equal(expected, got);
          }
        }
      }
      None => for args.each |&(_, typ)| { self.tc_small(typ); }
    }

    if prev == self.err.size() {
      self.funs.insert(id, (ret, @args.map(|x| x.second())));
    }
    prev == self.err.size()
  }

  fn tc_ensure(e : @Expression, t : @Type) {
    self.tc_equal(t, self.tc_exp(e));
  }

  fn tc_defined(t : @Type) -> bool {
    match t {
      @Struct(id) => match self.structs.find(id) {
        Some(Some(_)) => true,
        _ => { self.err.add(fmt!("Struct not defined '%s'", id.val)); false }
      },
      _ => true
    }
  }

  fn tc_equal(t1 : @Type, t2 : @Type) -> bool {
    if t1 != t2 {
      self.err.add(fmt!("Type mismatch: expected %s, got %s", t1.pp(), t2.pp()));
    }
    t1 == t2
  }

  fn tc_small(t : @Type) -> bool {
    if t.small() {
      self.err.add(fmt!("Type must be small: '%s'", t.pp()));
    }
    t.small()
  }

}
