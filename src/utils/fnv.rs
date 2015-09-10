use std::collections::hash_state::HashState;

use fnv::FnvHasher;

#[derive(Clone)]
pub struct FnvState;

impl HashState for FnvState {
    type Hasher = FnvHasher;

    fn hasher(&self) -> FnvHasher {
        FnvHasher::default()
    }
}

impl Default for FnvState {
    fn default() -> FnvState { FnvState }
}
