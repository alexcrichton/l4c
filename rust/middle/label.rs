use front::ast;

pub enum Label {
  External(~str),
  Internal(~str)
}

#[cfg(target_os = "macos")]
fn prefix() -> ~str { ~"_" }

#[cfg(target_os = "linux")]
fn prefix() -> ~str { ~"" }

impl Label : PrettyPrint {
  fn pp() -> ~str {
    match self {
      External(ref s) => prefix() + *s,
      Internal(ref s) => prefix() + ~"_c0_" + *s
    }
  }
}
