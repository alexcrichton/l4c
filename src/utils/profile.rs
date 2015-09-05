use std::cell::Cell;
use std::iter;

use time;

thread_local!(static LEVELS_KEY: Cell<usize> = Cell::new(0));

pub struct Guard {
    enabled: bool,
    start: f64,
}

impl Drop for Guard {
    fn drop(&mut self) {
        if self.enabled {
            println!("{:.2}s", time::precise_time_s() - self.start);
        }
    }
}

impl Guard {
    pub fn new(print: bool, name: &str) -> Guard {
        if print {
            print!("{:20} ", name);
        }
        Guard { enabled: print, start: time::precise_time_s() }
    }
}

pub fn run<U, F: FnOnce() -> U>(f: F, name: &str) -> U {
    let start = time::precise_time_s();
    print!("{:20} ", name);
    let ret = f();
    println!("{:.2}s", time::precise_time_s() - start);
    return ret;
}

pub fn dbg<U, F: FnOnce() -> U>(name: &str, f: F) -> U {
    /* apparently local_data_{get,set} are unsafe... */
    let lvls = LEVELS_KEY.with(|l| l.get());
    LEVELS_KEY.with(|l| l.set(lvls + 1));
    let start = time::precise_time_s();
    let ret = f();
    let val = time::precise_time_s() - start;
    if val > 0.001 {
        debug!("{}{} {:.8}s", iter::repeat("  ").take(lvls).collect::<String>(),
               name, time::precise_time_s() - start);
    }
    LEVELS_KEY.with(|l| l.set(lvls));
    return ret;
}
