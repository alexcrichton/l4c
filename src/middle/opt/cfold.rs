/// A few optimizations thrown into one: constant folding, constant
/// propagation, and copy propagation
///
/// This module will fold all constant expressions in the IR, reducing as much
/// definite arithmetic as possible. This will also propogate temps equal to
/// constants so that neededness analysis may be able to remove a lot of temps.
/// Finally if 'y <- x' is seen, then all instances of 'y' are replaced with 'x'
/// so the move can be considered dead code.

use std::collections::HashMap;
use std::i32;
use std::mem;

use middle::ir::{Expr, Stmt, Program, Function, Binop, Type};
use utils::Temp;

struct ConstantFolder<'a> {
    f: &'a mut Function,
    constants: HashMap<Temp, i32>,
    temps: HashMap<Temp, Temp>,
}

pub fn optimize(p: &mut Program) {
    for f in p.funs.iter_mut() {
        let mut opt = ConstantFolder {
            f: f,
            constants: HashMap::new(),
            temps: HashMap::new(),
        };
        opt.run();
    }
}

impl<'a> ConstantFolder<'a> {
    fn run(&mut self) {
        // Be sure to start at the top of the graph to visit definitions first
        let (order, _) = self.f.cfg.postorder(self.f.root);
        for &n in order.iter().rev() {
            // TODO: less movement
            let mut node = self.f.cfg.pop_node(n);
            for stm in node.iter_mut() {
                self.stm(stm);
            }
            self.f.cfg.add_node(n, node);
        }

        let temps = &self.temps;
        // TODO: less movement
        self.f.cfg.map_nodes(&mut |_, mut stms| {
            for stm in stms.iter_mut() {
                stm.map_temps(&mut |t| *temps.get(&t).unwrap_or(&t),
                              &mut |t| t);
            }
            stms
        });
    }

    /// Apply constant folding to a statement, returning the folded statement
    fn stm(&mut self, s: &mut Stmt) {
        match *s {
            Stmt::Move(t, ref mut e) => {
                self.exp(e);
                match *e {
                    Expr::Const(amt, _) => { self.constants.insert(t, amt); }
                    Expr::Temp(cp) => {
                        let other = match self.temps.get(&cp) {
                            Some(&other) => other,
                            None => cp
                        };
                        self.temps.insert(t, other);
                    }
                    _ => ()
                }
            }
            Stmt::Load(_, ref mut e) => {
                self.exp(e);
            }
            Stmt::Call(_, _, ref mut args) => {
                for arg in args {
                    self.exp(arg);
                }
            }
            Stmt::Store(ref mut e1, ref mut e2) => {
                self.exp(e1);
                self.exp(e2);
            }
            Stmt::Condition(ref mut e) |
            Stmt::Return(ref mut e) |
            Stmt::Die(ref mut e) => { self.exp(e); }

            Stmt::Arguments(..) |
            Stmt::Cast(..) |
            Stmt::Phi(..) => {}
        }
    }

    /// Apply constant folding to an expression, returning the folded expression
    ///
    /// The boolean returned is whether the expression is considered 'pure' and is
    /// safe for removal. This is false for things like div and mod
    fn exp(&mut self, e: &mut Expr) -> bool {
        let ret = match *e {
            Expr::Label(..) => return true,
            Expr::Const(..) => return true,
            Expr::Temp(t) => {
                if let Some(c) = self.constants.get(&t) {
                    *e = Expr::Const(*c, self.f.types[&t]);
                }
                return true
            }
            Expr::BinaryOp(ref mut op, ref mut e1, ref mut e2) => {
                let p1 = self.exp(e1);
                let p2 = self.exp(e2);
                let p = p1 && p2;
                if let Expr::Const(i1, t1) = **e1 {
                    // Two constants? let's actually fold them!
                    if let Expr::Const(i2, t2) = **e2 {
                        assert!(t1 == t2);
                        do_op(*op, i1, i2).map(|i| {
                            (Expr::Const(i, t1), true)
                        }).ok_or(false)
                    } else {
                        self.binop(op, e1, e2, p).ok_or(p)
                    }
                } else if let Expr::Const(i2, t2) = **e2 {
                    // Prefer the constant on the left
                    if op.commutative() {
                        mem::swap(e1, e2);
                    } else if *op == Binop::Sub {
                        **e2 = Expr::Const(-i2, t2);
                        mem::swap(e1, e2);
                        *op = Binop::Add;
                    }
                    self.binop(op, e1, e2, p).ok_or(p)
                } else {
                    return p
                }
            }
        };
        match ret {
            Ok((new_expr, ispure)) => {
                *e = new_expr;
                ispure
            }
            Err(ispure) => ispure
        }
    }

    /// Performs constant folding on binops where both expressions aren't constants
    ///
    /// This function assumes that e1 is a constant if possible, and it will
    /// attempt to eliminate redundant instructions like divisions/multiplications
    /// by 1, etc.
    fn binop(&mut self,
             o: &mut Binop,
             e1: &mut Expr,
             e2: &mut Expr,
             ispure: bool) -> Option<(Expr, bool)> {
        if let Expr::Const(mut c, s) = *e1 {
            // Attempt to rotate constants out of binops to the left
            while let Expr::BinaryOp(..) = *e2 {
                let (o2, e3, e4) = match mem::replace(e2, nop()) {
                    Expr::BinaryOp(a, b, c) => (a, b, c),
                    _ => unreachable!(),
                };

                if let Expr::Const(c2, s2) = *e3 {
                    assert!(s == s2);
                    if *o == o2 && o.associative() {
                        c = do_op(o2, c, c2).unwrap(); // div/mod aren't assoc.
                        *e2 = *e4;
                        continue
                    } else if *o == o2 && *o == Binop::Sub {
                        *o = Binop::Add;
                        c -= c2;
                        *e2 = *e4;
                        continue
                    }
                }

                *e2 = Expr::BinaryOp(o2, e3, e4);
                break
            }

            // If no rotations are possible, catch simple math like
            // multiplication by 0, bit tricks, etc.
            if c == 0 {
                if *o == Binop::Add || *o == Binop::Or || *o == Binop::Xor {
                    return Some((mem::replace(e2, nop()), ispure))
                }
                if ispure && (*o == Binop::Mul || *o == Binop::And) {
                    return Some((Expr::Const(0, s), true))
                }
            }
            if c == 1 && *o == Binop::Mul {
                return Some((mem::replace(e2, nop()), ispure))
            }
        }

        if let Expr::Const(1, s) = *e2 {
            // get rid of div/mod by 1
            if *o == Binop::Div {
                return Some((mem::replace(e1, nop()), ispure))
            }
            if ispure && *o == Binop::Mod {
                return Some((Expr::Const(0, s), ispure))
            }
        }
        None
    }
}

fn do_op(op: Binop, i1: i32, i2: i32) -> Option<i32> {
    Some(match op {
        Binop::Add => i1 + i2,
        Binop::Sub => i1 - i2,
        Binop::Mul => i1 * i2,
        Binop::Lt  => if i1 < i2 {1} else {0},
        Binop::Lte => if i1 <= i2 {1} else {0},
        Binop::Gt  => if i1 > i2 {1} else {0},
        Binop::Gte => if i1 >= i2 {1} else {0},
        Binop::Eq  => if i1 == i2 {1} else {0},
        Binop::Neq => if i1 != i2 {1} else {0},
        Binop::And => i1 & i2,
        Binop::Or  => i1 | i2,
        Binop::Xor => i1 ^ i2,
        Binop::Lsh => i1 << i2,
        Binop::Rsh => i1 >> i2,
        Binop::Div |
        Binop::Mod => {
            if i2 == 0 || (i1 == i32::MIN && i2 == -1) {
                return None
            } else {
                match op {
                    Binop::Div => i1 / i2,
                    Binop::Mod => i1 % i2,
                    _ => panic!()
                }
            }
        }
    })
}

fn nop() -> Expr {
    Expr::Const(0, Type::Int)
}
