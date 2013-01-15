use std::time;

pub fn run<U>(f : &fn() -> U, name : &str) -> U {
  let start = time::precise_time_s();
  io::print(fmt!("%20s ", name));
  let ret = f();
  io::println(fmt!("%.2fs", time::precise_time_s() - start));
  return ret;
}

pub fn dbg<U>(name : &str, f : &fn() -> U) -> U {
  let start = time::precise_time_s();
  let ret = f();
  debug!("%20s %.2fs", name, time::precise_time_s() - start);
  return ret;
}
