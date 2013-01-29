use core::hashmap::linear::LinearSet;
use core::cmp::Eq;
use core::to_bytes::IterBytes;
use core::hash::Hash;
use utils::PrettyPrint;

impl<T: Eq IterBytes Hash ToStr> LinearSet<T>: PrettyPrint {
  pure fn pp() -> ~str {
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
