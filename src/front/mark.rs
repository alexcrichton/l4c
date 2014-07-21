#[deriving(Clone)]
pub struct Coords(Span, String);
pub type Mark = uint;
pub type Span = ((uint, uint), (uint, uint));

#[allow(non_uppercase_statics)]
pub static dummy: Mark = -1 as uint;

#[deriving(Clone)]
pub struct Marked<T> {
    span: Mark,
    node: T,
}

impl<T:Eq> Eq for Marked<T> {
    fn eq(&self, other: &Marked<T>) -> bool { self.node.eq(&other.node) }
    fn ne(&self, other: &Marked<T>) -> bool { !self.eq(other) }
}

impl<T> Marked<T> {
    pub fn new(t: T, m: Mark) -> Marked<T> {
        Marked{ node: t, span: m }
    }

    pub fn unwrap(self: Box<Marked<T>>) -> T {
        self.node
    }
}
