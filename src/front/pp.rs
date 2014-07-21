use std::fmt::Show;
use std::fmt;
use std::io::IoResult;

use front::ast::*;
use front::mark::Marked;

pub trait ShowAST {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result;
}

pub struct WithAST<'a, T>(&'a T, &'a Program);

struct Tabber<'a, W> { f: &'a mut W }

impl<'a, T: ShowAST> fmt::Show for WithAST<'a, T> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result{
        let WithAST(obj, p) = *self;
        obj.fmt(p, f)
    }
}

impl<'a, W: Writer> Writer for Tabber<'a, W> {
    fn write(&mut self, bytes: &[u8]) -> IoResult<()> {
        for part in bytes.split(|b| *b == b'\n') {
            try!(self.f.write(part));
            try!(self.f.write(b"\n  "));
        }
    }
}

fn tab<'a, W>(f: &'a mut W) -> Tabber<'a, W> {
    Tabber { f: f }
}

impl fmt::Show for Unop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Negative => "-".fmt(f),
            Invert   => "~".fmt(f),
            Bang     => "!".fmt(f),
        }
    }
}

impl fmt::Show for Binop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Plus      => "+".fmt(f),
            Minus     => "-".fmt(f),
            Times     => "*".fmt(f),
            Divide    => "/".fmt(f),
            Modulo    => "%".fmt(f),
            Less      => "<".fmt(f),
            LessEq    => "<=".fmt(f),
            Greater   => ">".fmt(f),
            GreaterEq => ">=".fmt(f),
            Equals    => "==".fmt(f),
            NEquals   => "!=".fmt(f),
            LAnd      => "&&".fmt(f),
            LOr       => "||".fmt(f),
            BAnd      => "&".fmt(f),
            BOr       => "|".fmt(f),
            Xor       => "^".fmt(f),
            LShift    => "<<".fmt(f),
            RShift    => ">>".fmt(f),
        }
    }
}

impl<'a, T: ShowAST> ShowAST for &'a [T] {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result {
        for (i, e) in self.iter().enumerate() {
            if i > 0 { try!(write!(f, ", ")); }
            try!(write!(f, "{}", WithAST(&**e, p)));
        }
        Ok(())
    }
}

impl<'a, T: ShowAST> ShowAST for Box<T> {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result {
        WithAST(&**self, p).fmt(f)
    }
}

impl ShowAST for Type {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Int            => "int".fmt(f),
            Bool           => "bool".fmt(f),
            Alias(s)       => p.str(s).fmt(f),
            Pointer(ref t) => { try!(t.fmt(p, f)); write!(f.buf, "*") }
            Array(ref t)   => { try!(t.fmt(p, f)); write!(f.buf, "[]") }
            Struct(s)      => write!(f.buf, "struct {}", p.str(s)),
            Nullp          => "(null)".fmt(f),
            Fun(ref t, ref l) => write!(f.buf, "{}({})",
                                        WithAST(t, p),
                                        WithAST(l.as_slice(), p))
        }
    }
}

impl ShowAST for Expression {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result {
        match self.node {
            Var(s) => write!(f, "{}", p.str(s)),
            Boolean(b) => write!(f, "{}", b),
            Const(i) => write!(f, "{}", i),
            UnaryOp(o, ref e) => {
                write!(f, "{}({})", WithAST(o, p), WithAST(e, p))
            }
            Deref(ref e, _) => {
                write!(f, "*({})", WithAST(e, p)),
            }
            Field(ref e, f, _) => {
                write!(f, "{}.{}", WithAST(e, p), WithAST(f, p))
            }
            ArrSub(ref e1, ref e2, _) => {
                write!(f, "{}[{}]", WithAST(e1, p), WithAST(e2, p))
            }
            Alloc(ref t) => write!(f, "alloc({})", WithAST(t, p)),
            Null => write!(f, "NULL"),
            AllocArray(ref t, ref e) => {
                write!(f, "alloc_array({}, {})",
                       WithAST(t, p), WithAST(e, p))
            }
            Call(ref e, ref args, _) => {
                write!(f, "{}({:#})", WithAST(e, p),
                       WithAST(args.as_slice(), p))
            }
            BinaryOp(o, ref e1, ref e2) => {
                write!(f, "({} {} {})", WithAST(e1, p), o, WithAST(e2, p))
            }
            Ternary(ref e1, ref e2, ref e3, _) => {
                write!(f, "(({}) ? ({}) : ({}))", WithAST(e1, p),
                       WithAST(e2, p), WithAST(e3, p))
            }
        }
    }
}

impl ShowAST for Statement {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result {
        match self.node {
            Continue => write!(f, "continue"),
            Break => write!(f, "break"),
            Nop => Ok(()),
            Return(ref e) => write!(f, "return {}", WithAST(e, p)),
            Express(ref e) => write!(f, "{}", WithAST(e, p)),
            Declare(v, ref t, ref init, ref s) => {
                try!(write!(f, "{} {}", WithAST(t, p), p.str(v)));
                match *init {
                    Some(ref e) => try!(write!(f, " = {}", WithAST(e, p))),
                    None => {}
                }
                try!(write!(f, "\n"));
                write!(&mut tab(f), "{}", WithAST(s, p))
            }
            While(ref e, ref s) => {
                try!(write!(f, "while ({}) {{\n", WithAST(e, p)));
                try!(write!(&mut tab(f), "{}", WithAST(s, p)));
                write!(f, "\n}}")
            }
            If(ref e, ref s1, ref s2) => {
                try!(write!(f, "if ({}) {{\n", WithAST(e, p)));
                try!(write!(&mut tab(f), "{}", WithAST(s1, p)));
                try!(write!(f, "}} else {{\n"));
                try!(write!(&mut tab(f), "{}", WithAST(s2, p)));
                write!(f, "\n}}")
            }
            For(ref s1, ref e, ref s2, ref s3) => {
                try!(write!(f, "for ({}; {}; {}) {{\n", WithAST(s1, p),
                            WithAST(e, p), WithAST(s2, p)));
                try!(write!(&mut tab(f), "{}", WithAST(s3, p)));
                write!(f, "\n}}")
            }
            Assign(ref e1, ref o, ref e2) => {
                try!(write!(f, "{} ", WithAST(e1, p)));
                match *o {
                    Some(o) => try!(write!(f, " {}= ", o)),
                    None => try!(write!(f, " = ")),
                }
                write!(f, "{}", WithAST(e2, p))
            }
            Seq(box Marked{ node: Nop, .. }, box Marked{ node: Nop, .. }) => Ok(()),
            Seq(ref s, box Marked{ node: Nop, .. }) |
            Seq(box Marked{ node: Nop, .. }, ref s) => WithAST(s, p).fmt(f),
            Seq(ref s1, ref s2) => {
                write!(f, "{}\n{}", WithAST(s1, p), WithAST(s2, p))
            }
        }
    }
}

fn pfun(f: &mut fmt::Formatter, prog: &Program, t: &Type, i: Ident,
        p: &[(Ident, Type)]) -> fmt::Result {
    try!(write!(f, "{} {} (", WithAST(t, prog), prog.str(i)));
    for (i, (id, ref ty)) in p.iter().enumerate() {
        if i > 0 { try!(write!(f, ", ")); }
        try!(write!(f, "{} {}", WithAST(ty, prog), prog.str(id)));

    }
    write!(f, ")")
}

impl ShowAST for GDecl {
    fn fmt(&self, p: &Program, f: &mut fmt::Formatter) -> fmt::Result {
        match self.node {
            Typedef(s, ref t) => {
                write!(f, "typedef {} {}", WithAST(t, p), p.str(s))
            }
            StructDecl(s) => write!("struct {}", p.str(s)),
            StructDef(s, ref l) => {
                try!(write!(f, "struct {} {{\n", p.str(s)));
                for (id, ref ty) in l.iter() {
                    try!(write!(f, "  {} {}", WithAST(ty, p), p.str(id)));
                }
                write!(f, "\n}}")
            }
            FunIDecl(ref t, s, ref args) => pfun(f, p, t, s, args.as_slice()),
            FunEDecl(ref t, s, ref args) => {
                try!(write!(f, "extern "));
                pfun(f, p, t, s, args.as_slice())
            }
            Function(ref t, s, ref args, ref body) => {
                try!(pfun(f, p, t, s, args.as_slice()));
                try!(write!(f, " {{\n"));
                try!(write!(&mut tab(f), WithAST(body, p)));
                write!(f, "\n}}")
            }
        }
    }
}
