use std::map;

struct StackAllocator {
  f : &assem::Function,
}

pub fn alloc(p : &assem::Program) {
  for p.funs.each |f| {
    let sa = StackAllocator { f: f };
    sa.allocate();
  }
}

impl StackAllocator {
  fn allocate() {
  }
}
