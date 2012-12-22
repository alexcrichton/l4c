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

  fun pp_json file = print (Ast.Print.pp_program (Parse.parse file))

  fun main (name, args) = (map pp_json args; OS.Process.success)

end
