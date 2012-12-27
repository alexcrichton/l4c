use io::WriterUtil;

pub struct List {
  priv mut coords: Option<@mark::Coords>,
  priv errs: dvec::DVec<(Option<@mark::Coords>, ~str)>
}

pub fn new() -> ~List {
  ~List{errs: dvec::DVec(), coords: None}
}

impl List {
  fn add(s : ~str) {
    self.errs.push((self.coords, s))
  }

  pure fn size() -> uint {
    self.errs.len()
  }

  fn check() {
    if (self.errs.len() > 0) {
      let out = io::stderr();
      for self.errs.each |&(c, s)| {
        match c {
          None => out.write_str(fmt!("error: %s\n", s)),
          Some(@mark::Coords((l1, c1), (l2, c2), copy file)) =>
            out.write_str(fmt!("%s:%d.%d-%d.%d:error: %s\n", file,
                               l1, c1, l2, c2, s))
        }
      }
      libc::exit(1);
    }
  }

  fn die(s : ~str) -> ! {
    self.add(s);
    self.check();
    unreachable();
  }

  fn with<T, U>(m : &~mark::Mark<T>, f : fn(t : @T) -> U) -> U {
    do with(&mut self.coords, Some(m.pos)) {
      f(m.data)
    }
  }
}
