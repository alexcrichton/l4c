use std::io;

pub use utils::symbol::{Symbol, SymbolGenerator};
pub use utils::errors::Errors;
pub use utils::mark::{Mark, Marked, CodeMap, DUMMY_MARK};
pub use utils::temp::{Temp, TempSet, TempAllocator, TempBitVec, TempVecMap};
pub use utils::fnv::FnvState;
pub use utils::small_bit_vec::SmallBitVec;

pub mod graph;
pub mod profile;

mod errors;
mod mark;
mod symbol;
mod temp;
mod fnv;
mod small_bit_vec;

pub trait Graphable {
    fn dot(&self, &mut io::Write) -> io::Result<()>;
}
