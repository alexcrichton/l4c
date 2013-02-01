use core::hashmap::linear::{LinearMap, LinearSet};

use middle::{ir, temp, ssa, liveness, label};
use std::map;
use back::{assem, arch};

type Builder = fn(@assem::Instruction);

pub struct CodeGenerator {
  priv f: ir::Function,
  priv temps: temp::Allocator,
  priv sizes: LinearMap<temp::Temp, assem::Size>,
  priv stms: ~[@assem::Instruction],
  priv tmap: LinearMap<temp::Temp, temp::Temp>,
}

pub fn codegen(mut p: ir::Program) -> assem::Program {
  /* TODO: is there a better way to consume a field? */
  let mut funs = ~[];
  p.funs <-> funs;
  assem::Program{ funs: vec::map_consume(funs, translate) }
}

fn translate(f: ir::Function) -> assem::Function {
  info!("codegen of %s", f.name);
  let mut cg = CodeGenerator { f: f,
                               stms: ~[],
                               temps: temp::new(),
                               tmap: LinearMap::new(),
                               sizes: LinearMap::new() };
  cg.run()
}

impl CodeGenerator {
  fn run(&mut self) -> assem::Function {
    /* TODO: why can't this be above */
    let cfg = self.f.cfg.map(
      |id, stms| {
        debug!("block %?", id);
        for stms.each |&s| {
          self.stm(s);
        }
        let mut stms = ~[];
        stms <-> self.stms;
        @stms
      },
      |&edge| edge
    );
    info!("codegen of %s done", self.f.name);
    for self.f.types.each |k, v| {
      debug!("%? sized %?", k, v);
    }
    /* TODO: is there a better way to consume a field? */
    let mut loops = LinearMap::new();
    let mut sizes = LinearMap::new();
    self.f.loops <-> loops;
    self.sizes <-> sizes;
    assem::Function { name: copy self.f.name,
                      cfg: cfg,
                      root: self.f.root,
                      temps: self.temps.cnt(),
                      sizes: sizes,
                      loops: loops,
                      ssa: ssa::Analysis(),
                      liveness: liveness::Analysis() }
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
      _       => fail(fmt!("'%?' not a condition", c))
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

  fn half(&mut self, e: @ir::Expression) -> @assem::Operand {
    match e {
      @ir::Temp(t) => @assem::Temp(self.tmp(t)),
      @ir::Const(c, size) => @assem::Immediate(c, size),
      @ir::LabelExp(copy l) => @assem::LabelOp(l),
      @ir::BinaryOp(op, e1, e2) => {
        let out = self.tmpnew(self.f.size(e));
        self.push(@assem::BinaryOp(self.op(op), out, self.half(e1),
                                   self.half(e2)));
        return out;
      }
    }
  }

  fn stm(&mut self, s: @ir::Statement) {
    match s {
      @ir::Arguments(ref tmps) => {
        for tmps.eachi |i, &tmp| {
          let tmp = self.tmp(tmp);
          if i < arch::arg_regs {
            self.push(@assem::Arg(tmp, i));
          } else {
            let loc = @assem::StackArg(i - arch::arg_regs);
            self.push(@assem::Load(@assem::Temp(tmp), loc));
          }
        }
      }
      @ir::Phi(tmp, map) => {
        let map2 = map::HashMap();
        for map.each |k, v| {
          map2.insert(k, self.tmp(v));
        }
        self.push(@assem::Phi(self.tmp(tmp), map2));
      }
      @ir::Move(tmp, @ir::BinaryOp(op, e1, e2)) =>
        self.push(@assem::BinaryOp(self.op(op),
                                   @assem::Temp(self.tmp(tmp)),
                                   self.half(e1),
                                   self.half(e2))),
      @ir::Move(tmp, e) =>
        self.push(@assem::Move(@assem::Temp(self.tmp(tmp)),
                               self.half(e))),
      @ir::Load(tmp, e) => {
        let addr = @assem::MOp(self.half(e));
        self.push(@assem::Load(@assem::Temp(self.tmp(tmp)), addr));
      }
      @ir::Store(e1, e2) => {
        let addr = @assem::MOp(self.half(e1));
        let val  = self.half(e2);
        self.push(@assem::Store(addr, val));
      }
      @ir::Condition(@ir::BinaryOp(cond, e1, e2)) =>
        self.push(@assem::Condition(self.cond(cond), self.half(e1),
                                    self.half(e2))),
      @ir::Condition(e) =>
        self.push(@assem::Condition(assem::Neq,
                                    @assem::Immediate(0, ir::Int),
                                    self.half(e))),
      @ir::Die(@ir::BinaryOp(cond, e1, e2)) =>
        self.push(@assem::Die(self.cond(cond), self.half(e1), self.half(e2))),
      @ir::Die(@ir::Const(0, _)) => (),
      @ir::Die(@ir::Const(*)) =>
        self.push(@assem::Raw(fmt!("jmp %sraise_segv", label::prefix()))),
      @ir::Die(_) => fail(~"invalid die"),
      @ir::Return(e) => self.push(@assem::Return(self.half(e))),
      @ir::Call(tmp, fun, ref args) => {
        let fun = self.half(fun);
        let args = args.map(|&arg| self.half(arg));
        self.push(@assem::Call(self.tmp(tmp), fun, args));
      }
    }
  }

  /* Push the instruction into our basic block being built, while at the same
   * time constraining it for the x86-64 architecture */
  fn push(&mut self, ins: @assem::Instruction) {
    match ins {
      @assem::Condition(c, o1, o2) =>
        self.constrain_cmp(c, o1, o2, assem::Condition),
      @assem::Die(c, o1, o2) => self.constrain_cmp(c, o1, o2, assem::Die),
      @assem::BinaryOp(op, d, s1, s2) => {
        match op {
          /* the cmp instruction can only have immediates in a few places */
          assem::Cmp(c) => self.constrain_cmp(c, s1, s2, |c, o1, o2| {
            assem::BinaryOp(assem::Cmp(c), d, o1, o2)
          }),

          /* div/mod can't operate on immediates, only registers */
          assem::Div | assem::Mod => {
            let s1 = if s1.imm() {
              let tmp = self.tmpnew(ir::Int);
              self.stms.push(@assem::Move(tmp, s1));
              tmp
            } else { s1 };
            let s2 = if s2.imm() {
              let tmp = self.tmpnew(ir::Int);
              self.stms.push(@assem::Move(tmp, s2));
              tmp
            } else { s2 };
            self.stms.push(@assem::BinaryOp(op, d, s1, s2));
          }
          _ => self.stms.push(ins)
        }
      }

      /* When invoking functions, all argument registers must be actual
         registers, not immediates. Also the same register can't be an argument
         twice because it has to be in two different places */
      @assem::Call(dst, fun, ref args) => {
        let mut temps = LinearSet::new();
        let args = args.mapi(|i, &arg| {
          match arg {
            /* If we have first saw this temp, or the immediates/labels need to
               be stored on the stack, then no copy is needed */
            @assem::Temp(t) if temps.insert(t) => arg,
            @assem::Immediate(*) |
              @assem::LabelOp(*) if i >= arch::arg_regs => arg,

            /* Otherwise we need to create a temp to store this argument */
            _ if i < arch::arg_regs => {
              let size = match arg {
                @assem::Temp(t) => *self.sizes.get(&t), _ => arg.size()
              };
              let tmp = self.tmpnew(size);
              self.stms.push(@assem::Move(tmp, arg));
              tmp
            }
            _ => arg
          }
        });
        self.stms.push(@assem::Call(dst, fun, args));
      }

      /* The return value must be placed in the %eax register */
      @assem::Return(op) => match op {
        @assem::Temp(*) => self.stms.push(ins),
        _ => {
          let tmp = self.tmpnew(op.size());
          self.stms.push(@assem::Move(tmp, op));
          self.stms.push(@assem::Return(tmp));
        }
      },

      /* x86 can't load/store to immediate addresses */
      @assem::Store(@assem::MOp(a @ @assem::Immediate(*)), e) => {
        let tmp = self.tmpnew(ir::Pointer);
        self.stms.push(@assem::Move(tmp, a));
        self.stms.push(@assem::Store(@assem::MOp(tmp), e));
      }
      @assem::Load(e, @assem::MOp(a @ @assem::Immediate(*))) => {
        let tmp = self.tmpnew(ir::Pointer);
        self.stms.push(@assem::Move(tmp, a));
        self.stms.push(@assem::Load(e, @assem::MOp(tmp)));
      }

      _ => self.stms.push(ins)
    }
  }

  fn constrain_cmp(&mut self,
                   c: assem::Cond,
                   o1: @assem::Operand,
                   o2: @assem::Operand,
                   f: &fn(assem::Cond, @assem::Operand, @assem::Operand)
                          -> assem::Instruction) {
    match (o1, o2) {
      (@assem::Immediate(*), @assem::Immediate(*)) => {
        let tmp = self.tmpnew(ir::Int);
        self.stms.push(@assem::Move(tmp, o1));
        self.stms.push(@f(c, tmp, o2));
      }
      (@assem::Immediate(*), _) => self.stms.push(@f(c.flip(), o2, o1)),
      _ => self.stms.push(@f(c, o1, o2))
    }
  }

  fn tmp(&mut self, t: temp::Temp) -> temp::Temp {
    match self.tmap.find(&t) {
      Some(&t) => return t,
      None => ()
    }
    let ret = self.temps.new();
    self.tmap.insert(t, ret);
    self.sizes.insert(ret, *self.f.types.get(&t));
    return ret;
  }

  fn tmpnew(&mut self, s: ir::Type) -> @assem::Operand {
    let tmp = self.temps.new();
    self.sizes.insert(tmp, s);
    @assem::Temp(tmp)
  }
}
