/**
 * @brief A few optimizations thrown into one: constant folding, constant
 *        propagation, and copy propagation
 *
 * This module will fold all constant expressions in the IR, reducing as much
 * definite arithmetic as possible. This will also propogate temps equal to
 * constants so that neededness analysis may be able to remove a lot of temps.
 * Finally if 'y <- x' is seen, then all instances of 'y' are replaced with 'x'
 * so the move can be considered dead code.
 */

use core::hashmap::linear::LinearMap;
use std::map;

use middle::ir::*;

struct ConstantFolder {
  f: &mut Function,
  constants: LinearMap<Temp, i32>,
  temps: LinearMap<Temp, Temp>,
}

pub fn optimize(p: &mut Program) {
  for vec::each_mut(p.funs) |f| {
    let mut opt = ConstantFolder { f: f,
                                   constants: LinearMap::new(),
                                   temps: LinearMap::new() };
    opt.run();
  }
}

impl ConstantFolder {
  /* TODO: why can't this all be above */
  fn run(&mut self) {
    /* Be sure to start at the top of the graph to visit definitions first */
    let (order, _) = self.f.cfg.postorder(self.f.root);
    for vec::rev_each(order) |&n| {
      self.f.cfg.update_node(n, @self.f.cfg[n].map(|&s| self.stm(s)));
    }

    do self.f.cfg.map_nodes |_, stms| {
      @stms.map(|&s| {
        s.map_temps(|t| *self.temps.find(&t).get_or_default(&t), |t| t)
      })
    }
  }

  /**
   * Apply constant folding to a statement, returning the folded statement
   */
  fn stm(&mut self, s: @Statement) -> @Statement {
    match s {
      @Arguments(*) | @Phi(*) => s,
      @Move(t, e) => {
        let e = self.exp(e).first();
        match e {
          @Const(amt, _) => { self.constants.insert(t, amt); }
          @Temp(cp)      => {
            let other = match self.temps.find(&cp) {
              Some(&other) => other, None => cp
            };
            self.temps.insert(t, other);
          }
          _ => ()
        }
        @Move(t, e)
      }
      @Load(t, e) => @Load(t, self.exp(e).first()),
      @Call(t, e, ref args) => @Call(t, e, args.map(|&e| self.exp(e).first())),
      @Store(e1, e2) => @Store(self.exp(e1).first(), self.exp(e2).first()),
      @Condition(e) => @Condition(self.exp(e).first()),
      @Return(e) => @Return(self.exp(e).first()),
      @Die(e) => @Die(self.exp(e).first())
    }
  }

  /**
   * Apply constant folding to an expression, returning the folded expression
   *
   * The boolean returned is whether the expression is considered 'pure' and is
   * safe for removal. This is false for things like div and mod
   */
  fn exp(&self, e: @Expression) -> (@Expression, bool) {
    match e {
      @LabelExp(*) | @Const(*) => (e, true),
      @Temp(t) => {
        let opt = self.constants.find(&t);
        let e = opt.map_default(e, |&x| @Const(*x, *self.f.types.get(&t)));
        (e, true)
      }
      @BinaryOp(op, e1, e2) => {
        let (e1, p1) = self.exp(e1);
        let (e2, p2) = self.exp(e2);
        let p = p1 && p2;
        match (e1, e2) {
          /* Two constants? let's actually fold them! */
          (@Const(i1, t1), @Const(i2, t2)) => {
            let t = Type::max(t1, t2);
            match op {
              Add => (@Const(i1 + i2, t), true),
              Sub => (@Const(i1 - i2, t), true),
              Mul => (@Const(i1 * i2, t), true),
              Lt  => (@Const(if i1 < i2 { 1 } else { 0 }, t), true),
              Lte => (@Const(if i1 <= i2 { 1 } else { 0 }, t), true),
              Gt  => (@Const(if i1 > i2 { 1 } else { 0 }, t), true),
              Gte => (@Const(if i1 >= i2 { 1 } else { 0 }, t), true),
              Eq  => (@Const(if i1 == i2 { 1 } else { 0 }, t), true),
              Neq => (@Const(if i1 != i2 { 1 } else { 0 }, t), true),
              And => (@Const(i1 & i2, t), true),
              Or  => (@Const(i1 | i2, t), true),
              Xor => (@Const(i1 ^ i2, t), true),
              Lsh => (@Const(i1 << i2, t), true),
              Rsh => (@Const(i1 >> i2, t), true),
              Div | Mod => {
                if i2 == 0 || (i1 == i32::min_value && i2 == -1) {
                  (@BinaryOp(op, e1, e2), false)
                } else {
                  match op {
                    Div => (@Const(i1 / i2, t), true),
                    Mod => (@Const(i1 % i2, t), true),
                    _ => die!()
                  }
                }
              }
            }
          }

          /* Prefer the constant on the left */
          (@Const(*), _) => self.binop(op, e1, e2, p),
          (_, @Const(*)) if op.commutative() => self.binop(op, e2, e1, p),
          (_, @Const(i, t)) if op == Sub => self.binop(Add, @Const(-i, t), e1, p),
          (_, @Const(*)) => self.binop(op, e1, e2, p),
          _ => (@BinaryOp(op, e1, e2), p)
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
  fn binop(&self, o: Binop, e1: @Expression, e2: @Expression, ispure: bool)
      -> (@Expression, bool) {
    match (e1, e2) {
      /* Rotate the two constants together to get folded */
      (@Const(*), @BinaryOp(o2, c @ @Const(*), e3)) if o == o2 && o.associative()
        => self.exp(@BinaryOp(o, @BinaryOp(o, e1, c), e3)),

      /* Also rotate with subtraction (conversion to addition) */
      (@Const(*), @BinaryOp(o2, c @ @Const(*), e3)) if o == o2 && o == Sub
        => self.exp(@BinaryOp(Add, @BinaryOp(o, e1, c), e3)),

      /* Simplify easy arithmetic (i.e. 1 * n = n, 0 + n = n, etc. */
      (_, @Const(1, _)) if o == Div => (e1, ispure),
      (@Const(1, _), _) if o == Mul => (e2, ispure),
      (@Const(0, _), _) if (o == Mul || o == And) && ispure => (e1, ispure),
      (@Const(0, _), _) if o == Add || o == Or || o == Xor => (e2, ispure),

      /* Catch all, sadly we can't optimize */
      _ => (@BinaryOp(o, e1, e2), ispure)
    }
  }
}
