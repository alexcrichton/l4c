use std::fmt;
use std::mem;

pub struct SmallBitVec {
    bits: u32,
}

impl SmallBitVec {
    pub fn new() -> SmallBitVec {
        SmallBitVec { bits: 0 }
    }

    pub fn insert(&mut self, bit: u32) {
        debug_assert!((bit as usize) < mem::size_of_val(&self.bits) * 8);
        self.bits |= 1 << bit;
    }

    pub fn remove(&mut self, bit: u32) {
        debug_assert!((bit as usize) < mem::size_of_val(&self.bits) * 8);
        self.bits &= !(1 << bit);
    }

    pub fn contains(&self, bit: u32) -> bool {
        debug_assert!((bit as usize) < mem::size_of_val(&self.bits) * 8);
        self.bits & (1 << bit) != 0
    }

    pub fn clear(&mut self) {
        self.bits = 0;
    }
}

impl fmt::Debug for SmallBitVec {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        fmt::LowerHex::fmt(&self.bits, f)
    }
}
