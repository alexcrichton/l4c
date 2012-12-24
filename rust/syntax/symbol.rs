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
