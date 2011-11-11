(* L5 Compiler
 * InitializationCheck
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

structure InitializationChecker :> ANALYSIS =
struct
  structure A = Ast

  (* exp_uses : Symbol.symbol -> A.exp -> bool
   *
   * Tests whether an expression uses a symbol at any point.
   * @param sym the symbol in question
   * @param exp the expression to test against
   * @return true if the symbol is used in the computation of exp
   *)
  fun exp_uses sym (A.Var id) = Symbol.compare (sym, id) = EQUAL
    | exp_uses sym (A.BinaryOp (_, e1, e2)) =
        exp_uses sym e1 orelse exp_uses sym e2
    | exp_uses sym (A.UnaryOp (_, e)) = exp_uses sym e
    | exp_uses sym (A.Ternary (e1, e2, e3, _)) =
        exp_uses sym e1 orelse exp_uses sym e2 orelse exp_uses sym e3
    | exp_uses sym (A.Field (e, _, _)) = exp_uses sym e
    | exp_uses sym (A.Deref (e, _)) = exp_uses sym e
    | exp_uses sym (A.ArrSub (e1, e2, _)) =
        exp_uses sym e1 orelse exp_uses sym e2
    | exp_uses sym (A.Marked mark) = exp_uses sym (Mark.data mark)
    | exp_uses _ _ = false

  (* defines : Symbol.symbol -> A.stm -> bool
   *
   * Tests whether a statement will define a variable. This is recursive in that
   * it will look at all the sub-statements in the provided statement as well.
   *
   * @param sym the symbol in question
   * @param stm the statement to test against
   * @return true if the given statement will define sym when executed
   *)
  fun defines sym (A.Declare (_, _, s)) = defines sym s
    | defines sym (A.Assign (A.Marked m, a, b)) =
        defines sym (A.Assign (Mark.data m, a, b))
    | defines sym (A.Assign (A.Var id, _, _)) = Symbol.compare (sym, id) = EQUAL
    | defines sym (A.Assign _) = false
    | defines sym (A.If (_, s1, s2)) = defines sym s1 andalso defines sym s2
    | defines _ (A.While (e, s)) = false
    | defines _ A.Break = true
    | defines _ A.Continue = true
    | defines _ A.Nop = false
    | defines _ (A.Return _) = true
    | defines _ (A.Express _) = false
    | defines sym (A.Seq (s1, s2)) = defines sym s1 orelse defines sym s2
    | defines _ (A.For (_, _, _, _)) = raise Fail "No for loops!"
    | defines sym (A.Markeds mark) = defines sym (Mark.data mark)

  (* live : Symbol.symbol -> A.stm -> bool
   *
   * Tests whether a given variable is live in a statement. A variable is live
   * if at some point in the computation of the statement the variable is used.
   *
   * @param sym the symbol in question
   * @param stm the statement to test against
   * @return true if the symbol is live in the given statement
   *)
  fun live sym (A.Declare (id, _, s)) =
        Symbol.compare (sym, id) <> EQUAL andalso live sym s
    | live sym (A.Assign (e1, SOME _, e2)) =
        exp_uses sym e2 orelse exp_uses sym e1
    | live sym (A.Assign (e1, _, e2)) = exp_uses sym e2
    | live sym (A.If (e, s1, s2)) =
        exp_uses sym e orelse live sym s1 orelse live sym s2
    | live sym (A.While (e, s)) = exp_uses sym e orelse live sym s
    | live _ A.Break = false
    | live _ A.Continue = false
    | live _ A.Nop = false
    | live sym (A.Express e) = exp_uses sym e
    | live sym (A.Return e) = exp_uses sym e
    | live sym (A.Seq (s1, s2)) =
        live sym s1 orelse (live sym s2 andalso not (defines sym s1))
    | live sym (A.For (_, _, _, _)) = raise Fail "No for loops!"
    | live sym (A.Markeds mark) = live sym (Mark.data mark)

  (* analyze_stm : A.stm -> Mark.ext option -> unit
   *
   * Analyzes the given statement to make sure that all variables are
   * initialized before use. It is assumed that it has already been checked
   * that all variables used are declared somewhere before they are used.
   *
   * @param stm the statement (or program) to analyze_stm
   * @param ext the extents of the statement used for error messages
   * @raise ErrorMsg.Error if there is any variable in stm which is used before
   *        it is initialized
   *)
  fun analyze_stm (A.Declare (id, _, s)) ext =
        if not (live id s) then analyze_stm s ext
        else (ErrorMsg.error ext ("Uninitialized variable: " ^ Symbol.name id);
              raise ErrorMsg.Error)
    | analyze_stm (A.If (e, s1, s2)) ext = (analyze_stm s1 ext; analyze_stm s2 ext)
    | analyze_stm (A.While (e, s)) ext = analyze_stm s ext
    | analyze_stm (A.Seq (s1, s2)) ext = (analyze_stm s1 ext; analyze_stm s2 ext)
    | analyze_stm (A.For (_, _, _, _)) _ = raise Fail "No for loops!"
    | analyze_stm (A.Markeds mark) _ = analyze_stm (Mark.data mark) (Mark.ext mark)
    | analyze_stm _ _ = ()

  (* analyze_adecl : A.gdecl -> unit
   *
   * Analyzes a global declaration for intialization checking. This really only
   * looks inside of function definitions.
   * @see same args/raise as #analyze_stm
   *)
  fun analyze_adecl (A.Fun (_, _, _, body)) =
        analyze_stm (A.remove_for body A.Nop) NONE
    | analyze_adecl _ = ()

  (* analyze : A.program -> unit
   *
   * Performs semantic analysis on the given program to make sure that all
   * variables are initialized before use.
   *
   * @param p the program to check
   * @raise ErrorMsg.Error if a variable is used before initialization
   *)
  fun analyze prog = app analyze_adecl prog

end