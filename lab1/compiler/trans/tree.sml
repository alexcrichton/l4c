(* L1 Compiler
 * IR Trees
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature TREE =
sig

  datatype binop = ADD | SUB | MUL | DIV | MOD

  datatype exp = 
      CONST of Word32.word
    | TEMP of Temp.temp
    | BINOP of binop * exp * exp
  and stm =
      MOVE of exp * exp
    | RETURN of exp

  type program = stm list

  structure Print :
  sig
    val pp_exp : exp -> string
    val pp_stm : stm -> string
    val pp_program : program -> string
  end
end

structure Tree :> TREE =
struct

  datatype binop = ADD | SUB | MUL | DIV | MOD

  datatype exp = 
      CONST of Word32.word
    | TEMP of Temp.temp
    | BINOP of binop * exp * exp
  and stm =
      MOVE of exp * exp
    | RETURN of exp

  type program = stm list

  structure Print = 
  struct

    fun pp_binop ADD = "+"
      | pp_binop SUB = "-"
      | pp_binop MUL = "*"
      | pp_binop DIV = "/"
      | pp_binop MOD = "%"

    fun pp_exp (CONST(x)) = Word32Signed.toString x
      | pp_exp (TEMP(t)) = Temp.name t
      | pp_exp (BINOP (binop, e1, e2)) =
	  "(" ^ pp_exp e1 ^ " " ^ pp_binop binop ^ " " ^ pp_exp e2 ^ ")"

    fun pp_stm (MOVE (e1,e2)) =
	  pp_exp e1 ^ "  <--  " ^ pp_exp e2
      | pp_stm (RETURN e) =
	  "return " ^ pp_exp e

    fun pp_program (nil) = ""
      | pp_program (stm::stms) = pp_stm stm ^ "\n" ^ pp_program stms
  end
end
