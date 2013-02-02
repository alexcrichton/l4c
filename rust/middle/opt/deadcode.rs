/**
 * TODO: dox
 */

use std::bitv;

use middle::ir::*;

struct Eliminator {
  f: &mut Function,
  used: bitv::Bitv,
  stms: ~[@Statement],
}

pub fn optimize(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    let mut opt = Eliminator { f: f,
                               stms: ~[],
                               used: bitv::Bitv(f.types.len(), false) };
    opt.run();
  }
}

impl Eliminator {
  /* TODO: why can't this all be above */
  fn run(&mut self) {
    /* Mark all phi function arguments as used before we go anywhere */
    for self.f.cfg.each_node |_, stms| {
      for stms.each |&s| {
        match s {
          @Phi(_, m) => {
            for m.each_value |t| {
              self.used.set(t, true);
            }
          }
          _ => ()
        }
      }
    }

    /* Be sure to start at the top of the graph to visit definitions first */
    let (order, _) = self.f.cfg.postorder(self.f.root);
    for order.each |&n| {
      vec::rev_each(*self.f.cfg[n], |&stm| self.stm(stm));
      let mut block = ~[];
      block <-> self.stms;
      vec::reverse(block);
      self.f.cfg.update_node(n, @block);
    }
  }

  fn stm(&mut self, s: @Statement) -> bool {
    /* Keep all argument/phi statements */
    match s {
      @Arguments(*) => { self.stms.push(s); return true; }
      _ => ()
    }
    let mut def = None;
    for s.each_def |t| {
      assert def.is_none();
      def = Some(t);
    }

    /* If the definition was never used, and we're a pure statement (no side
       effects) then we can definitely remove this code */
    match def {
      Some(def) => {
        if !self.used.get(def) && self.ispure(s) {
          return true;
        }
      }
      /* No definitions? Kinda hard to eliminate... */
      None => ()
    }
    /* otherwise, mark all our uses as 'used', and continue on */
    for s.each_use |t| {
      self.used.set(t, true);
    }
    self.stms.push(s);
    return true;
  }

  fn ispure(&self, s: @Statement) -> bool {
    match s {
      @Phi(*) | @Call(*) | @Load(*) | @Move(_, @BinaryOp(Div, _, _)) => false,
      _ => true
    }
  }
}
