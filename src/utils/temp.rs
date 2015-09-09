//! IR Temporaries

use std::cell::Cell;
use std::collections::HashSet;
use std::fmt;
use std::ops::Index;

use vec_map::{self, VecMap};

use utils::FnvState;
use utils::{BitVec, BitVecIter};

/// A temporary in the IR.
///
/// Each temporary represents a numbered variable.
#[derive(Clone, PartialEq, Eq, PartialOrd, Ord, Hash, Copy)]
pub struct Temp(u32);

pub type TempSet = HashSet<Temp, FnvState>;

pub struct TempBitVec {
    inner: BitVec,
}

pub struct TempVecMap<T> {
    inner: VecMap<T>,
}

pub struct TempVecMapIter<'a, T: 'a> {
    iter: vec_map::Iter<'a, T>,
}

pub struct TempBitVecIter<'a> {
    iter: BitVecIter<'a>,
}

/// An allocator of Temporaries, used during translation.
pub struct TempAllocator {
    next: Cell<u32>,
}

impl Temp {
    pub fn get(p: Temp) -> u32 { p.0 }
}

impl TempAllocator {
    /// Prepares a new allocator ready to create new temporaries
    pub fn new() -> TempAllocator {
        TempAllocator::new_from(0)
    }

    pub fn new_from(start: u32) -> TempAllocator {
        TempAllocator { next: Cell::new(start) }
    }

    /// Returns the number of temporaries allocated so far
    pub fn count(&self) -> u32 { self.next.get() }

    /// Resets the allocator back to 0
    pub fn reset(&self) { self.next.set(0); }

    /// Generates a new unique temporary
    pub fn gen(&self) -> Temp {
        let ret = self.next.get();
        self.next.set(ret + 1);
        Temp(ret)
    }
}

impl fmt::Debug for Temp {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        fmt::Display::fmt(self, f)
    }
}

impl fmt::Display for Temp {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let Temp(i) = *self;
        write!(f, "%t{}", i)
    }
}

impl TempBitVec {
    pub fn with_capacity(n: usize) -> TempBitVec {
        TempBitVec { inner: BitVec::with_capacity(n) }
    }

    pub fn insert(&mut self, temp: Temp) {
        self.inner.insert(temp.0 as usize);
    }

    pub fn remove(&mut self, temp: Temp) {
        self.inner.remove(temp.0 as usize);
    }

    pub fn contains(&self, temp: Temp) -> bool {
        self.inner.contains(temp.0 as usize)
    }

    pub fn clear(&mut self) {
        self.inner.clear()
    }

    pub fn union(&mut self, other: &TempBitVec) {
        self.inner.union(&other.inner)
    }

    pub fn iter(&self) -> TempBitVecIter {
        TempBitVecIter { iter: self.inner.iter() }
    }
}

impl<'a> Iterator for TempBitVecIter<'a> {
    type Item = Temp;

    fn next(&mut self) -> Option<Temp> {
        self.iter.next().map(|t| Temp(t as u32))
    }
}

impl Extend<Temp> for TempBitVec {
    fn extend<I: IntoIterator<Item=Temp>>(&mut self, i: I) {
        for t in i {
            self.insert(t);
        }
    }
}

impl<'a> Extend<&'a Temp> for TempBitVec {
    fn extend<I: IntoIterator<Item=&'a Temp>>(&mut self, i: I) {
        for t in i {
            self.insert(*t);
        }
    }
}

impl<T> TempVecMap<T> {
    pub fn new() -> TempVecMap<T> {
        TempVecMap { inner: VecMap::new() }
    }

    pub fn insert(&mut self, temp: Temp, t: T) -> bool {
        self.inner.insert(temp.0 as usize, t).is_none()
    }

    pub fn contains_key(&self, temp: &Temp) -> bool {
        self.inner.contains_key(&(temp.0 as usize))
    }

    pub fn get(&self, temp: &Temp) -> Option<&T> {
        self.inner.get(&(temp.0 as usize))
    }

    pub fn iter(&self) -> TempVecMapIter<T> {
        TempVecMapIter { iter: self.inner.iter() }
    }

    pub fn len(&self) -> usize { self.inner.len() }
}

impl<T> Index<Temp> for TempVecMap<T> {
    type Output = T;

    fn index(&self, temp: Temp) -> &T {
        &self.inner[temp.0 as usize]
    }
}

impl<'a, T> Index<&'a Temp> for TempVecMap<T> {
    type Output = T;

    fn index(&self, temp: &'a Temp) -> &T {
        &self[*temp]
    }
}

impl<'a, T> Iterator for TempVecMapIter<'a, T> {
    type Item = (Temp, &'a T);

    fn next(&mut self) -> Option<(Temp, &'a T)> {
        self.iter.next().map(|(k, v)| (Temp(k as u32), v))
    }
}
