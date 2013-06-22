use std::hashmap::{HashMap, HashSet};
use std::util::swap;
use std::vec;

use middle::{ir, temp, ssa, label};
use back::{assem, arch};

pub struct CodeGenerator {
  priv temps: temp::Allocator,
  priv sizes: HashMap<temp::Temp, assem::Size>,
  priv stms: ~[~assem::Instruction],
  priv tmap: HashMap<temp::Temp, temp::Temp>,
  priv oldtypes: HashMap<temp::Temp, ir::Type>,
}

pub fn codegen(ir::Program{funs}: ir::Program) -> assem::Program {
  let mut cg = CodeGenerator{ stms: ~[],
                              temps: temp::new(),
                              tmap: HashMap::new(),
                              sizes: HashMap::new(),
                              oldtypes: HashMap::new() };

  let funs = do vec::map_consume(funs) |f| {
    let f = cg.run(f);
    cg.reset();
    f
  };
  assem::Program{ funs: funs }
}

impl CodeGenerator {
  fn run(&mut self, f: ir::Function) -> assem::Function {
    /* extract relevant information from the function */
    let ir::Function {root, name, cfg, loops, types, _} = f;
    let mut types = types;
    swap(&mut types, &mut self.oldtypes);

    /* Map over the cfg into a new one */
    let cfg = cfg.map(
      |id, stms| {
        debug!("block %?", id);
        for stms.each |&s| {
          self.stm(s);
        }
        let mut stms = ~[];
        swap(&mut stms, &mut self.stms);
        stms
      },
      |&edge| edge
    );

    /* Move our calculated sizes into the assem::Function instance */
    let mut sizes = HashMap::new();
    swap(&mut sizes, &mut self.sizes);

    info!("codegen of %s done", name);
    assem::Function { name: name,
                      cfg: cfg,
                      root: root,
                      temps: self.temps.cnt(),
                      sizes: sizes,
                      loops: loops,
                      ssa: ssa::Analysis() }
  }

  fn reset(&mut self) {
    self.temps.reset();
    self.stms.clear();
    self.tmap.clear()
  }

  fn cond(&self, c: ir::Binop) -> assem::Cond {
    match c {
      ir::Lt  => assem::Lt,
      ir::Lte => assem::Lte,
      ir::Gt  => assem::Gt,
      ir::Gte => assem::Gte,
      ir::Eq  => assem::Eq,
      ir::Neq => assem::Neq,
      ir::Xor => assem::Neq,
      _       => fail!(fmt!("'%?' not a condition", c))
    }
  }

  fn op(&self, c: ir::Binop) -> assem::Binop {
    match c {
      ir::Add => assem::Add,
      ir::Sub => assem::Sub,
      ir::Mul => assem::Mul,
      ir::Div => assem::Div,
      ir::Mod => assem::Mod,
      ir::And => assem::And,
      ir::Or  => assem::Or,
      ir::Xor => assem::Xor,
      ir::Lsh => assem::Lsh,
      ir::Rsh => assem::Rsh,
      _       => assem::Cmp(self.cond(c))
    }
  }

  fn half(&mut self, e: ~ir::Expression) -> ~assem::Operand {
    let size = e.size(&self.oldtypes);
    match e {
      ~ir::Temp(t) => ~assem::Temp(self.tmp(t)),
      ~ir::Const(c, size) => ~assem::Immediate(c, size),
      ~ir::LabelExp(l) => ~assem::LabelOp(l),
      ~ir::BinaryOp(op, e1, e2) => {
        let out = self.tmpnew(size);
        let op = self.op(op);
        let e1 = self.half(e1);
        let e2 = self.half(e2);
        self.push(~assem::BinaryOp(op, copy out, e1, e2));
        return out;
      }
    }
  }

  fn addr(&mut self, e: ~ir::Expression) -> ~assem::Address {
    use M = back::assem::Multiplier;
    use middle::ir::{BinaryOp, Mul, Const, Add};

    /* When optimizations are turned on, constants are favored on the left-hand
       side of binops, so that assumption is made here to test for fewer cases
       and make things all-around easier */
    debug!("%s", e.pp());
    let offsetify = |e: ~ir::Expression| {
      match e {
        ~BinaryOp(Add, e1, e2) => {
          match e2 {
            ~BinaryOp(Mul, ~Const(c, s), e2) => {
              if M::valid(c) {
                (e1, Some((self.half(e2), M::from_int(c))))
              } else {
                (e1, Some((self.half(~BinaryOp(Mul, ~Const(c, s), e2)),
                           assem::One)))
              }
            }
            e2 => (e1, Some((self.half(e2), assem::One)))
          }
        }
        e => (e, None)
      }
    };
    match e {
      ~BinaryOp(Add, ~Const(c, _), e) => {
        let (e, mulpart) = offsetify(e);
        ~assem::MOp(self.half(e), Some(c as uint), mulpart)
      }

      e => {
        let (e, mulpart) = offsetify(e);
        ~assem::MOp(self.half(e), None, mulpart)
      }
    }
  }

  fn stm(&mut self, s: ~ir::Statement) {
    match s {
      ~ir::Arguments(ref tmps) => {
        for tmps.iter().enumerate().advance |(i, &tmp)| {
          let tmp = self.tmp(tmp);
          if i < arch::arg_regs {
            self.push(~assem::Arg(tmp, i));
          } else {
            let loc = ~assem::StackArg(i - arch::arg_regs);
            self.push(~assem::Load(~assem::Temp(tmp), loc));
          }
        }
      }
      ~ir::Phi(tmp, ref map) => {
        let mut map2 = HashMap::new();
        for map.each |&k, &v| {
          map2.insert(k, self.tmp(v));
        }
        let tmp = self.tmp(tmp);
        self.push(~assem::Phi(tmp, map2));
      }
      ~ir::Move(tmp, ~ir::BinaryOp(op, e1, e2)) => {
        let tmp = self.tmp(tmp);
        let op = self.op(op);
        let e1 = self.half(e1);
        let e2 = self.half(e2);
        self.push(~assem::BinaryOp(op, ~assem::Temp(tmp), e1, e2));
      }
      ~ir::Move(tmp, e) => {
        let tmp = self.tmp(tmp);
        let e = self.half(e);
        self.push(~assem::Move(~assem::Temp(tmp), e));
      }
      ~ir::Cast(t1, t2) => {
        let t1 = self.tmp(t1);
        let t2 = self.tmp(t2);
        self.push(~assem::Move(~assem::Temp(t1), ~assem::Temp(t2)));
      }
      ~ir::Load(tmp, e) => {
        let tmp = self.tmp(tmp);
        let e = self.addr(e);
        self.push(~assem::Load(~assem::Temp(tmp), e));
      }
      ~ir::Store(e1, e2) => {
        let e1 = self.addr(e1);
        let e2 = self.half(e2);
        self.push(~assem::Store(e1, e2));
      }
      ~ir::Condition(~ir::BinaryOp(cond, e1, e2)) => {
        let cond = self.cond(cond);
        let e1 = self.half(e1);
        let e2 = self.half(e2);
        self.push(~assem::Condition(cond, e1, e2));
      }
      ~ir::Condition(e) => {
        let e = self.half(e);
        self.push(~assem::Condition(assem::Neq,
                                    ~assem::Immediate(0, ir::Int),
                                    e));
      }
      ~ir::Die(~ir::BinaryOp(cond, e1, e2)) => {
        let cond = self.cond(cond);
        let e1 = self.half(e1);
        let e2 = self.half(e2);
        self.push(~assem::Die(cond, e1, e2));
      }
      ~ir::Die(~ir::Const(0, _)) => (),
      ~ir::Die(~ir::Const(*)) =>
        self.push(~assem::Raw(fmt!("jmp %sraise_segv", label::prefix()))),
      ~ir::Die(_) => fail!(~"invalid die"),
      ~ir::Return(e) => {
        let e = self.half(e);
        self.push(~assem::Return(e));
      }
      ~ir::Call(tmp, fun, args) => {
        let fun = self.half(fun);
        let args = vec::map_consume(args, |arg| self.half(arg));
        let tmp = self.tmp(tmp);
        self.push(~assem::Call(tmp, fun, args));
      }
    }
  }

  /* Push the instruction into our basic block being built, while at the same
   * time constraining it for the x86-64 architecture */
  fn push(&mut self, ins: ~assem::Instruction) {
    match ins {
      ~assem::Condition(c, o1, o2) => {
        let (c, o1, o2) = self.constrain_cmp(c, o1, o2);
        self.stms.push(~assem::Condition(c, o1, o2));
      }
      ~assem::Die(c, o1, o2) => {
        let (c, o1, o2) = self.constrain_cmp(c, o1, o2);
        self.stms.push(~assem::Die(c, o1, o2));
      }

      /* the cmp instruction can only have immediates in a few places */
      ~assem::BinaryOp(assem::Cmp(c), d, s1, s2) => {
        let (c, s1, s2) = self.constrain_cmp(c, s1, s2);
        self.stms.push(~assem::BinaryOp(assem::Cmp(c), d, s1, s2));
      }

      /* div/mod can't operate on immediates, only registers */
      ~assem::BinaryOp(op @ assem::Div, d, s1, s2) |
      ~assem::BinaryOp(op @ assem::Mod, d, s1, s2) => {
        let s1 = if s1.imm() {
          let tmp = self.tmpnew(ir::Int);
          self.stms.push(~assem::Move(copy tmp, s1));
          tmp
        } else { s1 };
        let s2 = if s2.imm() {
          let tmp = self.tmpnew(ir::Int);
          self.stms.push(~assem::Move(copy tmp, s2));
          tmp
        } else { s2 };
        self.stms.push(~assem::BinaryOp(op, d, s1, s2));
      }

      /* When invoking functions, all argument registers must be actual
         registers, not immediates. Also the same register can't be an argument
         twice because it has to be in two different places */
      ~assem::Call(dst, fun, args) => {
        let mut temps = HashSet::new();
        let mut args2 = ~[];
        do vec::consume(args) |i, arg| {
          let arg = match arg {
            /* If we have first saw this temp, or the immediates/labels need to
               be stored on the stack, then no copy is needed */
            ~assem::Temp(t) if temps.insert(t) => arg,
            ~assem::Immediate(*) |
              ~assem::LabelOp(*) if i >= arch::arg_regs => arg,

            /* Otherwise we need to create a temp to store this argument */
            _ if i < arch::arg_regs => {
              let size = match arg {
                ~assem::Temp(t) => *self.sizes.get(&t), _ => arg.size()
              };
              let tmp = self.tmpnew(size);
              self.stms.push(~assem::Move(copy tmp, arg));
              tmp
            }
            _ => arg
          };
          args2.push(arg);
        };
        self.stms.push(~assem::Call(dst, fun, args2));
      }

      /* The return value must be a register, so ensure that it's in a temp */
      ~assem::Return(op) => match op {
        ~assem::Temp(t) => self.stms.push(~assem::Return(~assem::Temp(t))),
        op => {
          let tmp = self.tmpnew(op.size());
          self.stms.push(~assem::Move(copy tmp, op));
          self.stms.push(~assem::Return(tmp));
        }
      },

      /* x86 can't load/store to immediate addresses */
      ~assem::Store(a, e) => {
        let a = self.constrain_addr(a);
        self.stms.push(~assem::Store(a, e));
      }
      ~assem::Load(e, a) => {
        let a = self.constrain_addr(a);
        self.stms.push(~assem::Load(e, a));
      }

      ins => self.stms.push(ins)
    }
  }

  fn constrain_addr(&mut self, a: ~assem::Address) -> ~assem::Address {
    let unimm = |o: ~assem::Operand| {
      match o {
        ~assem::Immediate(*) => {
          let tmp = self.tmpnew(ir::Pointer);
          self.stms.push(~assem::Move(copy tmp, o));
          tmp
        }
        _ => o
      }
    };
    match a {
      ~assem::MOp(base, disp, off) => {
        let base = unimm(base);
        let off = off.map(|&(o, m)| (unimm(o), m));
        ~assem::MOp(base, disp, off)
      }
      a => a
    }
  }

  fn constrain_cmp(&mut self,
                   c: assem::Cond,
                   o1: ~assem::Operand,
                   o2: ~assem::Operand)
                      -> (assem::Cond, ~assem::Operand, ~assem::Operand)
  {
    match (o1, o2) {
      (~assem::Immediate(i1, s1), ~assem::Immediate(i2, s2)) => {
        let tmp = self.tmpnew(ir::Int);
        self.stms.push(~assem::Move(copy tmp, ~assem::Immediate(i1, s1)));
        (c, tmp, ~assem::Immediate(i2, s2))
      }
      (~assem::Immediate(i1, s1), o2) =>
        (c.flip(), o2, ~assem::Immediate(i1, s1)),
      (o1, o2) => (c, o1, o2)
    }
  }

  fn tmp(&mut self, t: temp::Temp) -> temp::Temp {
    match self.tmap.find(&t) {
      Some(&t) => return t,
      None => ()
    }
    let ret = self.temps.new();
    self.tmap.insert(t, ret);
    self.sizes.insert(ret, *self.oldtypes.get(&t));
    return ret;
  }

  fn tmpnew(&mut self, s: ir::Type) -> ~assem::Operand {
    let tmp = self.temps.new();
    self.sizes.insert(tmp, s);
    ~assem::Temp(tmp)
  }
}
