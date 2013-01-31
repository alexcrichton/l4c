use core::hashmap::linear::LinearSet;
use utils::PrettyPrint;

pub type Temp = uint;
pub type TempSet = LinearSet<Temp>;

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
  fn new(&mut self) -> Temp {
    let ret = self.next;
    self.next += 1;
    return ret;
  }

  pure fn cnt(&self) -> uint {
    self.next
  }

  fn reset(&mut self) {
    self.next = 0;
  }
}

impl Temp: PrettyPrint {
  pure fn pp(&self) -> ~str {
    fmt!("%%t%u", *self as uint)
  }
}
