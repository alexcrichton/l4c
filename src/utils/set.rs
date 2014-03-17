use collections::{HashSet};
use std::hash::Hash;

pub fn singleton<T: Eq + Hash>(t: T) -> HashSet<T> {
    let mut s = HashSet::new();
    s.insert(t);
    return s;
}
