use std::mem;
use std::collections::HashMap;

use front::ast::Binop as ABinop;
use front::ast::Type as AType;
use front::ast::{self, Expr_, Item_, Stmt_, Unop};
use middle::ir::{self, Type, Expr, Stmt, Binop, Edge, Program};
use middle::label::Label;
use utils::{Temp, TempAllocator, Marked, SymbolGenerator, Symbol};
use utils::graph::NodeId;

type StructInfo = HashMap<ast::Ident, (Type, u64)>;
type AllStructInfo = HashMap<ast::Ident, (StructInfo, u64)>;

struct ProgramInfo {
    funs: HashMap<ast::Ident, Expr>,
    structs: AllStructInfo,
    salloc: Symbol,
    salloc_array: Symbol,
    calloc: Symbol,
}

struct Translator<'a> {
    t: &'a ProgramInfo,
    f: ir::Function,
    vars: HashMap<ast::Ident, Temp>,
    temps: TempAllocator,

    // cfg creation
    cur_id: NodeId,
    stms: Vec<Stmt>,

    // loop translation
    break_to: NodeId,
    continue_to: NodeId,
    for_step: ast::Stmt,

    // different codegen flags
    safe: bool,
}

pub fn translate(p: ast::Program, safe: bool) -> ir::Program {
    debug!("building translation info");
    let mut syms = SymbolGenerator::new();
    let mut info = ProgramInfo {
        funs: HashMap::new(),
        structs: HashMap::new(),
        salloc: syms.intern("salloc"),
        salloc_array: syms.intern("salloc_array"),
        calloc: syms.intern("calloc@plt"),
    };
    syms.store();
    info.build(&p);

    debug!("translating");
    let mut accum = Vec::new();
    for d in p.decls.iter() {
        if let Item_::Function(_, id, ref args, ref body) = d.node {
            let mut trans = Translator {
                t: &info,
                f: ir::Function::new(id),
                vars: HashMap::new(),
                temps: TempAllocator::new(),
                cur_id: 0,
                stms: Vec::new(),
                break_to: 0,
                continue_to: 0,
                for_step: Marked::dummy(Stmt_::Nop),
                safe: safe,
            };
            trans.cur_id = trans.f.cfg.new_id();
            trans.f.root = trans.cur_id;
            trans.args(args);
            trans.stmt(body);
            let Translator{ f, .. } = trans;
            accum.push(f);
        }
    }

    return Program::new(accum)
}

fn typ(t: &ast::Type) -> Type {
    match *t {
        AType::Array(_) | AType::Struct(_) | AType::Pointer(_) => Type::Pointer,
        _ => Type::Int
    }
}

fn typ_size(t: &ast::Type, structs: &AllStructInfo) -> u64 {
    match *t {
        AType::Int | AType::Bool => 4,
        AType::Pointer(_) | AType::Array(_) => 8,
        AType::Struct(ref id) => structs[id].1,
        _ => panic!("bad type to typ_size")
    }
}

impl ProgramInfo {
    fn build(&mut self, p: &ast::Program) {
        for d in p.decls.iter() {
            self.build_item(d)
        }
    }

    fn build_item(&mut self, g: &ast::Item) {
        match g.node {
            Item_::StructDef(id, ref fields) => {
                let mut table = HashMap::new();
                let mut size = 0;
                for &(id, ref t) in fields.iter() {
                    let typsize = typ_size(t, &self.structs);
                    if size != 0 && size % typsize != 0 {
                        size += 4; // TODO: real math
                    }
                    table.insert(id, (typ(t), size));
                    size += typsize;
                }
                self.structs.insert(id, (table, size));
            }
            Item_::FunIDecl(_, id, _) => {
                let f = self.ilabel(id);
                self.funs.insert(id, f);
            }
            Item_::FunEDecl(_, id, _) => {
                let f = self.elabel(id);
                self.funs.insert(id, f);
            }
            Item_::Function(_, id, _, _) => {
                if !self.funs.contains_key(&id) {
                    let f = self.ilabel(id);
                    self.funs.insert(id, f);
                }
            }
            _ => ()
        }
    }

    fn elabel(&self, id: ast::Ident) -> Expr {
        Expr::Label(Label::External(id))
    }

    fn ilabel(&self, id: ast::Ident) -> Expr {
        Expr::Label(Label::Internal(id))
    }
}

impl<'a> Translator<'a> {
    fn args(&mut self, args: &[(ast::Ident, ast::Type)]) {
        let args = Stmt::Arguments(args.iter().map(|&(id, ref t)| {
            let tmp = self.tmp(typ(t));
            self.vars.insert(id, tmp);
            tmp
        }).collect());
        self.stms.push(args);
    }

    fn stmt(&mut self, s: &ast::Stmt) {
        match s.node {
            Stmt_::Nop => {}
            Stmt_::Seq(ref s1, ref s2) => {
                self.stmt(s1);
                self.stmt(s2);
            }
            Stmt_::Continue => {
                // TODO: can this clone be avoided?
                let step = self.for_step.clone();
                self.stmt(&step);
                let n = self.commit();
                self.f.cfg.add_edge(n, self.continue_to, Edge::Branch);
            }
            Stmt_::Break => {
                let n = self.commit();
                self.f.cfg.add_edge(n, self.break_to, Edge::LoopOut);
            }
            Stmt_::Return(ref e) => {
                let e = self.exp(e, false);
                self.stms.push(Stmt::Return(e));
                self.commit();
            }
            Stmt_::Express(ref e) => {
                let e = self.exp(e, false);
                let size = e.size(&self.f.types);
                let tmp = self.tmp(size);
                self.stms.push(Stmt::Move(tmp, e));
            }
            Stmt_::For(ref init, ref cond, ref step, ref body) => {
                self.stmt(init);
                // TODO: can this clone be avoided?
                let prevstep = mem::replace(&mut self.for_step, (**step).clone());
                self.with_loop(cond, &mut |me| {
                    me.stmt(body);
                    me.stmt(step);
                });
                self.for_step = prevstep;
            }
            Stmt_::While(ref cond, ref body) => {
                let prevstep = mem::replace(&mut self.for_step,
                                            Marked::dummy(Stmt_::Nop));
                self.with_loop(cond, &mut |me| me.stmt(body));
                self.for_step = prevstep;
            }
            Stmt_::If(ref cond, ref t, ref f) => {
                let true_id = self.f.cfg.new_id();
                let false_id = self.f.cfg.new_id();
                self.condition(cond, true_id, Edge::True, false_id, Edge::False,
                               true_id);

                self.stmt(t);
                let true_end = self.commit_with(false_id);
                self.stmt(f);
                let false_end = self.commit();

                self.f.cfg.add_edge(true_end, self.cur_id, Edge::Branch);
                self.f.cfg.add_edge(false_end, self.cur_id, Edge::Always);
            }
            Stmt_::Declare(id, ref t, ref exp, ref s) => {
                let tmp = self.tmp(typ(t));
                match exp.as_ref() {
                    None => (),
                    Some(init) => {
                        let init = self.exp(init, false);
                        self.stms.push(Stmt::Move(tmp, init));
                    }
                }
                self.vars.insert(id, tmp);
                self.stmt(s);
                self.vars.remove(&id);
            }
            Stmt_::Assign(ref e1, op, ref e2) => {
                let (ismem, leftsize) = match e1.node {
                    Expr_::Var(_) => (false, Type::Int), // size doesn't matter
                    Expr_::Deref(_, ref t) |
                    Expr_::ArrSub(_, _, ref t) => {
                        let t = t.borrow();
                        (true, typ(t.as_ref().unwrap()))
                    }
                    Expr_::Field(_, ref f, ref s) => {
                        let s = s.borrow();
                        let typ = self.t.structs[s.as_ref().unwrap()].0[f].0;
                        (true, typ)
                    }
                    _ => panic!("invalid assign")
                };
                let left = self.exp(e1, true);
                let right = match op {
                    None => self.exp(e2, false),
                    Some(op) => {
                        if ismem {
                            let tmp = self.tmp(leftsize);
                            self.stms.push(Stmt::Load(tmp, left.clone()));
                            Expr::BinaryOp(self.oper(op),
                                           Box::new(Expr::Temp(tmp)),
                                           Box::new(self.exp(e2, false)))
                        } else {
                            Expr::BinaryOp(self.oper(op),
                                           Box::new(left.clone()),
                                           Box::new(self.exp(e2, false)))
                        }
                    }
                };
                if ismem {
                    self.stms.push(Stmt::Store(left, right));
                } else {
                    let tmp = match left {
                        Expr::Temp(t) => t,
                        _ => panic!("bad left")
                    };
                    self.stms.push(Stmt::Move(tmp, right));
                }
            }
        }
    }

    fn with_loop(&mut self, cond: &ast::Expr, f: &mut FnMut(&mut Translator)) {
        let pred = self.commit();
        let condid = self.cur_id;
        let bodyid = self.f.cfg.new_id();
        let afterid = self.f.cfg.new_id();
        self.f.cfg.add_edge(pred, condid, Edge::Always);
        self.condition(cond, bodyid, Edge::True, afterid, Edge::FLoopOut, bodyid);

        let prevcont = mem::replace(&mut self.continue_to, condid);
        let prevbreak = mem::replace(&mut self.break_to, afterid);
        f(self);
        self.continue_to = prevcont;
        self.break_to = prevbreak;

        let bodyend = self.commit_with(afterid);
        self.f.cfg.add_edge(bodyend, condid, Edge::Always);
        self.f.loops.insert(condid, (bodyid, afterid));
    }

    fn condition(&mut self, e: &ast::Expr,
                 tid: NodeId, tedge: Edge,
                 fid: NodeId, fedge: Edge,
                 into: NodeId) {
        match e.node {
            Expr_::BinaryOp(ABinop::LOr, ref e1, ref e2) => {
                let next = self.f.cfg.new_id();
                self.condition(e1, tid, Edge::TBranch, next, Edge::False, next);
                self.condition(e2, tid, tedge, fid, fedge, into);
            }
            Expr_::BinaryOp(ABinop::LAnd, ref e1, ref e2) => {
                let next = self.f.cfg.new_id();
                self.condition(e1, next, Edge::True, fid, Edge::FBranch, next);
                self.condition(e2, tid, tedge, fid, fedge, into);
            }
            _ => {
                let e = self.exp(e, false);
                self.stms.push(Stmt::Condition(e));
                let id = self.commit_with(into);
                self.f.cfg.add_edge(id, tid, tedge);
                self.f.cfg.add_edge(id, fid, fedge);
            }
        }
    }

    fn exp(&mut self, e: &ast::Expr, addr: bool) -> Expr {
        match e.node {
            Expr_::Boolean(b) => self.consti(if b { 1 } else { 0 }),
            Expr_::Const(c) => self.consti(c),
            Expr_::Var(ref id) => {
                match self.vars.get(id) {
                    Some(&t) => Expr::Temp(t),
                    None => self.t.funs[id].clone(),
                }
            }
            Expr_::Null => self.constp(0),

            // All unary ops can be expressed as binary ops
            Expr_::UnaryOp(Unop::Negative, ref e) => {
                Expr::BinaryOp(Binop::Sub,
                               Box::new(self.consti(0)),
                               Box::new(self.exp(e, addr)))
            }
            Expr_::UnaryOp(Unop::Invert, ref e) => {
                Expr::BinaryOp(Binop::Xor,
                               Box::new(self.consti(-1)),
                               Box::new(self.exp(e, addr)))
            }
            Expr_::UnaryOp(Unop::Bang, ref e) => {
                Expr::BinaryOp(Binop::Xor,
                               Box::new(self.consti(1)),
                               Box::new(self.exp(e, addr)))
            }

            // Take care of logical binops as ternaries
            Expr_::BinaryOp(ABinop::LOr, ref e1, ref e2) => {
                self.tern(e1, &Marked::dummy(Expr_::Boolean(true)), e2,
                          Type::Int, false)
            }
            Expr_::BinaryOp(ABinop::LAnd, ref e1, ref e2) => {
                self.tern(e1, e2, &Marked::dummy(Expr_::Boolean(false)),
                          Type::Int, false)
            }

            Expr_::BinaryOp(op, ref e1, ref e2) => {
                let v1 = Box::new(self.exp(e1, addr));
                let v2 = Box::new(self.exp(e2, addr));
                let op = self.oper(op);
                let ret = Expr::BinaryOp(op, v1, v2);
                match op {
                    // div/mod have side effects, the result is a temp so they
                    // happen
                    Binop::Div | Binop::Mod => {
                        let tmp = self.tmp(Type::Int);
                        self.stms.push(Stmt::Move(tmp, ret));
                        Expr::Temp(tmp)
                    }
                    _ => ret
                }
            }

            Expr_::Ternary(ref e1, ref e2, ref e3, ref t) => {
                let t = t.borrow();
                self.tern(e1, e2, e3, typ(t.as_ref().unwrap()), addr)
            }

            Expr_::Call(ref e, ref args, ref t) => {
                let ret = t.borrow_mut().take().unwrap();
                let fun = self.exp(e, false);
                let args = args.iter().map(|e| self.exp(e, false)).collect();
                let typ = typ(&ret);
                let tmp = self.tmp(typ);
                self.stms.push(Stmt::Call(tmp, fun, args));
                Expr::Temp(tmp)
            }

            Expr_::Alloc(ref t) => {
                let amt = self.consti(1);
                let sym = self.t.salloc;
                self.alloc(t, amt, sym)
            }
            Expr_::AllocArray(ref t, ref e) => {
                let amt = self.exp(e, false);
                let sym = self.t.salloc_array;
                self.alloc(t, amt, sym)
            }

            Expr_::ArrSub(ref arr, ref idx, ref t) => {
                let base = Box::new(self.exp(arr, false));
                let idx = self.exp(idx, false);
                let idxt = self.tmp(Type::Int);
                self.stms.push(Stmt::Move(idxt, idx));
                let idxp = self.tmp(Type::Pointer);
                self.stms.push(Stmt::Cast(idxp, idxt));

                self.check_null(&base);
                self.check_bounds(&base, &Expr::Temp(idxt));

                let t = t.borrow();
                let t = t.as_ref().unwrap();
                let size = typ_size(t, &self.t.structs) as i32;
                let elsize = Box::new(self.constp(size));
                let offset = Box::new(Expr::BinaryOp(Binop::Mul,
                                                     Box::new(Expr::Temp(idxp)),
                                                     elsize));
                let address = Expr::BinaryOp(Binop::Add, base, offset);
                if addr {
                    return address;
                }
                let dest = self.tmp(typ(t));
                self.stms.push(Stmt::Load(dest, address));
                Expr::Temp(dest)
            }

            Expr_::Field(ref e, id, ref s) => {
                let s = s.borrow();
                let base = Box::new(self.exp(e, true));
                /*let &(ref fields, _) = self.t.structs.get(&s);*/
                let (typ, size) = self.t.structs[s.as_ref().unwrap()].0[&id];
                let address = Expr::BinaryOp(Binop::Add, base,
                                             Box::new(self.constp(size as i32)));
                self.check_null(&address);
                if addr {
                    return address;
                }
                let dest = self.tmp(typ);
                self.stms.push(Stmt::Load(dest, address));
                Expr::Temp(dest)
            }

            Expr_::Deref(ref e, ref t) => {
                let address = self.exp(e, false);
                self.check_null(&address);
                if addr {
                    return address;
                }
                let dest = self.tmp(typ(t.borrow().as_ref().unwrap()));
                self.stms.push(Stmt::Load(dest, address));
                Expr::Temp(dest)
            }
        }
    }

    fn alloc(&mut self, t: &ast::Type, cnt: Expr, safe: Symbol) -> Expr {
        let fun = self.t.elabel(if self.safe {safe} else {self.t.calloc});
        let result = self.tmp(Type::Pointer);
        let args = vec![cnt, self.constp(typ_size(t, &self.t.structs) as i32)];
        self.stms.push(Stmt::Call(result, fun, args));
        Expr::Temp(result)
    }

    /// Translates a ternary statement
    ///
    /// # Arguments
    ///
    /// * cond - The condition for the ternary statement
    /// * t - The expression to execute in the 'true' case
    /// * f - The expression to execute in the 'false' case
    /// * size - The size of the destination operand
    /// * addr - 'true' if an address is desired, or 'false' if the value is needed
    ///
    /// This returns the temp which holds the result of the ternary statement.
    fn tern(&mut self, cond: &ast::Expr, t: &ast::Expr,
            f: &ast::Expr, size: Type, addr: bool) -> Expr {
        let dst = self.tmp(size);
        let end = self.f.cfg.new_id();
        self.dotern(cond, t, f, dst, addr, (end, Edge::Branch, Edge::Always));
        self.commit_with(end);
        Expr::Temp(dst)
    }

    /// Actually translate a ternary statement
    ///
    /// # Arguments
    ///
    /// * c - the condition
    /// * t - The true expression
    /// * f - The false expression
    /// * dst - The temp to place the result into
    /// * addr - Flag if the address of the expressions are desired
    /// * (end, endt, endf) - The node to finally branch to at the end, and the
    ///                       types of edges that should be used to go from the
    ///                       true branch and false branch to the end
    fn dotern(&mut self, c: &ast::Expr,
              t: &ast::Expr, f: &ast::Expr,
              dst: Temp, addr: bool,
              (end, endt, endf): (NodeId, Edge, Edge)) {
        // Translate the conditional, terminating the basic block
        let true_id = self.f.cfg.new_id();
        let false_id = self.f.cfg.new_id();
        let c = self.exp(c, false);
        self.stms.push(Stmt::Condition(c));

        // translate each true/false branch
        let cond_id = self.commit_with(true_id);
        self.f.cfg.add_edge(cond_id, true_id, Edge::True);
        self.process_tern(t, endt, dst, addr, end);
        self.commit_with(false_id);
        self.f.cfg.add_edge(cond_id, false_id, Edge::FBranch);
        self.process_tern(f, endf, dst, addr, end);
    }

    fn process_tern(&mut self, e: &ast::Expr, typ: Edge,
                    dst: Temp, addr: bool, end: NodeId) {
        match e.node {
            // Some cases don't necessarily always need a 'join' node
            Expr_::Ternary(ref e1, ref e2, ref e3, _) => {
                self.dotern(e1, e2, e3, dst, addr, (end, Edge::Branch, typ));
            }
            Expr_::BinaryOp(ABinop::LOr, ref e1, ref e2) => {
                self.dotern(e1, &Marked::dummy(Expr_::Boolean(true)), e2, dst,
                            addr, (end, Edge::Branch, typ));
            }
            Expr_::BinaryOp(ABinop::LAnd, ref e1, ref e2) => {
                self.dotern(e1, e2, &Marked::dummy(Expr_::Boolean(false)), dst,
                            addr, (end, Edge::Branch, typ));
            }

            // Otherwise, we have to finish things up
            _ => {
                let e = self.exp(e, addr);
                self.stms.push(Stmt::Move(dst, e));
                self.f.cfg.add_edge(self.cur_id, end, typ);
            }
        }
    }

    fn check_null(&mut self, e: &Expr) {
        if !self.safe { return }
        let cond = Expr::BinaryOp(Binop::Eq,
                                  Box::new(e.clone()),
                                  Box::new(self.constp(0)));
        self.stms.push(Stmt::Die(cond));
    }

    fn check_bounds(&mut self, base: &Expr, idx: &Expr) {
        if !self.safe { return; }
        let tmp = self.tmp(Type::Int);
        let size = Expr::BinaryOp(Binop::Sub,
                                  Box::new(base.clone()),
                                  Box::new(self.constp(8)));
        self.stms.push(Stmt::Load(tmp, size));

        let under = Expr::BinaryOp(Binop::Lt,
                                   Box::new(idx.clone()),
                                   Box::new(self.consti(0)));
        self.stms.push(Stmt::Die(under));
        let over = Expr::BinaryOp(Binop::Gte,
                                  Box::new(idx.clone()),
                                  Box::new(Expr::Temp(tmp)));
        self.stms.push(Stmt::Die(over));
    }

    fn oper(&mut self, b: ast::Binop) -> Binop {
        use front::ast::Binop::*;
        match b {
            Plus      => Binop::Add,
            Minus     => Binop::Sub,
            Times     => Binop::Mul,
            Divide    => Binop::Div,
            Modulo    => Binop::Mod,
            Less      => Binop::Lt,
            LessEq    => Binop::Lte,
            Greater   => Binop::Gt,
            GreaterEq => Binop::Gte,
            Equals    => Binop::Eq,
            NEquals   => Binop::Neq,
            BAnd      => Binop::And,
            BOr       => Binop::Or,
            Xor       => Binop::Xor,
            LShift    => Binop::Lsh,
            RShift    => Binop::Rsh,
            LAnd | LOr => panic!("invalid binop trans")
        }
    }

    fn commit(&mut self) -> NodeId {
        let id = self.f.cfg.new_id();
        self.commit_with(id)
    }

    fn consti(&self, c: i32) -> Expr {
        Expr::Const(c, Type::Int)
    }
    fn constp(&self, c: i32) -> Expr {
        Expr::Const(c, Type::Pointer)
    }

    fn commit_with(&mut self, next: NodeId) -> NodeId {
        let mut ins = Vec::new();
        mem::swap(&mut ins, &mut self.stms); // swap a new block into place
        let id = mem::replace(&mut self.cur_id, next);
        self.f.cfg.add_node(id, ins);
        return id;
    }

    fn tmp(&mut self, t: Type) -> Temp {
        let tmp = self.temps.gen();
        self.f.types.insert(tmp, t);
        return tmp;
    }
}
