
signature ALLOCATION =
sig
  val allocate : Assem.instr list -> Assem.instr list
end

structure Allocation :> ALLOCATION =
struct
  fun allocate a = a
end
