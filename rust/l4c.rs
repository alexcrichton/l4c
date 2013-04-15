#[link(name = "l4c")];

extern mod std;

use core::run;
use utils::*;

pub mod utils {
  pub mod set;
  pub mod graph;
  pub mod profile;

  pub trait PrettyPrint {
    fn pp(&self) -> ~str;
  }
  pub trait Graphable {
    fn dot(&self, @io::Writer);
  }
}

mod front {
  pub mod ast;
  pub mod error;
  pub mod mark;
  pub mod parse;
  mod pp;

  pub mod analysis {
    mod initcheck;
    mod maincheck;
    mod returncheck;
    mod typecheck;
  }
}

mod middle {
  pub mod ir;
  pub mod label;
  pub mod temp;
  pub mod ssa;
  pub mod liveness;
  pub mod trans;

  pub mod opt {
    mod cfold;
    mod cfg;
    mod deadcode;
  }
}

mod back {
  pub mod alloc;
  pub mod arch;
  pub mod assem;
  pub mod coalesce;
  pub mod codegen;
  pub mod precolor;
  pub mod ressa;
  pub mod spill;
  pub mod peephole;
}

fn help() {
  io::print(fmt!("Usage: %s", os::args()[0]));
  io::println(" [OPTION...] SOURCEFILE
where OPTION is
  -v        --verbose       verbose messages
            --dump-ast      pretty print the AST
            --dump-asm      pretty print the assembly before register allocaction
  -p        --profile       profile the compiler
  -l l4.h0  --header=l4.h0  header file for the program
            --dot           output DOT file for the cfg
            --safe          safe compilation with memory checks
            --unsafe        unsafe compilation with no memory checks
  -O 0      --optimize=0    level of optimizations to perform
  -m x64    --arch=x64      architecture to emit ([x64] | x86)

");
}

#[allow(non_implicitly_copyable_typarams)]
fn main() {
  use front::*;
  use middle::*;
  use back::*;
  use std::getopts::*;
  use std::json;
  use core::io::ReaderUtil;

  let flags = ~[
    optflag("v"), optflag("verbose"),
    optflag("dump-ast"),
    optflag("profile"),
    optflag("f"), optflag("profile"),
    optopt("header"), optopt("l"),
    optflag("dot-ir"), optflag("dot-ssa"), optflag("dot-cfold"),
    optflag("dot-deadcode"), optflag("dot-simplify"),
    optflag("dot-assem"), optflag("dot-spilled"), optflag("dot-ressa"),
    optflag("dot-colored"), optflag("dot-precolor"), optflag("dot-peephole"),
    optflag("safe"), optflag("unsafe"),
    optopt("O"), optopt("optimize"),
    optopt("m"), optopt("arch"),
  ];
  let args = os::args();
  let m = &match getopts(vec::tail(args), flags) {
    result::Ok(m)  => m,
    result::Err(e) => fail!(fail_str(e))
  };
  if m.free.len() == 0 {
    help();
    return;
  }

  /* front */
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
  let ast = do prof(m, "generating ast") {
    parse::from_json(&json, copy m.free[0])
  };
  let ast = ast.elaborate();
  if opt_present(m, "dump-ast") {
    io::println(ast.pp());
  }
  do prof(m, "typecheck")   { analysis::typecheck::check(&ast)   }
  do prof(m, "returncheck") { analysis::returncheck::check(&ast) }
  do prof(m, "maincheck")   { analysis::maincheck::check(&ast)   }
  do prof(m, "initcheck")   { analysis::initcheck::check(&ast)   }

  /* middle */
  let safe = opt_present(m, "safe") && !opt_present(m, "unsafe");
  let mut ir = trans::translate(ast, safe);
  if opt_present(m, "dot-ir")  { ir.dot(io::stdout()); }
  pass(ir::ssa, &mut ir, m, "dot-ssa");

  pass(opt::cfold::optimize,    &mut ir, m, "dot-cfold");
  pass(opt::cfg::simplify,      &mut ir, m, "dot-simplify");
  pass(opt::deadcode::optimize, &mut ir, m, "dot-deadcode");

  /* backend */
  let mut assem = codegen::codegen(ir);
  if opt_present(m, "dot-assem") { assem.dot(io::stdout()); }
  pass(peephole::optimize,  &mut assem, m, "dot-peephole");
  pass(precolor::constrain, &mut assem, m, "dot-precolor");
  pass(spill::spill,        &mut assem, m, "dot-spilled");
  pass(ressa::convert,      &mut assem, m, "dot-ressa");
  pass(alloc::color,        &mut assem, m, "dot-colored");

  let output = Path(m.free[0]).with_filetype("s");
  match io::file_writer(&output, ~[io::Truncate, io::Create]) {
    result::Ok(f)  => assem.output(f),
    result::Err(e) => fail!(e)
  }
}

fn pass<T : Graphable, U>(f: &fn(&mut T) -> U, p: &mut T,
                          m: &std::getopts::Matches, s: &str) -> U {
  let ret = do prof(m, s) { f(p) };
  if std::getopts::opt_present(m, s) {
    p.dot(io::stdout());
  }
  return ret;
}

fn prof<U>(m : &std::getopts::Matches, s : &str, f: &fn() -> U) -> U {
  if std::getopts::opt_present(m, "profile") {
    profile::run(f, s)
  } else {
    f()
  }
}

#[allow(non_implicitly_copyable_typarams)]
fn get_json(m : &std::getopts::Matches) -> @run::Program {
  use std::getopts::*;
  let header = opt_maybe_str(m, "l").or(opt_maybe_str(m, "header"));
  let files = &match header {
    None => copy m.free,
    Some(file) => vec::append(~[file], m.free)
  };
  let mut prog = run::start_program("parse/parser", *files);
  prog.close_input();
  return prog;
}
