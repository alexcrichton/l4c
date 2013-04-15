/**
 * ~brief Dead code elimination
 *
 * Because the graph is in SSA form, it's far easier to do dead code elimination
 * than it would normally be. This simply walks up the dominator tree from the
 * bottom, and if a statement defines a temp never used and the statement is
 * pure, it's eliminated. Otherwise, all its uses are then flagged as used.
 *
 * Furthermore, this eliminates all code after a 'return' or sure death.
 */

use std::bitv;

use middle::ir::*;

struct Eliminator {
  f: @mut Function,
  used: bitv::Bitv,
  stms: ~[~Statement],
}

pub fn optimize(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    let mut opt = Eliminator { f: *f,
                               stms: ~[],
                               used: bitv::Bitv::new(f.types.len(), false) };
    /* TODO: surely this is easier on SSA form? */
    while opt.run() {}
  }
}

impl Eliminator {
  /* TODO: why can't this all be above */
  fn run(&mut self) -> bool {
    assert!(self.stms.len() == 0);
    debug!("running");
    self.used.clear();
    /* Mark all phi function arguments as used before we go anywhere */
    unsafe {
      for self.f.cfg.each_node |_, stms| {
        for stms.each |&s| {
          match s {
            ~Phi(_, ref m) => {
              for m.each |_, &t| {
                self.used.set(t, true);
              }
            }
            _ => ()
          }
        }
      }
    }

    /* Be sure to start at the top of the graph to visit definitions first */
    let (order, _) = unsafe { self.f.cfg.postorder(self.f.root) };
    let mut changed = false;
    for order.each |&n| {
      let orig = self.f.cfg.node(n).len();
      self.f.cfg.node(n).each_reverse(|&stm| self.stm(stm));
      let mut block = ~[];
      block <-> self.stms;
      vec::reverse(block);

      let end = self.first_impossible(block);
      block.truncate(end);
      changed = changed || orig != block.len();

      self.f.cfg.update_node(n, block);
    }
    return changed;
  }

  fn stm(&mut self, s: ~Statement) -> bool {
    let s = match s {
      /* Keep all argument statements */
      ~Arguments(a) => { self.stms.push(~Arguments(a)); return true; }
      /* Impossible death doesn't need to be pushed back */
      ~Die(~Const(0, _)) => { return true; }
      s => s
    };
    let mut def = None;
    for s.each_def |t| {
      assert!(def.is_none());
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

  fn ispure(&self, s: &Statement) -> bool {
    match *s {
      Call(*) | Load(*) |
        Move(_, ~BinaryOp(Div, _, _)) | Move(_, ~BinaryOp(Mod, _, _)) => false,
      _ => true
    }
  }

  fn first_impossible(&self, b: &[~Statement]) -> uint {
    for b.eachi |i, &stm| {
      match stm {
        ~Die(~Const(c, _)) if c != 0 => return i + 1,
        ~Return(*) => return i + 1,
        _ => ()
      }
    }
    return b.len();
  }
}
