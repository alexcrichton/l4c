use front::ast;

pub enum Label {
  External(~str),
  Internal(~str)
}

impl Label : PrettyPrint {
  fn pp() -> ~str {
    match self {
      External(ref s) => ~"_" + *s,
      Internal(ref s) => ~"_" + ~"_c0_" + *s
    }
  }
}
