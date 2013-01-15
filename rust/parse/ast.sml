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
    val pp_program : program -> unit
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

    fun appi f L = appi2 f 0 L
    and appi2 f n [] = ()
      | appi2 f n (x :: L) = (f (n, x); appi2 f (n + 1) L)

    val q = "\""
    fun pp_hash L =
      (print "{";
       appi (fn (i, (k, v)) => (if i = 0 then () else print ",";
                                print (q ^ k ^ "\":"); v ())) L;
       print "}")
    fun pp_list f L =
      (print "[";
       appi (fn (i, e) => (if i = 0 then () else print ","; f e)) L;
       print "]")

    fun pp_ident id = print ("\"" ^ Symbol.name id ^ "\"")

    fun typ s = ("typ", fn () => print (q ^ s ^ q))

    fun pp_typ BOOL = pp_hash [typ "bool"]
      | pp_typ INT  = pp_hash [typ "int"]
      | pp_typ NULL = pp_hash [typ "null"]
      | pp_typ (PTR t) = pp_hash [typ "ptr", ("to", fn () => pp_typ t)]
      | pp_typ (STRUCT id) = pp_hash [typ "struct",
                                      ("id", fn () => pp_ident id)]
      | pp_typ (ARRAY t) = pp_hash [typ "array", ("of", fn () => pp_typ t)]
      | pp_typ (TYPEDEF id) = pp_hash [typ "typedef",
                                       ("of", fn () => pp_ident id)]

    fun pp_unop2 NEGATIVE = "-"
      | pp_unop2 INVERT   = "~"
      | pp_unop2 BANG     = "!"
    fun pp_unop f = print (q ^ pp_unop2 f ^ q)

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
    fun pp_oper f = print (q ^ pp_oper2 f ^ q)

    fun pp_pair (a, b) =
          print ("[" ^ Int.toString a ^ "," ^ Int.toString b ^ "]")

    fun pp_mark m f =
          case Mark.ext m
            of NONE => f (Mark.data m)
             | SOME (l, r, file) =>
                pp_hash [(typ "mark"), ("l", fn () => pp_pair l),
                         ("r", fn () => pp_pair r),
                         ("d", fn () => f (Mark.data m))]

    fun pp_exp (Var id) =
          pp_hash [typ "var", ("var", fn () => pp_ident id)]
      | pp_exp (Const c) =
          pp_hash [typ "const",
                   ("val", fn () => print (Word32Signed.toString c))]
      | pp_exp (Bool b) =
          pp_hash [typ "bool",
                   ("val", fn () => print (if b then "true" else "false"))]
      | pp_exp Null = pp_hash [typ "null"]
      | pp_exp (Deref (e, _)) =
          pp_hash [(typ "deref"), ("e", fn () => pp_exp e)]
      | pp_exp (ArrSub (e1, e2, _)) =
          pp_hash [(typ "arrsub"), ("e1", fn () => pp_exp e1),
                   ("e2", fn () => pp_exp e2)]
      | pp_exp (Field (e, f, _)) =
          pp_hash [(typ "field"), ("e", fn () => pp_exp e),
                   ("field", fn () => pp_ident f)]
      | pp_exp (Alloc t) =
          pp_hash [(typ "alloc"), ("type", fn () => pp_typ t)]
      | pp_exp (AllocArray (t, e)) =
          pp_hash [(typ "allocarr"), ("type", fn () => pp_typ t),
                   ("e", fn () => pp_exp e)]
      | pp_exp (Call (e, E, _)) =
          pp_hash [(typ "call"), ("fun", fn () => pp_exp e),
                   ("args", fn () => pp_list pp_exp E)]
      | pp_exp (BinaryOp (oper, e1, e2)) =
          pp_hash [(typ "binop"), ("oper", fn () => pp_oper oper),
                   ("e1", fn () => pp_exp e1), ("e2", fn () => pp_exp e2)]
      | pp_exp (UnaryOp (oper, e)) =
          pp_hash [(typ "unop"), ("unop", fn () => pp_unop oper),
                   ("e", fn () => pp_exp e)]
      | pp_exp (Ternary (e1, e2, e3, _)) =
          pp_hash [(typ "ternary"),
                   ("e1", fn () => pp_exp e1),
                   ("e2", fn () => pp_exp e2),
                   ("e3", fn () => pp_exp e3)]
      | pp_exp (Marked e) = pp_mark e pp_exp

    fun pp_extra _ NONE = pp_hash [typ "none"]
      | pp_extra f (SOME v) = pp_hash [typ "some", ("val", fn () => f v)]

    fun pp_stm (Assign (e1, extra, e2)) =
          pp_hash [(typ "assign"), ("extra", fn () => pp_extra pp_oper extra),
                   ("e1", fn () => pp_exp e1), ("e2", fn () => pp_exp e2)]
      | pp_stm (If (e, s1, s2)) =
          pp_hash [(typ "if"), ("cond", fn () => pp_exp e),
                   ("true", fn () => pp_stm s1), ("false", fn () => pp_stm s2)]
      | pp_stm (While (e, s)) =
          pp_hash [(typ "while"), ("cond", fn () => pp_exp e),
                   ("body", fn () => pp_stm s)]
      | pp_stm (For (s1, e, s2, s3)) =
          pp_hash [(typ "for"), ("init", fn () => pp_stm s1),
                   ("cond", fn () => pp_exp e), ("step", fn () => pp_stm s2),
                   ("body", fn () => pp_stm s3)]
      | pp_stm Continue = pp_hash [typ "continue"]
      | pp_stm Break = pp_hash [typ "break"]
      | pp_stm Nop = pp_hash [typ "nop"]
      | pp_stm (Express e) =
          pp_hash [(typ "express"), ("exp", fn () => pp_exp e)]
      | pp_stm (Seq (s1, s2)) =
          pp_hash [(typ "seq"),
                   ("s1", fn () => pp_stm s1), ("s2", fn () => pp_stm s2)]
      | pp_stm (Return e) =
          pp_hash [(typ "return"), ("exp", fn () => pp_exp e)]
      | pp_stm (Declare (id, t, eopt, s)) =
          pp_hash [(typ "declare"), ("id", fn () => pp_ident id),
                   ("eopt", fn () => pp_extra pp_exp eopt),
                   ("type", fn () => pp_typ t), ("rest", fn () => pp_stm s)]
      | pp_stm (Markeds s) = pp_mark s pp_stm

    fun pp_def (typ, id) =
          pp_hash [("typ", fn () => pp_typ typ), ("name", fn () => pp_ident id)]

    fun pp_fun kind (t, i, L, static) ex =
          pp_hash ([typ kind, ("name", fn () => pp_ident i),
                    ("ret", fn () => pp_typ t),
                    ("args", fn () => pp_list pp_def L),
                    ("static", fn () => print (if static then "true" else
                    "false"))] @ ex)

    fun pp_adecl (Typedef (id, result)) =
          pp_hash [typ "typedef",
                   ("id", fn () => pp_ident id),
                   ("type", fn () => pp_typ result)]
      | pp_adecl (Markedg d) = pp_mark d pp_adecl
      | pp_adecl (IntDecl t) = pp_fun "intdecl" t []
      | pp_adecl (ExtDecl (a, b, c)) = pp_fun "extdecl" (a, b, c, false) []
      | pp_adecl (Fun (t, i, L, s, static)) =
          pp_fun "fun" (t, i, L, static) [("body", fn () => pp_stm s)]
      | pp_adecl (StrDecl s) =
          pp_hash [(typ "strdecl"), ("val", fn () => pp_ident s)]
      | pp_adecl (Struct (s, F)) =
          pp_hash [(typ "struct"), ("val", fn () => pp_ident s),
                   ("fields", fn () => pp_list pp_def F)]

    fun pp_program prog = pp_list pp_adecl prog
  end
end
