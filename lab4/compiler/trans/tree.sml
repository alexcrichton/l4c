(* L4 Compiler
 * IR Tree
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TREE =
sig
  type ident = Symbol.symbol

  datatype binop = ADD | SUB | MUL | DIV | MOD | LT | LTE | EQ | NEQ
                 | AND | OR  | XOR | LSH | RSH

  datatype exp =
      TEMP of Temp.temp
    | CONST of Word32.word
    | BINOP of binop * exp * exp
    | CALL of Label.label * exp list
  and stm =
      MOVE of exp * exp
    | LABEL of Label.label
    | GOTO  of Label.label * exp option
    | RETURN of exp

  type func = Label.label * Temp.temp list * stm list

  type program = func list

  structure Print :
  sig
    val pp_program : program -> string
  end
end

structure Tree :> TREE =
struct
  type ident = Symbol.symbol

  datatype binop = ADD | SUB | MUL | DIV | MOD | LT | LTE | EQ | NEQ
                 | AND | OR  | XOR | LSH | RSH

  datatype exp =
      TEMP of Temp.temp
    | CONST of Word32.word
    | BINOP of binop * exp * exp
    | CALL of Label.label * exp list
  and stm =
      MOVE of exp * exp
    | LABEL of Label.label
    | GOTO  of Label.label * exp option
    | RETURN of exp

  type func = Label.label * Temp.temp list * stm list

  type program = func list

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
      | pp_exp (CALL (l, L)) = let
          val args = String.concatWith ", " (map pp_exp L)
        in
          Label.name l ^ "(" ^ args ^ ")"
        end

    fun pp_stm (MOVE (e1,e2)) = pp_exp e1 ^ " <- " ^ pp_exp e2
      | pp_stm (LABEL l) = Label.name l
      | pp_stm (GOTO (l, NONE)) = "goto " ^ Label.name l
      | pp_stm (GOTO (l, SOME exp)) =
          "if (" ^ pp_exp exp ^ ") goto " ^ Label.name l
      | pp_stm (RETURN e) = "return " ^ pp_exp e

    fun pp_func (l, _, stms) = Label.name l ^ ":\n" ^
                          tab (String.concatWith "\n" (map pp_stm stms)) ^ "\n\n"

    and pp_program [] = ""
      | pp_program (func::funcs) = pp_func func ^ pp_program funcs
  end
end
