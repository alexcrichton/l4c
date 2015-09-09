#![feature(into_raw_os)]

extern crate getopts;
extern crate num_cpus;
extern crate term;
extern crate wait_timeout;

use std::env;
use std::fmt;
use std::fs::{self, File};
use std::io::BufReader;
use std::io::prelude::*;
use std::iter;
use std::os::unix::prelude::*;
use std::path::{PathBuf, Path};
use std::process::{self, Command, Stdio};
use std::str;
use std::sync::{Arc, Mutex};
use std::thread;

use term::{StdoutTerminal, Terminal, Attr};
use term::color;
use wait_timeout::ChildExt;

macro_rules! t {
    ($e:expr) => (match $e {
        Ok(e) => e,
        Err(e) => panic!("{} failed with {}", stringify!($e), e),
    })
}

struct Driver {
    parallel: u32,
    verbose: bool,
    quiet: bool,
    retry: bool,
    fail_fast: bool,
    debug: bool,
    log: PathBuf,
    compiler_timeout: u32,
    test_timeout: u32,
    gcc_timeout: u32,

    state: Mutex<State>,
}

struct State {
    tests: Vec<PathBuf>,
    total: usize,
    remaining: usize,
    exit: bool,
    failed: bool,
    out: Box<StdoutTerminal>,
    failures: Option<File>,
}

struct Test {
    path: PathBuf,
    safe: bool,
    expected: Expected,
    input: Option<File>,
    output: Option<String>,
}

struct Output {
    status: ExitStatus,
    stdout: Vec<u8>,
    stderr: Vec<u8>,
}

enum Expected {
    Exception(Option<i32>),
    Return(i32),
    Error,
}

enum ExitStatus {
    TimedOut(wait_timeout::ExitStatus),
    Std(process::ExitStatus),
}

enum TestResult {
    Pass,
    Fail(&'static str, Output),
}

fn main() {
    let mut opts = getopts::Options::new();
    opts.optopt("j", "parallel", "jobs to parallelize", "JOBS");
    opts.optflag("i", "fail-fast", "stop once one test fails");
    opts.optflag("v", "verbose", "print more output");
    opts.optflag("q", "quiet", "print less output");
    opts.optflag("h", "help", "show this message");
    opts.optflag("r", "retry", "retry failing tests");
    opts.optflag("d", "debug", "run debug compiler");
    opts.optopt("", "failures", "file to write failing tests to", "FILE");
    opts.optopt("", "only", "only run tests listed in this file", "FILE");

    let matches = opts.parse(env::args().skip(1)).unwrap();
    if matches.opt_present("h") {
        let msg = format!("Usage: {} [options] [file1 [file2 ..]]",
                          env::args().next().unwrap());
        return println!("{}", opts.usage(&msg));
    }
    let tests = if matches.free.len() > 0 {
        matches.free.iter().map(PathBuf::from).collect::<Vec<_>>()
    } else if let Some(f) = matches.opt_str("only") {
        let mut s = String::new();
        t!(t!(File::open(f)).read_to_string(&mut s));
        s.lines().map(|s| PathBuf::from(s)).collect()
    } else {
        t!(fs::read_dir("tests"))
            .map(|e| t!(e))
            .flat_map(|e| t!(fs::read_dir(e.path())))
            .map(|e| t!(e).path())
            .filter(istest)
            .collect()
    };

    let driver = Driver {
        parallel: matches.opt_str("j").map(|j| j.parse().unwrap())
                         .unwrap_or(num_cpus::get() as u32 * 3 / 2),
        verbose: matches.opt_present("v"),
        quiet: matches.opt_present("q"),
        retry: matches.opt_present("r"),
        fail_fast: matches.opt_present("i"),
        log: PathBuf::from("target/log"),
        debug: matches.opt_present("d"),
        gcc_timeout: 2_000,
        test_timeout: 5_000,
        compiler_timeout: if matches.opt_present("d") {20_000} else {5_000},
        state: Mutex::new(State {
            total: tests.len(),
            remaining: tests.len(),
            tests: tests,
            exit: false,
            failed: false,
            out: term::stdout().unwrap(),
            failures: matches.opt_str("failures").map(|f| t!(File::create(f))),
        }),
    };
    driver.run();
}

impl Driver {
    fn run(self) {
        self.build_compiler();
        let _ = fs::create_dir(&self.log);
        let me = Arc::new(self);
        let threads = (0..me.parallel).map(|_| {
            let me = me.clone();
            thread::spawn(move || {
                me.run_tests();
            })
        }).collect::<Vec<_>>();

        for thread in threads {
            if let Err(e) = thread.join() {
                me.state.lock().unwrap().exit = true;
                println!("failure: {:?}", e);
            }
        }
        let mut state = me.state.lock().unwrap();
        t!(state.out.carriage_return());
        t!(state.out.delete_line());
        t!(state.out.flush());
        if state.failed {
            panic!("some tests failed");
        }
    }

    fn build_compiler(&self) {
        let mut cmd = Command::new("cargo");
        cmd.arg("build");
        if !self.debug {
            cmd.arg("--release");
        }
        assert!(t!(cmd.status()).success());
    }

    fn run_tests(&self) {
        loop {
            let test = {
                let mut state = self.state.lock().unwrap();
                if state.exit { break }
                match state.tests.pop() {
                    Some(test) => test,
                    None => break,
                }
            };
            let result = self.run_test(self.parse(&test));

            let mut state = self.state.lock().unwrap();
            state.remaining -= 1;
            if let TestResult::Fail(..) = result {
                state.failed = true;
                if self.fail_fast {
                    state.exit = true;
                }
            }
            self.print_result(&mut state, &test, result);
            self.progress(&mut state);
        }
    }

    fn print_result(&self, state: &mut State, test: &Path, result: TestResult) {
        t!(state.out.carriage_return());
        t!(state.out.delete_line());
        t!(state.out.attr(Attr::Bold));
        let extra = match result {
            TestResult::Pass => {
                if self.quiet {
                    t!(state.out.reset());
                    return
                }
                t!(state.out.fg(color::GREEN));
                t!(state.out.write_all(b"pass: "));
                String::new()
            }
            TestResult::Fail(msg, output) => {
                if let Some(ref mut f) = state.failures {
                    t!(f.write_all(test.to_string_lossy().as_bytes()));
                    t!(f.write_all(b"\n"));
                }
                let mut msg = msg.to_string();
                t!(state.out.fg(color::RED));
                t!(state.out.write_all(b"fail: "));
                if self.verbose {
                    let stdout = String::from_utf8_lossy(&output.stdout);
                    let stderr = String::from_utf8_lossy(&output.stderr);
                    msg.push_str("\n");
                    msg.push_str(&tab(&format!("status: {}", output.status)));
                    msg.push_str("\n");
                    if stdout.len() > 0 {
                        msg.push_str(&tab("stdout:"));
                        msg.push_str("\n");
                        msg.push_str(&tab(&tab(&stdout)));
                        msg.push_str("\n");
                    }
                    if stderr.len() > 0 {
                        msg.push_str(&tab("stderr:"));
                        msg.push_str("\n");
                        msg.push_str(&tab(&tab(&stderr)));
                        msg.push_str("\n");
                    }
                }
                msg
            }
        };
        t!(state.out.reset());
        t!(state.out.write_all(test.to_string_lossy().as_bytes()));
        if extra.len() > 0 {
            t!(state.out.write_all(b": "));
            t!(state.out.write_all(extra.as_bytes()));
        }
        t!(state.out.write_all(b"\n"));
    }

    fn progress(&self, state: &mut State) {
        let total = state.total;
        let remaining = state.remaining;
        let width = 60;

        let progress = (total - remaining) * width / total;
        let progress = iter::repeat("=").take(progress).collect::<String>();
        let progress = format!("[{1:<0$}] {2}/{3}", width, progress,
                               total - remaining, total);
        t!(state.out.write_all(progress.as_bytes()));
        t!(state.out.flush());
    }

    fn run_test(&self, mut test: Test) -> TestResult {
        let root = self.log.join(&test.path);
        {
            let _l = self.state.lock();
            t!(fs::create_dir_all(root.parent().unwrap()));
        }
        let ext = root.extension().unwrap().to_str().unwrap();
        let exe = root.with_extension(format!("{}-bin", ext));
        let assem = root.with_extension(format!("{}.s", ext));

        let mut cmd = Command::new(self.compiler());
        cmd.arg(&test.path).arg("-o").arg(&assem)
           .arg("-l").arg("l4rt.h0")
           .arg(if test.safe {"--safe"} else {"--unsafe"});
        let out = output_timeout(cmd, self.compiler_timeout);
        if let Expected::Error = test.expected {
            if !out.status.success() {
                return TestResult::Pass
            }
        } else if !out.status.success() {
            return TestResult::Fail("compiler failed", out)
        }

        let mut cmd = Command::new("gcc");
        cmd.arg("-m64")
           .arg("-o").arg(&exe)
           .arg(&assem)
           .arg("l4rt.c");
        let out = output_timeout(cmd, self.gcc_timeout);
        if let Expected::Error = test.expected {
            return if out.status.success() {
                TestResult::Fail("gcc/compiler succeeded", out)
            } else {
                TestResult::Pass
            }
        } else if !out.status.success() {
            return TestResult::Fail("gcc failed", out)
        }

        let mut cmd = Command::new(&exe);
        if let Some(input) = test.input.take() {
            cmd.stdin(unsafe { Stdio::from_raw_fd(input.into_raw_fd()) });
        }
        let out = output_timeout(cmd, self.test_timeout);
        match test.expected {
            Expected::Exception(n) => {
                let got = match out.status.signal() {
                    Some(n) => n,
                    None => return TestResult::Fail("didn't fail", out),
                };
                // Exception 14 == SIGALRM but we kill with signal 9 down below,
                // so be sure to catch that specifically
                if n.is_none() || Some(got) == n ||
                   (n == Some(14) && got == 9) {
                    TestResult::Pass
                } else {
                    TestResult::Fail("wrong signal", out)
                }
            }
            Expected::Return(n) => {
                if out.status.code() != Some(0) {
                    return TestResult::Fail("wrong exit code", out)
                }
                if Some(n) != str::from_utf8(&out.stdout).unwrap().parse().ok() {
                    return TestResult::Fail("wrong return code", out)
                }
                if let Some(ref s) = test.output {
                    if out.stderr != s.as_bytes() {
                        return TestResult::Fail("wrong stdout", out)
                    }
                }
                TestResult::Pass
            }
            Expected::Error => panic!(),
        }
    }

    fn parse(&self, path: &Path) -> Test {
        let mut f = BufReader::new(t!(File::open(path)));
        let mut line = String::new();
        t!(f.read_line(&mut line));
        let expected = if line.starts_with("//test error") {
            Expected::Error
        } else if line.starts_with("//test exception") {
            Expected::Exception(line.split_whitespace().nth(2).map(|i| {
                i.parse().unwrap()
            }))
        } else if line.starts_with("//test return") {
            Expected::Return(line.split_whitespace().nth(2).unwrap()
                                 .parse().unwrap())
        } else {
            panic!("invalid test directive {:?}", line);
        };
        line.truncate(0);
        t!(f.read_line(&mut line));
        let safe = line.starts_with("//safe");
        let ext = path.extension().unwrap().to_str().unwrap();
        let input = path.with_extension(format!("{}.in", ext));
        let output = path.with_extension(format!("{}.out", ext));
        let input = File::open(input).ok();
        let output = File::open(output).map(|mut f| {
            let mut s = String::new();
            t!(f.read_to_string(&mut s));
            s
        }).ok();
        Test {
            path: path.to_owned(),
            expected: expected,
            safe: safe,
            input: input,
            output: output,
        }
    }

    fn compiler(&self) -> &'static str {
        if self.debug {"target/debug/l4c"} else {"target/release/l4c"}
    }
}

fn output_timeout(mut cmd: Command, timeout: u32) -> Output {
    cmd.stdout(Stdio::piped()).stderr(Stdio::piped());
    let mut child = t!(cmd.spawn());
    drop(child.stdin.take());
    let mut stdout = child.stdout.take().unwrap();
    let mut stderr = child.stderr.take().unwrap();
    let stdout = thread::spawn(move || {
        let mut v = Vec::new();
        t!(stdout.read_to_end(&mut v));
        v
    });
    let stderr = thread::spawn(move || {
        let mut v = Vec::new();
        t!(stderr.read_to_end(&mut v));
        v
    });

    let status = match t!(child.wait_timeout_ms(timeout)) {
        Some(status) => ExitStatus::TimedOut(status),
        None => {
            t!(child.kill());
            ExitStatus::Std(t!(child.wait()))
        }
    };
    Output {
        status: status,
        stdout: stdout.join().unwrap(),
        stderr: stderr.join().unwrap(),
    }
}

fn istest(p: &PathBuf) -> bool {
    match p.extension().and_then(|s| s.to_str()) {
        Some("in") |
        Some("out") |
        Some("q4") |
        Some("q3") => false,
        _ => true
    }
}

fn tab(s: &str) -> String {
    format!("    {}", s.replace("\n", "\n    "))
}

impl ExitStatus {
    fn success(&self) -> bool {
        match *self {
            ExitStatus::TimedOut(ref s) => s.success(),
            ExitStatus::Std(ref s) => s.success(),
        }
    }
    fn code(&self) -> Option<i32> {
        match *self {
            ExitStatus::TimedOut(ref s) => s.code(),
            ExitStatus::Std(ref s) => s.code(),
        }
    }
    fn signal(&self) -> Option<i32> {
        match *self {
            ExitStatus::TimedOut(ref s) => s.unix_signal(),
            ExitStatus::Std(ref s) => s.signal(),
        }
    }
}

impl fmt::Display for ExitStatus {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            ExitStatus::TimedOut(ref s) => s.fmt(f),
            ExitStatus::Std(ref s) => s.fmt(f),
        }
    }
}
