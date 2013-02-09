use core::hashmap::linear::LinearMap;
use core::to_bytes;

pub struct Symbol{
  priv id: uint,
  val: ~str
}

pub type Symtab = LinearMap<~str, @Symbol>;

impl Symbol: cmp::Eq {
  pure fn eq(&self, other: &Symbol) -> bool { self.id.eq(&other.id) }
  pure fn ne(&self, other: &Symbol) -> bool { self.id.ne(&other.id) }
}

impl Symbol: to_bytes::IterBytes {
  pure fn iter_bytes(&self, lsb0: bool, f: to_bytes::Cb) {
    self.id.iter_bytes(lsb0, f)
  }
}

pub fn Symtab() -> Symtab { LinearMap::new() }

pub fn new(t: &mut Symtab, s: &~str) -> @Symbol {
  if t.contains_key(s) {
    *t.get(s)
  } else {
    let sym = @Symbol{id: t.len(), val: copy *s};
    t.insert(copy *s, sym);
    sym
  }
}

#[cfg(test)]
mod test {
  use core::managed;
  use front::symbol::{Symtab, new};

  #[test]
  fn test_coalesces () {
    let mut tab = Symtab();
    let a = new(&mut tab, &~"a");
    let b = new(&mut tab, &~"a");
    assert managed::ptr_eq(a, b)
  }

  #[test]
  fn test_different() {
    let mut tab = Symtab();
    let a = new(&mut tab, &~"a");
    let b = new(&mut tab, &~"b");
    assert !managed::ptr_eq(a, b)
  }
}
