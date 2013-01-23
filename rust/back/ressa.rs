use middle::ssa;
use back::assem;
use std::map;

pub fn convert(p : &assem::Program) {
  for p.funs.each |f| {
    ressa(f);
  }
}

fn ressa(f : &assem::Function) {
  /* tables/metadata altered through temp remapping */
  let oldsizes = f.sizes;
  let newsizes = map::HashMap();

  /* And, convert! */
  ssa::convert(&f.cfg, f.root, ~[], &f.ssa, |old, new| {
    info!("%? => %?", old, new);
    newsizes.insert(new, oldsizes[old]);
  }, |tmp, map| @assem::Phi(tmp, map));

  /* update all type information for the new temps */
  f.sizes.clear();
  let mut max = 0;
  for newsizes.each |k, v| {
    f.sizes.insert(k, v);
    max = uint::max(max, k as uint);
  }
  f.temps = max + 1;
}
