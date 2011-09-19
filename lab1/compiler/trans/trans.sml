(* L1 Compiler
 * AST -> IR Translator
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified by: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature TRANS =
sig
  val translate : Ast.program -> Tree.stm list
end

structure Trans :> TRANS =
struct

  structure A = Ast
  structure T = Tree

  fun trans_oper A.PLUS = T.ADD
    | trans_oper A.MINUS = T.SUB
    | trans_oper A.TIMES = T.MUL
    | trans_oper A.DIVIDEDBY = T.DIV
    | trans_oper A.MODULO = T.MOD
    | trans_oper A.NEGATIVE = T.SUB (* unary to binary! *)

  and trans_exp env (A.Var(id)) =
      (* after type-checking, id must be declared; do not guard lookup *)
  T.TEMP (Symbol.look' env id)
    | trans_exp env (A.ConstExp c) = T.CONST(c)
    | trans_exp env (A.OpExp(oper, [e1, e2])) =
  T.BINOP(trans_oper oper, trans_exp env e1, trans_exp env e2)
    | trans_exp env (A.OpExp(A.NEGATIVE, [e])) =
  T.BINOP(trans_oper A.NEGATIVE, T.CONST(Word32Signed.ZERO), trans_exp env e)
    | trans_exp env (A.Marked(marked_exp)) =
  trans_exp env (Mark.data marked_exp)
    (* anything else should be impossible *)

  (* trans_stms : Temp.temp Symbol.table -> A.stm list -> Tree.stm list
   *
   * Translates statements from the AST to the IL representation.
   *
   * @param env the current environment of known symbols
   * @param stms the list of statements to convert from the AST
   * @return a list of statements in the IL.
   *)
  fun trans_stms env (A.Assign(id,e)::stms) = let
          val (env', t) = case Symbol.look env id
                            of SOME tmp => (env, tmp)
                             | NONE => let val tmp = Temp.new () in
                                         (Symbol.bind env (id, tmp), tmp)
                                       end
        in
          T.MOVE(T.TEMP(t), trans_exp env e) :: trans_stms env' stms
        end
    | trans_stms env (A.Declare _::stms) = trans_stms env stms
    | trans_stms env (A.Init (id,e)::stms) =
        trans_stms env (A.Assign(id,e)::stms)
    | trans_stms env (A.Return e::_) =
        (* ignore code after return *)
        T.RETURN (trans_exp env e) :: nil
    | trans_stms env (A.Markeds (marked_stm)::stms) =
      trans_stms env ((Mark.data marked_stm)::stms)

  (* translate : Ast.program -> Tree.stm list
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun translate prog = trans_stms Symbol.empty prog

end
