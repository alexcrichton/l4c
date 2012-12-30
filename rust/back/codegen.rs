use middle::ir;
use middle::temp;
use std::map;

type Builder = fn(@assem::Instruction);

pub struct CodeGenerator {
  temps : temp::Allocator,
  priv tmap : map::HashMap<temp::Temp, temp::Temp>,
}

pub fn codegen(p : &ir::Program) -> assem::Program {
  assem::Program{ funs: p.funs.map(translate) }
}

fn translate(f : &ir::Function) -> assem::Function {
  info!("codegen of %s", f.name);
  let cg = CodeGenerator { temps: temp::new(), tmap: map::HashMap() };
  let cfg = f.cfg.map(
    |stms|
      @vec::build(|push|
        for stms.each |&s| { cg.stm(s, |ins| arch::constrain(ins, push, &cg)); }
      ),
    |&edge| edge
  );
  debug!("codegen of %s done", f.name);
  assem::Function { name: copy f.name,
                    cfg: cfg,
                    root: f.root,
                    idoms: f.idoms,
                    idominated: f.idominated,
                    postorder:  f.postorder,
                    temps: cg.temps.cnt(),
                    args:  f.args.map(|&tmp| cg.tmap[tmp]) }
}

impl CodeGenerator {
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
      @ir::Temp((t, size)) => @assem::Temp(self.tmp(t), size),
      @ir::Const(c, size) => @assem::Immediate(c, size),
      @ir::LabelExp(copy l) => @assem::LabelOp(l),
      @ir::BinaryOp(op, e1, e2) => {
        let out = @assem::Temp(self.temps.new(), e.size());
        push(@assem::BinaryOp(self.op(op), out, self.half(e1, push),
                              self.half(e2, push)));
        return out;
      }
      @ir::Call(fun, typ, ref args) => {
        let fun = self.half(fun, push);
        let args = args.map(|&arg| (self.half(arg, push), arg.size()));
        for args.eachi |i, &(arg, size)| {
          let dst = if i < arch::arg_regs {
            @assem::Register(arch::arg_reg(i), size)
          } else {
            let loc = @assem::Stack((i - arch::arg_regs) * arch::ptrsize);
            @assem::Memory(loc, size)
          };
          push(@assem::Move(dst, arg));
        }
        let ret = @assem::Temp(self.temps.new(), typ);
        push(@assem::Call(fun, args.len()));
        push(@assem::Move(ret, @assem::Register(arch::ret_reg, typ)));
        return ret;
      }
    }
  }

  fn stm(s : @ir::Statement, push : Builder) {
    match s {
      @ir::Phi((tmp, size), map) => {
        let map2 = map::HashMap();
        for map.each |k, v| {
          map2.insert(k, self.tmp(v));
        }
        push(@assem::Phi(self.tmp(tmp), size, map2));
      }
      @ir::Move((tmp, typ), @ir::BinaryOp(op, e1, e2)) =>
        push(@assem::BinaryOp(self.op(op),
                              @assem::Temp(self.tmp(tmp), typ),
                              self.half(e1, push),
                              self.half(e2, push))),
      @ir::Move((tmp, typ), e) =>
        push(@assem::Move(@assem::Temp(self.tmp(tmp), typ),
                          self.half(e, push))),
      @ir::Load((tmp, typ), e) => {
        let addr = @assem::MOp(self.half(e, push));
        push(@assem::Move(@assem::Temp(self.tmp(tmp), typ),
                          @assem::Memory(addr, typ)));
      }
      @ir::Store(e1, typ, e2) => {
        let addr = @assem::MOp(self.half(e1, push));
        let val  = self.half(e2, push);
        push(@assem::Move(@assem::Memory(addr, typ), val));
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
        push(@assem::Move(@assem::Register(assem::EAX, e.size()),
                          self.half(e, push)));
        push(@assem::Return);
      }
    }
  }

  fn tmp(t : temp::Temp) -> temp::Temp {
    match self.tmap.find(t) {
      Some(t) => t,
      None => {
        let ret = self.temps.new();
        self.tmap.insert(t, ret);
        return ret;
      }
    }
  }
}
