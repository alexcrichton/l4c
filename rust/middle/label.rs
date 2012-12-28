use front::ast;

pub enum Label {
  External(~str),
  Internal(~str)
}
