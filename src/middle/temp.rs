use collections::HashSet;
use utils::PrettyPrint;

pub type Temp = uint;
pub type TempSet = HashSet<Temp>;

pub struct Allocator {
  priv next: uint
}

pub fn new() -> Allocator {
  Allocator{ next: 0 }
}

pub fn new_init(next: uint) -> Allocator {
  Allocator{ next: next }
}

impl Allocator {
  pub fn new(&mut self) -> Temp {
    let ret = self.next;
    self.next += 1;
    return ret;
  }

  pub fn cnt(&self) -> uint {
    self.next
  }

  pub fn reset(&mut self) {
    self.next = 0;
  }
}

impl PrettyPrint for Temp {
  fn pp(&self) -> ~str {
    format!("%t{}", *self as uint)
  }
}
