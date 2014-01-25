#[feature(macro_rules, globs)];

extern mod extra;

use std::io;
use std::result;
use std::vec;
use std::os;

use utils::profile;
use utils::PrettyPrint;
use utils::Graphable;

mod utils {
    pub mod set;
    pub mod graph;
    pub mod profile;

    pub trait PrettyPrint {
        fn pp(&self) -> ~str;
    }
    pub trait Graphable {
        fn dot(&self, &mut ::std::io::Writer);
    }
}

mod front {
    pub mod ast;
    pub mod mark;
    pub mod pp;
    pub mod lexer;
    pub mod parser;

    pub mod analysis {
        pub mod initcheck;
        pub mod maincheck;
        pub mod returncheck;
        pub mod typecheck;
    }

    pub fn die() -> ! {
        use std::libc;
        unsafe { libc::exit(1) }
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
        pub mod cfold;
        pub mod cfg;
        pub mod deadcode;
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
    println!("Usage: {}", os::args()[0]);
    println!(" [OPTION...] SOURCEFILE
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

fn main() {
    use extra::getopts::{optflag, optopt, getopts};

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
    let m = &match getopts(args.tail(), flags) {
        result::Ok(m)  => m,
        result::Err(e) => fail!("{}", e.to_err_msg())
    };
    if m.free.len() == 0 {
        help();
        return;
    }

    /* front */
    let mut ast = prof(m, "generating ast", || {
        let header = m.opt_str("l").or(m.opt_str("header"));
        let files = match header {
            None => m.free.clone(),
            Some(file) => vec::append(~[file], m.free)
        };
        match front::parser::parse_files(files, m.free[0]) {
            Ok(ast) => ast,
            Err(e) => fail!(e)
        }
    });
    prof(m, "elaboration", || ast.elaborate());
    if m.opt_present("dump-ast") {
        io::println(ast.pp());
    }
    prof(m, "typecheck",   || front::analysis::typecheck::check(&ast));
    prof(m, "returncheck", || front::analysis::returncheck::check(&ast));
    prof(m, "maincheck",   || front::analysis::maincheck::check(&ast));
    prof(m, "initcheck",   || front::analysis::initcheck::check(&ast));

    /* middle */
    let safe = m.opt_present("safe") && !m.opt_present("unsafe");
    let mut ir;
    {
        let _p = profstk(m, "translation");
        ir = middle::trans::translate(ast, safe);
    }
    if m.opt_present("dot-ir")  { ir.dot(&mut io::stdout()); }
    pass(middle::ir::ssa, &mut ir, m, "dot-ssa");

    pass(middle::opt::cfold::optimize,    &mut ir, m, "dot-cfold");
    pass(middle::opt::cfg::simplify,      &mut ir, m, "dot-simplify");
    pass(middle::opt::deadcode::optimize, &mut ir, m, "dot-deadcode");

    /* backend */
    let mut assem;
    {
        let _p = profstk(m, "codegen");
        assem = back::codegen::codegen(ir);
    }
    if m.opt_present("dot-assem") { assem.dot(&mut io::stdout()); }
    pass(back::peephole::optimize,  &mut assem, m, "dot-peephole");
    pass(back::precolor::constrain, &mut assem, m, "dot-precolor");
    pass(back::spill::spill,        &mut assem, m, "dot-spilled");
    pass(back::ressa::convert,      &mut assem, m, "dot-ressa");
    pass(back::alloc::color,        &mut assem, m, "dot-colored");

    let output = Path::new(m.free[0].as_slice()).with_extension("s");

    match io::result(|| io::File::create(&output)) {
        Ok(mut f)  => assem.output(&mut f),
        Err(e) => fail!(e)
    }
}

fn pass<T: utils::Graphable, U>(f: |&mut T| -> U, p: &mut T,
                                m: &extra::getopts::Matches, s: &str) -> U {
    let ret = prof(m, s, || f(p));
    if m.opt_present(s) {
        p.dot(&mut io::stdout());
    }
    return ret;
}

fn prof<U>(m : &extra::getopts::Matches, s : &str, f: || -> U) -> U {
    if m.opt_present("profile") {
        profile::run(f, s)
    } else {
        f()
    }
}

fn profstk(m : &extra::getopts::Matches, s : &str) -> profile::Guard {
    profile::Guard::new(m.opt_present("profile"), s)
}
