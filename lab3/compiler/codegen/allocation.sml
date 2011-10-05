(* L3 Compiler
 * Allocation
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature ALLOCATION =
sig
  val allocate : Assem.instr list -> Assem.instr list
end

(*
 * The interference graph is represented as a map between nodes and
 * a list of that node's neighbors. Nodes in this case are Temp.temps.
 * There is also an ('a node_data) type that stores metadata of type 'a
 * about nodes.
 *)
structure Allocation :> ALLOCATION =
struct
  structure AS = Assem
  structure G = Graph
  structure UDG = UndirectedGraph(DynArray)
  structure P = Profile
  structure HT = HashTable
  structure PQ = NodePriorityQueue(DynArray)
  type node_data = {color:int ref, weight:int ref, in_seo:bool ref}

  (* make_graph : (node_set list * instr list) -> graph -> unit
   * Converts the liveness information map into an interference graph.
   *
   * @param S       The list of live node sets
   * @param L       The liveness information list
   * @param graph   The current interference graph
   * @return        The complete interference graph
   *
   * @usage g should be an empty graph before calling this function
   *)
  fun make_graph ([], []) _ = ()
    | make_graph (set::S, i::L) (G.GRAPH graph) = let

        val insert = HT.insert (#graph_info graph)

        fun add_clique [] = ()
          | add_clique (x::L) = (add_neighbors x L; add_clique L)
        and add_neighbors _ [] = ()
          | add_neighbors x (y::L) =
              (if #has_edge graph (x, y) then () else #add_edge graph (x, y, 0);
               add_neighbors x L)

        fun process_op (AS.TEMP t, L) = let
              val id = case HT.find (#graph_info graph) t
                         of SOME id => id
                          | NONE => let val nid = #new_id graph () in
                              insert (t, nid);
                              #add_node graph (nid, {color=ref 0, weight=ref 0,
                                                    in_seo=ref false});
                              nid
                            end
            in id :: L end
          | process_op (AS.REG r, L) = let
              val id = #new_id graph ()
              val () = #add_node graph (id, {color=ref (AS.reg_num r),
                                             weight=ref 0, in_seo=ref false})
            in id :: L end
          | process_op (_, L) = L

        val ids = OperandSet.foldr process_op [] set
      in
        add_clique ids; make_graph (S, L) (G.GRAPH graph)
      end
    | make_graph _ _ = raise Fail ("Instruction list and temp list " ^
                                   "should be the same size")

  (* update_weights : graph -> unit
   * Updates the weights of all nodes in the graph
   *
   * @param graph   The graph
   *)
  fun update_weights (G.GRAPH graph) = let
        fun count (node, cnt) =
              case !(#color (#node_info graph node))
                of 0 => cnt
                 | _ => cnt + 1
        fun update (node, info : node_data) = let
              val w = foldl count 0 (#succ graph node)
            in
              (#weight info) := w
            end
      in
        app update (#nodes graph ())
      end

  (* generate_seo : graph -> node_set -> node list
   * Generates the simplicial elimination ordering (seo) of the given
   * interference graph.
   *
   * @param graph   The interference graph to generate the seo for
   * @param set     The set of nodes that have not yet been assigned an order
   * @return        A list of nodes in seo
   *)
  fun generate_seo (G.GRAPH graph) pq =
      if PQ.isEmpty pq then [] else let
        (* get the highest weighted todo node *)
        val max_id = PQ.deleteMin pq
        (* increase the weight of the neighbors *)
        fun incfn node = let val info : node_data = #node_info graph node in
              if !(#in_seo info) then ()
              else
                ((#weight info) := !(#weight info) + 1;
                 PQ.decreaseWeight (pq, node))
            end
        val () = app incfn (#succ graph max_id)
        val () = (#in_seo (#node_info graph max_id : node_data)) := true
      in max_id :: (generate_seo (G.GRAPH graph) pq) end

  (* minNotIn : (int * (int * bool)) -> (int * bool)
   * Used in a foldl across a set of sorted integers to find the smallest
   * integer above 1 that is not in the set.
   *
   * @param n   The next integer in the set
   * @param min The current candidate for the minimum element
   * @param found_hold true if we've found a hole in the list and min is right
   * @return    The next min candidate and whether we know we're right
   *)
  fun minNotIn (n, (min, found_hole)) =
        if found_hole orelse min < n then
          (min, true)
        else if min > n then
          (min, false)
        else
          (min + 1, false)

  (* color : graph -> node list -> unit
   * Colors the given graph according to the provided seo.
   *
   * @param graph     The graph to be colored
   * @param SEO       The seo that should be used
   * @return          A mapping from each node to the color it should be
   *                  assigned
   *
   * @usage coloring should initially be NodeData.empty unless there are
   *        pre-colored nodes. Pre-colored nodes should have their value
   *        inserted into the coloring map already, and those nodes should not
   *        be included in the SEO.
   *)
  fun color _ [] = ()
    | color (G.GRAPH graph) (node::SEO) = let
        (* get the set of neighbors of node n *)
        val nbrs = #succ graph node
        (* map nbrs to the neighbors' color *)
        fun cmapfn n = !(#color (#node_info graph n : node_data))
        val colors = foldl (fn (n, S) =>
                            IntBinarySet.add (S, cmapfn n))
                            IntBinarySet.empty nbrs
        (* find the lowest number > 0 not in the set *)
        val (clr, _) = IntBinarySet.foldl minNotIn (1, false) colors
        val () = (#color (#node_info graph node : node_data)) := clr
      in
        color (G.GRAPH graph) SEO
      end

  (* apply_coloring : instr list -> 'a graph -> instr list
   *
   * @param L     The list of instructions
   * @param graph The coloring information (a map of nodes (temps) to colors
   *              (ints))
   * @return      L, with all temps replaced with their correct registers
   *)
  fun apply_coloring L (G.GRAPH graph) = let
        fun get_color t = #color (
          #node_info graph (HT.lookup (#graph_info graph) t) : node_data
        )
        fun map_op (AS.TEMP t) = ((case !(get_color t)
                                    of 0 => AS.TEMP t
                                     | c => AS.REG (AS.num_reg c))
                                   handle Fail _ => (AS.TEMP t))
          | map_op operand     = operand

        fun map_instr (AS.BINOP (oper, op1, op2)) =
              AS.BINOP (oper, map_op op1, map_op op2)
          | map_instr (AS.MOV (op1, op2)) = AS.MOV (map_op op1, map_op op2)
          | map_instr (AS.MOVFLAG (op1, c)) = AS.MOVFLAG (map_op op1, c)
          | map_instr i = i
      in
        map map_instr L
      end

  (* filter_temps : instr list -> instr list
   * Removes instructions from the instruction list that contain temporary
   * registers. These temps were never assigned registers and thus are not
   * live, so they can be deleted. The only exception is div and mod, which
   * we are required to execute because they might cause an exception.
   *
   * @param L   The list of instructions
   * @return    The original list with dead instructions removed
   *)
  fun filter_temps L = let
        fun isTemp (AS.TEMP _) = true | isTemp _ = false
        fun hasTemps (AS.MOV (o1, o2)) =
              if (isTemp o2) then raise Fail "Live temp not allocated"
              else (isTemp o1)
          | hasTemps (AS.BINOP (oper, o1, o2)) = false
          | hasTemps _ = false
      in
        List.filter (fn i => not (hasTemps i)) L
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
        val live  = P.time ("Liveness", fn () => Liveness.compute L)
        val table = HT.mkTable (Temp.hash, Temp.equals)
                               (List.length L, Fail "temp not found!")
        val graph_rec = UDG.graph ("allocation", table, 10 * (List.length L))
        val G.GRAPH graph = graph_rec
        val () = P.time ("Make graph", fn () => make_graph (live, L) graph_rec)
        val () = P.time ("Update weights", fn () => update_weights graph_rec)

        fun less (n1, n2) = let
              val n1data : node_data = #node_info graph n1
              val n2data : node_data = #node_info graph n2
            in
              !(#weight n1data) > !(#weight n2data)
            end

        val pq = PQ.fromGraph less graph_rec

        val order = P.time ("Generate SEO", fn () => generate_seo graph_rec pq)
        val () = P.time ("Coloring", fn () => color graph_rec order)
        val L' = P.time ("Apply coloring", fn () => apply_coloring L graph_rec)
      in
        (* The result of an unused DIV or MOD operation cannot be elimitated
           by neededness analysis, but it never gets colored, so throw it away
           here *)
        filter_temps L'
      end
end
