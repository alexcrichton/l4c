pub type Temp = uint;

pub struct Allocator {
  priv mut next : uint
}

pub fn new() -> Allocator {
  Allocator{ next: 0 }
}

impl Allocator {
  fn new() -> Temp {
    let ret = self.next;
    self.next += 1;
    return ret;
  }
}

impl Temp : PrettyPrint {
  fn pp() -> ~str {
    fmt!("%%t%u", self as uint)
  }
}
