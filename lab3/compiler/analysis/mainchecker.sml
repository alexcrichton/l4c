(* L3 Compiler
 * MainChecker
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *
 * Checks that the program has a main function which returns an int and has no
 * arguments
 *)

signature MAIN_CHECK =
sig
  (* prints error message and raises ErrorMsg.error if error found *)
  val maincheck : Ast.program -> unit
end;

structure MainChecker :> MAIN_CHECK =
struct
  structure A = Ast

  fun eq_types (A.INT, A.INT) = true
    | eq_types (A.BOOL, A.BOOL) = true
    | eq_types _ = false

  fun ismain (A.Fun (typ, id, args, _)) =
        if Symbol.name id <> "main" then false
        else if not (eq_types (A.INT, typ)) then
          (ErrorMsg.error NONE "main() does not return int";
           raise ErrorMsg.Error)
        else if List.length args <> 0 then
          (ErrorMsg.error NONE "main() should have no arguments";
           raise ErrorMsg.Error)
        else true
    | ismain _ = false

  (* maincheck : A.program -> unit
   *
   * Checks a program has a main() function which takes no arguments and returns
   * an integer.
   *
   * @param prog the program to check
   * @raise ErrorMsg.Error if the program does not have a correct main
   *)
  fun maincheck L = (foldl (fn (a, b) => b orelse ismain a) false L
        orelse (ErrorMsg.error NONE "No main function was found";
                raise ErrorMsg.Error); ())

end
