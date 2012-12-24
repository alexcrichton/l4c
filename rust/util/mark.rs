pub struct Coords((int, int), (int, int), ~str);
pub struct Mark<T> {
  data : T,
  pos : Coords
}

pub fn make<T>(t : T, c : Coords) -> Mark<T> {
  Mark{data: t, pos: c}
}
