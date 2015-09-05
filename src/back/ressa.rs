use std::collections::HashMap;
use std::cmp;

use middle::ssa;
use back::assem::{Program, Function, StackInfo, RegisterInfo};
use utils::Temp;

pub fn convert(p: &mut Program) {
    for f in p.funs.iter_mut() {
        ressa(f);
    }
}

fn ressa(f: &mut Function) {
    // first, convert all temp registers
    let remapping = ssa::convert(&mut f.cfg, f.root, &mut f.ssa,
                                 &RegisterInfo);

    // Next, convert all memory locations (from spilling) to ssa-form. It'd be
    // nice if the analysis didn't have to get recomputed...
    let mut dummy = ssa::Analysis::new();
    ssa::convert(&mut f.cfg, f.root, &mut dummy, &StackInfo);

    // All of the temps now have new names, so we need to re-register the size
    // of each temp in the Function
    let mut newsizes = HashMap::new();
    for (new, old) in remapping {
        newsizes.insert(new, f.sizes[&old]);
    }
    f.sizes = newsizes;
    let mut max = 0;
    for &k in f.sizes.keys() {
        max = cmp::max(max, Temp::get(k));
    }
    f.temps = max + 1;
}
