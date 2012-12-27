use std::map;
use front::ast;

struct Translator {
  funs : map::HashMap<ast::Ident, bool>,
  structs : map::HashMap<ast::Ident, (map::HashMap<ast::Ident, uint>, uint)>,
  vars : map::HashMap<ast::Ident, (temp::Temp, ir::Type)>,
  temps : temp::Allocator,

  /* cfg creation */
  mut cur_id : graph::NodeId,
  mut preds  : ~[graph::NodeId],
  mut cfg    : graph::Graph<@~[@ir::Statement], ir::Edge>
}

pub fn translate(p : &ast::Program) -> ir::Program {
  let t = Translator{ funs:    map::HashMap(),
                      structs: map::HashMap(),
                      vars:    map::HashMap(),
                      temps:   temp::new(),
                      cur_id:  0,
                      preds:   ~[],
                      cfg:     graph::Graph()};
  t.translate(p)
}

impl Translator {
  fn translate(p : &ast::Program) -> ir::Program {
    for p.decls.each |&d| {
      self.trans(d);
    }
    3
  }

  fn trans(g : @ast::GDecl) {
    match g {
      @ast::Markedg(ref m) => self.trans(m.data),
      @ast::Function(_, id, ref args, body) => {
        self.vars.clear();
        self.funs.insert(id, true);
        for args.each |&(id, typ)| {
          self.vars.insert(id, (self.temps.new(), self.typ(typ)));
        }
        self.stm(body);
      },
      @ast::FunEDecl(_, id, _) => { self.funs.insert(id, false); },
      @ast::StructDef(id, ref fields) => {
        let table = map::HashMap();
        let mut size = 0;
        for fields.each |&(id, typ)| {
          let typsize = self.typ_size(typ);
          if (size != 0 && size % typsize != 0) {
            size += 4; /* TODO: real math */
          }
          table.insert(id, size);
          size += typsize;
        }
        self.structs.insert(id, (table, size));
      }
      _ => ()
    }
  }

  fn stm(s : @ast::Statement) {
    match s {
      @ast::Nop => (),
      @ast::Markeds(ref m) => self.stm(m.data),
      @ast::Seq(s1, s2) => {
        self.stm(s1);
        self.stm(s2);
      },
      _ => fail(~"unimplemented")
    }
  }

  fn typ(t : @ast::Type) -> ir::Type {
    match t {
      @ast::Array(_) | @ast::Struct(_) | @ast::Pointer(_) => ir::Pointer,
      _ => ir::Int
    }
  }

  fn oper(b : ast::Binop) -> ir::Binop {
    match b {
      ast::Plus      => ir::Add,
      ast::Minus     => ir::Sub,
      ast::Times     => ir::Mul,
      ast::Divide    => ir::Div,
      ast::Modulo    => ir::Mod,
      ast::Less      => ir::Lt,
      ast::LessEq    => ir::Lte,
      ast::Greater   => ir::Gt,
      ast::GreaterEq => ir::Gte,
      ast::Equals    => ir::Eq,
      ast::NEquals   => ir::Neq,
      ast::BAnd      => ir::And,
      ast::BOr       => ir::Or,
      ast::Xor       => ir::Xor,
      ast::LShift    => ir::Lsh,
      ast::RShift    => ir::Rsh,
      ast::LAnd | ast::LOr => fail(~"invalid binop trans")
    }
  }

  fn typ_size(t : @ast::Type) -> uint {
    match t {
      @ast::Int | @ast::Bool => 4,
      @ast::Pointer(_) | @ast::Array(_) => 8,
      @ast::Struct(id) => self.structs.get(id).second(),
      _ => fail(~"bad type to typ_size")
    }
  }

  fn commit() {
  }
}
