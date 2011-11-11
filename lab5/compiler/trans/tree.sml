(* L5 Compiler
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
  datatype edge = ALWAYS | TRUE | FALSE | BRANCH
  type tmp = Temp.temp * int ref

  datatype exp =
      TEMP of tmp * typ
    | PHI of tmp list
    | CONST of Word32.word * typ
    | BINOP of binop * exp * exp
    | CALL of Label.label * typ * (exp * typ) list
    | MEM of exp * typ
  and stm =
      MOVE of exp * exp
    | LABEL of Label.label
    | GOTO  of Label.label * exp option
    | COND  of exp
    | RETURN of exp

  type block = stm list
  type cfg_func = Label.label * typ * (Temp.temp * typ) list *
                  (block, edge, unit) Graph.graph
  type cfg = cfg_func list

  type func = Label.label * typ * (Temp.temp * typ) list * stm list
  type program = func list

  val tmphash : tmp -> word
  val tmpcompare : tmp * tmp -> order
  val tmpequals : tmp * tmp -> bool

  structure Print :
  sig
    val pp_program : program -> string
    val pp_stm : stm -> string
  end
end

structure Tree :> TREE =
struct
  type ident = Symbol.symbol

  datatype binop = ADD | SUB | MUL | DIV | MOD | LT | LTE | EQ | NEQ
                 | AND | OR  | XOR | LSH | RSH
  datatype typ = WORD | QUAD
  datatype edge = ALWAYS | TRUE | FALSE | BRANCH
  type tmp = Temp.temp * int ref

  datatype exp =
      TEMP of tmp * typ
    | PHI of tmp list
    | CONST of Word32.word * typ
    | BINOP of binop * exp * exp
    | CALL of Label.label * typ * (exp * typ) list
    | MEM of exp * typ
  and stm =
      MOVE of exp * exp
    | LABEL of Label.label
    | GOTO  of Label.label * exp option
    | COND  of exp
    | RETURN of exp

  type block = stm list
  type cfg_func = Label.label * typ * (Temp.temp * typ) list *
                  (block, edge, unit) Graph.graph
  type cfg = cfg_func list

  type func = Label.label * typ * (Temp.temp * typ) list * stm list
  type program = func list

  fun tmphash (t, ref n) = Word.fromInt (17 * n) + Temp.hash t
  fun tmpcompare ((t1, ref n1), (t2, ref n2)) = let
        val ord = Temp.compare (t1, t2)
      in
        if ord = EQUAL then Int.compare (n1, n2)
        else ord
      end
  fun tmpequals p = (tmpcompare p = EQUAL)

  structure Print =
  struct

    fun tab str = "  " ^ (String.translate
      (fn c => if c = #"\n" then "\n  " else (String.str c)) str)

    fun pp_tmp (t, ref n) = Temp.name t ^ "#" ^ Int.toString n

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
      | pp_exp (TEMP (t, typ)) = pp_tmp t ^ pp_typ typ
      | pp_exp (PHI L) = "PHI(" ^ String.concatWith "," (map pp_tmp L) ^ ")"
      | pp_exp (BINOP (binop, e1, e2)) =
          "(" ^ pp_exp e1 ^ " " ^ pp_binop binop ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (CALL (l, _, L)) = let
          val args = String.concatWith ", " (map (fn (e, _) => pp_exp e) L)
        in
          Label.name l ^ "(" ^ args ^ ")"
        end
      | pp_exp (MEM (e, t)) = "M[" ^ pp_exp e ^ "]" ^ pp_typ t

    fun pp_stm (MOVE (e1,e2)) = pp_exp e1 ^ " = " ^ pp_exp e2
      | pp_stm (COND e) = "if (" ^ pp_exp e ^ ") ..."
      | pp_stm (LABEL l) = Label.name l
      | pp_stm (GOTO (l, NONE)) = "goto " ^ Label.name l
      | pp_stm (GOTO (l, SOME exp)) =
          "if (" ^ pp_exp exp ^ ") goto " ^ Label.name l
      | pp_stm (RETURN e) = "return " ^ pp_exp e

    fun pp_func (l, _, args, stms) = Label.name l ^ "(" ^
                          String.concatWith ", "
                                  (map (fn (t, _) => pp_tmp (t, ref 0)) args) ^
                          "):\n" ^
                          tab (String.concatWith "\n" (map pp_stm stms)) ^
                          "\n\n"

    and pp_program [] = ""
      | pp_program (func::funcs) = pp_func func ^ pp_program funcs
  end
end