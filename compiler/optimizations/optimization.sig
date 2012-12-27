(* L5 Compiler
 * Optimization signature
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
signature CFG_OPTIMIZATION =
sig
  val optimize : Tree.cfg_func list -> Tree.cfg_func list
end

signature CODEGEN_OPTIMIZATION =
sig
  structure Assem : ASSEM
  val optimize : Label.label -> Assem.instr list -> Assem.instr list
end
