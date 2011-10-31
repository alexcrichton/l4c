signature SSA_ =
sig
  val idoms : ('n, 'e, 'g) Graph.graph -> int array
  val dom_frontiers : ('n, 'e, 'g) Graph.graph -> IntBinarySet.set array
end

structure SSA :> SSA_ =
struct
end
