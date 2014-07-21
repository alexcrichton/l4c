#![feature(macro_rules, globs, default_type_params, phase)]

#[phase(plugin, link)]
extern crate log;
extern crate getopts;
extern crate collections;
extern crate time;
extern crate libc;

use std::io;
use std::result;
use std::os;
use std::task::TaskBuilder;

use utils::profile;
use utils::Graphable;

mod utils {
    pub mod set;
    pub mod graph;
    pub mod profile;
    pub mod fnv;

    pub trait Graphable {
        fn dot(&self, &mut ::std::io::Writer) -> ::std::io::IoResult<()>;
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
        use libc;
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

fn main() {
    use getopts::{optflag, optopt, getopts};

    let flags = [
        optflag("h", "help", "print this help message"),
        optflag("v", "verbose", "verbose messages"),
        optflag("", "dump-ast", "pretty print the AST"),
        optflag("p", "profile", "profile the compiler"),
        optopt("l", "header", "header file for the program", "HEADER"),
        optflag("", "dot-ir", "dot IR after ast translation"),
        optflag("", "dot-ssa", "dot IR after SSA"),
        optflag("", "dot-cfold", "dot IR after constant folding"),
        optflag("", "dot-deadcode", "dot IR after dead code"),
        optflag("", "dot-simplify", "dot IR after simplification",),
        optflag("", "dot-assem", "dot IR after lowering"),
        optflag("", "dot-spilled", "dot IR after spilling"),
        optflag("", "dot-ressa", "dot IR after ressa"),
        optflag("", "dot-colored", "dot IR after coloring"),
        optflag("", "dot-precolor", "dot IR after precoloring"),
        optflag("", "dot-peephole", "dot IR after peephole optimizations"),
        optflag("", "safe", "safe compilation with memory checks"),
        optflag("", "unsafe", "unsafe compilation with no memory checks"),
        optopt("O", "optimize", "level of optimizations to perform", "LEVEL"),
        optopt("m", "arch", "architecture to emit", "([x64] | x86)"),
    ];
    let args = os::args();
    let m = match getopts(args.tail(), flags) {
        result::Ok(m)  => m,
        result::Err(e) => fail!("{}", e.to_err_msg())
    };
    if m.free.len() == 0 || m.opt_present("h") {
        let msg = format!("usage: {} [OPTION...] SOURCEFILE", os::args()[0]);
        return println!("{}", getopts::usage(msg.as_slice(), flags));
    }

    TaskBuilder::new().stack_size(64 * 1024 * 1024).spawn(proc() {
        run_compiler(&m);
    });
}

fn run_compiler(m: &getopts::Matches) {
    /* front */
    let mut ast = prof(m, "generating ast", || {
        let header = m.opt_str("l").or(m.opt_str("header"));
        let files = match header {
            None => m.free.clone(),
            Some(file) => vec![file].append(m.free.as_slice())
        };
        match front::parser::parse_files(files.as_slice(),
                                         m.free[0].as_slice()) {
            Ok(ast) => ast,
            Err(e) => fail!(e)
        }
    });
    prof(m, "elaboration", || ast.elaborate());
    if m.opt_present("dump-ast") {
        println!("{}", ast);
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
    if m.opt_present("dot-ir")  { ir.dot(&mut io::stdout()).unwrap(); }
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
    if m.opt_present("dot-assem") { assem.dot(&mut io::stdout()).unwrap(); }
    pass(back::peephole::optimize,  &mut assem, m, "dot-peephole");
    pass(back::precolor::constrain, &mut assem, m, "dot-precolor");
    pass(back::spill::spill,        &mut assem, m, "dot-spilled");
    pass(back::ressa::convert,      &mut assem, m, "dot-ressa");
    pass(back::alloc::color,        &mut assem, m, "dot-colored");

    let output = Path::new(m.free[0].as_slice()).with_extension("s");

    match io::File::create(&output) {
        Ok(f) => {
            let mut b = io::BufferedWriter::new(f);
            assem.output(&mut b).unwrap()
        }
        Err(e) => fail!(e)
    }
}

fn pass<T: utils::Graphable, U>(f: |&mut T| -> U, p: &mut T,
                                m: &getopts::Matches, s: &str) -> U {
    let ret = prof(m, s, || f(p));
    if m.opt_present(s) {
        p.dot(&mut io::stdout()).unwrap();
    }
    return ret;
}

fn prof<U>(m : &getopts::Matches, s : &str, f: || -> U) -> U {
    if m.opt_present("profile") {
        profile::run(f, s)
    } else {
        f()
    }
}

fn profstk(m : &getopts::Matches, s : &str) -> profile::Guard {
    profile::Guard::new(m.opt_present("profile"), s)
}
