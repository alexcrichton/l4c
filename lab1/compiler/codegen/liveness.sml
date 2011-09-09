structure TempSet = BinarySetFn(Temp)

signature LIVENESS =
sig
  (*
   * The two lists are the same size. Corresponding entries match instructions to conflicting temp
   * registers at that location.
   *)
  val compute : Assem.instr list -> TempSet.set list
end

structure Liveness :> LIVENESS = 
struct
  structure AS = Assem

  fun compute _ = []
end
