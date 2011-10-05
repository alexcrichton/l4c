(* L3 Compiler
 * Allocation
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

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
  structure G = Graph
  structure P = Profile
  type node_data = {color:int, weight:int}

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
    | make_graph (set::S, i::L) graph = let
        (* handle pre-coloring *)
        fun precolor [] set = set
          | precolor (c::L) set = let
              val t1 = Temp.new()
              val set' = TempSet.add (set, t1)
              val () = G.setValue graph (t1, {color=c, weight=0})
            in
              precolor L set'
            end
        val set' =
            case i
              of (AS.BINOP ((AS.DIV | AS.MOD), _, _, _)) => precolor [1,4] set
               | (AS.BINOP ((AS.LSH | AS.RSH), _, _, _)) => precolor [3] set
               | _ => set
        (* create part of the graph *)
        val () = G.addClique graph set'
      in
        make_graph (S, L) graph
      end
    | make_graph _ _ = raise AllocationExn ("Instruction list and temp list " ^
                                            "should be the same size")

  (* update_weights : graph -> unit
   * Updates the weights of all nodes in the graph
   *
   * @param graph   The graph
   *)
  fun update_weights graph = let
        fun count (node', cnt) =
              case #color ((G.getValue graph node'):node_data)
                of 0 => cnt
                 | _ => cnt + 1
        fun update node = let
              val {color=c, weight=_} = G.getValue graph node
              val w = TempSet.foldl count 0 (G.getNeighbors graph node)
            in
              G.setValue graph (node, {color=c, weight=w})
            end
      in
        TempSet.app update (G.getNodes graph)
      end

  (* generate_seo : graph -> node_set -> node list
   * Generates the simplicial elimination ordering (seo) of the given
   * interference graph.
   *
   * @param graph   The interference graph to generate the seo for
   * @param set     The set of nodes that have not yet been assigned an order
   * @return        A list of nodes in seo
   *)
  fun generate_seo graph set =
      if TempSet.numItems set = 0 then [] else let
        (* get the highest weighted todo node *)
        val maxfn = fn (n, (n', wt')) => let
                      val wt = #weight (G.getValue graph n)
                    in if wt > wt' then (SOME n, wt) else (n', wt') end
        val max = valOf (#1 (TempSet.foldl maxfn (NONE, ~1) set))
        (* increase the weight of the neighbors *)
        fun incfn node = let
              val {color=c, weight=w} = G.getValue graph node
            in
              G.setValue graph (node, {color=c, weight=w+1})
            end
        val () = TempSet.app incfn (G.getNeighbors graph max)
      in
        max :: (generate_seo graph (TempSet.delete (set, max)))
      end

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
    | color graph (node::SEO) = let
        (* get the set of neighbors of node n *)
        val nbrs = G.getNeighbors graph node
        (* map nbrs to the neighbors' color *)
        fun cmapfn n = #color (G.getValue graph n)
        (*val colors = ListMergeSort.uniqueSort Int.compare
                     (map cmapfn (TempSet.listItems nbrs))*)
        val colors = TempSet.foldl (fn (n, S) => IntBinarySet.add (S, cmapfn n))
                                   IntBinarySet.empty nbrs
        (* find the lowest number > 0 not in the set *)
        val (clr, _) = IntBinarySet.foldl minNotIn (1, false) colors
        (* set the color *)
        val {color=_, weight=w} = G.getValue graph node
        val () = G.setValue graph (node, {color=clr, weight=w})
      in
        color graph SEO
      end

  (* apply_coloring : instr list -> 'a graph -> instr list
   *
   * @param L     The list of instructions
   * @param graph The coloring information (a map of nodes (temps) to colors
   *              (ints))
   * @return      L, with all temps replaced with their correct registers
   *)
  fun apply_coloring L graph = let
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
          (*| map_color 14 = AS.R15D*) (* TODO: use r15d if only 14 regs *)
          | map_color x  = AS.STACK (x - 13)

        fun map_op (AS.TEMP n) = (case #color ((G.getValue graph n):node_data)
                                    of 0 => AS.TEMP n
                                     | c => AS.REG (map_color c))
          | map_op operand     = operand

        fun map_instr (AS.BINOP (oper, op1, op2, op3)) =
              AS.BINOP (oper, map_op op1, map_op op2, map_op op3)
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
        fun isTemp (AS.TEMP _) = true
          | isTemp _           = false
        fun hasTemps (AS.MOV (o1, o2)) =
              if (isTemp o2) then raise AllocationExn "Live temp not allocated"
              else (isTemp o1)
          | hasTemps (AS.BINOP (oper, o1, o2, o3)) =
              if (isTemp o2) orelse (isTemp o3) then
                raise AllocationExn "Live temp not allocated"
              else oper <> AS.DIV andalso oper <> AS.MOD andalso (isTemp o1)
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
        val graph = G.empty {color = 0, weight = 0}
        val () = P.time ("Make graph", fn () => make_graph  (live, L) graph)
        val () = P.time ("Update weights", fn () => update_weights graph)
        val order = P.time ("Generate SEO", fn () => generate_seo graph
                                                     (G.getNodes graph))
        val () = P.time ("Coloring", fn () => color graph order)
        val L' = P.time ("Apply coloring", fn () => apply_coloring L graph)
      in
        P.time ("Filter temps", fn () => filter_temps L')
      end
end
