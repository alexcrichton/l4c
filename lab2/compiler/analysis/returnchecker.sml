(* L2 Compiler
 * ReturnChecker
 * Author: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
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

  fun returns (A.If (_, s1, s2)) = returns s1 andalso returns s2
    | returns (A.Seq (s1, s2)) = returns s1 orelse returns s2
    | returns (A.Declare (_, _, s)) = returns s
    | returns (A.Markeds ms) = returns (Mark.data ms)
    | returns (A.Return _) = true
    | returns _ = false

  fun returncheck prog = if returns prog then () else
                          raise Fail "Program does not return"

end
