use std::collections::HashSet;
use std::fmt;

use utils::fnv;

pub type TempSet = HashSet<Temp, fnv::Hasher>;

#[deriving(Eq, PartialEq, Ord, PartialOrd, Clone, Hash)]
pub struct Temp(uint);

pub struct Allocator {
    next: uint
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
        Temp(ret)
    }

    pub fn cnt(&self) -> uint {
        self.next
    }

    pub fn reset(&mut self) {
        self.next = 0;
    }
}

impl Temp {
    pub fn new(n: uint) -> Temp { Temp(n) }
}

impl Deref<uint> for Temp {
    fn deref<'a>(&'a self) -> &'a uint { let Temp(ref inner) = *self; inner }
}

impl fmt::Show for Temp {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "%t{}", **self as uint)
    }
}
