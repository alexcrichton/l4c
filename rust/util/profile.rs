use std::time;

pub fn prof<T>(s : ~str, f : fn () -> T) -> T {
  let now = time::precise_time_s();
  let ret = f();
  let after = time::precise_time_s();
  io::print(fmt!("%10s... %?\n", s, after - now));
  return ret;
}
