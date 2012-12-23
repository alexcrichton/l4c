type Coords = ((int, int), (int, int), ~str);
pub type Mark<T> = (T, Coords);

/*impl<T> Mark<T> {*/
/*  fn data() -> T {*/
/*    match self { (t, _) => t }*/
/*  }*/
/*}*/

pub fn make<T>(t : T, c : Coords) -> Mark<T> {
  (t, c)
}
