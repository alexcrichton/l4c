(* L5 Compiler
 * ReturnChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *
 * Checks that the program will always return.
 *)

structure ReturnChecker :> ANALYSIS =
struct
  structure A = Ast

  (* returns : A.stm -> bool
   *
   * Test whether a statement of a program will return.
   * @param stm the statement to check
   * @return true if it returns
   *)
  fun returns (A.If (_, s1, s2)) = returns s1 andalso returns s2
    | returns (A.Seq (s1, s2)) = returns s1 orelse returns s2
    | returns (A.Declare (_, _, s)) = returns s
    | returns (A.Markeds ms) = returns (Mark.data ms)
    | returns (A.Return _) = true
    | returns _ = false

  (* is_ctor : A.gdecl -> bool
   *
   * Tests whether the global declaration is a constructor for a class. This i
   * because constructors should not return.
   *)
  fun is_ctor (A.CFun (class, A.PTR (A.CLASS c), id, _, _)) =
        Symbol.equal (class, c) andalso Symbol.equal (c, id)
    | is_ctor _ = false

  (* analyze_gdecl : ext -> A.gdecl -> unit
   *
   * Analyzes global declarations to make sure that all functions listed will
   * return.
   *)
  fun analyze_gdecl ext (g as (A.Fun (_, name, _, f) |
                               A.CFun (_, _, name, _, f))) =
        if is_ctor g then
          if returns f then
            (ErrorMsg.error ext ("Constructor should not return");
             raise ErrorMsg.Error)
          else ()
        else if returns f then ()
        else (ErrorMsg.error NONE ("Function " ^ Symbol.name name ^
                                   " does not return");
              raise ErrorMsg.Error)
    | analyze_gdecl _ (A.Markedg data) =
        analyze_gdecl (Mark.ext data) (Mark.data data)
    | analyze_gdecl _ _ = ()

  (* analyze : A.program -> unit
   *
   * Checks a program to make sure that it always returns
   *
   * @param prog the program to check
   * @raise ErrorMsg.Error if the program does not return
   *)
  fun analyze L = app (analyze_gdecl NONE) L

end
