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

impl Temp : ToStr {
  pure fn to_str() -> ~str {
    fmt!("%%t%u", self as uint)
  }
}
