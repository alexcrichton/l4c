use core::util::{with, unreachable};
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
  fn add(&mut self, s : ~str) {
    self.errs.push((self.coords, s))
  }

  pure fn size() -> uint {
    self.errs.len()
  }

  fn check(&mut self) {
    if (self.errs.len() > 0) {
      let out = io::stderr();
      let msgs = do self.errs.map |&(c, s)| {
        match c {
          None => fmt!("error: %s\n", s),
          Some(@mark::Coords((l1, c1), (l2, c2), file)) =>
            fmt!("%s:%d.%d-%d.%d:error: %s\n", *file, l1, c1, l2, c2, s)
        }
      };
      do msgs.consume |_, msg| {
        out.write_str(msg);
      }
      unsafe { libc::exit(1); }
    }
  }

  fn die(&mut self, s : ~str) -> ! {
    self.add(s);
    self.check();
    unreachable();
  }

  fn with<T, U>(&mut self, m : &~mark::Mark<T>, f : fn(t : @T) -> U) -> U {
    do with(&mut self.coords, Some(m.pos)) {
      f(m.data)
    }
  }
}
