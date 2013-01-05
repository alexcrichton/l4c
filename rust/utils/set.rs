use std::map;
use cmp::Eq;
use to_bytes::IterBytes;
use hash::Hash;

/* returns true if item already existed in the map */
pub fn add<T : Eq IterBytes Hash Const Copy>(s : map::Set<T>, t : T) -> bool {
  !s.insert(t, ())
}

pub fn remove<T : Eq IterBytes Hash Const Copy>(s : map::Set<T>, t : T) -> bool {
  s.remove(t)
}

pub fn contains<T : Eq IterBytes Hash Const Copy>(s : map::Set<T>, t : T) -> bool {
  s.contains_key(t)
}

/* returns number of new elements in the set */
pub fn union<T : Eq IterBytes Hash Const Copy>(s1 : map::Set<T>,
                                               s2 : map::Set<T>) {
  for s2.each_key |k| {
    add(s1, k);
  }
}

pub fn intersect<T : Eq IterBytes Hash Const Copy>(s1 : map::Set<T>,
                                                   s2 : map::Set<T>) {
  let mut to_remove = ~[];
  for s1.each_key |k| {
    if !contains(s2, k) {
      to_remove.push(k);
    }
  }
  for to_remove.each |&k| {
    remove(s1, k);
  }
}

pub fn eq<T : Eq IterBytes Hash Const Copy>(s1 : map::Set<T>,
                                            s2 : map::Set<T>) -> bool {
  if s1.size() != s2.size() {
    return false;
  }
  for s1.each_key |k| {
    if !contains(s2, k) {
      return false;
    }
  }
  return true;
}

pub fn each<T : Eq IterBytes Hash Const Copy>(s1 : map::Set<T>,
                                              f : &fn(T) -> bool) {
  s1.each_key(f);
}

pub fn to_str<T : Eq IterBytes Hash Const Copy ToStr>(m : map::Set<T>) -> ~str {
  let mut s = ~"{";
  let mut first = true;
  for m.each_key |k| {
    if first {
      first = false;
    } else {
      s += ~", ";
    }
    s += k.to_str();
  }
  return s + ~"}";
}
