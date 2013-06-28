use std::hashmap::{HashSet, HashMap};
use std::cmp::Eq;
use std::to_bytes::IterBytes;
use std::hash::Hash;
use utils::PrettyPrint;

pub fn singleton<T: Eq + IterBytes + Hash>(t: T) -> HashSet<T> {
  let mut s = HashSet::new();
  s.insert(t);
  return s;
}

impl<T: Eq + IterBytes + Hash + ToStr> PrettyPrint for HashSet<T> {
  fn pp(&self) -> ~str {
    let mut s = ~"{";
    let mut first = true;
    for self.iter().advance |k| {
      if first {
        first = false;
      } else {
        s.push_str(", ");
      }
      s.push_str(k.to_str());
    }
    return s + "}";
  }
}

impl<K: Eq + IterBytes + Hash + ToStr, V: ToStr> PrettyPrint for HashMap<K, V> {
  fn pp(&self) -> ~str {
    let mut s = ~"{";
    let mut first = true;
    for self.iter().advance |(k, v)| {
      if first {
        first = false;
      } else {
        s.push_str(", ");
      }
      s.push_str(k.to_str() + ": " + v.to_str());
    }
    return s + "}";
  }
}
