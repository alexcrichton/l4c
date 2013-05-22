use front::ast;
use front::mark::Span;
use core::io::ReaderUtil;
use core::hashmap::HashMap;
use front::parse::SymbolGenerator;

#[deriving(Eq, Clone)]
pub enum Token {
  EOF, SEMI, TRUE, FALSE, NULL, ALLOC, ALLOCARR, INT, BOOL, STRUCT, PLUS, MINUS,
  STAR, SLASH, PERCENT, PLUSPLUS, MINUSMINUS, AND, PIPE, BANG, CARET, LSHIFT,
  RSHIFT, TILDE, ANDAND, PIPEPIPE, EQUALS, NEQUALS, ASSIGN, PLUSEQ, MINUSEQ,
  STAREQ, SLASHEQ, PERCENTEQ, XOREQ, ANDEQ, OREQ, LSHIFTEQ, RSHIFTEQ, LESS,
  LESSEQ, GREATER, GREATEREQ, LBRACE, RBRACE, LPAREN, RPAREN, COMMA, PERIOD,
  ARROW, LBRACKET, RBRACKET, IF, ELSE, WHILE, FOR, CONTINUE, BREAK, RETURN,
  TYPEDEF, STATIC, QUESTION, COLON, ASNOP, NEWLINE,

  COMMENT,

  INTCONST(i32),
  IDENT(ast::Ident),
  TYPE(ast::Ident),
}

enum State {
  Start,
  Ident, Number, Hex,

  CommentLine, CommentBlock,

  OneSlash, OneStar, OneZero, OneEqual, OneLT, OneGT, OnePlus, OneMinus, OneAnd,
  OnePipe, OneCaret, OneBang, OnePercent,

  TwoLT, TwoGT,
}

pub struct Lexer<'self> {
  priv input: @io::Reader,
  priv keywords: HashMap<~str, Token>,
  priv symgen: &'self mut SymbolGenerator,

  priv state: State,
  priv cur: ~str,
  priv next: Option<char>,

  priv startrow: uint,
  priv startcol: uint,
  priv endrow: uint,
  priv endcol: uint,

  priv commdepth: int,
  priv commslash: bool,
  priv commstar: bool,
}

pub impl<'self> Lexer<'self> {
  fn new<'a>(in: @io::Reader, s: &'a mut SymbolGenerator) -> Lexer<'a> {
    let mut keywords = HashMap::new();
    keywords.insert(~"return", RETURN);
    keywords.insert(~"while", WHILE);
    keywords.insert(~"if", IF);
    keywords.insert(~"else", ELSE);
    keywords.insert(~"break", BREAK);
    keywords.insert(~"continue", CONTINUE);
    keywords.insert(~"for", FOR);
    keywords.insert(~"int", INT);
    keywords.insert(~"bool", BOOL);
    keywords.insert(~"true", TRUE);
    keywords.insert(~"false", FALSE);
    keywords.insert(~"NULL", NULL);
    keywords.insert(~"struct", STRUCT);
    keywords.insert(~"alloc", ALLOC);
    keywords.insert(~"alloc_array", ALLOCARR);
    keywords.insert(~"typedef", TYPEDEF);
    keywords.insert(~"static", STATIC);

    Lexer { input: in, cur: ~"", state: Start, commdepth: 0,
            next: None, keywords: keywords, symgen: s,
            commslash: false, commstar: false, startrow: 1, startcol: 1,
            endrow: 1, endcol: 1, }
  }

  fn next(&mut self) -> (Token, Span) {
    loop {
      let c = match self.next {
        Some(c) => { self.next = None; c }
        None => self.input.read_char()
      };
      if c as int == -1 {
        return (EOF, ((-1, -1), (-1, -1)));
      }
      match self.consume(c) {
        Some(tok) => {
          let start = (self.startrow, self.startcol);
          let end = (self.endrow, self.endcol);
          self.startrow = self.endrow;
          self.startcol = self.endcol;
          return (tok, (start, end));
        }
        None => {}
      }
    }
  }

  fn consume(&mut self, c: char) -> Option<Token> {
    self.endcol += 1;
    match self.state {
      Start => {
        match c {
          // whitespace skips
          '\t' | ' ' | '\x0b' | '\x0c' | '\x0d' => {
            self.startcol = self.endcol;
          }
          '\n' => {
            self.endrow += 1;
            self.endcol = 1;
            self.startrow = self.endrow;
            self.startcol = 1;
            return Some(NEWLINE);
          }

          // idents
          'a' .. 'z' | 'A' .. 'Z' | '_' => {
            self.state = Ident;
            self.cur.push_char(c);
          }

          // numbers
          '0' =>        { self.state = OneZero; }
          '1' .. '9' => { self.state = Number;  self.cur.push_char(c); }

          // Easy 1-character tokens
          '(' => { return Some(LPAREN); }
          ')' => { return Some(RPAREN); }
          '{' => { return Some(LBRACE); }
          '}' => { return Some(RBRACE); }
          '[' => { return Some(LBRACKET); }
          ']' => { return Some(RBRACKET); }
          '?' => { return Some(QUESTION); }
          ':' => { return Some(COLON); }
          ';' => { return Some(SEMI); }
          ',' => { return Some(COMMA); }
          '~' => { return Some(TILDE); }
          '.' => { return Some(PERIOD); }

          // A little more difficult, each of these can have more characters
          '/' => { self.state = OneSlash; }
          '*' => { self.state = OneStar; }
          '=' => { self.state = OneEqual; }
          '<' => { self.state = OneLT; }
          '>' => { self.state = OneGT; }
          '+' => { self.state = OnePlus; }
          '-' => { self.state = OneMinus; }
          '&' => { self.state = OneAnd; }
          '|' => { self.state = OnePipe; }
          '^' => { self.state = OneCaret; }
          '!' => { self.state = OneBang; }
          '%' => { self.state = OnePercent; }

          _ => fail!("unhandled %?", c)
        }
      }

      OneSlash => {
        match c {
          '*' => {
            self.state = CommentBlock;
            self.commdepth = 1;
            self.commslash = false;
            self.commstar = false;
          }
          '/' => { self.state = CommentLine; }
          '=' => { return self.reset(SLASHEQ); }
          _   => { return self.reset_back(c, SLASH); }
        }
      }
      OneStar => {
        match c {
          '=' => { return self.reset(STAREQ); }
          _   => { return self.reset_back(c, STAR); }
        }
      }
      OneEqual => {
        match c {
          '=' => { return self.reset(EQUALS); }
          _   => { return self.reset_back(c, ASSIGN); }
        }
      }
      OnePlus => {
        match c {
          '+' => { return self.reset(PLUSPLUS); }
          '=' => { return self.reset(PLUSEQ); }
          _   => { return self.reset_back(c, PLUS); }
        }
      }
      OneMinus => {
        match c {
          '+' => { return self.reset(MINUSMINUS); }
          '=' => { return self.reset(MINUSEQ); }
          '>' => { return self.reset(ARROW); }
          _   => { return self.reset_back(c, MINUS); }
        }
      }
      OneAnd => {
        match c {
          '&' => { return self.reset(ANDAND); }
          '=' => { return self.reset(ANDEQ); }
          _   => { return self.reset_back(c, AND); }
        }
      }
      OnePipe => {
        match c {
          '|' => { return self.reset(PIPEPIPE); }
          '=' => { return self.reset(OREQ); }
          _   => { return self.reset_back(c, PIPE); }
        }
      }
      OneCaret => {
        match c {
          '=' => { return self.reset(XOREQ); }
          _   => { return self.reset_back(c, CARET); }
        }
      }
      OneBang => {
        match c {
          '=' => { return self.reset(NEQUALS); }
          _   => { return self.reset_back(c, BANG); }
        }
      }
      OnePercent => {
        match c {
          '=' => { return self.reset(PERCENTEQ); }
          _   => { return self.reset_back(c, PERCENT); }
        }
      }
      OneLT => {
        match c {
          '<' => { self.state = TwoLT; }
          '=' => { return self.reset(LESSEQ); }
          _   => { return self.reset_back(c, LESS); }
        }
      }
      OneGT => {
        match c {
          '<' => { self.state = TwoGT; }
          '=' => { return self.reset(GREATEREQ); }
          _   => { return self.reset_back(c, GREATER); }
        }
      }

      TwoLT => {
        match c {
          '=' => { return self.reset(LSHIFTEQ); }
          _   => { return self.reset_back(c, LSHIFT); }
        }
      }
      TwoGT => {
        match c {
          '=' => { return self.reset(RSHIFTEQ); }
          _   => { return self.reset_back(c, RSHIFT); }
        }
      }

      CommentLine => {
        if c == '\n' {
          self.endrow += 1;
          self.endcol = 0;
          return self.reset(COMMENT);
        }
      }

      CommentBlock => {
        match c {
          '/' if self.commstar => {
            self.commstar = false;
            self.commdepth -= 1;
            if self.commdepth == 0 {
              return self.reset(COMMENT);
            }
          }
          '/' => { self.commslash = true; self.commstar = false; }
          '*' if self.commslash => {
            self.commslash = false;
            self.commdepth += 1;
          }
          '*' => { self.commstar = true; self.commslash = false; }
          _ => {
            self.commslash = false;
            self.commstar = false;
          }
        }
      }

      Ident => {
        match c {
          'a' .. 'z' | 'A' .. 'Z' | '_' | '0' .. '9' => {
            self.cur.push_char(c);
          }

          c => {
            let tok = self.ident();
            unsafe { str::raw::set_len(&mut self.cur, 0); }
            return self.reset_back(c, tok);
          }
        }
      }

      OneZero => {
        match c {
          'x' | 'X' => { self.state = Hex; }
          '1' .. '9' => { fail!("invalid literal"); }
          c => { return self.reset_back(c, INTCONST(0)); }
        }
      }

      Hex => {
        match c {
          '0' .. '9' | 'a' .. 'f' | 'A' .. 'F' => { self.cur.push_char(c); }
          c => {
            if self.cur.len() == 0 { fail!("invalid literal"); }
            let n = u32::from_str_radix(self.cur, 16).unwrap();
            unsafe { str::raw::set_len(&mut self.cur, 0); }
            return self.reset_back(c, INTCONST(n as i32));
          }
        }
      }

      Number => {
        match c {
          '0' .. '9' => { self.cur.push_char(c); }
          c => {
            let n = u32::from_str(self.cur).unwrap();
            unsafe { str::raw::set_len(&mut self.cur, 0); }
            return self.reset_back(c, INTCONST(n as i32));
          }
        }
      }
    }

    return None;
  }

  #[inline(always)]
  fn reset(&mut self, t: Token) -> Option<Token> {
    self.state = Start;
    return Some(t);
  }

  #[inline(always)]
  fn reset_back(&mut self, c: char, t: Token) -> Option<Token> {
    assert!(self.next.is_none());
    self.endcol -= 1;
    self.next = Some(c);
    return self.reset(t);
  }

  fn ident(&mut self) -> Token {
    match self.keywords.find(&self.cur) {
      Some(tok) => { return *tok; }
      None => {}
    }
    IDENT(self.symgen.intern(&self.cur))
  }
}