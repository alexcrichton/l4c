//! Positional markers
//!
//! This module contains an implementation of positional markers to attribute
//! nodes in the AST with information from whence they came. This facilitates
//! higher quality error messages.

use std::fmt;
use std::path::{PathBuf, Path};
use std::io::{self, Read};
use std::fs::File;

/// A mark is represented by the (lo, hi) byte offsets into the original source
/// program.
///
/// It is guaranteed that `lo <= hi`. A `CodeMap` instance is needed to make
/// sense of a `Mark`.
#[derive(Copy, Clone, Eq, PartialEq)]
pub struct Mark {
    pub lo: u32,
    pub hi: u32,
}

/// A generic wrapper to contain a marked piece of information.
///
/// This is convenient for specifying that the inner `node` is produced by the
/// code mentioned by `mark`.
#[derive(Copy, Clone, Eq)]
pub struct Marked<T> {
    pub mark: Mark,
    pub node: T,
}

/// Representation of a source program to translate a `Mark` to a `String`.
pub struct CodeMap {
    code: String,
    files: Vec<(usize, PathBuf)>,
}

/// A dummy span to represent the "entire program"
pub static DUMMY_MARK: Mark = Mark { lo: 0, hi: 0 };

impl Mark {
    /// Converts this `Mark` to a string given the specified code map.
    pub fn to_string(&self, cm: &CodeMap) -> String {
        let (loline, locol) = cm.linecol(self.lo);
        let (hiline, hicol) = cm.linecol(self.hi);
        format!("{}:{}-{}:{}", loline, locol, hiline, hicol)
    }
}

impl<T> Marked<T> {
    /// Helper function for creating a new instance of a marked node.
    pub fn new(t: T, mark: Mark) -> Marked<T> {
        Marked { node: t, mark: mark }
    }

    pub fn dummy(t: T) -> Marked<T> {
        Marked::new(t, DUMMY_MARK)
    }
}

/// Allow marked instances to be compared with == and !=
impl<T: PartialEq> PartialEq for Marked<T> {
    fn eq(&self, other: &Marked<T>) -> bool { self.node.eq(&other.node) }
}

/// Allow marked things to be printed with `{:?}`
impl<T: fmt::Display> fmt::Display for Marked<T> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        self.node.fmt(f)
    }
}

impl CodeMap {
    /// Creates a new code map for the program in question.
    pub fn new() -> CodeMap {
        CodeMap { code: String::new(), files: Vec::new() }
    }

    /// Adds a new file to this code map
    pub fn add(&mut self, file: &Path) -> io::Result<u32> {
        let ret = self.files.len() as u32;
        let offset = self.code.len();
        let mut f = try!(File::open(file));
        try!(f.read_to_string(&mut self.code));
        self.files.push((offset, file.to_owned()));
        Ok(ret)
    }

    /// Converts a bytes offset of a `Mark` into a (line, column) pair.
    ///
    /// All indexes returned are 1-based.
    pub fn linecol(&self, offset: u32) -> (usize, usize) {
        let file = self.file(Mark { lo: offset, hi: offset });
        let offset = offset as usize - self.files[file as usize].0;
        let code = self.code(file);

        let mut cur = 0;
        for (i, line) in code.split('\n').enumerate() {
            if cur + line.len() > offset {
                return (i + 1, offset - cur + 1)
            }
            cur += line.len() + 1;
        }
        (code.split('\n').count() + 1, 1)
    }

    pub fn mark(&self, file: u32, lo: usize, hi: usize) -> Mark {
        let offset = self.files[file as usize].0;
        Mark {
            lo: (lo + offset) as u32,
            hi: (hi + offset) as u32,
        }
    }

    /// Returns the code for a particular file in this code map.
    pub fn code(&self, file: u32) -> &str {
        let file = file as usize;
        let end = self.files.get(file + 1).map(|f| f.0)
                            .unwrap_or(self.code.len());
        &self.code[(self.files[file].0)..end]
    }

    /// Returns the file that the offset corresponds to
    pub fn file(&self, mark: Mark) -> u32 {
        self.files.iter().enumerate().find(|&(_, &(o, _))| {
            o > (mark.lo as usize)
        }).map(|(i, _)| i - 1).unwrap_or(self.files.len() - 1) as u32
    }

    /// Returns the file that this code map represents.
    pub fn path(&self, mark: Mark) -> &Path {
        &self.files[self.file(mark) as usize].1
    }
}
