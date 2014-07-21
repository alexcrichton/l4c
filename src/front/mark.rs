use std::fmt;

#[deriving(Clone)]
pub struct Coords(pub Span, pub String);
pub type Mark = uint;
pub type Span = ((uint, uint), (uint, uint));

#[allow(non_uppercase_statics)]
pub static dummy: Mark = -1 as uint;

#[deriving(Clone, Eq)]
pub struct Marked<T> {
    pub span: Mark,
    pub node: T,
}

impl<T:PartialEq> PartialEq for Marked<T> {
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

impl<T: fmt::Show> fmt::Show for Marked<T> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        self.node.fmt(f)
    }
}
