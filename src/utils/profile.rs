use std::io;
use std::local_data;
use std::ops::Drop;

use time;

local_data_key!(levels_key: uint)

pub struct Guard {
    priv enabled: bool,
    priv start: f64,
}

impl Drop for Guard {
    fn drop(&mut self) {
        if self.enabled {
            io::println(format!("{:.2f}s", time::precise_time_s() - self.start));
        }
    }
}

impl Guard {
    pub fn new(print: bool, name: &str) -> Guard {
        if print {
            io::print(format!("{:20s} ", name));
        }
        Guard { enabled: print, start: time::precise_time_s() }
    }
}

pub fn run<U>(f: || -> U, name: &str) -> U {
    let start = time::precise_time_s();
    io::print(format!("{:20s} ", name));
    let ret = f();
    io::println(format!("{:.2f}s", time::precise_time_s() - start));
    return ret;
}

pub fn dbg<U>(name: &str, f: || -> U) -> U {
    /* apparently local_data_{get,set} are unsafe... */
    let lvls = local_data::pop(levels_key).unwrap_or(0);
    local_data::set(levels_key, lvls + 1);
    let start = time::precise_time_s();
    let ret = f();
    let val = time::precise_time_s() - start;
    if val > 0.001 {
        debug!("{}{} {:.8f}s", "  ".repeat(lvls), name,
        time::precise_time_s() - start);
    }
    local_data::set(levels_key, lvls);
    return ret;
}
