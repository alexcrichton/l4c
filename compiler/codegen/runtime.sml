signature RUNTIME =
sig
  structure Assem : ASSEM
  val instrs : Assem.instr list -> Assem.instr list
end

functor Runtime(A : ASSEM) :> RUNTIME where Assem = A =
struct
  structure Assem = A
  open Assem

  fun instrs prog =
        DIRECTIVE ".ident\t\"15-411 L5 compiler\"" :: prog

end
