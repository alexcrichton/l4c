#[link(name = "ptest")];

extern mod std;

use core::run;
use utils::*;

pub mod utils {
  pub mod profile;

  pub trait PrettyPrint {
    fn pp(&self) -> ~str;
  }
}

mod front {
  pub mod ast;
  pub mod mark;
  pub mod parse;
  pub mod pp;

  pub mod parser {
    pub mod lexer;
    pub mod parser;
  }
}

fn main() {
  use front::*;
  use std::getopts::*;
  use std::json;
  use core::io::ReaderUtil;

  let flags = ~[optflag("profile")];
  let args = os::args();
  let m = &match getopts(vec::tail(args), flags) {
    result::Ok(m)  => m,
    result::Err(e) => fail!(fail_str(e))
  };
  if m.free.len() == 0 {
    return;
  }

  let mut myast = do prof(m, "custom parser") {
    match front::parser::parser::parse_file(m.free) {
      Ok(ast) => ast,
      Err(s) => fail!(s)
    }
  };
  let mut jsonast = do prof(m, "generating ast") {
    let mut prog = get_json(m);
    let json = do prof(m, "reading/parsing json") {
      match (json::from_reader(prog.output()), prog.finish()) {
        (result::Ok(j), 0)  => j,
        (result::Err(e), 0) => fail!(fmt!("JSON parse error: %?", e.msg)),
        _ => {
          io::stderr().write(prog.err().read_whole_stream());
          unsafe { libc::exit(1); }
        }
      }
    };
    parse::from_json(&json, copy m.free[0])
  };
  jsonast.elaborate();
  myast.elaborate();
  io::println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< json");
  io::println(jsonast.pp());
  io::println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< mine");
  io::println(myast.pp());
  assert_eq!(jsonast.pp(), myast.pp());
}

fn prof<U>(m : &std::getopts::Matches, s : &str, f: &fn() -> U) -> U {
  if std::getopts::opt_present(m, "profile") {
    profile::run(f, s)
  } else {
    f()
  }
}

fn get_json(m : &std::getopts::Matches) -> run::Program {
  let mut prog = run::start_program("parse/parser", m.free);
  prog.close_input();
  return prog;
}
