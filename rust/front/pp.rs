use front::ast::*;

pure fn tab(s : ~str) -> ~str {
  ~"  " + str::replace(s, ~"\n", ~"\n  ")
}

impl Unop {
  pure fn pp() -> ~str {
    match self {
      Negative => ~"-",
      Invert   => ~"~",
      Bang     => ~"!"
    }
  }
}

impl Binop {
  pure fn pp() -> ~str {
    match self {
      Plus      => ~"+",
      Minus     => ~"-",
      Times     => ~"*",
      Divide    => ~"/",
      Modulo    => ~"%",
      Less      => ~"<",
      LessEq    => ~"<=",
      Greater   => ~">",
      GreaterEq => ~">=",
      Equals    => ~"==",
      NEquals   => ~"!=",
      LAnd      => ~"&&",
      LOr       => ~"||",
      BAnd      => ~"&",
      BOr       => ~"|",
      Xor       => ~"^",
      LShift    => ~"<<",
      RShift    => ~">>"
    }
  }
}

impl Type {
  pure fn pp() -> ~str {
    match self {
      Int           => ~"int",
      Bool          => ~"bool",
      Alias(s)      => copy s.val,
      Pointer(t)    => ~"*" + t.pp(),
      Array(t)      => t.pp() + ~"[]",
      Struct(s)     => copy s.val,
      Nullp         => ~"(null)",
      Fun(t, ref L) => t.pp() + ~"(" + str::connect(L.map(|x| x.pp()), ~", ")
    }
  }
}

impl Expression {
  pure fn pp() -> ~str {
    match self {
      Var(s)            => copy s.val,
      Boolean(b)        => b.to_str(),
      Const(i)          => i.to_str(),
      UnaryOp(o, e)     => o.pp() + ~"(" + e.pp() + ~")",
      Deref(e, _)       => ~"*(" + e.pp() + ~")",
      Field(e, f, _)    => e.pp() + ~"." + f.val,
      ArrSub(e1, e2, _) => e1.pp() + ~"[" + e2.pp() + ~"]",
      Alloc(t)          => ~"alloc(" + t.pp() + ~")",
      Null              => ~"NULL",
      Marked(ref m)     => m.data.pp(),
      AllocArray(t, e)  =>
        ~"alloc_array(" + t.pp() + ~", " + e.pp() + ~")",
      Call(e, ref E, _) =>
        e.pp() + ~"(" + str::connect(E.map(|e| e.pp()), ~", ") + ~")",
      BinaryOp(o, e1, e2) =>
        ~"(" + e1.pp() + ~" " + o.pp() + ~" " + e2.pp() + ~")",
      Ternary(e1, e2, e3, _) =>
        ~"((" + e1.pp() + ~") ? (" + e2.pp() +
        ~") : (" + e3.pp() + ~"))"
    }
  }
}

impl Statement {
  pure fn pp() -> ~str {
    match self {
      Continue => ~"continue",
      Break => ~"break",
      Nop => ~"",
      Return(e) => ~"return " + e.pp(),
      Express(e) => e.pp(),
      Declare(v, t, init, s) =>
        t.pp() + ~" " + v.val + self.pp_opt(init) + ~"\n" + tab(s.pp()),
      Markeds(ref m) => m.data.pp(),
      While(ref e, ref s) =>
        ~"while (" + e.pp() + ~") {\n" + tab(s.pp()) + ~"\n}",
      If(ref e, ref s1, ref s2) =>
        ~"if(" + e.pp() + ~") {\n" + tab(s1.pp()) +
        ~"\n} else {\n" + tab(s2.pp()) + ~"\n}",
      For(ref s1, ref e, ref s2, ref s3) =>
        ~"for (" + s1.pp() + ~"; " + e.pp() + ~"; " + s2.pp() +
        ~") {\n" + tab(s3.pp()) + ~"\n}",
      Assign(ref e1, ref o, ref e2) =>
        e1.pp() +
        match *o { None => ~" = ", Some(o) => ~" " + o.pp() + ~"= " } +
        e2.pp(),
      Seq(@Nop, ref s) | Seq(ref s, @Nop) => s.pp(),
      Seq(ref s1, ref s2) => s1.pp() + ~"\n" + s2.pp()
    }
  }

  pure fn pp_opt(o : Option<@Expression>) -> ~str {
    match o {
      Some(e) => ~" = " + e.pp(),
      None => ~""
    }
  }
}

pure fn ppair(p : &(Ident, @Type)) -> ~str {
  match *p { (id, typ) => typ.pp() + ~" " + id.val }
}

pure fn pfun(t : @Type, i : Ident, p : &~[(Ident, @Type)]) -> ~str {
  t.pp() + ~" " + i.val + ~"(" + str::connect(p.map(ppair), ~", ") + ~")"
}

impl GDecl {
  pure fn pp() -> ~str {
    match self {
      Markedg(ref m) => m.data.pp(),
      Typedef(s, t) => ~"typedef " + t.pp() + ~" " + s.val,
      StructDecl(s) => ~"struct " + s.val,
      StructDef(s, ref L) =>
        ~"struct " + s.val + "{\n" + str::connect(L.map(ppair), "\n") + "\n}",
      FunIDecl(t, s, ref args) => pfun(t, s, args),
      FunEDecl(t, s, ref args) => ~"extern " + pfun(t, s, args),
      Function(t, s, ref args, body) =>
        pfun(t, s, args) + ~" {\n" + tab(body.pp()) + ~"\n}"
    }
  }
}
