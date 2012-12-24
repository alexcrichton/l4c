use ast::*;

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
      Int            => ~"int",
      Bool           => ~"bool",
      Alias(copy s)  => s,
      Pointer(ref t) => ~"*" + t.pp(),
      Array(ref t)   => t.pp() + ~"[]",
      Struct(copy s) => s,
      Nullp          => ~"(null)"
    }
  }
}

impl Expression {
  pure fn pp() -> ~str {
    match self {
      Var(copy s)            => s,
      Boolean(b)             => b.to_str(),
      Const(i)               => i.to_str(),
      UnaryOp(ref o, ref e)  => o.pp() + ~"(" + e.pp() + ~")",
      Deref(ref e)           => ~"*(" + e.pp() + ~")",
      Field(ref e, copy f)   => e.pp() + ~"." + f,
      ArrSub(ref e1, ref e2) => e1.pp() + ~"[" + e2.pp() + ~"]",
      Alloc(ref t)           => ~"alloc(" + t.pp() + ~")",
      Null                   => ~"NULL",
      Marked(ref m)          => m.data.pp(),
      AllocArray(ref t, ref e) =>
        ~"alloc_array(" + t.pp() + ~", " + e.pp() + ~")",
      Call(copy id, ref E) =>
        id + ~"(" + str::connect(E.map(|e| e.pp()), ~", ") + ~")",
      BinaryOp(ref o, ref e1, ref e2) =>
        ~"(" + e1.pp() + ~" " + o.pp() + ~" " + e2.pp() + ~")",
      Ternary(ref e1, ref e2, ref e3) =>
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
      Seq(~Nop, ~Nop) => ~"",
      Return(ref e) => ~"return " + e.pp(),
      Express(ref e) => e.pp(),
      Declare(copy v, ref t, ref s) =>
        t.pp() + ~" " + v + ~"\n" + tab(s.pp()),
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
      Seq(~Nop, ref s) | Seq(ref s, ~Nop) => s.pp(),
      Seq(ref s1, ref s2) => s1.pp() + ~"\n" + s2.pp()
    }
  }
}

pure fn ppair(p : &(Ident, ~Type)) -> ~str {
  match *p {
    (copy id, ref typ) => typ.pp() + ~" " + id
  }
}

pure fn pfun(t : &~Type, i : ~str, p : &~[(Ident, ~Type)]) -> ~str {
  t.pp() + ~" " + i + ~"(" + str::connect(p.map(ppair), ~", ") + ~")"
}

impl GDecl {
  pure fn pp() -> ~str {
    match self {
      Markedg(ref m) => m.data.pp(),
      Typedef(copy s, ref t) => ~"typedef " + t.pp() + ~" " + s,
      StructDecl(copy s) => ~"struct " + s,
      StructDef(copy s, ref L) =>
        ~"struct " + s + "{\n" + str::connect(L.map(ppair), "\n") + "\n}",
      FunIDecl(ref t, copy s, ref args) => pfun(t, s, args),
      FunEDecl(ref t, copy s, ref args) => ~"extern " + pfun(t, s, args),
      Function(ref t, copy s, ref args, ref body) =>
        pfun(t, s, args) + ~" {\n" + tab(body.pp()) + ~"\n}"
    }
  }
}

impl &Program {
  pure fn pp() -> ~str {
    str::connect(self.decls.map(|d| d.pp()), "\n")
  }
}
