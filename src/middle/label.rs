use std::fmt;
use utils::Symbol;

#[derive(Clone, Copy)]
pub enum Label {
    External(Symbol),
    Internal(Symbol),
}

#[cfg(target_os = "macos")]
pub fn prefix() -> &'static str { "_" }

#[cfg(target_os = "linux")]
pub fn prefix() -> &'static str { "" }

impl fmt::Display for Label {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        try!(write!(f, "{}", prefix()));
        match *self {
            Label::External(s) => write!(f, "{}", s),
            Label::Internal(s) => write!(f, "_c0_{}", s),
        }
    }
}
