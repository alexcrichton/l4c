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
    | trans_oper A.LESS = T.LT
    | trans_oper A.LESSEQ = T.LTE
    | trans_oper A.EQUALS = T.EQ
    | trans_oper A.NEQUALS = T.NEQ
    | trans_oper A.BAND = T.AND
    | trans_oper A.BOR = T.OR
    | trans_oper A.XOR = T.XOR
    | trans_oper A.LSHIFT = T.LSH
    | trans_oper A.RSHIFT = T.RSH
    | trans_oper _ = raise Fail "Invalid binop translation"

  fun trans_exp env (A.Var id) = T.TEMP (Symbol.look' env id)
    | trans_exp env (A.Bool b) = T.CONST (Word32.fromInt (if b then 1 else 0))
    | trans_exp env (A.Const w) = T.CONST w
    | trans_exp env (A.BinaryOp (A.GREATER, e1, e2)) =
        trans_exp env (A.BinaryOp (A.LESS, e2, e1))
    | trans_exp env (A.BinaryOp (A.GREATEREQ, e1, e2)) =
        trans_exp env (A.BinaryOp (A.LESSEQ, e2, e1))
    | trans_exp env (A.BinaryOp (A.LAND, e1, e2)) =
        trans_exp env (A.Ternary (e1, e2, A.Bool false))
    | trans_exp env (A.BinaryOp (A.LOR, e1, e2)) =
        trans_exp env (A.Ternary (e1, A.Bool true, e2))
    | trans_exp env (A.BinaryOp (oper, e1, e2)) =
        T.BINOP (trans_oper oper, trans_exp env e1, trans_exp env e2)
    | trans_exp env (A.UnaryOp (A.NEGATIVE, e)) =
        trans_exp env (A.BinaryOp (A.MINUS, A.Const Word32Signed.ZERO, e))
    | trans_exp env (A.UnaryOp (A.INVERT, e)) =
        trans_exp env (A.BinaryOp (A.XOR, A.Const (Word32.fromInt ~1), e))
    | trans_exp env (A.UnaryOp (A.BANG, e)) =
        trans_exp env (A.BinaryOp (A.XOR, A.Const (Word32.fromInt 1), e))
    | trans_exp env (A.Ternary (e1, e2, e3)) =
        T.TERN (trans_exp env e1, trans_exp env e2, trans_exp env e3)
    | trans_exp env (A.Marked(marked_exp)) =
        trans_exp env (Mark.data marked_exp)

  (* trans_stm : Temp.temp Symbol.table -> A.stm list -> T.program
   *
   * Translates statements from the AST to the IL representation.
   *
   * @param env the current environment of known symbols
   * @param stms the list of statements to convert from the AST
   * @return a list of statements in the IL.
   *)
  fun trans_stm env (A.Assign(id,e)) _ =
        [T.MOVE (T.TEMP (Symbol.look' env id), trans_exp env e)]
    | trans_stm env (A.If(e,s1,s2)) cs =
        [T.IF (trans_exp env e, trans_stm env s1 cs, trans_stm env s2 cs)]
    | trans_stm env (A.While (e,s)) _ =
        [T.WHILE (trans_exp env e, trans_stm env s [])]
    | trans_stm env (A.For (s1, e, s2, s3)) cs = let
        val s2' = trans_stm env s2 []
      in
        (trans_stm env s1 []) @
        [T.WHILE (trans_exp env e, (trans_stm env s3 s2') @ s2')]
      end
    | trans_stm env A.Continue cs = cs @ [T.CONTINUE]
    | trans_stm env A.Break _ = [T.BREAK]
    | trans_stm env (A.Return e) _ = [T.RETURN (trans_exp env e)]
    | trans_stm env (A.Seq (s1,s2)) cs =
        (trans_stm env s1 cs) @ (trans_stm env s2 cs)
    | trans_stm env (A.Declare (id,_,s)) cs = let
        val env' = Symbol.bind env (id, Temp.new ())
      in
        trans_stm env' s cs
      end
    | trans_stm env (A.Markeds marked_stm) cs =
        trans_stm env (Mark.data marked_stm) cs
    | trans_stm env A.Nop _ = []

  (* translate : Ast.program -> T.program
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun translate prog = trans_stm Symbol.empty prog []

end
