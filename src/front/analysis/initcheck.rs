use std::mem;

use front::ast::{self, Item_, Stmt_, Expr_};
use utils::{Errors, Marked};

struct Initchecker<'a> {
    errors: &'a Errors,
    step: ast::Stmt,
}

pub fn check(a: &ast::Program) {
    let mut ic = Initchecker {
        errors: a.errors(),
        step: Marked::dummy(Stmt_::Nop),
    };
    debug!("initchecking");
    ic.run(a);
}

impl<'a> Initchecker<'a> {
    fn run(&mut self, p: &ast::Program) {
        for x in p.decls.iter() {
            self.check_item(x);
        }
        self.errors.check();
    }

    fn check_item(&mut self, g: &ast::Item) {
        match g.node {
            Item_::Function(_, _, _, ref body) => self.analyze(body),
            _ => ()
        }
    }

    fn analyze(&mut self, s: &ast::Stmt) {
        match s.node {
            Stmt_::If(_, ref s1, ref s2) |
            Stmt_::Seq(ref s1, ref s2) => {
                self.analyze(s1);
                self.analyze(s2);
            }
            Stmt_::While(_, ref s) => self.analyze(s),
            Stmt_::Declare(id, _, None, ref s) => {
                if self.live(id, s) {
                    self.errors.add(s.mark,
                                    &format!("Uninitialized variable: '{}'", id));
                } else {
                    self.analyze(s);
                }
            }
            Stmt_::Declare(_, _, _, ref s) => self.analyze(s),
            Stmt_::For(_, _, _, ref body) => self.analyze(body),
            _ => {}
        }
    }

    fn live(&mut self, sym: ast::Ident, s: &ast::Stmt) -> bool {
        match s.node {
            Stmt_::Declare(id, _, ref init, ref s) => {
                id != sym && (self.live(sym, s) || self.uses_opt(sym, init))
            }
            Stmt_::Assign(ref e1, Some(_), ref e2) => {
                self.uses(sym, e1) || self.uses(sym, e2)
            }
            Stmt_::Assign(_, _, ref e2) => self.uses(sym, e2),
            Stmt_::If(ref e, ref s1, ref s2) => {
                self.uses(sym, e) || self.live(sym, s1) || self.live(sym, s2)
            }
            Stmt_::While(ref e, ref s) => {
                let prev = mem::replace(&mut self.step,
                                        Marked::dummy(Stmt_::Nop));
                let ret = self.uses(sym, e) || self.live(sym, s);
                self.step = prev;
                ret
            }
            Stmt_::Break |
            Stmt_::Nop => false,
            Stmt_::Continue => {
                // TODO: remove clone
                let step = self.step.clone();
                self.live(sym, &step)
            }
            Stmt_::Express(ref e) |
            Stmt_::Return(ref e) => self.uses(sym, e),
            Stmt_::Seq(ref s1, ref s2) => self.seq_live(sym, s1, s2),
            Stmt_::For(ref s1, ref e, ref s2, ref s3) => {
                // TODO: remove clone and use 'with'
                let prev = mem::replace(&mut self.step, (**s2).clone());
                let ret = self.live(sym, s1) ||
                    ((self.uses(sym, e) ||
                      self.seq_live(sym, s3, s2)) &&
                     !self.defines(sym, s1));
                self.step = prev;
                ret
            }
        }
    }

    fn seq_live(&mut self, sym: ast::Ident, s1: &ast::Stmt,
                s2: &ast::Stmt) -> bool {
        self.live(sym, s1) || (self.live(sym, s2) && !self.defines(sym, s1))
    }

    fn uses(&self, sym: ast::Ident, e: &ast::Expr) -> bool {
        match e.node {
            Expr_::Var(id) => id == sym,
            Expr_::UnaryOp(_, ref e) |
            Expr_::Field(ref e, _, _) |
            Expr_::Deref(ref e, _) |
            Expr_::AllocArray(_, ref e) => self.uses(sym, e),
            Expr_::BinaryOp(_, ref e1, ref e2) |
            Expr_::ArrSub(ref e1, ref e2, _) => {
                self.uses(sym, e1) || self.uses(sym, e2)
            }
            Expr_::Ternary(ref e1, ref e2, ref e3, _) => {
                self.uses(sym, e1) || self.uses(sym, e2) ||
                self.uses(sym, e3)
            }
            Expr_::Call(_, ref args, _) => {
                args.iter().any(|x| self.uses(sym, x))
            }
            _ => false
        }
    }

    fn uses_opt(&self, sym: ast::Ident, e: &Option<ast::Expr>) -> bool {
        match *e {
            None => false,
            Some(ref e) => self.uses(sym, e)
        }
    }

    fn defines(&mut self, sym: ast::Ident, s: &ast::Stmt) -> bool {
        match s.node {
            Stmt_::While(_, _) |
            Stmt_::Nop |
            Stmt_::Express(_) => false,

            Stmt_::Break |
            Stmt_::Continue |
            Stmt_::Return(_) => true,

            Stmt_::Declare(id, _, Some(_), ref s) => {
                sym == id || self.defines(sym, s)
            }
            Stmt_::Declare(_, _, None, ref s) => self.defines(sym, s),
            Stmt_::Assign(ref dst, _, _) => {
                match dst.node {
                    Expr_::Var(id) => id == sym,
                    _ => false,
                }
            }
            Stmt_::If(_, ref s1, ref s2) => {
                self.defines(sym, s1) && self.defines(sym, s2)
            }

            Stmt_::For(ref init, _, _, _) => self.defines(sym, init),
            Stmt_::Seq(ref s1, ref s2) => {
                self.defines(sym, s1) || self.defines(sym, s2)
            }
        }
    }
}
