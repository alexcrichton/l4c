use middle::ir;
use middle::temp;
use std::map;

type Builder = &fn(@assem::Instruction);

pub struct CodeGenerator {
  f : &ir::Function,
  temps : temp::Allocator,
  sizes : map::HashMap<temp::Temp, assem::Size>,
  priv tmap : map::HashMap<temp::Temp, temp::Temp>,
}

pub fn codegen(p : &ir::Program) -> assem::Program {
  assem::Program{ funs: p.funs.map(translate) }
}

fn translate(f : &ir::Function) -> assem::Function {
  info!("codegen of %s", f.name);
  let cg = CodeGenerator { f: f,
                           temps: temp::new(),
                           tmap: map::HashMap(),
                           sizes: map::HashMap() };
  let cfg = f.cfg.map(
    |id, stms|
      @vec::build(|push| {
        if id == f.root {
          cg.load_args(*f.args, |ins| arch::constrain(ins, push, &cg));
        }
        for stms.each |&s| {
          cg.stm(s, |ins| arch::constrain(ins, push, &cg));
        }
      }),
    |&edge| edge
  );
  info!("codegen of %s done", f.name);
  for f.types.each |k, v| {
    debug!("%? sized %?", k, v);
  }
  assem::Function { name: copy f.name,
                    cfg: cfg,
                    root: f.root,
                    temps: cg.temps.cnt(),
                    idominated: map::HashMap(),
                    sizes: cg.sizes,
                    loops: f.loops }
}

impl CodeGenerator {
  fn load_args(args : &[temp::Temp], push : Builder) {
    for args.eachi |i, &tmp| {
      let tmp = self.tmp(tmp);
      if i < arch::arg_regs {
        let reg = @assem::Register(arch::arg_reg(i), self.f.types[tmp]);
        push(@assem::Move(@assem::Temp(tmp), reg));
      } else {
        let loc = @assem::StackArg(i - arch::arg_regs);
        push(@assem::Load(@assem::Temp(tmp), loc));
      }
    }
  }

  fn cond(c : ir::Binop) -> assem::Cond {
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

  fn op(c : ir::Binop) -> assem::Binop {
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

  fn half(e : @ir::Expression, push : Builder) -> @assem::Operand {
    match e {
      @ir::Temp(t) => @assem::Temp(self.tmp(t)),
      @ir::Const(c, size) => @assem::Immediate(c, size),
      @ir::LabelExp(copy l) => @assem::LabelOp(l),
      @ir::BinaryOp(op, e1, e2) => {
        let out = self.tmpnew(self.f.size(e));
        push(@assem::BinaryOp(self.op(op), out, self.half(e1, push),
                              self.half(e2, push)));
        return out;
      }
    }
  }

  fn stm(s : @ir::Statement, push : Builder) {
    match s {
      @ir::Phi(tmp, map) => {
        let map2 = map::HashMap();
        for map.each |k, v| {
          map2.insert(k, self.tmp(v));
        }
        push(@assem::Phi(self.tmp(tmp), map2));
      }
      @ir::Move(tmp, @ir::BinaryOp(op, e1, e2)) =>
        push(@assem::BinaryOp(self.op(op),
                              @assem::Temp(self.tmp(tmp)),
                              self.half(e1, push),
                              self.half(e2, push))),
      @ir::Move(tmp, e) =>
        push(@assem::Move(@assem::Temp(self.tmp(tmp)),
                          self.half(e, push))),
      @ir::Load(tmp, e) => {
        let addr = @assem::MOp(self.half(e, push));
        push(@assem::Load(@assem::Temp(self.tmp(tmp)), addr));
      }
      @ir::Store(e1, e2) => {
        let addr = @assem::MOp(self.half(e1, push));
        let val  = self.half(e2, push);
        push(@assem::Store(addr, val));
      }
      @ir::Condition(@ir::BinaryOp(cond, e1, e2)) =>
        push(@assem::Condition(self.cond(cond), self.half(e1, push),
                               self.half(e2, push))),
      @ir::Condition(e) =>
        push(@assem::Condition(assem::Neq, @assem::Immediate(0, ir::Int),
                               self.half(e, push))),
      @ir::Die(@ir::BinaryOp(cond, e1, e2)) =>
        push(@assem::Die(self.cond(cond), self.half(e1, push),
                         self.half(e2, push))),
      @ir::Die(_) => fail(~"invalid die"),
      @ir::Return(e) => {
        push(@assem::Move(@assem::Register(assem::EAX, self.f.size(e)),
                          self.half(e, push)));
        push(@assem::Return);
      }
      @ir::Call(tmp, fun, ref args) => {
        let fun = self.half(fun, push);
        let args = args.map(|&arg| (self.half(arg, push), self.f.size(arg)));
        for args.eachi |i, &(arg, size)| {
          if i < arch::arg_regs {
            push(@assem::Move(@assem::Register(arch::arg_reg(i), size), arg));
          } else {
            let loc = @assem::Stack((i - arch::arg_regs) * arch::ptrsize);
            push(@assem::Store(loc, arg));
          }
        }
        let ret = @assem::Temp(self.tmp(tmp));
        let size = self.f.types[tmp];
        push(@assem::Call(fun, args.len()));
        push(@assem::Move(ret, @assem::Register(arch::ret_reg, size)));
      }
    }
  }

  fn tmp(t : temp::Temp) -> temp::Temp {
    match self.tmap.find(t) {
      Some(t) => t,
      None => {
        let ret = self.temps.new();
        self.tmap.insert(t, ret);
        self.sizes.insert(ret, self.f.types[t]);
        return ret;
      }
    }
  }

  fn tmpnew(s : ir::Type) -> @assem::Operand {
    let tmp = self.temps.new();
    self.sizes.insert(tmp, s);
    @assem::Temp(tmp)
  }
}
