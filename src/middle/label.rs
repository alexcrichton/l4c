use std::fmt;

#[deriving(Clone)]
pub enum Label {
    External(String),
    Internal(String),
}

#[cfg(target_os = "macos")]
pub fn prefix() -> &'static str { "_" }

#[cfg(target_os = "linux")]
pub fn prefix() -> &'static str { "" }

impl fmt::Show for Label {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        try!(write!(f, "{}", prefix()));
        match *self {
            External(ref s) => write!(f, "{}", s),
            Internal(ref s) => write!(f, "_c0_{}", s),
        }
    }
}
