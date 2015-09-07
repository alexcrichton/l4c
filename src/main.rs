#![feature(hashmap_hasher)]

extern crate env_logger;
extern crate fnv;
extern crate getopts;
extern crate libc;
extern crate time;
extern crate vec_map;

#[macro_use] extern crate log;

use std::env;
use std::fs::File;
use std::io::{self, BufWriter, Write};
use std::path::PathBuf;
use std::thread;

use getopts::Options;

use utils::profile;
use utils::Graphable;

mod front;
mod middle;
mod back;
mod utils;

fn main() {
    env_logger::init().unwrap();

    let mut opts = Options::new();
    opts.optflag("h", "help", "print this help message")
        .optflag("v", "verbose", "verbose messages")
        .optflag("", "dump-ast", "pretty print the AST")
        .optflag("p", "profile", "profile the compiler")
        .optopt("l", "header", "header file for the program", "HEADER")
        .optopt("o", "output", "where to place output", "FILE")
        .optflag("", "dot-ir", "dot IR after ast translation")
        .optflag("", "dot-ssa", "dot IR after SSA")
        .optflag("", "dot-cfold", "dot IR after constant folding")
        .optflag("", "dot-deadcode", "dot IR after dead code")
        .optflag("", "dot-simplify", "dot IR after simplification",)
        .optflag("", "dot-assem", "dot IR after lowering")
        .optflag("", "dot-spilled", "dot IR after spilling")
        .optflag("", "dot-ressa", "dot IR after ressa")
        .optflag("", "dot-colored", "dot IR after coloring")
        .optflag("", "dot-precolor", "dot IR after precoloring")
        .optflag("", "dot-peephole", "dot IR after peephole optimizations")
        .optflag("", "safe", "safe compilation with memory checks")
        .optflag("", "unsafe", "unsafe compilation with no memory checks")
        .optopt("O", "optimize", "level of optimizations to perform", "LEVEL")
        .optopt("m", "arch", "architecture to emit", "([x64] | x86)");
    let m = opts.parse(env::args().skip(1)).unwrap_or_else(|e| {
        panic!("failed to parse arguments: {}", e)
    });
    if m.free.len() == 0 || m.opt_present("h") {
        let msg = format!("usage: {} [OPTION...] SOURCEFILE",
                          env::args().next().unwrap());
        return println!("{}", opts.usage(&msg));
    }

    let r = thread::Builder::new().stack_size(64 * 1024 * 1024).spawn(move || {
        run_compiler(&m);
    }).unwrap().join();
    std::process::exit(match r {
        Ok(()) => 0,
        Err(..) => 2,
    });
}

fn run_compiler(m: &getopts::Matches) {
    // front
    let mut ast = prof(m, "generating ast", || {
        let mut files = m.free.clone();
        if let Some(header) = m.opt_str("l") {
            files.insert(0, header);
        }
        match front::parser::parse_files(&files, &m.free[0]) {
            Ok(ast) => ast,
            Err(e) => panic!("I/O error: {}", e)
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

    // middle
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

    // backend
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

    let output = match m.opt_str("o") {
        Some(path) => PathBuf::from(path),
        None => PathBuf::from(&m.free[0]).with_extension("s"),
    };

    File::create(&output).and_then(|f| {
        assem.output(&mut BufWriter::new(f))
    }).unwrap_or_else(|e| {
        panic!("I/O error: {}", e)
    })
}

fn pass<T, U, F>(f: F, p: &mut T, m: &getopts::Matches, s: &str) -> U
    where T: utils::Graphable,
          F: FnOnce(&mut T) -> U
{
    let ret = prof(m, s, || f(p));
    if m.opt_present(s) {
        let mut out = io::stdout();
        p.dot(&mut out).unwrap();
        out.flush().unwrap();
    }
    return ret;
}

fn prof<U, F: FnOnce() -> U>(m : &getopts::Matches, s : &str, f: F) -> U {
    if m.opt_present("profile") {
        profile::run(f, s)
    } else {
        f()
    }
}

fn profstk(m : &getopts::Matches, s : &str) -> profile::Guard {
    profile::Guard::new(m.opt_present("profile"), s)
}
