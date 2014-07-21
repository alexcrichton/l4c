use std::collections::HashMap;
use std::cmp;

use middle::ssa;
use back::assem;

pub fn convert(p: &mut assem::Program) {
    for f in p.funs.mut_iter() {
        ressa(f);
    }
}

fn ressa(f: &mut assem::Function) {
    /* first, convert all temp registers */
    let remapping = ssa::convert(&mut f.cfg, f.root, &mut f.ssa,
                                 &assem::RegisterInfo);

    /* Next, convert all memory locations (from spilling) to ssa-form. It'd be
       nice if the analysis didn't have to get recomputed... */
    let mut dummy = ssa::Analysis::new();
    ssa::convert(&mut f.cfg, f.root, &mut dummy, &assem::StackInfo);

    /* All of the temps now have new names, so we need to re-register the size of
       each temp in the Function */
    let mut newsizes = HashMap::new();
    for (new, old) in remapping.move_iter() {
        newsizes.insert(new, *f.sizes.get(&old));
    }
    f.sizes.clear();
    let mut max = 0;
    for (&k, &v) in newsizes.iter() {
        debug!("{} => {}", k, v);
        f.sizes.insert(k, v);
        max = cmp::max(max, *k as uint);
    }
    f.temps = max + 1;
}
