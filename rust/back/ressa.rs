use middle::ssa;
use back::assem;
use std::map;

pub fn convert(p : &mut assem::Program) {
  for vec::each_mut(p.funs) |f| {
    ressa(f);
  }
}

fn ressa(f : &mut assem::Function) {
  /* tables/metadata altered through temp remapping */
  let newsizes = map::HashMap();

  /* And, convert! */
  let mut remapping = ssa::convert(&mut f.cfg, f.root, &mut f.ssa);
  do remapping.consume |new, old| {
    newsizes.insert(new, f.sizes[old]);
  }

  /* update all type information for the new temps */
  f.sizes.clear();
  let mut max = 0;
  for newsizes.each |k, v| {
    f.sizes.insert(k, v);
    max = uint::max(max, k as uint);
  }
  f.temps = max + 1;
}
