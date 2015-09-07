use std::fmt;
use std::mem;
use std::ops::Range;

#[derive(Debug)]
pub struct BitVec {
    bits: Vec<u32>,
}

pub struct BitVecIter<'a> {
    bits: &'a BitVec,
    range: Range<usize>,
}

impl BitVec {
    pub fn with_capacity(n: usize) -> BitVec {
        BitVec { bits: vec![0; n / 32 + 1] }
    }

    pub fn insert(&mut self, bit: usize) {
        self.bits[bit / 32] |= 1 << (bit % 32);
    }

    pub fn remove(&mut self, bit: usize) {
        self.bits[bit / 32] &= !(1 << (bit % 32));
    }

    pub fn contains(&self, bit: usize) -> bool {
        (self.bits[bit / 32] & (1 << (bit % 32))) != 0
    }

    pub fn clear(&mut self) {
        for slot in self.bits.iter_mut() {
            *slot = 0;
        }
    }

    pub fn union(&mut self, other: &BitVec) {
        assert!(self.bits.len() == other.bits.len());
        for (a, b) in self.bits.iter_mut().zip(&other.bits) {
            *a |= *b;
        }
    }

    pub fn iter(&self) -> BitVecIter {
        BitVecIter { bits: self, range: 0..(32 * self.bits.len()) }
    }
}

impl<'a> Iterator for BitVecIter<'a> {
    type Item = usize;

    fn next(&mut self) -> Option<usize> {
        while let Some(i) = self.range.next() {
            if self.bits.contains(i) {
                return Some(i)
            }
        }
        None
    }
}

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

