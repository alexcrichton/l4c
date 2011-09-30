(* L2 Compiler
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

  datatype typ = INT | BOOL

  datatype unop =
     NEGATIVE
   | INVERT
   | BANG

  datatype binop =
     PLUS
   | MINUS
   | TIMES
   | DIVIDEDBY
   | MODULO
   | LESS
   | LESSEQ
   | GREATER
   | GREATEREQ
   | EQUALS
   | NEQUALS
   | LAND
   | LOR
   | BAND
   | XOR
   | BOR
   | LSHIFT
   | RSHIFT

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp
   | Marked of exp Mark.marked
  and stm =
     Assign  of ident * exp
   | If      of exp * stm * stm
   | While   of exp * stm
   | For     of stm * exp * stm * stm
   | Express of exp
   | Continue
   | Break
   | Return  of exp
   | Nop
   | Seq     of stm * stm
   | Declare of ident * typ * stm
   | Markeds of stm Mark.marked

  type program = stm

  (* print as source, with redundant parentheses *)
  structure Print :
  sig
    val pp_program : program -> string
  end

  val elaborate  : program -> program
  val remove_for : program -> stm -> program

end

structure Ast :> AST =
struct
  type ident = Symbol.symbol

  datatype typ = INT | BOOL

  datatype unop =
     NEGATIVE
   | INVERT
   | BANG

  datatype binop =
     PLUS
   | MINUS
   | TIMES
   | DIVIDEDBY
   | MODULO
   | LESS
   | LESSEQ
   | GREATER
   | GREATEREQ
   | EQUALS
   | NEQUALS
   | LAND
   | LOR
   | BAND
   | XOR
   | BOR
   | LSHIFT
   | RSHIFT

  datatype exp =
     Var of ident
   | Bool of bool
   | Const of Word32.word
   | BinaryOp of binop * exp * exp
   | UnaryOp of unop * exp
   | Ternary of exp * exp * exp
   | Marked of exp Mark.marked
  and stm =
     Assign  of ident * exp
   | If      of exp * stm * stm
   | While   of exp * stm
   | For     of stm * exp * stm * stm
   | Express of exp
   | Continue
   | Break
   | Return  of exp
   | Nop
   | Seq     of stm * stm
   | Declare of ident * typ * stm
   | Markeds of stm Mark.marked

  type program = stm

  (* elaborate : program -> program
   *
   * @param program the raw AST of the parser, a program which has not yet
   *                been elaborated
   *
   * @return an elaborated version of the AST which fixes structure the parser
   *         would have trouble knowing about
   *)
  fun elaborate (Markeds mark) =
        Markeds (Mark.mark' (elaborate (Mark.data mark), Mark.ext mark))
    | elaborate (Declare (id, typ, stm)) = Declare (id, typ, elaborate stm)
    | elaborate (For (Declare(id, typ, s1), e, s2, s3)) =
        Declare (id, typ, elaborate (For (s1, e, s2, s3)))
    | elaborate (For (Markeds mark, e, s2, s3)) =
        elaborate (For (Mark.data mark, e, s2, s3))
    | elaborate (For (s1, e, s2, s3)) =
        For (elaborate s1, e, elaborate s2, elaborate s3)
    | elaborate (If (e, s1, s2)) = If (e, elaborate s1, elaborate s2)
    | elaborate (While (e, s)) = While (e, elaborate s)
    | elaborate (Seq (Declare (id, typ, s1), s2)) =
        Declare (id, typ, Seq (s1, elaborate s2))
    | elaborate (Seq (Markeds mark, s2)) =
        Markeds (Mark.mark' (elaborate (Seq (Mark.data mark, s2)),
                             Mark.ext mark))
    | elaborate (Seq (s1, Markeds mark)) =
        Markeds (Mark.mark' (elaborate (Seq (s1, Mark.data mark)),
                             Mark.ext mark))
    | elaborate (Seq (s1, s2)) = Seq (elaborate s1, elaborate s2)
    | elaborate stm = stm

  (* remove_for : program -> program
   *
   * Transforms an AST to make it easier to perform analysis on.
   * This involves changing for loops to while loops.
   *
   * @param prog the program to transform
   * @param an AST without any for loops (they're converted to while loops)
   *)
  fun remove_for (For (s1, e, s2, s3)) _ =
        Seq (s1, While (e, Seq(remove_for s3 s2, s2)))
    | remove_for (If (e, s1, s2)) rep =
        If (e, remove_for s1 rep, remove_for s2 rep)
    | remove_for (While (e, s)) _ = While (e, remove_for s Nop)
    | remove_for Continue s = Seq (s, Continue)
    | remove_for (Markeds mark) s =
        Markeds (Mark.mark' (remove_for (Mark.data mark) s, Mark.ext mark))
    | remove_for (Seq (s1, s2)) r = Seq (remove_for s1 r, remove_for s2 r)
    | remove_for (Declare (id, typ, s)) r = Declare (id, typ, remove_for s r)
    | remove_for s _ = s

  (* print programs and expressions in source form
   * using redundant parentheses to clarify precedence
   *)
  structure Print =
  struct
    fun pp_ident id = Symbol.name id
    fun pp_typ BOOL = "bool"
      | pp_typ INT  = "int"

    fun pp_unop NEGATIVE = "-"
      | pp_unop INVERT   = "~"
      | pp_unop BANG     = "!"

    fun pp_oper PLUS      = "+"
      | pp_oper MINUS     = "-"
      | pp_oper TIMES     = "*"
      | pp_oper DIVIDEDBY = "/"
      | pp_oper MODULO    = "%"
      | pp_oper LESS      = "<"
      | pp_oper LESSEQ    = "<="
      | pp_oper GREATER   = ">"
      | pp_oper GREATEREQ = ">="
      | pp_oper EQUALS    = "=="
      | pp_oper NEQUALS   = "!="
      | pp_oper LAND      = "&&"
      | pp_oper LOR       = "||"
      | pp_oper BAND      = "&"
      | pp_oper XOR       = "^"
      | pp_oper BOR       = "|"
      | pp_oper LSHIFT    = "<<"
      | pp_oper RSHIFT    = ">>"

    fun pp_exp (Var id) = pp_ident id
      | pp_exp (Const c) = Word32Signed.toString c
      | pp_exp (Bool b) = if b then "true" else "false"
      | pp_exp (BinaryOp (oper, e1, e2)) =
          "(" ^ pp_exp e1 ^ " " ^ pp_oper oper ^ " " ^ pp_exp e2 ^ ")"
      | pp_exp (UnaryOp (oper, e)) = pp_unop oper ^ "(" ^ pp_exp e ^ ")"
      | pp_exp (Ternary (e1, e2, e3)) =
          "((" ^ pp_exp e1 ^ ") ? (" ^ pp_exp e2 ^ ") : (" ^ pp_exp e3 ^ "))"
      | pp_exp (Marked(marked_exp)) = pp_exp (Mark.data marked_exp)

    fun tab str = "  " ^ (String.translate
      (fn c => if c = #"\n" then "\n  " else (String.str c)) str)

    fun pp_stm (Assign (id, e)) = pp_ident id ^ " = " ^ pp_exp e ^ ""
      | pp_stm (If (e, s1, s2)) =
          "if (" ^ pp_exp e ^ ") {\n" ^ tab(pp_stm s1) ^ "\n} else {\n" ^
          pp_stm s2 ^ "\n}"
      | pp_stm (While (e, s)) = "while (" ^ tab(pp_exp e) ^ ") {\n" ^
          pp_stm s ^ " }"
      | pp_stm (For (s1, e, s2, s3)) = "for (" ^ pp_stm s1 ^ "; " ^ pp_exp e ^
          "; " ^ pp_stm s2 ^ ") {\n" ^ tab(pp_stm s3) ^ "\n}"
      | pp_stm Continue = "continue"
      | pp_stm Break = "break"
      | pp_stm Nop = ""
      | pp_stm (Express e) = pp_exp e
      | pp_stm (Seq (s1, s2)) = pp_stm s1 ^ "\n" ^ pp_stm s2
      | pp_stm (Return e) = "return " ^ pp_exp e ^ ";"
      | pp_stm (Declare (id, t, s)) = pp_typ t ^ " " ^ pp_ident id ^ "\n" ^
          tab(pp_stm s)
      | pp_stm (Markeds (marked_stm)) = pp_stm (Mark.data marked_stm)

    fun pp_program prog = "int main {\n" ^ tab (pp_stm prog) ^ "\n}\n"
  end
end
