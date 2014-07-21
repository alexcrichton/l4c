/**
 * ~brief A few optimizations thrown into one: constant folding, constant
 *        propagation, and copy propagation
 *
 * This module will fold all constant expressions in the IR, reducing as much
 * definite arithmetic as possible. This will also propogate temps equal to
 * constants so that neededness analysis may be able to remove a lot of temps.
 * Finally if 'y <- x' is seen, then all instances of 'y' are replaced with 'x'
 * so the move can be considered dead code.
 */

use std::collections::HashMap;
use std::i32;

use middle::ir::*;
use middle::ir;
use middle::temp::Temp;

struct ConstantFolder<'a> {
    f: &'a mut Function,
    constants: HashMap<Temp, i32>,
    temps: HashMap<Temp, Temp>,
}

pub fn optimize(p: &mut Program) {
    for f in p.funs.mut_iter() {
        /* TODO(#5884): should initialize directly */
        let (constants, temps) = (HashMap::new(), HashMap::new());
        let mut opt = ConstantFolder {
            f: f,
            constants: constants,
            temps: temps,
        };
        opt.run();
    }
}

impl<'a> ConstantFolder<'a> {
    fn run(&mut self) {
        /* Be sure to start at the top of the graph to visit definitions first */
        let (order, _) = self.f.cfg.postorder(self.f.root);
        for &n in order.iter().rev() {
            let node = self.f.cfg.pop_node(n);
            let node = node.move_iter().map(|s| self.stm(s)).collect();
            self.f.cfg.add_node(n, node);
        }

        let temps = &self.temps;
        self.f.cfg.map_nodes(|_, stms| {
            stms.move_iter().map(|s| {
                s.map_temps(|t| *temps.find(&t).unwrap_or(&t), |t| t)
            }).collect()
        });
    }

    /**
     * Apply constant folding to a statement, returning the folded statement
     */
    fn stm(&mut self, s: Box<Statement>) -> Box<Statement> {
        box match *s {
            Move(t, e) => {
                let e = self.exp(e).val0();
                match *e {
                    Const(amt, _) => { self.constants.insert(t, amt); }
                    ir::Temp(cp)      => {
                        let other = match self.temps.find(&cp) {
                            Some(&other) => other, None => cp
                        };
                        self.temps.insert(t, other);
                    }
                    _ => ()
                }
                Move(t, e)
            }
            Load(t, e) => Load(t, self.exp(e).val0()),
            Call(t, e, args) => Call(t, e,
                                       args.move_iter().map(|e| {
                                           self.exp(e).val0()
                                       }).collect()),
            Store(e1, e2) => Store(self.exp(e1).val0(), self.exp(e2).val0()),
            Condition(e) => Condition(self.exp(e).val0()),
            Return(e) => Return(self.exp(e).val0()),
            Die(e) => Die(self.exp(e).val0()),

            /* TODO: shouldn't have to re-build these things */
            Arguments(args) => Arguments(args),
            Cast(t1, t2) => Cast(t1, t2),
            Phi(t, map) => Phi(t, map)
        }
    }

    /**
     * Apply constant folding to an expression, returning the folded expression
     *
     * The boolean returned is whether the expression is considered 'pure' and is
     * safe for removal. This is false for things like div and mod
     */
    fn exp(&mut self, e: Box<Expression>) -> (Box<Expression>, bool) {
        match e {
            box LabelExp(l) => (box LabelExp(l), true),
            box Const(c, s) => (box Const(c, s), true),
            box ir::Temp(t) => {
                let opt = self.constants.find(&t);
                let typ = *self.f.types.get(&t);
                let e = opt.map_or(e, |x| box Const(*x, typ));
                (e, true)
            }
            box BinaryOp(op, e1, e2) => {
                let (e1, p1) = self.exp(e1);
                let (e2, p2) = self.exp(e2);
                let p = p1 && p2;
                match (e1, e2) {
                    /* Two constants? let's actually fold them! */
                    (box Const(i1, t1), box Const(i2, t2)) => {
                        assert!(t1 == t2);
                        do_op(op, i1, i2, t1)
                    }

                    /* Prefer the constant on the left */
                    (box Const(c, s), e2) => self.binop(op, box Const(c, s), e2, p),
                    (e1, box Const(c, s)) => {
                        if op.commutative() {
                            self.binop(op, box Const(c, s), e1, p)
                        } else if op == Sub {
                            self.binop(Add, box Const(-c, s), e1, p)
                        } else {
                            self.binop(op, e1, box Const(c, s), p)
                        }
                    }
                    (e1, e2) => (box BinaryOp(op, e1, e2), p)
                }
            }
        }
    }

    /**
     * Performs constant folding on binops where both expressions aren't constants
     *
     * This function assumes that e1 is a constant if possible, and it will
     * attempt to eliminate redundant instructions like divisions/multiplications
     * by 1, etc.
     */
    fn binop(&mut self, o: Binop, e1: Box<Expression>, e2: Box<Expression>, ispure: bool)
             -> (Box<Expression>, bool) {
        match e1 {
            box Const(c, s) => {
                /* Attempt to rotate constants out of binops to the left */
                let e2 = match e2 {
                    box BinaryOp(o2, box Const(c2, s2), e3) => {
                        assert!(s == s2);
                        if o == o2 && o.associative() {
                            let (e, _) = do_op(o, c, c2, s);
                            return self.exp(box BinaryOp(o, e, e3));
                        } else if o == o2 && o == Sub {
                            return self.exp(box BinaryOp(Add, box Const(c - c2, s), e3));
                        }
                        box BinaryOp(o2, box Const(c2, s2), e3)
                    }
                    e2 => e2
                };

                /* If no rotations are possible, catch simple math like multiplication
                   by 0, division by 1, etc. */
                match c {
                    0 if o == Add || o == Or || o == Xor  => (e2, ispure),
                    0 if ispure && (o == Mul || o == And) => (box Const(0, s), true),
                    1 if o == Mul => (e2, ispure),
                    _ => (box BinaryOp(o, box Const(c, s), e2), ispure)
                }
            }

            e1 => {
                match e2 {
                    /* get rid of divisions by 1 */
                    box Const(1, _) if o == Div => (e1, ispure),
                    e2 => (box BinaryOp(o, e1, e2), ispure)
                }
            }
        }
    }
}

fn do_op(op: Binop, i1: i32, i2: i32, t: Type) -> (Box<Expression>, bool) {
    match op {
        Add => (box Const(i1 + i2, t), true),
        Sub => (box Const(i1 - i2, t), true),
        Mul => (box Const(i1 * i2, t), true),
        Lt  => (box Const(if i1 < i2 { 1 } else { 0 }, t), true),
        Lte => (box Const(if i1 <= i2 { 1 } else { 0 }, t), true),
        Gt  => (box Const(if i1 > i2 { 1 } else { 0 }, t), true),
        Gte => (box Const(if i1 >= i2 { 1 } else { 0 }, t), true),
        Eq  => (box Const(if i1 == i2 { 1 } else { 0 }, t), true),
        Neq => (box Const(if i1 != i2 { 1 } else { 0 }, t), true),
        And => (box Const(i1 & i2, t), true),
        Or  => (box Const(i1 | i2, t), true),
        Xor => (box Const(i1 ^ i2, t), true),
        Lsh => (box Const(i1 << i2 as uint, t), true),
        Rsh => (box Const(i1 >> i2 as uint, t), true),
        Div | Mod => {
            if i2 == 0 || (i1 == i32::MIN && i2 == -1) {
                (box BinaryOp(op, box Const(i1, t), box Const(i2, t)), false)
            } else {
                match op {
                    Div => (box Const(i1 / i2, t), true),
                    Mod => (box Const(i1 % i2, t), true),
                    _ => fail!()
                }
            }
        }
    }
}
