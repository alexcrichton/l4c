use std::collections::{HashMap, HashSet};
use std::i32;
use std::io;
use std::num;
use std::u32;

use front::die;
use front::ast;
use front::mark::Span;
use front::parser;

#[deriving(Eq, PartialEq, Clone, Show)]
pub enum Token {
    EOF, SEMI, TRUE, FALSE, NULL, ALLOC, ALLOCARR, INT, BOOL, STRUCT, PLUS,
    MINUS, STAR, SLASH, PERCENT, PLUSPLUS, MINUSMINUS, AND, PIPE, BANG, CARET,
    LSHIFT, RSHIFT, TILDE, ANDAND, PIPEPIPE, EQUALS, NEQUALS, ASSIGN, PLUSEQ,
    MINUSEQ, STAREQ, SLASHEQ, PERCENTEQ, XOREQ, ANDEQ, OREQ, LSHIFTEQ, RSHIFTEQ,
    LESS, LESSEQ, GREATER, GREATEREQ, LBRACE, RBRACE, LPAREN, RPAREN, COMMA,
    PERIOD, ARROW, LBRACKET, RBRACKET, IF, ELSE, WHILE, FOR, CONTINUE, BREAK,
    RETURN, TYPEDEF, STATIC, QUESTION, COLON, ASNOP, NEWLINE,

    COMMENT,

    INTCONST(i32),
    IDENT(ast::Ident),
    TYPE(ast::Ident),
}

enum State {
    Start,
    Ident, Number, Hex,

    CommentLine, CommentBlock,

    OneSlash, OneStar, OneZero, OneEqual, OneLT, OneGT, OnePlus, OneMinus,
    OneAnd, OnePipe, OneCaret, OneBang, OnePercent,

    TwoLT, TwoGT,
}

pub struct Lexer<'a> {
    input: io::BufferedReader<&'a mut io::Reader>,
    keywords: HashMap<String, Token>,
    bad_keywords: HashSet<String>,
    symgen: &'a mut parser::SymbolGenerator,
    types: HashSet<ast::Ident>,
    file: String,

    state: State,
    cur: String,
    next: Option<char>,

    startrow: uint,
    startcol: uint,
    endrow: uint,
    endcol: uint,

    commdepth: int,
    commslash: bool,
    commstar: bool,
}

impl<'a> Lexer<'a> {
    pub fn new<'a>(file: String, input: &'a mut io::Reader,
                   s: &'a mut parser::SymbolGenerator) -> Lexer<'a> {
        let input = io::BufferedReader::new(input);

        let mut keywords = HashMap::new();
        keywords.insert("return".to_string(), RETURN);
        keywords.insert("while".to_string(), WHILE);
        keywords.insert("if".to_string(), IF);
        keywords.insert("else".to_string(), ELSE);
        keywords.insert("break".to_string(), BREAK);
        keywords.insert("continue".to_string(), CONTINUE);
        keywords.insert("for".to_string(), FOR);
        keywords.insert("int".to_string(), INT);
        keywords.insert("bool".to_string(), BOOL);
        keywords.insert("true".to_string(), TRUE);
        keywords.insert("false".to_string(), FALSE);
        keywords.insert("NULL".to_string(), NULL);
        keywords.insert("struct".to_string(), STRUCT);
        keywords.insert("alloc".to_string(), ALLOC);
        keywords.insert("alloc_array".to_string(), ALLOCARR);
        keywords.insert("typedef".to_string(), TYPEDEF);
        keywords.insert("static".to_string(), STATIC);

        let mut bad_keywords = HashSet::new();
        bad_keywords.insert("char".to_string());
        bad_keywords.insert("string".to_string());
        bad_keywords.insert("void".to_string());

        Lexer {
            input: input, cur: "".to_string(), state: Start, commdepth: 0,
            next: None, keywords: keywords, symgen: s,
            commslash: false, commstar: false, startrow: 1, startcol: 1,
            endrow: 1, endcol: 1, types: HashSet::new(), file: file,
            bad_keywords: bad_keywords
        }
    }

    pub fn next(&mut self) -> (Token, Span) {
        loop {
            let c = match self.next {
                Some(c) => { self.next = None; c }
                None => match self.input.read_char() {
                    Ok(c) => c,
                    Err(..) => return (EOF, ((-1, -1), (-1, -1)))
                }
            };
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

                    // A little more difficult, each of these can have more
                    // characters
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

                    _ => self.err(format!("unexpected character `{}`", c).as_slice())
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
                    '-' => { return self.reset(MINUSMINUS); }
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
                    '>' => { self.state = TwoGT; }
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
                        self.cur.truncate(0);
                        return self.reset_back(c, tok);
                    }
                }
            }

            OneZero => {
                match c {
                    'x' | 'X' => { self.state = Hex; }
                    '1' .. '9' => {
                        self.err("invalid numerical literal (leading zero)")
                    }
                    c => { return self.reset_back(c, INTCONST(0)); }
                }
            }

            Hex => {
                match c {
                    '0' .. '9' | 'a' .. 'f' | 'A' .. 'F' => {
                        self.cur.push_char(c);
                    }
                    c => {
                        if self.cur.len() == 0 {
                            self.err("invalid hex literal (need digits");
                        }
                        let n = self.parse_num(16);
                        return self.reset_back(c, INTCONST(n));
                    }
                }
            }

            Number => {
                match c {
                    '0' .. '9' => { self.cur.push_char(c); }
                    c => {
                        let n = self.parse_num(10);
                        return self.reset_back(c, INTCONST(n));
                    }
                }
            }
        }

        return None;
    }

    fn parse_num(&mut self, base: uint) -> i32 {
        match num::from_str_radix::<u64>(self.cur.as_slice(), base) {
            Some(n) if (base == 10 && n <= i32::MAX as u64 + 1) ||
                (base == 16 && n <= u32::MAX as u64) => {
                    self.cur.truncate(0);
                    return n as i32;
                }
            _ => self.err("invalid numerical literal (too large)")
        }
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
        if self.bad_keywords.contains(&self.cur) {
            self.err("reserved keyword");
        }
        let id = self.symgen.intern(&self.cur);
        if self.types.contains(&id) {
            return TYPE(id);
        }
        return IDENT(id);
    }

    pub fn add_type(&mut self, t: ast::Ident) {
        self.types.insert(t);
    }

    // Abort lexing with the given error
    fn err(&mut self, s: &str) -> ! {
        println!("{}: {}:{}-{}:{} {}", self.file,
        self.startrow, self.startcol, self.endrow, self.endcol, s);
        die()
    }
}

impl Token {
    pub fn precedence(&self) -> parser::Precedence {
        match *self {
            ASSIGN                              => parser::PAssign,
            QUESTION | COLON                    => parser::PTernary,
            PIPEPIPE                            => parser::PLor,
            ANDAND                              => parser::PLand,
            PIPE                                => parser::PBor,
            CARET                               => parser::PXor,
            AND                                 => parser::PBand,
            EQUALS | NEQUALS                    => parser::PEquals,
            LESS | GREATER | LESSEQ | GREATEREQ => parser::PCmp,
            LSHIFT | RSHIFT                     => parser::PShift,
            PLUS | MINUS                        => parser::PAdd,
            STAR | PERCENT | SLASH              => parser::PTimes,
            BANG | TILDE                        => parser::PUnary,
            ARROW | PERIOD | LBRACKET | LPAREN  => parser::PHighest,
            _ => parser::Default,
        }
    }
}
