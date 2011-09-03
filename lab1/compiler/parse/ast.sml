(* L1 Compiler
 * Abstract Syntax Trees
 * Author: Alex Vaynberg
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Modified: Anand Subramanian <asubrama@andrew.cmu.edu> Fall 2010
 * Forward compatible fragment of C0
 *
 * Consider using smlnj's pretty printing library --
 * you might find it useful to deal with indentation, spacing, etc.
 * This is especially useful for large programs when string concatenation
 * may get very slow.
 *)

signature AST =
sig
  type ident = Symbol.symbol

  datatype oper = 
     PLUS
   | MINUS
   | TIMES
   | DIVIDEDBY
   | MODULO
   | NEGATIVE			(* unary minus *)

  datatype exp =
     Var of ident
   | ConstExp of Word32.word
   | OpExp of oper * exp list
   | Marked of exp Mark.marked
  and stm =
     Assign of ident * exp
   | Return of exp
   | Markeds of stm Mark.marked

  type decl = ident

  type program = (decl list * stm list)

  (* print as source, with redundant parentheses *)
  structure Print :
  sig
    val pp_exp : exp -> string
    val pp_stm : stm -> string
    val pp_program : program -> string
  end

end

structure Ast :> AST =
struct
  type ident = Symbol.symbol

  datatype oper = 
     PLUS
   | MINUS
   | TIMES
   | DIVIDEDBY
   | MODULO
   | NEGATIVE			(* unary minus *)

  datatype exp =
     Var of ident
   | ConstExp of Word32.word
   | OpExp of oper * exp list
   | Marked of exp Mark.marked
  and stm =
     Assign of ident * exp
   | Return of exp
   | Markeds of stm Mark.marked

  type decl = ident

  type program = (decl list * stm list)

  (* print programs and expressions in source form
   * using redundant parentheses to clarify precedence
   *)
  structure Print =
  struct
    fun pp_ident id = Symbol.name id

    fun pp_oper PLUS = "+"
      | pp_oper MINUS = "-"
      | pp_oper TIMES = "*"
      | pp_oper DIVIDEDBY = "/"
      | pp_oper MODULO = "%"
      | pp_oper NEGATIVE = "-"

    fun pp_exp (Var(id)) = pp_ident id
      | pp_exp (ConstExp(c)) = Word32Signed.toString c
      | pp_exp (OpExp(oper, [e])) =
	  pp_oper oper ^ "(" ^ pp_exp e ^ ")"
      | pp_exp (OpExp(oper, [e1,e2])) =
	  "(" ^ pp_exp e1 ^ " " ^ pp_oper oper
	  ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (Marked(marked_exp)) =
	  pp_exp (Mark.data marked_exp)

    fun pp_stm (Assign (id,e)) =
	pp_ident id ^ " = " ^ pp_exp e ^ ";"
      | pp_stm (Return e) =
	  "return " ^ pp_exp e ^ ";"
      | pp_stm (Markeds (marked_stm)) =
	  pp_stm (Mark.data marked_stm)

    fun pp_stms nil = ""
      | pp_stms (s::ss) = pp_stm s ^ "\n" ^ pp_stms ss

    fun pp_decl d = "int " ^ pp_ident d

    fun pp_decls nil = ""
      | pp_decls (d::dd) = pp_decl d ^ "\n" ^ pp_decls dd

    fun pp_program (decls, stms) = "{\n" ^ pp_decls decls ^ pp_stms stms ^ "}"
  end
end
