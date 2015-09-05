/// Dead code elimination
///
/// Because the graph is in SSA form, it's far easier to do dead code elimination
/// than it would normally be. This simply walks up the dominator tree from the
/// bottom, and if a statement defines a temp never used and the statement is
/// pure, it's eliminated. Otherwise, all its uses are then flagged as used.
///
/// Furthermore, this eliminates all code after a 'return' or sure death.

use middle::ir::{Stmt, Program, Function, Expr, Binop};
use utils::TempBitVec;

struct Eliminator {
    used: TempBitVec,
}

pub fn optimize(p: &mut Program) {
    for f in p.funs.iter_mut() {
        let mut opt = Eliminator {
            used: TempBitVec::with_capacity(f.types.len()),
        };
        // TODO: surely this is easier on SSA form?
        while opt.run(f) {}
    }
}

impl Eliminator {
    fn run(&mut self, f: &mut Function) -> bool {
        debug!("running");
        self.used.clear();

        // Mark all phi function arguments as used before we go anywhere
        for (_, stms) in f.cfg.nodes() {
            for s in stms.iter() {
                if let Stmt::Phi(_, ref m) = *s {
                    for (_, &t) in m.iter() {
                        self.used.insert(t);
                    }
                }
            }
        }

        // Be sure to start at the top of the graph to visit definitions first
        let (order, _) = f.cfg.postorder(f.root);
        let mut changed = false;
        for &n in order.iter() {
            // TODO: less movement
            let mut node = f.cfg.pop_node(n);
            let orig = node.len();
            node.reverse();
            node.retain(|stmt| self.keep_stmt(stmt));
            node.reverse();

            let end = self.first_impossible(&node);
            node.truncate(end);
            changed = changed || orig != node.len();

            f.cfg.update_node(n, node);
        }
        return changed;
    }

    fn keep_stmt(&mut self, s: &Stmt) -> bool {
        match *s {
            // Keep all argument statements
            Stmt::Arguments(..) => return true,
            // Impossible death doesn't need to be pushed back
            Stmt::Die(Expr::Const(0, _)) => return false,
            _ => {}
        }
        let mut def = None;
        s.each_def(&mut |t| {
            assert!(def.is_none());
            def = Some(t);
        });

        // If the definition was never used, and we're a pure statement (no side
        // effects) then we can definitely remove this code
        if let Some(def) = def {
            if !self.used.contains(def) && self.ispure(&s) {
                return false
            }
        }
        // otherwise, mark all our uses as 'used', and continue on
        s.each_use(&mut |t| {
            self.used.insert(t);
        });
        return true
    }

    fn ispure(&self, s: &Stmt) -> bool {
        match *s {
            Stmt::Call(..) |
            Stmt::Load(..) |
            Stmt::Move(_, Expr::BinaryOp(Binop::Div, _, _)) |
            Stmt::Move(_, Expr::BinaryOp(Binop::Mod, _, _)) => false,
            _ => true
        }
    }

    fn first_impossible(&self, b: &[Stmt]) -> usize {
        for (i, stm) in b.iter().enumerate() {
            match *stm {
                Stmt::Die(Expr::Const(c, _)) if c != 0 => return i + 1,
                Stmt::Return(..) => return i + 1,
                _ => ()
            }
        }
        return b.len()
    }
}
