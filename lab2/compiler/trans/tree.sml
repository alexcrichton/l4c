(* L2 Compiler
 * IR Tree
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TREE =
sig

  datatype binop = ADD | SUB | MUL | DIV | MOD | LT | LTE | EQ | NEQ
                 | AND | OR | XOR | LSH | RSH

  datatype exp =
      TEMP of Temp.temp
    | CONST of Word32.word
    | BINOP of binop * exp * exp
    | TERN of exp * exp * exp
  and stm =
      MOVE of exp * exp
    | IF of exp * stm list * stm list
    | WHILE of exp * stm list
    | CONTINUE
    | BREAK
    | RETURN of exp

  type program = stm list

  structure Print :
  sig
    val pp_program : program -> string
  end
end

structure Tree :> TREE =
struct

  datatype binop = ADD | SUB | MUL | DIV | MOD | LT | LTE | EQ | NEQ
                 | AND | OR | XOR | LSH | RSH

  datatype exp =
      TEMP of Temp.temp
    | CONST of Word32.word
    | BINOP of binop * exp * exp
    | TERN of exp * exp * exp
  and stm =
      MOVE of exp * exp
    | IF of exp * stm list * stm list
    | WHILE of exp * stm list
    | CONTINUE
    | BREAK
    | RETURN of exp

  type program = stm list

  structure Print =
  struct

    fun tab str = "  " ^ (String.translate
      (fn c => if c = #"\n" then "\n  " else (String.str c)) str)

    fun pp_binop ADD = "+"
      | pp_binop SUB = "-"
      | pp_binop MUL = "*"
      | pp_binop DIV = "/"
      | pp_binop MOD = "%"
      | pp_binop LT  = "<"
      | pp_binop LTE = "<="
      | pp_binop EQ  = "=="
      | pp_binop NEQ = "!="
      | pp_binop AND = "&"
      | pp_binop OR  = "|"
      | pp_binop XOR = "^"
      | pp_binop LSH = "<<"
      | pp_binop RSH = ">>"

    fun pp_exp (CONST x) = Word32Signed.toString x
      | pp_exp (TEMP t) = Temp.name t
      | pp_exp (BINOP (binop, e1, e2)) =
          "(" ^ pp_exp e1 ^ " " ^ pp_binop binop ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (TERN (e1, e2, e3)) =
          "(" ^ pp_exp e1 ^ " ? " ^ pp_exp e2 ^ " : " ^ pp_exp e3 ^ ")"

    fun pp_stm (MOVE (e1,e2)) = pp_exp e1 ^ " = " ^ pp_exp e2
      | pp_stm (IF (e, s1, s2)) = "if " ^ pp_exp e ^ " {\n" ^
                                  tab(pp_program s1) ^ "\n} else {\n" ^
                                  tab(pp_program s2) ^ "\n}"
      | pp_stm (WHILE (e, s)) = "while " ^ pp_exp e ^ " {\n" ^
                                tab(pp_program s) ^ "\n}"
      | pp_stm CONTINUE = "continue"
      | pp_stm BREAK = "break"
      | pp_stm (RETURN e) = "return " ^ pp_exp e

    and pp_program [] = ""
      | pp_program (stm::stms) = pp_stm stm ^ "\n" ^ pp_program stms
  end
end
