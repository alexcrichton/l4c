//! Symbol-related functionality
//!
//! This module contains functions and helpers related to generating and
//! managing symbols in a program. Symbols are represented as indices into a
//! vector allocated elsewhere in order to allow symbols to be copyable and to
//! deduplicate copies of symbols in a program.

use std::cell::RefCell;
use std::collections::HashMap;
use std::fmt;

/// A symbol, represented as a pointer into a table elsewhere.
///
/// Symbols can be compared for equality and inequality, as well as hashed to be
/// keys later in hash maps.
#[derive(Clone, PartialEq, Eq, PartialOrd, Ord, Hash, Copy, Debug)]
pub struct Symbol(u32);

/// A structure to help generate symbols.
///
/// This structure is used during lexing and parsing to generate identifiers in
/// the AST.
#[derive(Clone)]
pub struct SymbolGenerator {
    /// Actual symbol table, the `Symbol` type above just contains indexes into
    /// this table.
    symbols: Vec<String>,
    /// Local cache of strings to symbols, this is destroyed after parsing.
    table: HashMap<String, Symbol>,
}

thread_local!(static SYMBOLS: RefCell<Vec<String>> = RefCell::new(Vec::new()));

impl SymbolGenerator {
    /// Creates a new empty symbol generator ready to generate new symbols.
    pub fn new() -> SymbolGenerator {
        let syms = SYMBOLS.with(|s| s.borrow().clone());
        SymbolGenerator {
            table: syms.iter().enumerate().map(|(i, s)| {
                (s.clone(), Symbol(i as u32))
            }).collect(),
            symbols: syms,
        }
    }

    /// Interns a new string, returning the corresponding symbol.
    ///
    /// This will aggressively deduplicate symbols, returning a Symbol which
    /// points to a previously allocated string if one exists.
    pub fn intern(&mut self, s: &str) -> Symbol {
        if let Some(sym) = self.table.get(s) {
            return *sym
        }
        let ret = Symbol(self.symbols.len() as u32);
        let s = String::from(s);
        self.table.insert(s.clone(), ret);
        self.symbols.push(s);
        return ret
    }

    /// Consume ownership of this Generator, storing the symbol table in
    /// task-local-data.
    ///
    /// The symbol table is stored in a "global" location so all functions have
    /// access to it instead of requiring it to be passed around.
    pub fn store(self) {
        SYMBOLS.with(move |symbols| {
            *symbols.borrow_mut() = self.symbols;
        })
    }
}

impl fmt::Display for Symbol {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        SYMBOLS.with(|symbols| {
            symbols.borrow()[self.0 as usize].fmt(f)
        })
    }
}

impl<'a> PartialEq<&'a str> for Symbol {
    fn eq(&self, other: &&'a str) -> bool {
        SYMBOLS.with(|symbols| {
            symbols.borrow()[self.0 as usize] == *other
        })
    }
}
