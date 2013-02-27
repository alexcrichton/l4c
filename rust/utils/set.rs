use core::hashmap::linear::{LinearSet, LinearMap};
use core::cmp::Eq;
use core::to_bytes::IterBytes;
use core::hash::Hash;
use utils::PrettyPrint;

impl<T: Eq + IterBytes + Hash + ToStr> PrettyPrint for LinearSet<T> {
  fn pp(&self) -> ~str {
    let mut s = ~"{";
    let mut first = true;
    for self.each |k| {
      if first {
        first = false;
      } else {
        s += ~", ";
      }
      s += k.to_str();
    }
    return s + ~"}";
  }
}

impl<K: Eq + IterBytes + Hash + ToStr, V: ToStr> PrettyPrint for LinearMap<K, V> {
  fn pp(&self) -> ~str {
    let mut s = ~"{";
    let mut first = true;
    for self.each |&(k, v)| {
      if first {
        first = false;
      } else {
        s += ~", ";
      }
      s += k.to_str() + ~": " + v.to_str();
    }
    return s + ~"}";
  }
}
