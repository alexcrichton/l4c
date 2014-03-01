use std::hash;
use std::io;

pub struct Hasher;
struct State(u64);

impl hash::Hasher<State> for Hasher {
    fn hash<T: hash::Hash<State>>(&self, t: &T) -> u64 {
        let mut state = State(0xcbf29ce484222325);
        t.hash(&mut state);
        let State(ret) = state;
        return ret;
    }
}

impl Writer for State {
    fn write(&mut self, bytes: &[u8]) -> io::IoResult<()> {
        let State(mut hash) = *self;
        for byte in bytes.iter() {
            hash = hash * 0x100000001b3;
            hash = hash ^ (*byte as u64);
        }
        *self = State(hash);
        Ok(())
    }
}
