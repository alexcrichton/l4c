(* L2 Compiler
 * AST -> IR translator
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TRANS =
sig
  val translate : Ast.program -> Tree.stm list
end

structure Trans :> TRANS =
struct

  structure A = Ast
  structure T = Tree

  fun trans_oper A.PLUS      = T.ADD
    | trans_oper A.MINUS     = T.SUB
    | trans_oper A.TIMES     = T.MUL
    | trans_oper A.DIVIDEDBY = T.DIV
    | trans_oper A.MODULO    = T.MOD
    | trans_oper A.LESS      = T.LT
    | trans_oper A.LESSEQ    = T.LTE
    | trans_oper A.EQUALS    = T.EQ
    | trans_oper A.NEQUALS   = T.NEQ
    | trans_oper A.BAND      = T.AND
    | trans_oper A.BOR       = T.OR
    | trans_oper A.XOR       = T.XOR
    | trans_oper A.LSHIFT    = T.LSH
    | trans_oper A.RSHIFT    = T.RSH
    | trans_oper _           = raise Fail "Invalid binop translation"

  (* trans_exp : Temp.temp Symbol.table -> A.exp -> T.stm list * T.exp *)
  fun trans_exp env (A.Var id) = ([], T.TEMP (Symbol.look' env id))
    | trans_exp _ (A.Bool b) =
        ([], T.CONST (Word32.fromInt (if b then 1 else 0)))
    | trans_exp _ (A.Const w) = ([], T.CONST w)
    | trans_exp env (A.UnaryOp (A.NEGATIVE, e)) =
        trans_exp env (A.BinaryOp (A.MINUS, A.Const Word32Signed.ZERO, e))
    | trans_exp env (A.UnaryOp (A.INVERT, e)) =
        trans_exp env (A.BinaryOp (A.XOR, A.Const (Word32.fromInt ~1), e))
    | trans_exp env (A.UnaryOp (A.BANG, e)) =
        trans_exp env (A.BinaryOp (A.XOR, A.Const (Word32.fromInt 1), e))
    | trans_exp env (A.BinaryOp (A.GREATER, e1, e2)) =
        trans_exp env (A.BinaryOp (A.LESS, e2, e1))
    | trans_exp env (A.BinaryOp (A.GREATEREQ, e1, e2)) =
        trans_exp env (A.BinaryOp (A.LESSEQ, e2, e1))
    | trans_exp env (A.BinaryOp (A.LAND, e1, e2)) =
        trans_exp env (A.Ternary (e1, e2, A.Bool false))
    | trans_exp env (A.BinaryOp (A.LOR, e1, e2)) =
        trans_exp env (A.Ternary (e1, A.Bool true, e2))
    | trans_exp env (A.Marked(marked_exp)) =
        trans_exp env (Mark.data marked_exp)
    | trans_exp env (A.BinaryOp (oper, e1, e2)) = let
        val (e1stms, e1') = trans_exp env e1
        val (e2stms, e2') = trans_exp env e2
        val t = T.TEMP(Temp.new())
        val (stms, e) = (e1stms @ e2stms, T.BINOP (trans_oper oper, e1', e2'))
      in
        if oper = A.DIVIDEDBY orelse oper = A.MODULO then
          let val t = T.TEMP(Temp.new()) in
            (stms @ [T.MOVE (t, e)], t)
          end
        else (stms, e)
      end
    | trans_exp env (A.Ternary (e1, e2, e3)) = let
        val (l1, l2) = (Label.new(), Label.new())
        val t = T.TEMP (Temp.new())
        val (e1stms, e1') = trans_exp env e1
        val (e2stms, e2') = trans_exp env e2
        val (e3stms, e3') = trans_exp env e3
      in
        (e1stms @ [T.GOTO (l1, SOME e1')] @
         e3stms @ [T.MOVE (t, e3'), T.GOTO (l2, NONE), T.LABEL l1] @
         e2stms @ [T.MOVE (t, e2'), T.LABEL l2], t)
      end

  (* trans_stm : Temp.temp Symbol.table -> A.stm list -> T.program
   *
   * Translates statements from the AST to the IL representation.
   *
   * @param env the current environment of known symbols
   * @param stms the list of statements to convert from the AST
   * @return a list of statements in the IL.
   *)
  fun trans_stm env (A.Assign (id,e)) _ = let
        val (einstrs, e') = trans_exp env e
      in
        einstrs @ [T.MOVE (T.TEMP (Symbol.look' env id), e')]
      end
    | trans_stm env (A.If(e, s1, s2)) lp = let
        val (einstrs, e') = trans_exp env e
        val (truel, endl) = (Label.new(), Label.new())
      in
        einstrs @ [T.GOTO (truel, SOME e')] @
          trans_stm env s2 lp @ [T.GOTO (endl, NONE), T.LABEL truel] @
          trans_stm env s1 lp @ [T.LABEL endl]
      end
    | trans_stm env (A.While (e, s)) _ = let
        val (einstrs, e') = trans_exp env e
        val (start, continue, break) = (Label.new(), Label.new(), Label.new())
      in
        [T.GOTO (continue, NONE), T.LABEL start] @
        trans_stm env s (break, continue, []) @ [T.LABEL continue] @ einstrs @
        [T.GOTO (start, SOME e'), T.LABEL break]
      end
    | trans_stm env A.Continue (_, cont, instrs) =
        instrs @ [T.GOTO (cont, NONE)]
    | trans_stm env A.Break (break, _, _) = [T.GOTO (break, NONE)]
    | trans_stm env (A.Return e) _ = let val (einstrs, e') = trans_exp env e in
        einstrs @ [T.RETURN e']
      end
    | trans_stm env (A.Seq (s1,s2)) lp =
        (trans_stm env s1 lp) @ (trans_stm env s2 lp)
    | trans_stm env (A.Declare (id,_,s)) lp = let
        val env' = Symbol.bind env (id, Temp.new ())
      in
        trans_stm env' s lp
      end
    | trans_stm env (A.Markeds marked_stm) cs =
        trans_stm env (Mark.data marked_stm) cs
    | trans_stm _ A.Nop _ = []
    | trans_stm env (A.Express e) _ = #1 (trans_exp env e)
    | trans_stm _ (A.For (_, _, _, _)) _ = raise Fail "no for loops!"

  (* translate : Ast.program -> T.program
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun translate prog = trans_stm Symbol.empty (A.remove_for prog A.Nop)
                                 (Label.new(), Label.new(), [])

end
