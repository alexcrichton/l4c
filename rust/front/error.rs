use core::util::{with, unreachable, replace};
use io::WriterUtil;
use front::mark;

pub struct List {
  priv coords: Option<@mark::Coords>,
  priv errs: ~[(Option<@mark::Coords>, ~str)]
}

pub fn new() -> List {
  List{errs: ~[], coords: None}
}

impl List {
  fn add(&mut self, s: ~str) {
    self.errs.push((self.coords, s))
  }

  fn size(&self) -> uint {
    self.errs.len()
  }

  fn check(&mut self) {
    if self.errs.len() > 0 {
      let out = io::stderr();
      for self.errs.each |&(c, s)| {
        match c {
          None => out.write_str(fmt!("error: %s\n", s)),
          Some(@mark::Coords((l1, c1), (l2, c2), file)) =>
            out.write_str(fmt!("%s:%d.%d-%d.%d:error: %s\n", *file, l1, c1, l2,
                               c2, s))
        }
      }
      unsafe { libc::exit(1); }
    }
  }

  fn die(&mut self, s: ~str) -> ! {
    self.add(s);
    self.check();
    unreachable();
  }

  fn with<T, U>(&mut self, m: &mark::Mark<T>, f: fn(&T) -> U) -> U {
    do with(&mut self.coords, Some(m.pos)) {
      f(m.data)
    }
  }

  fn map_mark<T>(&mut self, mark: mark::Mark<T>,
                 f: fn(~T) -> ~T) -> mark::Mark<T> {
    /* TODO(#4875): this should be bound in the parameters, not down here */
    let mark::Mark{data, pos} = mark;
    let prev = replace(&mut self.coords, Some(pos));
    let ret = f(data);
    self.coords = prev;
    return mark::make(ret, pos);
  }
}
