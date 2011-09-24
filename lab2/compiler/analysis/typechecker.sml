(* L2 Compiler
 * TypeChecker
 * Author: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Simple typechecker that is based on a unit Symbol.table
 * This is all that is needed since there is only an integer type present
 * Also, since only straightline code is accepted, we hack our way
 * around initialization checks here.
 *
 * Modified: Anand Subramanian <asubrama@andrew.cmu.edu> Fall 2010
 * Now distinguishes between declarations and initialization
 *)

signature TYPE_CHECK =
sig
  (* prints error message and raises ErrorMsg.error if error found *)
  val typecheck : Ast.program -> unit
end;

structure TypeChecker :> TYPE_CHECK =
struct
  structure A = Ast

  fun tc_equal (t1, t2) _ = if t1 = t2 then () else raise Fail "Tycon mismatch"
  fun tc_ensure env (e,t) ext = tc_equal (t, tc_exp env e ext) ext

  (* tc_exp : A.typ Symbol.table -> Ast.exp -> Mark.ext option -> A.typ *)
  and tc_exp env (A.Var id) ext =
      (case Symbol.look env id
         of NONE => (ErrorMsg.error ext ("undeclared variable `" ^
                      Symbol.name id ^ "'"); raise ErrorMsg.Error )
          | SOME t => t)
    | tc_exp env (A.Bool _) ext = A.BOOL
    | tc_exp env (A.Const _) ext = A.INT
    | tc_exp env (A.BinaryOp (A.LESSEQ,e1,e2)) ext = tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.GREATER,e1,e2)) ext = tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.GREATEREQ,e1,e2)) ext = tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (A.NEQUALS,e1,e2)) ext = tc_exp env (A.BinaryOp (A.EQUALS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.EQUALS,e1,e2)) ext =
        (tc_ensure env (e1, tc_exp env e2 ext) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (A.LAND,e1,e2)) ext = tc_exp env (A.BinaryOp (A.LOR,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.LOR,e1,e2)) ext =
        (tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e2, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (_,e1,e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.INT)
    | tc_exp env (A.UnaryOp (A.BANG,e)) ext = (tc_ensure env (e, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.UnaryOp (_,e)) ext = (tc_ensure env (e, A.INT) ext; A.INT)
    | tc_exp env (A.Ternary (e1,e2,e3)) ext = let
        val t2 = tc_exp env e2 ext
      in
        tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e3, t2) ext; t2
      end
    | tc_exp env (A.Marked marked_exp) ext =
        tc_exp env (Mark.data marked_exp) (Mark.ext marked_exp)

  (* tc_stm : A.typ Symbol.table -> Ast.stm -> Mark.ext option -> bool -> () *)
  fun tc_stm env (A.Assign (id,e)) ext _ =
        (case Symbol.look env id
           of SOME t => tc_ensure env (e, t) ext
            | NONE   => raise Fail ("Variable " ^ Symbol.name id ^ " undeclared"))
    | tc_stm env (A.If (e,s1,s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s1 ext lp; tc_stm env s2 ext lp)
    | tc_stm env (A.While (e,s)) ext _ =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext true)
    | tc_stm env (A.For (s,e,s1,s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext lp; tc_stm env s1 ext true; tc_stm env s2 ext true)
    | tc_stm _ A.Continue _ lp = if lp then () else raise Fail "Continue outside of loop"
    | tc_stm _ A.Break _ lp = if lp then () else raise Fail "Break outside of loop"
    | tc_stm env (A.Return e) ext _ = tc_ensure env (e,A.INT) ext
    | tc_stm _ A.Nop _ _ = ()
    | tc_stm env (A.Seq (s1,s2)) ext lp = (tc_stm env s1 ext lp; tc_stm env s2 ext lp)
    | tc_stm env (A.Declare (id,t,s)) ext lp =
        (case Symbol.look env id
           of SOME _ => raise Fail ("Redeclared variable " ^ Symbol.name id)
            | NONE   => tc_stm (Symbol.bind env (id, t)) s ext lp)
    | tc_stm env (A.Markeds marked_stm) _ lp =
        tc_stm env (Mark.data marked_stm) (Mark.ext marked_stm) lp

  fun typecheck prog = tc_stm Symbol.empty prog NONE false

end
