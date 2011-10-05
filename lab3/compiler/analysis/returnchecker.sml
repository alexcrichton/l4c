(* L3 Compiler
 * ReturnChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *
 * Checks that the program will always return.
 *)

signature RETURN_CHECK =
sig
  (* prints error message and raises ErrorMsg.error if error found *)
  val returncheck : Ast.program -> unit
end;

structure ReturnChecker :> RETURN_CHECK =
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

  (* returncheck : A.program -> unit
   *
   * Checks a program to make sure that it always returns
   *
   * @param prog the program to check
   * @raise ErrorMsg.Error if the program does not return
   *)
  fun returncheck prog = if returns prog then () else (
      ErrorMsg.error NONE "Program does not return"; raise ErrorMsg.Error)

end
