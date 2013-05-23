pub struct Coords(Span, @str);
pub type Mark = uint;
pub type Span = ((uint, uint), (uint, uint));

pub static dummy: Mark = -1 as uint;

pub struct Marked<T> {
  span: Mark,
  node: T,
}

impl<T:Eq> Eq for Marked<T> {
  fn eq(&self, other: &Marked<T>) -> bool { self.node.eq(&other.node) }
  fn ne(&self, other: &Marked<T>) -> bool { !self.eq(other) }
}

pub impl<T> Marked<T> {
  fn new(t: T, m: Mark) -> Marked<T> {
    Marked{ node: t, span: m }
  }

  fn unwrap(~self) -> T {
    match self {
      ~Marked { node, _ } => return node,
    }
  }
}
