use std::mem;

use middle::ir::{Expr, Stmt, Program, Binop, Type};
use utils::Temp;

pub fn optimize(p: &mut Program) {
    for f in p.funs.iter_mut() {
        f.cfg.map_nodes(&mut |_, mut ins| {
            for s in ins.iter_mut() {
                stmt(s);
            }
            return ins
        })
    }
}

fn stmt(s: &mut Stmt) {
    match *s {
        Stmt::Move(_, ref mut e) |
        Stmt::Load(_, ref mut e) |
        Stmt::Condition(ref mut e) |
        Stmt::Return(ref mut e) |
        Stmt::Die(ref mut e) => expr(e),

        Stmt::Call(_, ref mut e, ref mut args) => {
            expr(e);
            for arg in args {
                expr(arg);
            }
        }
        Stmt::Store(ref mut e1, ref mut e2) => {
            expr(e1);
            expr(e2);
        }

        Stmt::Cast(..) |
        Stmt::Phi(..) |
        Stmt::Arguments(..) => {}
    }
}

fn expr(e: &mut Expr) {
    match *e {
        Expr::BinaryOp(ref mut op, ref mut e1, ref mut e2) => {
            expr(e1);
            expr(e2);

            match (*op, imm(e1), imm(e2)) {
                (Binop::Mul, Some((c, s)), _) if pow2(c) => {
                    mem::swap(e1, e2);
                    **e2 = Expr::Const(log2(c), s);
                    *op = Binop::Lsh;
                }
                (Binop::Mul, _, Some((c, s))) if pow2(c) => {
                    **e2 = Expr::Const(log2(c), s);
                    *op = Binop::Lsh;
                }
                (Binop::Div, _, Some((c, s))) if pow2(c) => {
                    **e2 = Expr::Const(log2(c), s);
                    *op = Binop::Rsh;
                }
                (Binop::Mod, _, Some((c, s))) if pow2(c) => {
                    **e2 = Expr::Const(c - 1, s);
                    *op = Binop::And;
                }
                _ => {}
            }
        }

        Expr::Temp(..) |
        Expr::Const(..) |
        Expr::Label(..) => {}
    }
}

fn imm(e: &Expr) -> Option<(i32, Type)> {
    match *e {
        Expr::Const(c, s) => Some((c, s)),
        _ => None,
    }
}

fn pow2(c: i32) -> bool {
    // http://stackoverflow.com/questions/600293/how
    c > 0 && (c & (c - 1) == 0)
}

fn log2(mut c: i32) -> i32 {
    let mut ret = 0;
    while c > 1 {
        ret += 1;
        c /= 2;
    }
    return ret;
}

#[test]
fn test_pow2() {
    assert!(pow2(2));
    assert!(pow2(4));
    assert!(pow2(8));
    assert!(pow2(16));
    assert!(pow2(32));
    assert!(pow2(64));
    assert!(pow2(1 << 22));
    assert!(!pow2(3));
    assert!(!pow2(5));
    assert!(!pow2(135318));
    assert!(!pow2(1991919));
}

#[test]
fn test_log2() {
    assert!(log2(1) == 0);
    assert!(log2(2) == 1);
    assert!(log2(4) == 2);
    assert!(log2(8) == 3);
    assert!(log2(1 << 22) == 22);
}
