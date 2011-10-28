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
  datatype typ = WORD | QUAD

  datatype exp =
      TEMP of Temp.temp * typ
    | CONST of Word32.word * typ
    | BINOP of binop * exp * exp
    | CALL of Label.label * typ * (exp * typ) list
    | MEM of exp * typ
  and stm =
      MOVE of exp * exp
    | LABEL of Label.label
    | GOTO  of Label.label * exp option
    | RETURN of exp

  type func = Label.label * typ * (Temp.temp * typ) list * stm list

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
  datatype typ = WORD | QUAD

  datatype exp =
      TEMP of Temp.temp * typ
    | CONST of Word32.word * typ
    | BINOP of binop * exp * exp
    | CALL of Label.label * typ * (exp * typ) list
    | MEM of exp * typ
  and stm =
      MOVE of exp * exp
    | LABEL of Label.label
    | GOTO  of Label.label * exp option
    | RETURN of exp

  type func = Label.label * typ * (Temp.temp * typ) list * stm list

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

    fun pp_typ WORD = ":w"
      | pp_typ QUAD = ":q"

    fun pp_exp (CONST (x, typ)) = Word32Signed.toString x ^ pp_typ typ
      | pp_exp (TEMP (t, typ)) = Temp.name t ^ pp_typ typ
      | pp_exp (BINOP (binop, e1, e2)) =
          "(" ^ pp_exp e1 ^ " " ^ pp_binop binop ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (CALL (l, _, L)) = let
          val args = String.concatWith ", " (map (fn (e, _) => pp_exp e) L)
        in
          Label.name l ^ "(" ^ args ^ ")"
        end
      | pp_exp (MEM (e, _)) = "M[" ^ pp_exp e ^ "]"

    fun pp_stm (MOVE (e1,e2)) = pp_exp e1 ^ " <- " ^ pp_exp e2
      | pp_stm (LABEL l) = Label.name l
      | pp_stm (GOTO (l, NONE)) = "goto " ^ Label.name l
      | pp_stm (GOTO (l, SOME exp)) =
          "if (" ^ pp_exp exp ^ ") goto " ^ Label.name l
      | pp_stm (RETURN e) = "return " ^ pp_exp e

    fun pp_func (l, _, _, stms) = Label.name l ^ ":\n" ^
                          tab (String.concatWith "\n" (map pp_stm stms)) ^ "\n\n"

    and pp_program [] = ""
      | pp_program (func::funcs) = pp_func func ^ pp_program funcs
  end
end
