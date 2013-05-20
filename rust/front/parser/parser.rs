use front::ast;
use front::parse;
use super::lexer::Lexer;
use super::grammar::*;
use core::io;

pub fn parse_file(f: &str) -> Result<ast::Program, ~str> {
  do io::file_reader(&Path(f)).chain |r| {
    let mut symgen = parse::SymbolGenerator::new();
    let mut lexer = Lexer::new(r, &mut symgen);

    loop {
      let t = lexer.next();
      io::println(fmt!("%?", t));
      if t == EOF { break }
    }

    fail!()
  }
}
