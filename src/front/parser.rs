use std::cell::RefCell;
use std::collections::HashMap;
use std::io;
use std::mem;

use front::die;
use front::ast;
use front::ast::*;
use front::mark::{Marked, Mark, Span, Coords};
use front::lexer::*;

struct PositionGenerator {
    spans: Vec<Coords>,
    map: HashMap<Span, uint>,
    file: String,
}

pub struct SymbolGenerator {
    symbols: Vec<String>,
    table: HashMap<String, uint>,
}

// Listed in order of ascending precedence
#[deriving(Ord, Eq, PartialEq, PartialOrd, Show)]
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
            PTernary | PAssign | PUnary => true,
            _ => false
        }
    }
}

pub fn parse_files(f: &[String], main: &str) -> Result<Program, String> {
    let mut decls = Vec::new();
    let mut symgen = SymbolGenerator::new();
    let mut posgen = PositionGenerator::new();

    for f in f.iter() {
        let input = match io::File::open(&Path::new(f.as_slice())).read_to_end() {
            Ok(i) => i,
            Err(e) => { return Err(format!("{}", e)); }
        };
        let mut rdr = io::MemReader::new(input);

        posgen.file = f.to_string();
        let mut lexer = Lexer::new(posgen.file.clone(), &mut rdr, &mut symgen);
        let mut parser = Parser::new(&mut lexer, &mut posgen, main);

        while parser.cur != EOF {
            decls.push(parser.parse_gdecl());
        }
    }

    let syms = symgen.unwrap();
    let spans = posgen.unwrap();
    return Ok(Program::new(decls, syms, spans));
}

impl SymbolGenerator {
    pub fn new() -> SymbolGenerator {
        SymbolGenerator{ table: HashMap::new(), symbols: Vec::new() }
    }

    pub fn intern(&mut self, s: &String) -> ast::Ident {
        let s = match self.table.find(s) {
            Some(&i) => { return ast::Ident(i) }
            None => s.clone()
        };
        let ret = self.symbols.len();
        self.table.insert(s.clone(), ret);
        self.symbols.push(s);
        return ast::Ident(ret);
    }

    pub fn unwrap(self) -> Vec<String> {
        match self { SymbolGenerator{ symbols, .. } => symbols }
    }
}

impl PositionGenerator {
    fn new() -> PositionGenerator {
        PositionGenerator{ spans: Vec::new(), map: HashMap::new(), file: String::new() }
    }

    fn gen(&mut self, sp: Span) -> Mark {
        match self.map.find(&sp) {
            Some(&id) => { return id; }
            None => {}
        }
        let ret = self.spans.len();
        self.spans.push(Coords(sp, self.file.clone()));
        self.map.insert(sp, ret);
        return ret;
    }

    fn to_span(&self, m: Mark) -> Span {
        match self.spans[m] { Coords(sp, _) => sp }
    }

    fn unwrap(self) -> Vec<Coords> {
        match self { PositionGenerator{ spans, .. } => spans }
    }
}

struct Parser<'a> {
    lexer: &'a mut Lexer<'a>,
    posgen: &'a mut PositionGenerator,
    target: &'a str,

    cur: Token,
    span: Span,
    pending: Vec<(Token, Span)>,
}

impl<'a> Parser<'a> {
    fn new<'a>(l: &'a mut Lexer<'a>, p: &'a mut PositionGenerator,
               target: &'a str) -> Parser<'a> {
        let mut p = Parser {
            lexer: l, cur: EOF, span: ((0, 0), (0, 0)),
            pending: Vec::new(), posgen: p, target: target
        };
        p.shift();
        p
    }

    // Parses one global declaration
    fn parse_gdecl(&mut self) -> Box<GDecl> {
        match self.cur {
            TYPEDEF => {
                let start = self.shift().val1();
                let typ = self.parse_type();
                let id = self.parse_ident();
                self.lexer.add_type(id); // must be before expectation
                let end = self.expect(SEMI);
                return self.mark(Typedef(id, typ), start, end);
            }

            // Struct declarations
            STRUCT if self.peek(2) == SEMI => {
                let start = self.expect(STRUCT);
                let end = self.span;
                let name = self.parse_ident_or_type();
                self.expect(SEMI);
                return self.mark(StructDecl(name), start, end);
            }

            // Struct definitions
            STRUCT if self.peek(2) == LBRACE => {
                let start = self.expect(STRUCT);
                let name = self.parse_ident_or_type();
                self.expect(LBRACE);
                let fields = self.parse_field_list();
                let end = self.expect(RBRACE);
                self.expect(SEMI);

                return self.mark(StructDef(name, fields), start, end);
            }

            _ => { self.parse_fdecl() }
        }
    }

    // Parse a struct name (which could be an ident or a type)
    fn parse_ident_or_type(&mut self) -> Ident {
        match self.shift() {
            (IDENT(id), _) | (TYPE(id), _) => id,
            (_, sp) => self.err(sp, "expected struct name")
        }
    }

    // Parse a struct-like list of fields
    fn parse_field_list(&mut self) -> Vec<(Ident, Type)> {
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
    fn parse_fdecl(&mut self) -> Box<GDecl> {
        let start = self.span;
        let ret = self.parse_type();
        let name = self.parse_ident();
        self.expect(LPAREN);
        let args = self.parse_list(|p| {
            let t = p.parse_type();
            let i = p.parse_ident();
            (i, t)
        });
        let end = self.expect(RPAREN);

        if self.cur == SEMI {
            self.shift();
            if self.target == self.posgen.file.as_slice() {
                return self.mark(FunIDecl(ret, name, args), start, end);
            }
            return self.mark(FunEDecl(ret, name, args), start, end);
        }

        // Ensure that parse_stmt will try to parse a block of statements by
        // ensuring that there's a '{' token
        if self.cur != LBRACE {
            let span = self.span;
            self.err(span, "expected a '{' token");
        }
        let end = self.span;
        let body = self.parse_stmt();
        return self.mark(Function(ret, name, args, body), start, end);
    }

    // Parse one statement
    fn parse_stmt(&mut self) -> Box<Statement> {
        let start = self.span;
        match self.cur {
            // Blocks can have multiple statements.
            LBRACE => {
                self.shift();
                let mut stmts = Vec::new();
                while self.cur != RBRACE {
                    stmts.push((self.cur == LBRACE, self.parse_stmt()));
                }
                let end = self.expect(RBRACE);
                let mut cur = Some(self.mark(Nop, start, end));
                for s in stmts.move_iter().rev() {
                    match s {
                        (false, box Marked{ node: Declare(id, typ, init, _), span }) => {
                            let sp = self.posgen.to_span(span);
                            cur = Some(self.mark(Declare(id, typ, init,
                                                         cur.take_unwrap()),
                            sp, sp));
                        }
                        (_, s) => {
                            cur = Some(self.mark(Seq(s, cur.take_unwrap()),
                                                 start, end));
                        }
                    }
                }
                return cur.unwrap();
            }

            RETURN => {
                self.shift();
                let e = self.parse_exp(Default);
                let end = self.expect(SEMI);
                return self.mark(Return(e), start, end);
            }

            CONTINUE => {
                self.shift();
                let end = self.expect(SEMI);
                return self.mark(Continue, start, end);
            }

            BREAK => {
                self.shift();
                let end = self.expect(SEMI);
                return self.mark(Break, start, end);
            }

            WHILE => {
                self.shift();
                self.expect(LPAREN);
                let cond = self.parse_exp(Default);
                let end = self.expect(RPAREN);
                let body = self.parse_stmt();
                return self.mark(While(cond, body), start, end);
            }

            FOR => {
                self.shift();
                self.expect(LPAREN);
                let init = if self.cur == SEMI {
                    let span = self.span;
                    self.mark(Nop, span, span)
                } else {
                    self.parse_simp()
                };
                self.expect(SEMI);
                let cond = self.parse_exp(Default);
                self.expect(SEMI);
                let step = if self.cur == RPAREN {
                    self.mark(Nop, start, start)
                } else {
                    self.parse_simp()
                };
                let end = self.expect(RPAREN);
                let body = self.parse_stmt();
                return self.mark(For(init, cond, step, body), start, end);
            }

            IF => {
                self.shift();
                self.expect(LPAREN);
                let cond = self.parse_exp(Default);
                let end = self.expect(RPAREN);
                let t = self.parse_stmt();
                let f = if self.cur == ELSE {
                    self.shift();
                    self.parse_stmt()
                } else {
                    let span = self.span;
                    self.mark(Nop, span, span)
                };

                return self.mark(If(cond, t, f), start, end);
            }

            _ => {
                let s = self.parse_simp();
                self.expect(SEMI);
                return s;
            }
        }
    }

    // Parses a simple statement (a subset of statements)
    fn parse_simp(&mut self) -> Box<Statement> {
        let start = self.span;
        match self.cur {
            // Declaration of a variable
            STRUCT | INT | BOOL | TYPE(..) => {
                let typ = self.parse_type();
                let name = self.parse_ident();
                let init = if self.cur == SEMI { None } else {
                    self.expect(ASSIGN);
                    Some(self.parse_exp(Default))
                };
                let end = self.span;
                let rest = self.mark(Nop, start, start);
                return self.mark(Declare(name, typ, init, rest), start, end);
            }

            // Generic assignments or expressions
            _ => {
                let e = self.parse_exp(Default);
                if self.cur == SEMI || self.cur == RPAREN {
                    let end = self.span;
                    return self.mark(Express(e), start, end);
                } if self.cur == PLUSPLUS || self.cur == MINUSMINUS {
                    let (op, end) = match self.shift() {
                        (PLUSPLUS, s) => (Plus, s),
                        (MINUSMINUS, s) => (Minus, s),
                        (_, s) => self.err(s, "expected ++ or --")
                    };
                    let c = self.mark(Const(1), end, end);
                    return self.mark(Assign(e, Some(op), c), start, end);
                } else {
                    let end = self.span;
                    let op = self.parse_asnop();
                    let e2 = self.parse_exp(Default);
                    return self.mark(Assign(e, op, e2), start, end);
                }
            }
        }
    }

    // Parse one expression, using no precedences lower than the given
    // precedence.
    fn parse_exp(&mut self, precedence: Precedence) -> Box<Expression> {
        debug!("exp({}) starting on {}", precedence, self.cur);
        let start = self.span;
        // Start with the lhs of an expression. It may have a rhs (to be determined
        // later on)
        let mut base = match self.shift() {
            // function calls
            (IDENT(id), sp) if self.cur == LPAREN => {
                self.expect(LPAREN);
                let args = self.parse_list(|p| p.parse_exp(Default));
                let end = self.expect(RPAREN);
                let e = self.mark(Var(id), sp, sp);
                self.mark(Call(e, args, RefCell::new(None)), start, end)
            }

            (IDENT(id), sp) => { self.mark(Var(id), sp, sp) }
            (INTCONST(i), sp) => { self.mark(Const(i), sp, sp) }
            (LPAREN, _) => {
                let e = self.parse_exp(Default);
                self.expect(RPAREN);
                e
            }
            (unop, start) if unop == MINUS || unop == BANG || unop == TILDE => {
                let unop = self.parse_unop(unop);
                let e = self.parse_exp(PUnary);
                let end = self.posgen.to_span(e.span);
                self.mark(UnaryOp(unop, e), start, end)
            }
            (STAR, start) => {
                let e = self.parse_exp(PUnary);
                let end = self.posgen.to_span(e.span);
                if self.cur == PLUSPLUS || self.cur == MINUSMINUS {
                    let span = self.span;
                    self.err(span, "invalid expression for C0");
                }
                self.mark(Deref(e, RefCell::new(None)), start, end)
            }
            (ALLOC, start) => {
                self.expect(LPAREN);
                let typ = self.parse_type();
                let end = self.expect(RPAREN);
                self.mark(Alloc(typ), start, end)
            }
            (ALLOCARR, start) => {
                self.expect(LPAREN);
                let typ = self.parse_type();
                self.expect(COMMA);
                let size = self.parse_exp(Default);
                let end = self.expect(RPAREN);
                self.mark(AllocArray(typ, size), start, end)
            }
            (NULL, sp)  => { self.mark(Null, sp, sp) }
            (TRUE, sp)  => { self.mark(Boolean(true), sp, sp) }
            (FALSE, sp) => { self.mark(Boolean(false), sp, sp) }
            (t, sp) => self.err(sp, format!("unimpl {}", t).as_slice())
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
                    let end = self.span;
                    let field = self.parse_ident_or_type();
                    base = self.mark(Field(base, field, RefCell::new(None)),
                                     start, end);
                }

                // this is purely syntactic sugar for a field of a deref, so we
                // simply expand that to doing so here.
                ARROW => {
                    self.shift();
                    let end = self.span;
                    let field = self.parse_ident_or_type();
                    base = self.mark(Deref(base, RefCell::new(None)), end, end);
                    base = self.mark(Field(base, field, RefCell::new(None)),
                                     start, end);
                }

                // Sure would be nice to not list out all the binops here.
                LESSEQ | GREATEREQ | MINUS | EQUALS | LESS | GREATER | SLASH |
                PLUS | STAR | PERCENT | AND | PIPE | PIPEPIPE | CARET |
                ANDAND | NEQUALS | LSHIFT | RSHIFT => {
                    let op = self.parse_binop();
                    let next = self.parse_exp(prec);
                    let start = self.posgen.to_span(base.span);
                    let end = self.posgen.to_span(next.span);
                    base = self.mark(BinaryOp(op, base, next), start, end);
                }

                LBRACKET => {
                    self.shift();
                    let idx = self.parse_exp(Default);
                    let end = self.expect(RBRACKET);
                    base = self.mark(ArrSub(base, idx, RefCell::new(None)),
                                     start, end);
                }

                QUESTION => {
                    self.shift();
                    let t = self.parse_exp(prec);
                    self.expect(COLON);
                    let f = self.parse_exp(prec);
                    let end = self.posgen.to_span(f.span);
                    base = self.mark(Ternary(base, t, f, RefCell::new(None)),
                                     start, end);
                }

                _ => break
            }
        }
        return base;
    }

    // Parse a list of arguments to a function
    fn parse_list<T>(&mut self, f: |&mut Parser| -> T) -> Vec<T> {
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
    fn parse_ident(&mut self) -> Ident {
        match self.shift() {
            (IDENT(id), _) => id,
            (_, sp) => self.err(sp, "expected an ident")
        }
    }

    // Parse a type
    fn parse_type(&mut self) -> Type {
        // First, get the base type
        let mut cur = match self.shift() {
            (BOOL, _)     => Bool,
            (INT, _)      => Int,
            (TYPE(id), _) => Alias(id),
            (STRUCT, _)   => { Struct(self.parse_ident_or_type()) }
            (NULL, _)     => Nullp,
            (_, sp)       => self.err(sp, "expected a type")
        };

        // Next, decorate with pointers and arrays if necessary
        loop {
            match self.cur {
                STAR => {
                    self.shift();
                    cur = Pointer(box cur);
                }
                LBRACKET => {
                    self.shift();
                    self.expect(RBRACKET);
                    cur = Array(box cur);
                }
                _ => { return cur; }
            }
        }
    }

    // Grab a binop (if one is available)
    fn parse_asnop(&mut self) -> Option<Binop> {
        match self.shift() {
            (ASSIGN, _)    => None,
            (PLUSEQ, _)    => Some(Plus),
            (MINUSEQ, _)   => Some(Minus),
            (STAREQ, _)    => Some(Times),
            (SLASHEQ, _)   => Some(Divide),
            (PERCENTEQ, _) => Some(Modulo),
            (ANDEQ, _)     => Some(BAnd),
            (OREQ, _)      => Some(BOr),
            (XOREQ, _)     => Some(Xor),
            (LSHIFTEQ, _)  => Some(LShift),
            (RSHIFTEQ, _)  => Some(RShift),
            (_, sp) => self.err(sp, "expected assignment or semicolon")
        }
    }

    // Parse one binary operation
    fn parse_binop(&mut self) -> Binop {
        match self.shift() {
            (PLUS, _)      => Plus,
            (MINUS, _)     => Minus,
            (STAR, _)      => Times,
            (SLASH, _)     => Divide,
            (PERCENT, _)   => Modulo,
            (AND, _)       => BAnd,
            (PIPE, _)      => BOr,
            (CARET, _)     => Xor,
            (LSHIFT, _)    => LShift,
            (RSHIFT, _)    => RShift,
            (LESSEQ, _)    => LessEq,
            (LESS, _)      => ast::Less,
            (GREATER, _)   => ast::Greater,
            (GREATEREQ, _) => GreaterEq,
            (EQUALS, _)    => Equals,
            (NEQUALS, _)   => NEquals,
            (ANDAND, _)    => LAnd,
            (PIPEPIPE, _)  => LOr,
            (_, sp)        => self.err(sp, "expected binary operation")
        }
    }

    // Parse one unary operation (token given)
    fn parse_unop(&mut self, unop: Token) -> Unop {
        match unop {
            BANG => Bang,
            TILDE => Invert,
            MINUS => Negative,
            _ => {
                let span = self.span;
                self.err(span, "expected unary operation")
            }
        }
    }

    // Expect the token to be in 'cur', and then advance
    fn expect(&mut self, t: Token) -> Span {
        if self.cur != t {
            let span = self.span;
            self.err(span, format!("expected {}", t).as_slice());
        }
        self.shift().val1()
    }

    // Move one token down
    fn shift(&mut self) -> (Token, Span) {
        fn pop(p: &mut Parser) -> (Token, Span) {
            let (next, nsp) = match p.pending.shift() {
                Some(p) => p,
                None => p.lexer.next()
            };
            let prev = mem::replace(&mut p.cur, next);
            let psp = mem::replace(&mut p.span, nsp);
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
    fn peek(&mut self, amt: uint) -> Token {
        assert!(amt > 0);
        let amt = amt - 1;
        while amt >= self.pending.len() {
            match self.lexer.next() {
                (NEWLINE, _) | (COMMENT(..), _) => { continue }
                tok => { self.pending.push(tok); }
            }
        }
        return self.pending[amt].val0();
    }

    fn mark<T>(&mut self, t: T, start: Span, end: Span) -> Box<Marked<T>> {
        box Marked::new(t, self.posgen.gen((start.val0(), end.val1())))
    }

    // Abort parsing with the given error
    fn err(&mut self, sp: Span, s: &str) -> ! {
        let ((a, b), (c, d)) = sp;
        println!("{}: {}:{}-{}:{} {}", self.posgen.file, a, b, c, d, s);
        die();
    }
}
