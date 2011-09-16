
signature ALLOCATION =
sig
  val allocate : Assem.instr list -> Assem.instr list
  exception AllocationExn of string
end

(*
 * The interference graph is represented as a map between nodes and
 * a list of that node's neighbors. Nodes in this case are Temp.temps.
 * There is also an ('a node_data) type that stores metadata of type 'a
 * about nodes.
 *)
structure Allocation :> ALLOCATION =
struct
  exception AllocationExn of string
  structure AS = Assem
  structure Node = Temp
  structure NodeSet = TempSet
  structure Graph = BinaryMapFn(Node)
  structure NodeData = Graph

  type node = Node.temp
  type node_set = NodeSet.set
  type 'a node_data = 'a NodeData.map
  type graph = node list Graph.map

  (* make_graph : (node_set list * instr list) -> (graph * int node_data) -> (graph * int node_data)
   * Converts the liveness information map into an interference graph.
   *
   * @param N   The list of nodes
   * @param L   The liveness information list
   * @param g   The current interference graph
   * @return    The complete interference graph
   *
   * @usage g should be equal to Graph.empty when calling this function
   *)
  fun make_graph ([], []) g = g
    | make_graph (set::S, i::L) (G, C) = let
        fun reserve_registers pair nil = pair
          | reserve_registers (set, C) (r::L) = let
            val t1   = Node.new()
            val set' = NodeSet.add (set, t1)
            val C'   = NodeData.insert (C, t1, r)
          in
            reserve_registers (set', C') L
          end
        (* handle instructions that should be pre-colored *)
        val (set', C') = (
          case i
            of (AS.BINOP (AS.DIV, _, _, _)) => reserve_registers (set, C) [1, 4]
             | (AS.BINOP (AS.MOD, _, _, _)) => reserve_registers (set, C) [1, 4]
             | _ => (set, C))
        fun addNode(n, G') = let
              val L = (case Graph.find (G', n)
                         of SOME(L) => L
                          | NONE    => [])
              val set'' = NodeSet.delete (set', n)
              val L' = NodeSet.listItems (NodeSet.addList (set'', L))
            in
              Graph.insert (G', n, L')
            end
        val G' = NodeSet.foldl addNode G set'
      in
        make_graph (S, L) (G', C')
      end
    | make_graph _ _ = raise AllocationExn ("Instruction list and temp list " ^
                                            "should be the same size")

  (* apply_coloring : instr list -> int node_data -> instr list
   *
   * @param I   The list of instructions
   * @param c   The coloring information (a map of nodes (temps) to colors (ints))
   * @return    L, with all temps replaced with their correct registers
   *)
  fun apply_coloring L coloring = let
        fun map_color 1  = AS.EAX (* We use these constants in make_graph *)
          | map_color 2  = AS.EBX
          | map_color 3  = AS.ECX
          | map_color 4  = AS.EDX
          | map_color 5  = AS.EDI
          | map_color 6  = AS.ESI
          | map_color 7  = AS.R8D
          | map_color 8  = AS.R9D
          | map_color 9  = AS.R10D
          | map_color 10 = AS.R11D
          | map_color 11 = AS.R12D
          | map_color 12 = AS.R13D
          | map_color 13 = AS.R14D
          | map_color 14 = AS.R15D
          | map_color x  = AS.STACK (x - 14)

        fun map_op (AS.TEMP n) = (case NodeData.find (coloring, n)
                                    of SOME(clr) => AS.REG (map_color clr)
                                     | NONE      => AS.TEMP n)
          | map_op operand     = operand

        fun map_instr (AS.BINOP (oper, op1, op2, op3)) = AS.BINOP (oper, map_op op1, map_op op2, map_op op3)
          | map_instr (AS.MOV (op1, op2)) = AS.MOV (map_op op1, map_op op2)
          | map_instr i = i
      in
        map map_instr L
      end

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
  fun color _        []    coloring = coloring
    | color graph (n::SEO) coloring = let
        (* get the set of neighbors of node n *)
        val nbrs = valOf (Graph.find (graph, n))
        (* map nbrs to the neighbors' color *)
        val cmap = fn n' => (case NodeData.find(coloring, n')
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
  fun generate_seo graph todo weights =
      if NodeSet.numItems todo = 0 then [] else let
        (* get the highest weighted todo node *)
        val maxfn = fn (n, (n', wt')) => let
                      val wt = (case NodeData.find (weights, n) of NONE => 0 | SOME(w) => w)
                    in if wt > wt' then (SOME n, wt) else (n', wt') end
        val max = valOf (#1 (NodeSet.foldl maxfn (NONE, ~1) todo))
        (* increase the weight of the neighbors *)
        val incfn = fn (n, weights') =>
                       (case NodeData.find (weights', n)
                          of NONE     => NodeData.insert (weights', n, 1)
                           | SOME(wt) => NodeData.insert (weights', n, wt + 1))
        val weights' = foldl incfn weights (valOf (Graph.find (graph, max)))
      in
        max :: (generate_seo graph (NodeSet.delete (todo, max)) weights')
      end

  (* allocate : instr list -> instr list
   * Returns the given instruction list with all temps and variables assigned
   * to specific registers or stack locations. This function will perform the
   * liveness analysis and register allocation.
   *
   * @param L   The list of instructions with temps
   * @return    The original list of instructions with all temps replaced with
   *            registers or stack locations
   *)
  fun allocate L = let
        val live  = Liveness.compute L
        val (G, C) = make_graph  (live, L) (Graph.empty, NodeData.empty)
        val all_nodes = Graph.foldli (fn (n, _, S) => NodeSet.add (S, n))
                                     NodeSet.empty G
        val order = generate_seo G all_nodes NodeData.empty
        val C' = color G order C
        (* functions to determine if an instruction still has a temp *)
        fun isTemp (AS.TEMP _) = true
          | isTemp _           = false
        fun hasTemps (AS.MOV (o1, o2)) = (isTemp o1) orelse (isTemp o2)
          | hasTemps (AS.BINOP (_, o1, o2, o3)) = (isTemp o1) orelse (isTemp o2)
                                                              orelse (isTemp o3)
          | hasTemps _ = false
        val L' = apply_coloring L C'
      in
        List.filter (fn i => not (hasTemps i)) L'
      end
end
