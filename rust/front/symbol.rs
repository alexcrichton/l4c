use core::hashmap::linear::LinearMap;
use core::to_bytes;

pub struct Symbol{
  priv id : uint,
  val : ~str
}

pub type Symtab = LinearMap<~str, @Symbol>;

impl Symbol : cmp::Eq {
  pure fn eq(&self, other : &Symbol) -> bool { self.id.eq(&other.id) }
  pure fn ne(&self, other : &Symbol) -> bool { self.id.ne(&other.id) }
}

impl Symbol : to_bytes::IterBytes {
  pure fn iter_bytes(&self, lsb0 : bool, f : to_bytes::Cb) {
    self.id.iter_bytes(lsb0, f)
  }
}

pub fn Symtab() -> Symtab { LinearMap() }

#[allow(non_implicitly_copyable_typarams)]
pub fn new(t : &mut Symtab, s : &~str) -> @Symbol {
  if t.contains_key(s) {
    *t.get(s)
  } else {
    let sym = @Symbol{id: t.len(), val: copy *s};
    t.insert(copy *s, sym);
    sym
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
