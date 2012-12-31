(* L5 Compiler
 * Top Level Environment
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature TOP =
sig
  val main : string * string list -> OS.Process.status
end

structure Top :> TOP =
struct

  fun pp_json [] = ()
    | pp_json [a] =
         (print ("\"" ^ a ^ "\":");
          Ast.Print.pp_program (Parse.parse a))
    | pp_json (a :: b :: L) =
        (pp_json [a]; print ","; pp_json (b ::L))

  fun main (name, args) = (
    print "{";
    pp_json args;
    print "}";
    OS.Process.success)

end
