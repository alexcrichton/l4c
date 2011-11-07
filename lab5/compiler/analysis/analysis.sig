(* L4 Compiler
 * Analysis signature
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
signature ANALYSIS =
sig
  val analyze : Ast.program -> unit
end
