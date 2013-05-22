use core::hashmap::HashMap;
use core::io;
use core::util;
use core::cell;

use front::ast::*;
use front::mark::{Marked, Mark, Span, Coords};
use front::parse;
use front::parser::lexer::*;

struct PositionGenerator {
  spans: ~[Coords],
  map: HashMap<Span, uint>,
  file: @str,
}

pub fn parse_file(f: &[~str]) -> Result<Program, ~str> {
  let mut decls = ~[];
  let mut symgen = parse::SymbolGenerator::new();
  let mut posgen = PositionGenerator::new();

  for f.each |f| {
    let input = match io::file_reader(&Path(*f)) {
      Ok(in) => in,
      Err(s) => { return Err(s); }
    };

    posgen.file = f.to_managed();
    let mut lexer = Lexer::new(input, &mut symgen);
    let mut parser = Parser::new(&mut lexer, &mut posgen);

    while parser.cur != EOF {
      decls.push(parser.gdecl());
    }
  }

  let syms = symgen.unwrap();
  let spans = posgen.unwrap();
  return Ok(Program::new(decls, syms, spans));
}

impl PositionGenerator {
  fn new() -> PositionGenerator {
    PositionGenerator{ spans: ~[], map: HashMap::new(), file: @"" }
  }

  fn gen(&mut self, sp: Span) -> Mark {
    match self.map.find(&sp) {
      Some(&id) => { return id; }
      None => {}
    }
    let ret = self.spans.len();
    self.spans.push(Coords(sp, self.file));
    self.map.insert(sp, ret);
    return ret;
  }

  fn to_span(&self, m: Mark) -> Span {
    match self.spans[m] { Coords(sp, _) => sp }
  }

  fn unwrap(self) -> ~[Coords] {
    match self { PositionGenerator{ spans, _ } => spans }
  }
}

struct Parser<'self> {
  lexer: &'self mut Lexer<'self>,
  posgen: &'self mut PositionGenerator,

  cur: Token,
  span: Span,
  pending: ~[(Token, Span)],
}

impl<'self> Parser<'self> {
  fn new<'a>(l: &'a mut Lexer<'a>, p: &'a mut PositionGenerator) -> Parser<'a> {
    let mut p = Parser{ lexer: l, cur: EOF, span: ((0, 0), (0, 0)),
                        pending: ~[], posgen: p };
    p.shift();
    p
  }

  fn gdecl(&mut self) -> ~GDecl {
    match self.cur {
      STRUCT => {
        match self.peek(1) {
          IDENT(*) => {
            match self.peek(2) {
              LBRACE => { return self.parse_sdecl(); }
              _ => {}
            }
          }
          _ => { self.err(self.span, "expected an identifier after 'struct'"); }
        }
      }

      _ => {}
    }

    return self.parse_fdecl();
  }

  // Parse a struct declaration
  fn parse_sdecl(&mut self) -> ~GDecl {
    let start = self.expect(STRUCT);
    let name = match self.shift() {
      (IDENT(id), _) => id, (_, sp) => self.err(sp, "expected identifier")
    };
    self.expect(LBRACE);
    let fields = self.parse_field_list();
    let end = self.expect(RBRACE);
    self.expect(SEMI);

    return self.mark(StructDef(name, fields), start, end);
  }

  // Parse a struct-like list of fields
  fn parse_field_list(&mut self) -> ~[(Ident, @Type)] {
    let mut fields = ~[];
    while self.cur != RBRACE {
      let typ = self.parse_type();
      let id = self.parse_ident();
      self.expect(SEMI);
      fields.push((id, typ));
    }
    return fields;
  }

  // Parse a function declaration or body
  fn parse_fdecl(&mut self) -> ~GDecl {
    let start = self.span;
    let ret = self.parse_type();
    let name = self.parse_ident();
    self.expect(LPAREN);
    let args = self.parse_argument_list();
    let end = self.expect(RPAREN);

    if self.cur == SEMI {
      self.shift();
      return self.mark(FunIDecl(ret, name, args), start, end);
    }

    if self.cur != LBRACE {
      self.err(self.span, "expected a '{' token");
    }
    let end = self.span;
    let body = self.parse_stmt();
    return self.mark(Function(ret, name, args, body), start, end);
  }

  // Parse one statement
  fn parse_stmt(&mut self) -> ~Statement {
    let start = self.span;
    match self.cur {
      LBRACE => {
        self.shift();
        let mut stmts = ~[];
        while self.cur != RBRACE {
          stmts.push(self.parse_stmt());
        }
        let end = self.expect(RBRACE);
        let mut cur = Some(self.mark(Nop, start, end));
        do vec::consume_reverse(stmts) |_, s| {
          match s {
            ~Marked{ node: Declare(id, typ, init, _), span } => {
              let sp = self.posgen.to_span(span);
              cur = Some(self.mark(Declare(id, typ, init, cur.swap_unwrap()),
                                   sp, sp));
            }
            s => {
              cur = Some(self.mark(Seq(s, cur.swap_unwrap()), start, end));
            }
          }
        }
        return cur.unwrap();
      }

      RETURN => {
        self.shift();
        let e = self.parse_exp();
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
        let cond = self.parse_exp();
        let end = self.expect(RPAREN);
        let body = self.parse_stmt();
        return self.mark(While(cond, body), start, end);
      }

      FOR => {
        self.shift();
        self.expect(LPAREN);
        let init = if self.cur == SEMI {
          self.mark(Nop, self.span, self.span)
        } else {
          self.parse_stmt()
        };
        self.expect(SEMI);
        let cond = self.parse_exp();
        self.expect(SEMI);
        let step = self.parse_stmt();
        let end = self.expect(RPAREN);
        let body = self.parse_stmt();
        return self.mark(For(init, cond, step, body), start, end);
      }

      IF => {
        self.shift();
        self.expect(LPAREN);
        let cond = self.parse_exp();
        let end = self.expect(RPAREN);
        let t = self.parse_stmt();
        let f = if self.cur == ELSE {
          self.shift();
          self.parse_stmt()
        } else {
          self.mark(Nop, self.span, self.span)
        };

        return self.mark(If(cond, t, f), start, end);
      }

      STRUCT | INT | BOOL | TYPE(*) => {
        let typ = self.parse_type();
        let name = self.parse_ident();
        match self.shift() {
          (SEMI, end) => {
            let rest = self.mark(Nop, start, start);
            return self.mark(Declare(name, typ, None, rest), start, end);
          }
          _ => fail!()
        }
      }

      IDENT(*) if self.peek(1) == PLUSPLUS || self.peek(1) == MINUSMINUS => {
        let id = self.parse_ident();
        let (op, end) = match self.shift() {
          (PLUSPLUS, s) => (Plus, s),
          (MINUSMINUS, s) => (Minus, s),
          _ => fail!()
        };
        let v = self.mark(Var(id), start, start);
        let c = self.mark(Const(1), end, end);
        return self.mark(Assign(v, Some(op), c), start, end);
      }

      _ => {
        let e = self.parse_exp();
        if self.cur == SEMI {
          let end = self.shift().second();
          return self.mark(Express(e), start, end);
        } else {
          let end = self.span;
          let op = self.parse_asnop();
          let e2 = self.parse_exp();
          self.expect(SEMI);
          return self.mark(Assign(e, op, e2), start, end);
        }
      }
    }
  }

  fn parse_exp(&mut self) -> ~Expression {
    let start = self.span;
    let mut base = match self.shift() {
      (IDENT(id), sp) => { self.mark(Var(id), sp, sp) }
      (INTCONST(i), sp) => { self.mark(Const(i), sp, sp) }
      (LPAREN, _) => {
        let e = self.parse_exp();
        self.expect(RPAREN);
        e
      }
      (STAR, start) => {
        let e = self.parse_exp();
        let end = self.posgen.to_span(e.span);
        self.mark(Deref(e, cell::empty_cell()), start, end)
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
        let size = self.parse_exp();
        let end = self.expect(RPAREN);
        self.mark(AllocArray(typ, size), start, end)
      }
      (t, sp) => self.err(sp, fmt!("unimpl %?", t))
    };

    loop {
      debug!("expanding expression %?", base);
      match self.cur {
        ARROW => {
          self.shift();
          let end = self.span;
          let field = self.parse_ident();
          base = self.mark(Deref(base, cell::empty_cell()), end, end);
          base = self.mark(Field(base, field, cell::empty_cell()), start, end);
        }

        LESSEQ => {
          self.shift();
          let next = self.parse_exp();
          let start = self.posgen.to_span(base.span);
          let end = self.posgen.to_span(next.span);
          base = self.mark(BinaryOp(LessEq, base, next), start, end);
        }

        _ => { return base; }
      }
    }
  }

  // Parse a list of arguments to a function
  fn parse_argument_list(&mut self) -> ~[(Ident, @Type)] {
    let mut fields = ~[];
    let mut first = true;
    while self.cur != RPAREN {
      if first {
        first = false;
      } else {
        self.expect(COMMA);
      }
      let typ = self.parse_type();
      let id = self.parse_ident();
      fields.push((id, typ));
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
  fn parse_type(&mut self) -> @Type {
    // First, get the base type
    let mut cur = match self.shift() {
      (BOOL, _)     => @Bool,
      (INT, _)      => @Int,
      (TYPE(id), _) => @Alias(id),
      (STRUCT, _)   => { @Struct(self.parse_ident()) }
      (NULL, _)     => @Nullp,
      (_, sp)       => self.err(sp, "expected a type")
    };

    // Next, decorate with pointers and arrays if necessary
    loop {
      match self.cur {
        STAR => {
          self.shift();
          cur = @Pointer(cur);
        }
        LBRACKET => {
          self.shift();
          self.expect(RBRACKET);
          cur = @Array(cur);
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

  // Expect the token to be in 'cur', and then advance
  fn expect(&mut self, t: Token) -> Span {
    if self.cur != t {
      self.err(self.span, fmt!("expected %?", t));
    }
    self.shift().second()
  }

  // Move one token down
  fn shift(&mut self) -> (Token, Span) {
    fn pop(p: &mut Parser) -> (Token, Span) {
      let (next, nsp) = if p.pending.len() > 0 {
        p.pending.shift()
      } else {
        p.lexer.next()
      };
      let prev = util::replace(&mut p.cur, next);
      let psp = util::replace(&mut p.span, nsp);
      (prev, psp)
    }

    let ret = pop(self);
    loop {
      match self.cur {
        NEWLINE | COMMENT(*) => { pop(self); }
        _ => { return ret; }
      }
    }
  }

  // Peek ahead in the input stream to look at a token
  fn peek(&mut self, amt: uint) -> Token {
    assert!(amt > 0);
    let amt = amt - 1;
    while amt >= self.pending.len() {
      self.pending.push(self.lexer.next());
    }
    return self.pending[amt].first();
  }

  fn mark<T>(&mut self, t: T, start: Span, end: Span) -> ~Marked<T> {
    return ~Marked::new(t, self.posgen.gen((start.first(), end.second())));
  }

  // Abort parsing with the given error
  fn err(&mut self, sp: Span, s: &str) -> ! {
    let ((a, b), (c, d)) = sp;
    io::println(fmt!("%s: %u:%u-%u:%u %s", self.posgen.file, a, b, c, d, s));
    unsafe { libc::exit(1); }
  }
}
