use std::cell::RefCell;
use std::io;
use std::mem;
use std::path::Path;

use front::ast::{self, Unop, Binop, Type, Expr_, Stmt_, Item_};
use front::lexer::{Lexer, Token};
use front::lexer::Token::*;
use utils::{Marked, Mark, Errors, CodeMap, SymbolGenerator, DUMMY_MARK};

// Listed in order of ascending precedence
#[derive(Ord, Eq, PartialEq, PartialOrd, Debug, Copy, Clone)]
pub enum Precedence {
    Default,
    PAssign,
    PTernary,
    PLor,
    PLand,
    PBor,
    PXor,
    PBand,
    PEquals,
    PCmp,
    PShift,
    PAdd,
    PTimes,
    PUnary,
    PHighest,
}

impl Precedence {
    fn right(&self) -> bool {
        match *self {
            Precedence::PTernary |
            Precedence::PAssign |
            Precedence::PUnary => true,
            _ => false
        }
    }
}

pub fn parse_files(f: &[String], main: &str) -> io::Result<ast::Program> {
    let mut decls = Vec::new();
    let mut symgen = SymbolGenerator::new();
    let mut errors = Errors::new(CodeMap::new());

    for f in f.iter() {
        let file = try!(errors.codemap_mut().add(Path::new(f)));
        let mut lexer = Lexer::new(&errors, file, &mut symgen);
        let mut parser = Parser::new(&mut lexer, &errors, f != main);

        while parser.cur != EOF {
            decls.push(parser.parse_gdecl());
        }
    }

    symgen.store();
    Ok(ast::Program::new(decls, errors))
}

struct Parser<'a> {
    lexer: &'a mut Lexer<'a>,
    errors: &'a Errors,
    header: bool,

    cur: Token,
    mark: Mark,
    pending: Vec<(Token, Mark)>,
}

impl<'a> Parser<'a> {
    fn new(l: &'a mut Lexer<'a>, errors: &'a Errors,
           header: bool) -> Parser<'a> {
        let mut p = Parser {
            lexer: l,
            cur: EOF,
            mark: DUMMY_MARK,
            pending: Vec::new(),
            errors: errors,
            header: header,
        };
        p.shift();
        p
    }

    // Parses one global declaration
    fn parse_gdecl(&mut self) -> ast::Item {
        match self.cur {
            TYPEDEF => {
                let start = self.shift().1;
                let typ = self.parse_type();
                let id = self.parse_ident();
                self.lexer.add_type(id); // must be before expectation
                let end = self.expect(SEMI);
                self.mark(Item_::Typedef(id, typ), start, end)
            }

            STRUCT => {
                // Struct declarations
                if self.peek(2) == SEMI {
                    let start = self.expect(STRUCT);
                    let end = self.mark;
                    let name = self.parse_ident_or_type();
                    self.expect(SEMI);
                    return self.mark(Item_::StructDecl(name), start, end)
                }

                // Struct definitions
                if self.peek(2) == LBRACE {
                    let start = self.expect(STRUCT);
                    let name = self.parse_ident_or_type();
                    self.expect(LBRACE);
                    let fields = self.parse_field_list();
                    let end = self.expect(RBRACE);
                    self.expect(SEMI);

                    return self.mark(Item_::StructDef(name, fields), start, end)
                }

                self.parse_fdecl()
            }

            _ => self.parse_fdecl(),
        }
    }

    // Parse a struct name (which could be an ident or a type)
    fn parse_ident_or_type(&mut self) -> ast::Ident {
        match self.shift() {
            (IDENT(id), _) | (TYPE(id), _) => id,
            (_, sp) => self.err(sp, "expected struct name")
        }
    }

    // Parse a struct-like list of fields
    fn parse_field_list(&mut self) -> Vec<(ast::Ident, Type)> {
        let mut fields = Vec::new();
        while self.cur != RBRACE {
            let typ = self.parse_type();
            let id = self.parse_ident_or_type();
            self.expect(SEMI);
            fields.push((id, typ));
        }
        return fields;
    }

    // Parse a function declaration or body
    fn parse_fdecl(&mut self) -> ast::Item {
        let start = self.mark;
        let ret = self.parse_type();
        let name = self.parse_ident();
        self.expect(LPAREN);
        let args = self.parse_list(&mut |p| {
            let t = p.parse_type();
            let i = p.parse_ident();
            (i, t)
        });
        let end = self.expect(RPAREN);

        if self.cur == SEMI {
            self.shift();
            if self.header {
                return self.mark(Item_::FunEDecl(ret, name, args), start, end);
            }
            return self.mark(Item_::FunIDecl(ret, name, args), start, end);
        }

        // Ensure that parse_stmt will try to parse a block of statements by
        // ensuring that there's a '{' token
        if self.cur != LBRACE {
            let mark = self.mark;
            self.err(mark, "expected a '{' token");
        }
        let end = self.mark;
        let body = self.parse_stmt();
        self.mark(Item_::Function(ret, name, args, body), start, end)
    }

    // Parse one statement
    fn parse_stmt(&mut self) -> ast::Stmt {
        let start = self.mark;
        match self.cur {
            // Blocks can have multiple statements.
            LBRACE => {
                self.shift();
                let mut stmts = Vec::new();
                while self.cur != RBRACE {
                    stmts.push((self.cur == LBRACE, self.parse_stmt()));
                }
                let end = self.expect(RBRACE);
                let mut cur = self.mark(Stmt_::Nop, start, end);
                for (is_lbrace, stmt) in stmts.into_iter().rev() {
                    if !is_lbrace {
                        if let Stmt_::Declare(id, typ, init, _) = stmt.node {
                            let rest = Box::new(cur);
                            cur = self.mark(Stmt_::Declare(id, typ, init, rest),
                                            stmt.mark, stmt.mark);
                            continue
                        }
                    }
                    cur = self.mark(Stmt_::Seq(Box::new(stmt),
                                               Box::new(cur)), start, end);
                }
                return cur
            }

            RETURN => {
                self.shift();
                let e = self.parse_exp(Precedence::Default);
                let end = self.expect(SEMI);
                self.mark(Stmt_::Return(e), start, end)
            }

            CONTINUE => {
                self.shift();
                let end = self.expect(SEMI);
                self.mark(Stmt_::Continue, start, end)
            }

            BREAK => {
                self.shift();
                let end = self.expect(SEMI);
                self.mark(Stmt_::Break, start, end)
            }

            WHILE => {
                self.shift();
                self.expect(LPAREN);
                let cond = self.parse_exp(Precedence::Default);
                let end = self.expect(RPAREN);
                let body = Box::new(self.parse_stmt());
                self.mark(Stmt_::While(cond, body), start, end)
            }

            FOR => {
                self.shift();
                self.expect(LPAREN);
                let init = Box::new(if self.cur == SEMI {
                    self.mark(Stmt_::Nop, self.mark, self.mark)
                } else {
                    self.parse_simp()
                });
                self.expect(SEMI);
                let cond = self.parse_exp(Precedence::Default);
                self.expect(SEMI);
                let step = Box::new(if self.cur == RPAREN {
                    self.mark(Stmt_::Nop, start, start)
                } else {
                    self.parse_simp()
                });
                let end = self.expect(RPAREN);
                let body = Box::new(self.parse_stmt());
                self.mark(Stmt_::For(init, cond, step, body), start, end)
            }

            IF => {
                self.shift();
                self.expect(LPAREN);
                let cond = self.parse_exp(Precedence::Default);
                let end = self.expect(RPAREN);
                let t = Box::new(self.parse_stmt());
                let f = Box::new(if self.cur == ELSE {
                    self.shift();
                    self.parse_stmt()
                } else {
                    let mark = self.mark;
                    self.mark(Stmt_::Nop, mark, mark)
                });

                self.mark(Stmt_::If(cond, t, f), start, end)
            }

            _ => {
                let s = self.parse_simp();
                self.expect(SEMI);
                return s
            }
        }
    }

    // Parses a simple statement (a subset of statements)
    fn parse_simp(&mut self) -> ast::Stmt {
        let start = self.mark;
        match self.cur {
            // Declaration of a variable
            STRUCT | INT | BOOL | TYPE(..) => {
                let typ = self.parse_type();
                let name = self.parse_ident();
                let init = if self.cur == SEMI { None } else {
                    self.expect(ASSIGN);
                    Some(self.parse_exp(Precedence::Default))
                };
                let end = self.mark;
                let rest = Box::new(self.mark(Stmt_::Nop, start, start));
                self.mark(Stmt_::Declare(name, typ, init, rest), start, end)
            }

            // Generic assignments or expressions
            _ => {
                let e = self.parse_exp(Precedence::Default);
                if self.cur == SEMI || self.cur == RPAREN {
                    self.mark(Stmt_::Express(e), start, self.mark)
                } else if self.cur == PLUSPLUS || self.cur == MINUSMINUS {
                    let (op, end) = match self.shift() {
                        (PLUSPLUS, s) => (Binop::Plus, s),
                        (MINUSMINUS, s) => (Binop::Minus, s),
                        (_, s) => self.err(s, "expected ++ or --")
                    };
                    let c = self.mark(Expr_::Const(1), end, end);
                    self.mark(Stmt_::Assign(e, Some(op), c), start, end)
                } else {
                    let end = self.mark;
                    let op = self.parse_asnop();
                    let e2 = self.parse_exp(Precedence::Default);
                    self.mark(Stmt_::Assign(e, op, e2), start, end)
                }
            }
        }
    }

    // Parse one expression, using no precedences lower than the given
    // precedence.
    fn parse_exp(&mut self, precedence: Precedence) -> ast::Expr {
        debug!("exp({:?}) starting on {:?}", precedence, self.cur);
        let start = self.mark;
        // Start with the lhs of an expression. It may have a rhs (to be determined
        // later on)
        let mut base = match self.shift() {
            // function calls
            (IDENT(id), sp) if self.cur == LPAREN => {
                self.expect(LPAREN);
                let args = self.parse_list(&mut |p| {
                    p.parse_exp(Precedence::Default)
                });
                let end = self.expect(RPAREN);
                let e = Box::new(self.mark(Expr_::Var(id), sp, sp));
                self.mark(Expr_::Call(e, args, rcn()), start, end)
            }

            (IDENT(id), sp) => self.mark(Expr_::Var(id), sp, sp),
            (INTCONST(i), sp) => self.mark(Expr_::Const(i), sp, sp),
            (LPAREN, _) => {
                let e = self.parse_exp(Precedence::Default);
                self.expect(RPAREN);
                e
            }
            (unop, start) if unop == MINUS || unop == BANG || unop == TILDE => {
                let unop = self.parse_unop(unop);
                let e = Box::new(self.parse_exp(Precedence::PUnary));
                let end = e.mark;
                self.mark(Expr_::UnaryOp(unop, e), start, end)
            }
            (STAR, start) => {
                let e = Box::new(self.parse_exp(Precedence::PUnary));
                if self.cur == PLUSPLUS || self.cur == MINUSMINUS {
                    self.err(self.mark, "invalid expression for C0");
                }
                let end = e.mark;
                self.mark(Expr_::Deref(e, rcn()), start, end)
            }
            (ALLOC, start) => {
                self.expect(LPAREN);
                let typ = self.parse_type();
                let end = self.expect(RPAREN);
                self.mark(Expr_::Alloc(typ), start, end)
            }
            (ALLOCARR, start) => {
                self.expect(LPAREN);
                let typ = self.parse_type();
                self.expect(COMMA);
                let size = Box::new(self.parse_exp(Precedence::Default));
                let end = self.expect(RPAREN);
                self.mark(Expr_::AllocArray(typ, size), start, end)
            }
            (NULL, sp)  => self.mark(Expr_::Null, sp, sp),
            (TRUE, sp)  => self.mark(Expr_::Boolean(true), sp, sp),
            (FALSE, sp) => self.mark(Expr_::Boolean(false), sp, sp),
            (t, sp) => self.err(sp, &format!("unimpl {:?}", t)),
        };

        // while we can conume more tokens (as determined by precedences), do so
        loop {
            let prec = self.cur.precedence();
            if precedence > prec || (precedence == prec && !prec.right()) {
                break;
            }

            match self.cur {
                PERIOD => {
                    self.shift();
                    let end = self.mark;
                    let field = self.parse_ident_or_type();
                    base = self.mark(Expr_::Field(Box::new(base), field, rcn()),
                                     start, end);
                }

                // this is purely syntactic sugar for a field of a deref, so we
                // simply expand that to doing so here.
                ARROW => {
                    self.shift();
                    let end = self.mark;
                    let field = self.parse_ident_or_type();
                    base = self.mark(Expr_::Deref(Box::new(base), rcn()),
                                     end, end);
                    base = self.mark(Expr_::Field(Box::new(base), field, rcn()),
                                     start, end);
                }

                // Sure would be nice to not list out all the binops here.
                LESSEQ | GREATEREQ | MINUS | EQUALS | LESS | GREATER | SLASH |
                PLUS | STAR | PERCENT | AND | PIPE | PIPEPIPE | CARET |
                ANDAND | NEQUALS | LSHIFT | RSHIFT => {
                    let op = self.parse_binop();
                    let next = Box::new(self.parse_exp(prec));
                    let (start, end) = (base.mark, next.mark);
                    base = self.mark(Expr_::BinaryOp(op, Box::new(base), next),
                                     start, end);
                }

                LBRACKET => {
                    self.shift();
                    let idx = Box::new(self.parse_exp(Precedence::Default));
                    let end = self.expect(RBRACKET);
                    base = self.mark(Expr_::ArrSub(Box::new(base), idx, rcn()),
                                     start, end);
                }

                QUESTION => {
                    self.shift();
                    let t = Box::new(self.parse_exp(prec));
                    self.expect(COLON);
                    let f = Box::new(self.parse_exp(prec));
                    let end = f.mark;
                    base = self.mark(Expr_::Ternary(Box::new(base), t, f, rcn()),
                                     start, end);
                }

                _ => break
            }
        }
        return base;
    }

    // Parse a list of arguments to a function
    fn parse_list<T>(&mut self, f: &mut FnMut(&mut Parser) -> T) -> Vec<T> {
        let mut fields = Vec::new();
        let mut first = true;
        while self.cur != RPAREN {
            if first {
                first = false;
            } else {
                self.expect(COMMA);
            }
            fields.push(f(self));
        }
        return fields;
    }

    // Parse an IDENT
    fn parse_ident(&mut self) -> ast::Ident {
        match self.shift() {
            (IDENT(id), _) => id,
            (_, sp) => self.err(sp, "expected an ident")
        }
    }

    // Parse a type
    fn parse_type(&mut self) -> Type {
        // First, get the base type
        let mut cur = match self.shift() {
            (BOOL, _)     => Type::Bool,
            (INT, _)      => Type::Int,
            (TYPE(id), _) => Type::Alias(id),
            (STRUCT, _)   => Type::Struct(self.parse_ident_or_type()),
            (NULL, _)     => Type::Nullp,
            (_, sp)       => self.err(sp, "expected a type")
        };

        // Next, decorate with pointers and arrays if necessary
        loop {
            match self.cur {
                STAR => {
                    self.shift();
                    cur = Type::Pointer(Box::new(cur));
                }
                LBRACKET => {
                    self.shift();
                    self.expect(RBRACKET);
                    cur = Type::Array(Box::new(cur));
                }
                _ => { return cur; }
            }
        }
    }

    // Grab a binop (if one is available)
    fn parse_asnop(&mut self) -> Option<Binop> {
        match self.shift() {
            (ASSIGN, _)    => None,
            (PLUSEQ, _)    => Some(Binop::Plus),
            (MINUSEQ, _)   => Some(Binop::Minus),
            (STAREQ, _)    => Some(Binop::Times),
            (SLASHEQ, _)   => Some(Binop::Divide),
            (PERCENTEQ, _) => Some(Binop::Modulo),
            (ANDEQ, _)     => Some(Binop::BAnd),
            (OREQ, _)      => Some(Binop::BOr),
            (XOREQ, _)     => Some(Binop::Xor),
            (LSHIFTEQ, _)  => Some(Binop::LShift),
            (RSHIFTEQ, _)  => Some(Binop::RShift),
            (_, sp) => self.err(sp, "expected assignment or semicolon")
        }
    }

    // Parse one binary operation
    fn parse_binop(&mut self) -> Binop {
        match self.shift() {
            (PLUS, _)      => Binop::Plus,
            (MINUS, _)     => Binop::Minus,
            (STAR, _)      => Binop::Times,
            (SLASH, _)     => Binop::Divide,
            (PERCENT, _)   => Binop::Modulo,
            (AND, _)       => Binop::BAnd,
            (PIPE, _)      => Binop::BOr,
            (CARET, _)     => Binop::Xor,
            (LSHIFT, _)    => Binop::LShift,
            (RSHIFT, _)    => Binop::RShift,
            (LESSEQ, _)    => Binop::LessEq,
            (LESS, _)      => Binop::Less,
            (GREATER, _)   => Binop::Greater,
            (GREATEREQ, _) => Binop::GreaterEq,
            (EQUALS, _)    => Binop::Equals,
            (NEQUALS, _)   => Binop::NEquals,
            (ANDAND, _)    => Binop::LAnd,
            (PIPEPIPE, _)  => Binop::LOr,
            (_, sp)        => self.err(sp, "expected binary operation")
        }
    }

    // Parse one unary operation (token given)
    fn parse_unop(&mut self, unop: Token) -> Unop {
        match unop {
            BANG => Unop::Bang,
            TILDE => Unop::Invert,
            MINUS => Unop::Negative,
            _ => {
                let mark = self.mark;
                self.err(mark, "expected unary operation")
            }
        }
    }

    // Expect the token to be in 'cur', and then advance
    fn expect(&mut self, t: Token) -> Mark {
        if self.cur != t {
            self.err(self.mark, &format!("expected {:?}", t));
        }
        self.shift().1
    }

    // Move one token down
    fn shift(&mut self) -> (Token, Mark) {
        fn pop(p: &mut Parser) -> (Token, Mark) {
            let (next, nsp) = if p.pending.len() > 0 {
                p.pending.remove(0)
            } else {
                p.lexer.next()
            };
            let prev = mem::replace(&mut p.cur, next);
            let psp = mem::replace(&mut p.mark, nsp);
            (prev, psp)
        }

        let ret = pop(self);
        loop {
            match self.cur {
                NEWLINE | COMMENT(..) => { pop(self); }
                _ => { return ret; }
            }
        }
    }

    // Peek ahead in the input stream to look at a token
    fn peek(&mut self, amt: usize) -> Token {
        assert!(amt > 0);
        let amt = amt - 1;
        while amt >= self.pending.len() {
            match self.lexer.next() {
                (NEWLINE, _) | (COMMENT(..), _) => { continue }
                tok => { self.pending.push(tok); }
            }
        }
        return self.pending[amt].0
    }

    fn mark<T>(&self, t: T, lo: Mark, hi: Mark) -> Marked<T> {
        Marked::new(t, Mark { lo: lo.lo, hi: hi.hi })
    }

    // Abort parsing with the given error
    fn err(&self, mark: Mark, s: &str) -> ! {
        self.errors.die(mark, s)
    }
}

fn rcn<T>() -> RefCell<Option<T>> { RefCell::new(None) }
