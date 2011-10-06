(* L3 Compiler
 * TypeChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature TYPE_CHECK =
sig
  (* prints error message and raises ErrorMsg.error if error found *)
  val typecheck : Ast.program -> unit
end;

structure TypeChecker :> TYPE_CHECK =
struct
  structure A = Ast
(*
  (* typ_name : A.typ -> string
   * Helper method to get a string description of a type
   *)
  fun typ_name A.BOOL = "bool"
    | typ_name A.INT  = "int"
    | typ_name (A.TYPEDEF ident) = Symbol.name ident

  fun typs_equal (A.BOOL, A.BOOL) = true
    | typs_equal (A.INT, A.INT)   = true
    | typs_equal (A.TYPEDEF id1, A.TYPEDEF id2) =
        Symbol.compare (id1, id2) = EQUAL
    | typs_equal _ = false

  (* tc_equal : A.typ * A.typ -> Mark.ext option -> unit
   *
   * @param t1, t2 the types to test for equivalence
   * @param ext    the extent that these types show up in
   *
   * @raise ErrorMsg.Error if the types are not equal
   *)
  fun tc_equal (t1, t2) ext = if typs_equal (t1, t2) then () else (
        ErrorMsg.error ext ("type mismatch, " ^ typ_name t1 ^ " != " ^
                            typ_name t2);
        raise ErrorMsg.Error)

  (* tc_ensure : A.typ Symbol.table -> A.exp * A.typ -> Mark.ext option -> unit
   *
   * Ensures that the provided statement is of the provided type.
   *
   * @param env see tc_exp and tc_stm
   * @param e   the expression to check
   * @param t   the expected type of the expression
   * @param ext see tc_exp and tc_stm
   *
   * @raise ErrorMsg.Error if there's a typecheck error or the expression isn't
   *                       of the expected type
   * @return nothing if the expression is of the right type.
   *)
  fun tc_ensure env (e,t) ext = tc_equal (t, tc_exp env e ext) ext

  (* tc_exp : A.typ Symbol.table -> A.exp -> Mark.ext option -> A.typ
   *
   * Typecheck a single expression.
   *
   * @param env the currently known environment of variables and their types
   * @param exp the expression to typecheck
   * @param ext the current extents of the statement in the source file
   *
   * @raise ErrorMsg.Error if there is a typecheck error
   * @return the type of the expression if it is well formed
   *)
  and tc_exp env (A.Var id) ext =
      (case Symbol.look env id
         of NONE => (ErrorMsg.error ext ("undeclared variable `" ^
                      Symbol.name id ^ "'"); raise ErrorMsg.Error)
          | SOME t => t)
    | tc_exp _ (A.Bool _) _ = A.BOOL
    | tc_exp _ (A.Const _) _ = A.INT
    | tc_exp env (A.BinaryOp (A.LESSEQ,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.GREATER,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.GREATEREQ,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.LESS,e1,e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (A.NEQUALS,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.EQUALS,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.EQUALS,e1,e2)) ext =
        (tc_ensure env (e1, tc_exp env e2 ext) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (A.LAND,e1,e2)) ext =
        tc_exp env (A.BinaryOp (A.LOR,e1,e2)) ext
    | tc_exp env (A.BinaryOp (A.LOR,e1,e2)) ext =
        (tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e2, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.BinaryOp (_,e1,e2)) ext =
        (tc_ensure env (e1, A.INT) ext; tc_ensure env (e2, A.INT) ext; A.INT)
    | tc_exp env (A.UnaryOp (A.BANG,e)) ext =
        (tc_ensure env (e, A.BOOL) ext; A.BOOL)
    | tc_exp env (A.UnaryOp (_,e)) ext = (tc_ensure env (e, A.INT) ext; A.INT)
    | tc_exp env (A.Ternary (e1,e2,e3)) ext = let
        val t2 = tc_exp env e2 ext
      in
        tc_ensure env (e1, A.BOOL) ext; tc_ensure env (e3, t2) ext; t2
      end
    | tc_exp env (A.Marked marked_exp) _ =
        tc_exp env (Mark.data marked_exp) (Mark.ext marked_exp)

  (* tc_stm : A.typ Symbol.table -> Ast.stm -> Mark.ext option -> bool -> unit
   *
   * Typecheck a single statement in a program.
   *
   * @param env the currently known environment of variables and their types
   * @param stm the statement to typecheck
   * @param ext the current extents of the statement in the source file
   * @param lp  true if we're inside of a loop
   *
   * @raise ErrorMsg.Error if there is a typecheck error
   * @return nothing
   *)
  fun tc_stm env (A.Assign (id,e)) ext _ =
        (case Symbol.look env id
           of SOME t => tc_ensure env (e, t) ext
            | NONE   => (ErrorMsg.error ext ("Variable " ^ Symbol.name id ^
                                             " undeclared");
                         raise ErrorMsg.Error))
    | tc_stm env (A.If (e,s1,s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s1 ext lp;
         tc_stm env s2 ext lp)
    | tc_stm env (A.While (e,s)) ext _ =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext true)
    | tc_stm env (A.For (s,e,s1,s2)) ext lp =
        (tc_ensure env (e,A.BOOL) ext; tc_stm env s ext lp;
         tc_stm env s1 ext true; tc_stm env s2 ext true)
    | tc_stm _ A.Continue ext lp = if lp then () else (
        ErrorMsg.error ext "'continue' outside of a loop is not allowed";
        raise ErrorMsg.Error)
    | tc_stm _ A.Break ext lp = if lp then () else (
        ErrorMsg.error ext "'break' outside of a loop is not allowed";
        raise ErrorMsg.Error)
    | tc_stm env (A.Return e) ext _ = tc_ensure env (e,A.INT) ext
    | tc_stm env (A.Express e) ext _ = (tc_exp env e ext; ())
    | tc_stm _ A.Nop _ _ = ()
    | tc_stm env (A.Seq (s1,s2)) ext lp =
        (tc_stm env s1 ext lp; tc_stm env s2 ext lp)
    | tc_stm env (A.Declare (id,t,s)) ext lp =
        (case Symbol.look env id
           of NONE   => tc_stm (Symbol.bind env (id, t)) s ext lp
            | SOME _ => (ErrorMsg.error ext ("Redeclared variable: " ^
                                             Symbol.name id);
                         raise ErrorMsg.Error))
    | tc_stm env (A.Markeds marked_stm) _ lp =
        tc_stm env (Mark.data marked_stm) (Mark.ext marked_stm) lp
*)
  (* typecheck : A.program -> unit
   *
   * Performs static analysis on the program to typecheck it. An error is raised
   * if there is a type problem, otherwise nothing happens.
   *
   * @param prog the program to typecheck
   *)
  fun typecheck prog = (*tc_stm Symbol.empty prog NONE false*)
                       ()

end
