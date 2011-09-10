exception CodeGenExn of string

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

  type node = Node.temp
  type node_set = NodeSet.set
  type 'a node_data = 'a NodeData.map
  type 'a graph = 'a Graph.map

  fun allocate a = a

  (*  color : graph -> node list -> node_data *)
  fun color g []     = NodeData.empty
    | color g (n::L) = NodeData.empty

  (*  generate_seo : graph -> node_set -> node list *)
  fun generate_seo g s0 = let
    fun remove s w = let
      (* get the highest weighted node *)
      val maxfn = fn (n, (n', wt')) => let
                    val wt = (case NodeData.find(w, n) of NONE => 0 | SOME(wt'') => wt'')
                  in if wt > wt' then (n, wt) else (n', wt') end
      val (max, _) = NodeSet.foldl maxfn (Node.new(), ~1) s
      (* increase the weight of the neighbors *)
      val incfn = fn (n, w') =>
                    (case NodeData.find(w', n)
                       of NONE     => NodeData.insert(w', n, 1)
                        | SOME(wt) => NodeData.insert(w', n, wt + 1))
      val w' = (case Graph.find(g, max)
                  of NONE            => raise CodeGenExn "Node in set isn't in graph"
                   | SOME(neighbors) => NodeSet.foldl incfn w neighbors)
    in
      max :: (remove (NodeSet.delete(s, max)) w')
    end
  in
    remove s0 NodeData.empty
  end
end
