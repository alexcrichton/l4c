(* L3 Compiler
 * AST -> IR translator
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TRANS =
sig
  val translate : Ast.program -> Tree.program
end

structure Trans :> TRANS =
struct

  structure A = Ast
  structure T = Tree

  val ident_label = Label.literal o Symbol.name

  (* trans_oper : A.binop -> T.binop
   *
   * Translates an AST binop to a IR binop
   *)
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

  (* trans_exp : Temp.temp Symbol.table -> A.exp -> T.stm list * T.exp
   *
   * Translates an AST expression into an IR expression.
   *
   * @param env the known variables so far
   * @param exp the expression to convert
   *
   * @return A tuple of statements and an IR expression. The statement list is
   *         commands that need to be executed beforehand, and the expression
   *         contains the result of this operation.
   *)
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
        val (e1s, e1') = trans_exp env e1
        val (e2s, e2') = trans_exp env e2
        val (stms, e)  = (e1s @ e2s, T.BINOP (trans_oper oper, e1', e2'))
      in
        if oper <> A.DIVIDEDBY andalso oper <> A.MODULO then (stms, e)
        else
          (* Divides and mods can have side effects. Make sure that they always
             happen by moving the result of the operation into a temp *)
          let val t = T.TEMP(Temp.new()) in
            (stms @ [T.MOVE (t, e)], t)
          end
      end
    | trans_exp env (A.Ternary (e1, e2, e3)) = let
        val (l1, l2) = (Label.new "ternary_true", Label.new "ternary_end")
        val t = T.TEMP (Temp.new())
        val (e1s, e1') = trans_exp env e1
        val (e2s, e2') = trans_exp env e2
        val (e3s, e3') = trans_exp env e3
      in
        (e1s @ [T.GOTO (l1, SOME e1')] @
         e3s @ [T.MOVE (t, e3'), T.GOTO (l2, NONE), T.LABEL l1] @
         e2s @ [T.MOVE (t, e2'), T.LABEL l2], t)
      end
    | trans_exp env (A.Call (name, EL)) = let
        fun ev (d, (instrs, dests)) = let
              val (dinstrs, dest) = trans_exp env d
            in
              (dinstrs @ instrs, dest::dests)
            end
        val (instrs, args) = foldr ev ([], []) EL
        val t = Temp.new ()
      in
        (instrs @ [T.MOVE (T.TEMP t, T.CALL (ident_label name, args))], T.TEMP t)
      end

  (* trans_stm : Temp.temp Symbol.table -> A.stm -> Label.label * Label.label
                                        -> T.program
   *
   * Translates statements from the AST to the IL representation. This assumes
   * that the AST has no for loops
   *
   * @param env the current environment of known symbols
   * @param stms the list of statements to convert from the AST
   * @param (break, continue) labels of where to go if we're translating a
            break or continue statement.
   * @return a list of statements in the IL.
   *)
  fun trans_stm env (A.Assign (id, e)) _ = let val (es, e') = trans_exp env e in
        es @ [T.MOVE (T.TEMP (Symbol.look' env id), e')]
      end
    | trans_stm env (A.If(e, s1, s2)) lp = let
        val (es, e') = trans_exp env e
        val (truel, endl) = (Label.new "if_true", Label.new "if_end")
      in
        es @ [T.GOTO (truel, SOME e')] @
          trans_stm env s2 lp @ [T.GOTO (endl, NONE), T.LABEL truel] @
          trans_stm env s1 lp @ [T.LABEL endl]
      end
    | trans_stm env (A.While (e, s)) _ = let
        val (es, e') = trans_exp env e
        val start    = Label.new "lp_start"
        val continue = Label.new "lp_continue"
        val break    = Label.new "lp_break"
      in
        [T.GOTO (continue, NONE), T.LABEL start] @
        trans_stm env s (break, continue) @
        [T.LABEL continue] @ es @ [T.GOTO (start, SOME e'), T.LABEL break]
      end
    | trans_stm env A.Continue (_, continue) = [T.GOTO (continue, NONE)]
    | trans_stm env A.Break (break, _) = [T.GOTO (break, NONE)]
    | trans_stm env (A.Return e) _ = let val (einstrs, e') = trans_exp env e in
        einstrs @ [T.RETURN e']
      end
    | trans_stm env (A.Seq (s1, s2)) lp =
        (trans_stm env s1 lp) @ (trans_stm env s2 lp)
    | trans_stm env (A.Declare (id, _, s)) lp = let
        val env' = Symbol.bind env (id, Temp.new ())
      in
        trans_stm env' s lp
      end
    | trans_stm env (A.Markeds data) cs = trans_stm env (Mark.data data) cs
    | trans_stm env (A.Express e) _ = #1 (trans_exp env e)
    | trans_stm _ A.Nop _ = []
    | trans_stm _ (A.For (_, _, _, _)) _ = raise Fail "no for loops!"

  (* translate_fun : Ast.gdecl -> T.func
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun translate_fun (A.Fun (_, name, args, body)) = let
        fun bind (A.Declare (id, _, _), e) = Symbol.bind e (id, Temp.new ())
          | bind _ = raise Fail "Invalid statement in function arguments"
        val e = foldl bind Symbol.empty args
        val instrs = trans_stm e (A.remove_for body A.Nop)
                                 (Label.new "_", Label.new "_")
      in
        SOME (ident_label name, instrs)
      end
    | translate_fun _ = NONE
  
  (* translate : Ast.program -> T.program
   *
   * Translates an abstract syntax tree into the intermediate language.
   * @param prog the AST program
   * @return a list of statements in the intermediate language.
   *)
  fun translate p = List.mapPartial translate_fun p

end
