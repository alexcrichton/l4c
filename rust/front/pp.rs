use front::ast::*;
use front::mark::Marked;
use utils::PrettyPrint;

pub trait PrettyPrintAST {
  pub fn pp(&self, p: &Program) -> ~str;
}

fn tab(s: ~str) -> ~str {
  ~"  " + str::replace(s, ~"\n", ~"\n  ")
}

impl PrettyPrint for Unop {
  fn pp(&self) -> ~str {
    match *self {
      Negative => ~"-",
      Invert   => ~"~",
      Bang     => ~"!"
    }
  }
}

impl PrettyPrint for Binop {
  fn pp(&self) -> ~str {
    match *self {
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

impl PrettyPrintAST for Type {
  fn pp(&self, p: &Program) -> ~str {
    match *self {
      Int           => ~"int",
      Bool          => ~"bool",
      Alias(s)      => p.str(s),
      Pointer(t)    => t.pp(p) + "*",
      Array(t)      => t.pp(p) + ~"[]",
      Struct(s)     => ~"struct " + p.str(s),
      Nullp         => ~"(null)",
      Fun(t, ref L) => t.pp(p) + ~"(" + str::connect(L.map(|x| x.pp(p)), ~", ")
    }
  }
}

impl PrettyPrintAST for Expression {
  fn pp(&self, p: &Program) -> ~str {
    match self.node {
      Var(s)                    => p.str(s),
      Boolean(b)                => b.to_str(),
      Const(i)                  => i.to_str(),
      UnaryOp(o, ref e)         => o.pp() + ~"(" + e.pp(p) + ~")",
      Deref(ref e, _)           => ~"*(" + e.pp(p) + ~")",
      Field(ref e, f, _)        => e.pp(p) + ~"." + p.str(f),
      ArrSub(ref e1, ref e2, _) => e1.pp(p) + ~"[" + e2.pp(p) + ~"]",
      Alloc(t)                  => ~"alloc(" + t.pp(p) + ~")",
      Null                      => ~"NULL",
      AllocArray(t, ref e) =>
        ~"alloc_array(" + t.pp(p) + ~", " + e.pp(p) + ~")",
      Call(ref e, ref E, _) =>
        e.pp(p) + ~"(" + str::connect(E.map(|e| e.pp(p)), ~", ") + ~")",
      BinaryOp(o, ref e1, ref e2) =>
        ~"(" + e1.pp(p) + ~" " + o.pp() + ~" " + e2.pp(p) + ~")",
      Ternary(ref e1, ref e2, ref e3, _) =>
        ~"((" + e1.pp(p) + ~") ? (" + e2.pp(p) +
        ~"): (" + e3.pp(p) + ~"))"
    }
  }
}

impl PrettyPrintAST for Statement {
  fn pp(&self, p: &Program) -> ~str {
    match self.node {
      Continue => ~"continue",
      Break => ~"break",
      Nop => ~"",
      Return(ref e) => ~"return " + e.pp(p),
      Express(ref e) => e.pp(p),
      Declare(v, t, ref init, ref s) =>
        t.pp(p) + ~" " + p.str(v) + pp_opt(p, init) + ~"\n" + tab(s.pp(p)),
      While(ref e, ref s) =>
        ~"while (" + e.pp(p) + ~") {\n" + tab(s.pp(p)) + ~"\n}",
      If(ref e, ref s1, ref s2) =>
        ~"if(" + e.pp(p) + ~") {\n" + tab(s1.pp(p)) +
        ~"\n} else {\n" + tab(s2.pp(p)) + ~"\n}",
      For(ref s1, ref e, ref s2, ref s3) =>
        ~"for (" + s1.pp(p) + ~"; " + e.pp(p) + ~"; " + s2.pp(p) +
        ~") {\n" + tab(s3.pp(p)) + ~"\n}",
      Assign(ref e1, ref o, ref e2) =>
        e1.pp(p) +
        match *o { None => ~" = ", Some(o) => ~" " + o.pp() + ~"= " } +
        e2.pp(p),
      Seq(~Marked{ node: Nop, _ }, ~Marked{ node: Nop, _ }) => ~"",
      Seq(ref s, ~Marked{ node: Nop, _ }) => s.pp(p),
      Seq(~Marked{ node: Nop, _ }, ref s) => s.pp(p),
      Seq(ref s1, ref s2) => s1.pp(p) + ~"\n" + s2.pp(p)
    }
  }
}

fn pp_opt(p: &Program, o: &Option<~Expression>) -> ~str {
  match *o {
    Some(ref e) => ~" = " + e.pp(p),
    None => ~""
  }
}

fn ppair(prog: &Program, p: &(Ident, @Type)) -> ~str {
  match *p { (id, typ) => typ.pp(prog) + ~" " + prog.str(id) }
}

fn pfun(prog: &Program, t: @Type, i: Ident, p: &~[(Ident, @Type)]) -> ~str {
  t.pp(prog) + ~" " + prog.str(i) + ~"(" +
    str::connect(p.map(|p| ppair(prog, p)), ~", ") + ~")"
}

impl PrettyPrintAST for GDecl {
  fn pp(&self, p: &Program) -> ~str {
    match self.node {
      Typedef(s, t) => ~"typedef " + t.pp(p) + ~" " + p.str(s),
      StructDecl(s) => ~"struct " + p.str(s),
      StructDef(s, ref L) =>
        ~"struct " + p.str(s) + "{\n" +
          tab(str::connect(L.map(|t| ppair(p, t)), "\n")) + "\n}",
      FunIDecl(t, s, ref args) => pfun(p, t, s, args),
      FunEDecl(t, s, ref args) => ~"extern " + pfun(p, t, s, args),
      Function(t, s, ref args, ref body) =>
        pfun(p, t, s, args) + ~" {\n" + tab(body.pp(p)) + ~"\n}"
    }
  }
}
