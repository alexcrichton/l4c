use std::fmt::{Display, Write};
use std::fmt;

use front::ast::{self, Expr_, Item_, Stmt_, Unop, Binop, Type};

struct Tabber<'a, 'b: 'a> {
    f: &'a mut fmt::Formatter<'b>
}

impl<'a, 'b> fmt::Write for Tabber<'a, 'b> {
    fn write_str(&mut self, bytes: &str) -> fmt::Result {
        for part in bytes.lines() {
            try!(self.f.write_str(part));
            try!(self.f.write_str("\n  "));
        }
        Ok(())
    }
}

fn tab<'a, 'b>(f: &'a mut fmt::Formatter<'b>) -> Tabber<'a, 'b> {
    Tabber { f: f }
}

pub struct CommaSep<'a, T: 'a>(pub &'a [T]);

impl<'a, T: fmt::Display> fmt::Display for CommaSep<'a, T> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        for (i, item) in self.0.iter().enumerate() {
            if i > 0 { try!(write!(f, ", ")); }
            try!(write!(f, "{}", item));
        }
        Ok(())
    }
}

impl fmt::Display for Unop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Unop::Negative => "-".fmt(f),
            Unop::Invert   => "~".fmt(f),
            Unop::Bang     => "!".fmt(f),
        }
    }
}

impl fmt::Display for Binop {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Binop::Plus      => "+".fmt(f),
            Binop::Minus     => "-".fmt(f),
            Binop::Times     => "*".fmt(f),
            Binop::Divide    => "/".fmt(f),
            Binop::Modulo    => "%".fmt(f),
            Binop::Less      => "<".fmt(f),
            Binop::LessEq    => "<=".fmt(f),
            Binop::Greater   => ">".fmt(f),
            Binop::GreaterEq => ">=".fmt(f),
            Binop::Equals    => "==".fmt(f),
            Binop::NEquals   => "!=".fmt(f),
            Binop::LAnd      => "&&".fmt(f),
            Binop::LOr       => "||".fmt(f),
            Binop::BAnd      => "&".fmt(f),
            Binop::BOr       => "|".fmt(f),
            Binop::Xor       => "^".fmt(f),
            Binop::LShift    => "<<".fmt(f),
            Binop::RShift    => ">>".fmt(f),
        }
    }
}

impl fmt::Display for Type {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Type::Int            => "int".fmt(f),
            Type::Bool           => "bool".fmt(f),
            Type::Alias(s)       => s.fmt(f),
            Type::Pointer(ref t) => write!(f, "{}*", t),
            Type::Array(ref t)   => write!(f, "{}[]", t),
            Type::Struct(s)      => write!(f, "struct {}", s),
            Type::Nullp          => "(null)".fmt(f),
            Type::Fun(ref t, ref l) => write!(f, "{}({})", t, CommaSep(l)),
        }
    }
}

impl fmt::Display for ast::Expr_ {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Expr_::Var(s) => write!(f, "{}", s),
            Expr_::Boolean(b) => write!(f, "{}", b),
            Expr_::Const(i) => write!(f, "{}", i),
            Expr_::UnaryOp(o, ref e) => write!(f, "{}({})", o, e),
            Expr_::Deref(ref e, _) => write!(f, "*({})", e),
            Expr_::Field(ref e, field, _) => write!(f, "{}.{}", e, field),
            Expr_::ArrSub(ref e1, ref e2, _) => write!(f, "{}[{}]", e1, e2),
            Expr_::Alloc(ref t) => write!(f, "alloc({})", t),
            Expr_::Null => write!(f, "NULL"),
            Expr_::AllocArray(ref t, ref e) => {
                write!(f, "alloc_array({}, {})", t, e)
            }
            Expr_::Call(ref e, ref args, _) => {
                write!(f, "{}({})", e, CommaSep(args))
            }
            Expr_::BinaryOp(o, ref e1, ref e2) => {
                write!(f, "({} {} {})", e1, o, e2)
            }
            Expr_::Ternary(ref e1, ref e2, ref e3, _) => {
                write!(f, "(({}) ? ({}) : ({}))", e1, e2, e3)
            }
        }
    }
}

impl fmt::Display for ast::Stmt_ {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            Stmt_::Continue => write!(f, "continue"),
            Stmt_::Break => write!(f, "break"),
            Stmt_::Nop => Ok(()),
            Stmt_::Return(ref e) => write!(f, "return {}", e),
            Stmt_::Express(ref e) => write!(f, "{}", e),
            Stmt_::Declare(v, ref t, ref init, ref s) => {
                try!(write!(f, "{} {}", t, v));
                if let Some(ref e) = *init {
                    try!(write!(f, " = {}", e));
                }
                try!(write!(f, "\n"));
                write!(tab(f), "{}", s)
            }
            Stmt_::While(ref e, ref s) => {
                try!(write!(f, "while ({}) {{\n", e));
                try!(write!(tab(f), "{}", s));
                write!(f, "\n}}")
            }
            Stmt_::If(ref e, ref s1, ref s2) => {
                try!(write!(f, "if ({}) {{\n", e));
                try!(write!(tab(f), "{}", s1));
                try!(write!(f, "}} else {{\n"));
                try!(write!(tab(f), "{}", s2));
                write!(f, "\n}}")
            }
            Stmt_::For(ref s1, ref e, ref s2, ref s3) => {
                try!(write!(f, "for ({}; {}; {}) {{\n", s1, e, s2));
                try!(write!(tab(f), "{}", s3));
                write!(f, "\n}}")
            }
            Stmt_::Assign(ref e1, ref o, ref e2) => {
                try!(write!(f, "{} ", e1));
                match *o {
                    Some(o) => try!(write!(f, " {}= ", o)),
                    None => try!(write!(f, " = ")),
                }
                write!(f, "{}", e2)
            }
            Stmt_::Seq(ref s1, ref s2) => {
                match (&s1.node, &s2.node) {
                    (&Stmt_::Nop, &Stmt_::Nop) => Ok(()),
                    (s, &Stmt_::Nop) |
                    (&Stmt_::Nop, s) => s.fmt(f),
                    (s1, s2) => write!(f, "{}\n{}", s1, s2),
                }
            }
        }
    }
}

fn pfun(f: &mut fmt::Formatter, t: &ast::Type,
        i: ast::Ident, p: &[(ast::Ident, ast::Type)]) -> fmt::Result
{
    try!(write!(f, "{} {} (", t, i));
    for (i, &(id, ref ty)) in p.iter().enumerate() {
        if i > 0 { try!(write!(f, ", ")); }
        try!(write!(f, "{} {}", ty, id));
    }
    write!(f, ")")
}

impl fmt::Display for ast::Item {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self.node {
            Item_::Typedef(s, ref t) => write!(f, "typedef {} {}", t, s),
            Item_::StructDecl(s) => write!(f, "struct {}", s),
            Item_::StructDef(s, ref l) => {
                try!(write!(f, "struct {} {{\n", s));
                for &(id, ref ty) in l.iter() {
                    try!(write!(f, "  {} {}", ty, id));
                }
                write!(f, "\n}}")
            }
            Item_::FunIDecl(ref t, s, ref args) => pfun(f, t, s, args),
            Item_::FunEDecl(ref t, s, ref args) => {
                try!(write!(f, "extern "));
                pfun(f, t, s, args)
            }
            Item_::Function(ref t, s, ref args, ref body) => {
                try!(pfun(f, t, s, args));
                try!(write!(f, " {{\n"));
                try!(write!(tab(f), "{}", body));
                write!(f, "\n}}")
            }
        }
    }
}
