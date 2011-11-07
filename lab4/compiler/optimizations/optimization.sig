(* L5 Compiler
 * Optimization signature
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
signature OPTIMIZATION =
sig
  val optimize : Tree.program -> Tree.program
end
