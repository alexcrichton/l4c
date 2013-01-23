use utils::PrettyPrint;

pub enum Label {
  External(~str),
  Internal(~str)
}

#[cfg(target_os = "macos")]
pub pure fn prefix() -> ~str { ~"_" }

#[cfg(target_os = "linux")]
pub pure fn prefix() -> ~str { ~"" }

impl Label : PrettyPrint {
  pure fn pp() -> ~str {
    match self {
      External(ref s) => prefix() + *s,
      Internal(ref s) => prefix() + ~"_c0_" + *s
    }
  }
}
