
signature ALLOCATION =
sig
  val allocate : Assem.instr list -> Assem.instr list
end

(*
 * NodeData: Map<Node, int>
 * Node    : Temp
 * Graph 1 : Map<Node, Set<Node>>
 *  also   : Set<Node> - remaining nodes
 *)
structure Allocation :> ALLOCATION =
struct
  structure AS = Assem
  structure Node = Temp
  structure NodeSet = BinarySetFn(Node)
  structure Graph = BinaryMapFn(Node)
  structure NodeData = Graph

  fun allocate a = a
end
