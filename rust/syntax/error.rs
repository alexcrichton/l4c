use io::WriterUtil;

pub struct List {
  priv errs: dvec::DVec<(Option<@mark::Coords>, ~str)>
}

pub fn new() -> ~List {
  ~List{errs: dvec::DVec()}
}

impl List {
  fn add(c : Option<@mark::Coords>, s : ~str) {
    self.errs.push((c, s))
  }

  fn check() {
    if (self.errs.len() > 0) {
      let out = io::stderr();
      for self.errs.each |&(c, s)| {
        match c {
          None => out.write_str(fmt!("error: %s", s)),
          Some(@mark::Coords((l1, c1), (l2, c2), copy file)) =>
            out.write_str(fmt!("%s:%d.%d-%d.%d:error: %s", file,
                               l1, c1, l2, c2, s))
        }
      }
      libc::exit(1);
    }
  }
}
