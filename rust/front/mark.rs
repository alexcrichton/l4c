pub struct Coords((int, int), (int, int), @~str);

pub type Mark = uint;

pub static dummy: Mark = -1 as uint;

pub struct Marked<T> {
  span: Mark,
  node: T,
}

impl<T> Marked<T> {
  pub fn new(t: T, m: Mark) -> Marked<T> {
    Marked{ node: t, span: m }
  }

  pub fn unwrap(~self) -> T {
    match self {
      ~Marked { node, _ } => return node,
    }
  }
}
