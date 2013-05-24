use std::hashmap::HashMap;

use middle::ssa;
use back::assem;

pub fn convert(p: &mut assem::Program) {
  for vec::each_mut(p.funs) |f| {
    ressa(f);
  }
}

fn ressa(f: &mut assem::Function) {
  /* first, convert all temp registers */
  let mut remapping = ssa::convert(&mut f.cfg, f.root, &mut f.ssa,
                                   &assem::RegisterInfo);

  /* Next, convert all memory locations (from spilling) to ssa-form. It'd be
     nice if the analysis didn't have to get recomputed... */
  let mut dummy = ssa::Analysis();
  ssa::convert(&mut f.cfg, f.root, &mut dummy, &assem::StackInfo);

  /* All of the temps now have new names, so we need to re-register the size of
     each temp in the Function */
  let mut newsizes = HashMap::new();
  do remapping.consume |new, old| {
    newsizes.insert(new, *f.sizes.get(&old));
  }
  f.sizes.clear();
  let mut max = 0;
  for newsizes.each |&k, &v| {
    debug!("%? => %?", k, v);
    f.sizes.insert(k, v);
    max = uint::max(max, k as uint);
  }
  f.temps = max + 1;
}