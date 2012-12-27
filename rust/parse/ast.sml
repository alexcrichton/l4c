(* L5 Compiler
 * Abstract Syntax Trees
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
signature AST =
sig
  type ident = Symbol.symbol

  datatype typ = INT | BOOL | TYPEDEF of ident | PTR of typ | ARRAY of typ
               | STRUCT of ident | NULL | FUN of typ * typ list

  datatype unop = NEGATIVE | INVERT | BANG

  datatype binop = PLUS | MINUS | TIMES | DIVIDEDBY | MODULO | LESS | LESSEQ
                 | GREATER | GREATEREQ | EQUALS | NEQUALS | LAND | LOR | BAND
                 | XOR | BOR | LSHIFT | RSHIFT

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp * typ ref
   | Call  of exp * exp list * (typ * typ list) ref
   | Deref of exp * typ ref
   | Field of exp * ident * typ ref
   | ArrSub of exp * exp * typ ref
   | Alloc of typ
   | AllocArray of typ * exp
   | Null
   | Marked of exp Mark.marked
  and stm =
     Assign  of exp * binop option * exp
   | If      of exp * stm * stm
   | While   of exp * stm
   | For     of stm * exp * stm * stm
   | Express of exp
   | Continue
   | Break
   | Return  of exp
   | Nop
   | Seq     of stm * stm
   | Declare of ident * typ * exp option * stm
   | Markeds of stm Mark.marked

  datatype gdecl =
     Fun of typ * ident * (typ * ident) list * stm * bool
   | ExtDecl of typ * ident * (typ * ident) list
   | IntDecl of typ * ident * (typ * ident) list * bool
   | Typedef of ident * typ
   | Markedg of gdecl Mark.marked
   | StrDecl of ident
   | Struct  of ident * (typ * ident) list

  type program = gdecl list

  (* print as source, with redundant parentheses *)
  structure Print :
  sig
    val pp_typ : typ -> string
    val pp_program : program -> string
  end

end

structure Ast :> AST =
struct
  type ident = Symbol.symbol

  datatype typ = INT | BOOL | TYPEDEF of ident | PTR of typ | ARRAY of typ
               | STRUCT of ident | NULL | FUN of typ * typ list

  datatype unop = NEGATIVE | INVERT | BANG

  datatype binop = PLUS | MINUS | TIMES | DIVIDEDBY | MODULO | LESS | LESSEQ
                 | GREATER | GREATEREQ | EQUALS | NEQUALS | LAND | LOR | BAND
                 | XOR | BOR | LSHIFT | RSHIFT

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp * typ ref
   | Call  of exp * exp list * (typ * typ list) ref
   | Deref of exp * typ ref
   | Field of exp * ident * typ ref
   | ArrSub of exp * exp * typ ref
   | Alloc of typ
   | AllocArray of typ * exp
   | Null
   | Marked of exp Mark.marked
  and stm =
     Assign  of exp * binop option * exp
   | If      of exp * stm * stm
   | While   of exp * stm
   | For     of stm * exp * stm * stm
   | Express of exp
   | Continue
   | Break
   | Return  of exp
   | Nop
   | Seq     of stm * stm
   | Declare of ident * typ * exp option * stm
   | Markeds of stm Mark.marked

  datatype gdecl =
     Fun of typ * ident * (typ * ident) list * stm * bool
   | ExtDecl of typ * ident * (typ * ident) list
   | IntDecl of typ * ident * (typ * ident) list * bool
   | Typedef of ident * typ
   | Markedg of gdecl Mark.marked
   | StrDecl of ident
   | Struct  of ident * (typ * ident) list

  type program = gdecl list

  (* print programs and expressions in source form
   * using redundant parentheses to clarify precedence
   *)
  structure Print =
  struct
    val q = "\""
    fun pp_field (a, b) = q ^ a ^ "\":" ^
                          (if a = "typ" then q ^ b ^ q else b)
    fun pp_hash L = "{" ^ String.concatWith "," (map pp_field L) ^ "}"
    fun pp_list L = "[" ^ String.concatWith "," L ^ "]"

    fun pp_ident id = "\"" ^ Symbol.name id ^ "\""

    fun pp_typ BOOL = pp_hash [("typ", "bool")]
      | pp_typ INT  = pp_hash [("typ", "int")]
      | pp_typ NULL = pp_hash [("typ", "null")]
      | pp_typ (PTR t) = pp_hash [("typ", "ptr"), ("to", pp_typ t)]
      | pp_typ (STRUCT id) = pp_hash [("typ", "struct"), ("id", pp_ident id)]
      | pp_typ (ARRAY t) = pp_hash [("typ", "array"), ("of", pp_typ t)]
      | pp_typ (TYPEDEF id) = pp_hash [("typ", "typedef"), ("of", pp_ident id)]

    fun pp_unop2 NEGATIVE = "-"
      | pp_unop2 INVERT   = "~"
      | pp_unop2 BANG     = "!"
    fun pp_unop f = q ^ pp_unop2 f ^ q

    fun pp_oper2 PLUS      = "+"
      | pp_oper2 MINUS     = "-"
      | pp_oper2 TIMES     = "*"
      | pp_oper2 DIVIDEDBY = "/"
      | pp_oper2 MODULO    = "%"
      | pp_oper2 LESS      = "<"
      | pp_oper2 LESSEQ    = "<="
      | pp_oper2 GREATER   = ">"
      | pp_oper2 GREATEREQ = ">="
      | pp_oper2 EQUALS    = "=="
      | pp_oper2 NEQUALS   = "!="
      | pp_oper2 LAND      = "&&"
      | pp_oper2 LOR       = "||"
      | pp_oper2 BAND      = "&"
      | pp_oper2 XOR       = "^"
      | pp_oper2 BOR       = "|"
      | pp_oper2 LSHIFT    = "<<"
      | pp_oper2 RSHIFT    = ">>"
    fun pp_oper f = q ^ pp_oper2 f ^ q

    fun pp_pair (a, b) = "[" ^ Int.toString a ^ "," ^ Int.toString b ^ "]"

    fun pp_mark m f =
          case Mark.ext m
            of NONE => f (Mark.data m)
             | SOME (l, r, file) =>
                pp_hash [("typ", "mark"), ("l", pp_pair l), ("r", pp_pair r),
                         ("f", q ^ file ^ q),
                         ("d", f (Mark.data m))]

    fun pp_exp (Var id) =
          pp_hash [("typ", "var"), ("var", pp_ident id)]
      | pp_exp (Const c) =
          pp_hash [("typ", "const"), ("val", Word32Signed.toString c)]
      | pp_exp (Bool b) =
          pp_hash [("typ", "bool"),
                   ("val", if b then "true" else "false")]
      | pp_exp Null = pp_hash [("typ", "null")]
      | pp_exp (Deref (e, _)) =
          pp_hash [("typ", "deref"), ("e", pp_exp e)]
      | pp_exp (ArrSub (e1, e2, _)) =
          pp_hash [("typ", "arrsub"), ("e1", pp_exp e1), ("e2", pp_exp e2)]
      | pp_exp (Field (e, f, _)) =
          pp_hash [("typ", "field"), ("e", pp_exp e),
                   ("field", pp_ident f)]
      | pp_exp (Alloc t) =
          pp_hash [("typ", "alloc"), ("type", pp_typ t)]
      | pp_exp (AllocArray (t, e)) =
          pp_hash [("typ", "allocarr"), ("type", pp_typ t), ("e", pp_exp e)]
      | pp_exp (Call (e, E, _)) =
          pp_hash [("typ", "call"), ("fun", pp_exp e),
                   ("args", pp_list (map pp_exp E))]
      | pp_exp (BinaryOp (oper, e1, e2)) =
          pp_hash [("typ", "binop"), ("oper", pp_oper oper),
                   ("e1", pp_exp e1), ("e2", pp_exp e2)]
      | pp_exp (UnaryOp (oper, e)) =
          pp_hash [("typ", "unop"), ("unop", pp_unop oper), ("e", pp_exp e)]
      | pp_exp (Ternary (e1, e2, e3, _)) =
          pp_hash [("typ", "ternary"),
                   ("e1", pp_exp e1), ("e2", pp_exp e2), ("e3", pp_exp e3)]
      | pp_exp (Marked e) = pp_mark e pp_exp

    fun pp_extra _ NONE = pp_hash [("typ", "none")]
      | pp_extra f (SOME v) = pp_hash [("typ", "some"), ("val", f v)]

    fun pp_stm (Assign (e1, extra, e2)) =
          pp_hash [("typ", "assign"), ("extra", pp_extra pp_oper extra),
                   ("e1", pp_exp e1), ("e2", pp_exp e2)]
      | pp_stm (If (e, s1, s2)) =
          pp_hash [("typ", "if"), ("cond", pp_exp e),
                   ("true", pp_stm s1), ("false", pp_stm s2)]
      | pp_stm (While (e, s)) =
          pp_hash [("typ", "while"), ("cond", pp_exp e), ("body", pp_stm s)]
      | pp_stm (For (s1, e, s2, s3)) =
          pp_hash [("typ", "for"), ("init", pp_stm s1),
                   ("cond", pp_exp e), ("step", pp_stm s2),
                   ("body", pp_stm s3)]
      | pp_stm Continue = pp_hash [("typ", "continue")]
      | pp_stm Break = pp_hash [("typ", "break")]
      | pp_stm Nop = pp_hash [("typ", "nop")]
      | pp_stm (Express e) =
          pp_hash [("typ", "express"), ("exp", pp_exp e)]
      | pp_stm (Seq (s1, s2)) =
          pp_hash [("typ", "seq"),
                   ("s1", pp_stm s1), ("s2", pp_stm s2)]
      | pp_stm (Return e) =
          pp_hash [("typ", "return"), ("exp", pp_exp e)]
      | pp_stm (Declare (id, t, eopt, s)) =
          pp_hash [("typ", "declare"), ("id", pp_ident id),
                   ("eopt", pp_extra pp_exp eopt),
                   ("type", pp_typ t), ("rest", pp_stm s)]
      | pp_stm (Markeds s) = pp_mark s pp_stm

    fun pp_def (typ, id) =
          "{\"typ\":" ^ pp_typ typ ^ ", \"name\":" ^ pp_ident id ^ "}"

    fun pp_fun typ (t, i, L, static) ex =
          pp_hash ([("typ", typ), ("name", pp_ident i),
                    ("ret", pp_typ t),
                    ("args", pp_list (map pp_def L)),
                    ("static", if static then "true" else "false")] @ ex)

    fun pp_adecl (Typedef (id, typ)) =
          pp_hash [("typ", "typedef"), ("id", pp_ident id),
                   ("type", pp_typ typ)]
      | pp_adecl (Markedg d) = pp_mark d pp_adecl
      | pp_adecl (IntDecl t) = pp_fun "intdecl" t []
      | pp_adecl (ExtDecl (a, b, c)) = pp_fun "extdecl" (a, b, c, false) []
      | pp_adecl (Fun (t, i, L, s, static)) =
          pp_fun "fun" (t, i, L, static) [("body", pp_stm s)]
      | pp_adecl (StrDecl s) =
          pp_hash [("typ", "strdecl"), ("val", pp_ident s)]
      | pp_adecl (Struct (s, F)) =
          pp_hash [("typ", "struct"), ("val", pp_ident s),
                   ("fields", pp_list (map pp_def F))]

    fun pp_program prog = pp_list (map pp_adecl prog)
  end
end
