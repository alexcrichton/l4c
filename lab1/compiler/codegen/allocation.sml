exception AllocationExn of string

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
  type graph = node list Graph.map

  (* allocate : instr list -> instr list
   * Returns the given instruction list with all temps and variables assigned
   * to specific registers or stack locations. This function will perform the
   * liveness analysis and register allocation.
   *
   * @param L   The list of instructions with temps
   * @return    The original list of instructions with all temps replaced with
   *            registers or stack locations
   *)
  fun allocate a = a (* TODO *)

  (* minNotIn : int -> int list -> int
   * Returns the lowest integer >= x that is not in sorted list L
   *
   * @param x   The current candidate for lowest number not in the set
   * @param L   The sorted list of numbers
   * @return    The lowest number >= x that is not in list L
   *)
  fun minNotIn x [] = x
    | minNotIn x (n::L) =
        if x < n then
          x
        else if x > n then (* shouldn't happen - but just in case... *)
          minNotIn x L
        else
          minNotIn (x+1) L

  (* color : graph -> node list -> int node_data -> int node_data
   * Colors the given graph according to the provided seo.
   *
   * @param graph     The graph to be colored
   * @param SEO       The seo that should be used
   * @param coloring  The current coloring of the graph
   * @return          A mapping from each node to the color it should be assigned
   *
   * @usage coloring should initially be NodeData.empty unless there are
   *        pre-colored nodes. Pre-colored nodes should have their value
   *        inserted into the coloring map already, and those nodes should not
   *        be included in the SEO.
   *)
  fun color _   []   coloring       = coloring
    | color graph (n::SEO) coloring = let
        (* get the set of neighbors of node n *)
        val nbrs = (case Graph.find (graph, n)
                      of NONE     => raise AllocationExn "Node in order isn't in graph"
                       | SOME(nbrs) => nbrs)
        (* map nbrs to the neighbors' color *)
        val cmap = fn n' => (case NodeData.find(coloring, n)
                               of NONE      => 0 (* 0 means not yet colored *)
                                | SOME(clr) => clr)
        val clrs = ListMergeSort.uniqueSort Int.compare (map cmap nbrs)
        (* find the lowest number > 0 not in the set *)
        val clr = minNotIn 1 clrs
      in
        (* recurse with L and the color added to c *)
        color graph SEO (NodeData.insert (coloring, n, clr))
      end

  (* generate_seo : graph -> node_set -> int node_data -> node list
   * Generates the simplicial elimination ordering (seo) of the given interference graph.
   *
   * @param graph   The interference graph to generate the seo for
   * @param todo    The set of nodes that have not yet been assigned an order
   * @param weights A mapping of nodes to their weight.
   * @return        A list of nodes in seo
   *
   * @usage todo should initially be the set of all nodes, and weights should
   *        initially be NodeData.empty.
   *)
  fun generate_seo graph todo weights = let
        (* get the highest weighted todo node *)
        val maxfn = fn (n, (n', wt')) => let
                      val wt = (case NodeData.find (weights, n) of NONE => 0 | SOME(w) => w)
                    in if wt > wt' then (n, wt) else (n', wt') end
        val (max, _) = NodeSet.foldl maxfn (Node.new(), ~1) todo
        (* increase the weight of the neighbors *)
        val incfn = fn (n, weights') =>
                       (case NodeData.find (weights', n)
                          of NONE     => NodeData.insert (weights', n, 1)
                           | SOME(wt) => NodeData.insert (weights', n, wt + 1))
        val weights' = (case Graph.find(graph, max)
                          of NONE            => raise AllocationExn "Node in set isn't in graph"
                           | SOME(neighbors) => NodeSet.foldl incfn weights neighbors)
      in
        max :: (generate_seo graph (NodeSet.delete (todo, max)) weights')
      end
end
