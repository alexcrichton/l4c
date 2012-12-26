use std::map;

pub struct Symbol{
  priv id : uint,
  val : ~str
}

pub type Symtab = map::HashMap<~str, @Symbol>;

impl Symbol : cmp::Eq {
  pure fn eq(&self, other : &Symbol) -> bool { self.id.eq(&other.id) }
  pure fn ne(&self, other : &Symbol) -> bool { self.id.ne(&other.id) }
}

impl Symbol : to_bytes::IterBytes {
  pure fn iter_bytes(&self, lsb0 : bool, f : to_bytes::Cb) {
    self.id.iter_bytes(lsb0, f)
  }
}

pub fn Symtab() -> Symtab {
  map::HashMap()
}

#[allow(non_implicitly_copyable_typarams)]
pub fn new(t : Symtab, s : ~str) -> @Symbol {
  match t.find(s) {
    Some(s) => s,
    None => {
      let sym = @Symbol{id: t.size(), val: copy s};
      t.insert(s, sym);
      sym
    }
  }
}

#[test]
fn test_coalesces () {
  let tab = Symtab();
  let a = new(tab, ~"a");
  let b = new(tab, ~"a");
  assert managed::ptr_eq(a, b)
}

#[test]
fn test_different() {
  let tab = Symtab();
  let a = new(tab, ~"a");
  let b = new(tab, ~"b");
  assert !managed::ptr_eq(a, b)
}
