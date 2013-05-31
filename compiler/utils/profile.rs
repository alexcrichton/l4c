use std::io;
use std::local_data;
use std::ops::Drop;
use std::str;

use extra::time;

fn levels_key(_v: @uint) {}

pub struct Guard {
  priv enabled: bool,
  priv start: float,
}

impl Drop for Guard {
  fn finalize(&self) {
    if self.enabled {
      io::println(fmt!("%.2fs", time::precise_time_s() - self.start));
    }
  }
}

pub impl Guard {
  fn new(print: bool, name: &str) -> Guard {
    if print {
      io::print(fmt!("%20s ", name));
    }
    Guard { enabled: print, start: time::precise_time_s() }
  }
}

pub fn run<U>(f: &fn() -> U, name: &str) -> U {
  let start = time::precise_time_s();
  io::print(fmt!("%20s ", name));
  let ret = f();
  io::println(fmt!("%.2fs", time::precise_time_s() - start));
  return ret;
}

pub fn dbg<U>(name: &str, f: &fn() -> U) -> U {
  /* apparently local_data_{get,set} are unsafe... */
  unsafe {
    let lvls = local_data::local_data_get(levels_key).get_or_default(@0);
    local_data::local_data_set(levels_key, @(*lvls + 1));
    let start = time::precise_time_s();
    let ret = f();
    let val = time::precise_time_s() - start;
    if val > 0.001f {
      debug!("%s%s %.8fs", str::repeat("  ", *lvls), name,
             time::precise_time_s() - start);
    }
    local_data::local_data_set(levels_key, lvls);
    return ret;
  }
}
