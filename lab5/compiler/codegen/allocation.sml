(* L5 Compiler
 * Allocation
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature ALLOCATION =
sig
  val allocate : (Label.label * Assem.instr list) -> Assem.instr list
end

(*
 * The interference graph is represented as a map between nodes and
 * a list of that node's neighbors. Nodes in this case are T.temps.
 * There is also an ('a node_data) type that stores metadata of type 'a
 * about nodes.
 *)
structure Allocation :> ALLOCATION =
struct
  structure AS = Assem
  structure T = Temp
  structure IS = IntBinarySet
  structure G = Graph
  structure UDG = UndirectedHashGraph(DynArray)
  structure P = Profile
  structure HT = HashTable
  structure PQ = NodePriorityQueue(DynArray)
  type node_data = {color:int ref, weight:int ref, in_seo:bool ref}

  (* default : int -> node_data
   *
   * Creates the default data for the given color.
   *)
  fun default clr = {color=ref clr, weight=ref 0, in_seo=ref true}

  (* make_graph : graph -> OperandSet-> unit
   * Converts the liveness information map into an interference graph.
   *
   * @param graph   The current interference graph
   * @param set     The live node set
   * @return        The complete interference graph
   *
   * @usage g should be an empty graph before calling this function
   *)
  fun make_graph (G.GRAPH graph) set = let
        fun add_clique [] = ()
          | add_clique (x::L) = (add_neighbors x L; add_clique L)
        and add_neighbors _ [] = ()
          | add_neighbors x (y::L) =
              (if #has_edge graph (x, y) then () else #add_edge graph (x, y, 0);
               add_neighbors x L)

        fun process_op (AS.IMM _, L) = L
          | process_op (AS.MEM _, _) = raise Fail "mem!"
          | process_op (AS.REG ((AS.STACK _ | AS.STACKARG _ | AS.STACKLOC _
                                            | AS.R11D | AS.R10D), _), L) = L
          | process_op (oper, L) = let
              val clr = case oper of AS.REG (r, _) => AS.reg_num r | _ => ~2
              val id  = case HT.find (#graph_info graph) oper
                          of SOME id => id
                           | NONE => let val nid = #new_id graph () in
                               HT.insert (#graph_info graph) (oper, nid);
                               #add_node graph (nid, default clr);
                               nid
                             end
            in id :: L end
      in add_clique (OperandSet.foldr process_op [] set) end

  (* update_weights : graph -> unit
   * Updates the weights of all nodes in the graph
   *
   * @param graph   The graph
   *)
  fun update_weights (G.GRAPH graph) = let
        fun count (node, cnt) =
              case !(#color (#node_info graph node))
                of ~2 => cnt
                 | _  => cnt + 1
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

  (* color : graph -> node -> unit
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
  fun color (G.GRAPH graph) node = let
        (* get the set of neighbors of node n *)
        val nbrs = #succ graph node
        (* map nbrs to the neighbors' color *)
        fun cmapfn n = !(#color (#node_info graph n : node_data))
        val colors = foldl (fn (n, S) => IS.add (S, cmapfn n)) IS.empty nbrs
        (* find the lowest number > 0 not in the set *)
        val (clr, _) = IS.foldl minNotIn (1, false) colors
      in (#color (#node_info graph node : node_data)) := clr end

  (* apply_coloring : instr list -> 'a graph -> instr list
   *
   * @param L     The list of instructions
   * @param graph The coloring information (a map of nodes (temps) to colors
   *              (ints))
   * @return      L, with all temps replaced with their correct registers
   *)
  fun apply_coloring L (G.GRAPH graph) = let
        fun get_color oper = #color (
          #node_info graph (HT.lookup (#graph_info graph) oper) : node_data
        )
        fun map_op (oper as (AS.TEMP (t, s))) =
              ((case !(get_color oper)
                  of ~2 => oper
                   | c => AS.REG (AS.num_reg c, s))
             handle G.NotFound => oper)
          | map_op (AS.MEM (oper, t)) = AS.MEM (map_op oper, t)
          | map_op oper = oper

        fun map_instr (AS.BINOP (oper, op1, op2)) =
              AS.BINOP (oper, map_op op1, map_op op2)
          | map_instr (AS.MOV (op1, op2)) = AS.MOV (map_op op1, map_op op2)
          | map_instr (AS.MOVFLAG (op1, c)) = AS.MOVFLAG (map_op op1, c)
          | map_instr i = i
      in
        map map_instr L
      end

  (* filter_instrs : instr list -> instr list
   * Removes instructions from the instruction list that contain temporary
   * registers. These temps were never assigned registers and thus are not
   * live, so they can be deleted. The only exception is div and mod, which
   * we are required to execute because they might cause an exception.
   *
   * @param L   The list of instructions
   * @return    The original list with dead instructions removed
   *)
  fun filter_instrs L = let
        fun isTemp (AS.TEMP _) = true | isTemp _ = false
        fun hasTemps (a as AS.MOV (o1, o2)) =
              if (isTemp o2) then raise Fail ("Temp not allocated: " ^
                                              Assem.format_operand o2)
              else (isTemp o1)
          | hasTemps (AS.BINOP (oper, o1, o2)) = false
          | hasTemps _ = false
        fun fltr (AS.MOV (AS.REG r1, AS.REG r2)) = r1 <> r2
          | fltr (AS.MOV (_, AS.MEM _)) = true
          | fltr i = not (hasTemps i)
      in
        List.filter fltr L
      end

  (* coalesce : graph -> instr -> unit
   * Performs register coalescing on the given instruction
   *)
  fun coalesce _ (AS.MOV (_, AS.IMM _)) = ()
    | coalesce g (AS.MOV (d as AS.REG _, s as AS.TEMP _)) =
        coalesce g (AS.MOV (s, d))
    | coalesce (G.GRAPH g) (AS.MOV (d as AS.TEMP _, s as AS.REG (r, _))) = (let
        val table = #graph_info g
        val ids as (did, _) = (HT.lookup table d, HT.lookup table s)
        val _ = if #has_edge g ids then raise G.NotFound else ()
        val color = AS.reg_num r
        fun cmapfn n = !(#color (#node_info g n : node_data)) = color
      in
        if List.exists cmapfn (#succ g did) then () else
          (#color (#node_info g did : node_data) := color)
      end
      handle G.NotFound => ())
    | coalesce (G.GRAPH g) (AS.MOV (d as AS.TEMP _, s as AS.TEMP _)) = (let
        val _ = if AS.oper_equal (d, s) then raise G.NotFound else ()

        val table = #graph_info g
        val ids as (did, sid) = (HT.lookup table d, HT.lookup table s)
        val _ = if #has_edge g ids then raise G.NotFound else ()

        fun cmapfn n = !(#color (#node_info g n : node_data))
        val nbrs' = IS.addList (IS.fromList (#succ g did), #succ g sid)
        val nbrs = IS.map cmapfn nbrs'
        val (clr, _) = IS.foldl minNotIn (1, false) nbrs
        val num_regs = AS.reg_num (AS.STACK 0)
        val _ = if clr >= num_regs then raise G.NotFound else ()
      in
        let
          val new_id = #new_id g ()
          val data : node_data = #node_info g sid
        in
          #color (#node_info g sid : node_data) := clr;
          #remove_node g sid; #remove_node g did; #add_node g (new_id, data);
          HT.appi (fn (oper, nid) =>
                    if nid = sid orelse nid = did then
                      HT.insert table (oper, new_id)
                    else ()) table;
          IS.app (fn n => #add_edge g (n, new_id, 0)) nbrs'
        end
      end
      handle G.NotFound => ())
    | coalesce _ _ = ()

  (* caller_save : ('n, 'e, 'g)  Graph.graph
   *                -> AS.instr * OS.set * AS.instr list
   *                -> AS.instr list
   *
   * Add all of the caller save register operations into the instruction stream.
   * This is meant to be used in a ListPair.foldl or similarly.
   *
   * @param g the interference graph
   * @param c the instruction currently being looked at.
   * @param live the live operands on the current instruction
   * @param L the resulting list of instructions.
   *
   * @return all CALL instructions surrounded with saves/restores of caller
   *         save registers. All saves are ensured they are in the graph as lone
   *         nodes because otherwise callee_regs wouldn't know new registers
   *         were added but need to be saved.
   *)
  fun caller_save (G.GRAPH g) (c as AS.CALL (_, args), live, L) =
      if args < 0 then c :: L else let
        (* Map the live operands to the set of live colors of registers on the
           current line *)
        fun getcolor id = !(#color (#node_info g id : node_data))
        val lookup = getcolor o (HT.lookup (#graph_info g))
        fun add_operand (oper, set) =
              IS.add (set, lookup oper) handle NotFound => set
        val live_clrs = OperandSet.foldl add_operand IS.empty live

        (* precalculate the set of colors for the caller_save registers *)
        val caller_save = foldl (fn (r, s) => IS.add (s, AS.reg_num r))
                                (IS.singleton (AS.reg_num AS.EAX))
                                AS.caller_regs

        (* We need to save all caller-save registers, except for those which
           are parameters to the CALL. The parameters never need to be saved *)
        val to_save = IS.fromList (map AS.reg_num AS.caller_regs)
        fun remove (reg, set) =
              IS.delete (set, AS.reg_num reg) handle NotFound => set
        val to_save = foldl remove to_save (List.tabulate (args, AS.arg_reg))

        (* Generates a save instruction for each register which needs to be
           saved *)
        fun gensave (r, (operands, set)) =
              (* Skip if we don't need to save the register *)
              if not(IS.member (set, r)) then (operands, set)
              else let
                (* The location for this saved register can't been in any other
                   caller save registers, nor the current live colors. *)
                val set' = IS.union (set, IS.delete (caller_save, r))
                val (clr, _) = IS.foldl minNotIn (~1, false) set'
                val dest = AS.REG (AS.num_reg clr, AS.QUAD)
                (* Make sure to add this register to the graph so callee_regs
                   knows that we need to save this color if it happens to be
                   a callee-save register *)
                val id = #new_id g ()
                val _ = #add_node g (id, default clr)
              in
                ((dest, AS.REG (AS.num_reg r, AS.QUAD))::operands,
                 IS.add (set, clr))
              end
        val (operands, _) = IS.foldl gensave ([], live_clrs) to_save
        val saves    = map (fn t => AS.MOV t) operands
        val restores = map (fn (a, b) => AS.MOV (b, a)) operands
      in
        saves @ [c] @ restores @ L
      end
    | caller_save _ (instr, _, L) = instr::L

  (* callee_save : ('n, 'e, 'g)  Graph.graph -> AS.instr list -> AS.instr list
   *
   * Add all of the callee save register operations into the instruction stream.
   *
   * @param g the interference graph
   * @param L the current list of instructions
   *
   * @return the same instruction list, except that callee-save registers are
   *         preserved across the function. The graph must contain all registers
   *         currently in use by the function
   *)
  fun callee_save (G.GRAPH g) L = let
        val callee_save = foldl (fn (r, s) => IS.add (s, AS.reg_num r)) IS.empty
                                AS.callee_regs
        val caller_save = foldl (fn (r, s) => IS.add (s, AS.reg_num r)) IS.empty
                                AS.caller_regs
        fun add_node ((_, data : node_data), clrs) =
              IS.add (clrs, !(#color data))
        (* Callee-save registers cannot be saved in any used register, nor any
           caller-save register. That would just be silly. *)
        val live_clrs = foldl add_node IS.empty (#nodes g ())
        val live_clrs = IS.union (live_clrs, caller_save)

        (* Similar to caller_save, generates the save operands to save *)
        fun gensave (r, (operands, set)) =
              if not(IS.member (set, AS.reg_num r)) then (operands, set)
              else let
                val set' = IS.union (set, IS.delete (callee_save, AS.reg_num r))
                val (clr, _) = IS.foldl minNotIn (~1, false) set'
                val dest = AS.REG (AS.num_reg clr, AS.QUAD)
              in ((dest, AS.REG (r, AS.QUAD))::operands, IS.add (set, clr)) end

        val (operands, _) = foldl gensave ([], live_clrs) AS.callee_regs
        val saves    = map (fn t => AS.MOV t) operands
        val restores = map (fn (a, b) => AS.MOV (b, a)) operands
        fun alter_ret (AS.RET, L) = restores @ (AS.RET :: L)
          | alter_ret (i, L) = i::L
      in
        saves @ foldr alter_ret [] L
      end

  (* allocate : instr list -> int * instr list
   * Returns the given instruction list with all temps and variables assigned
   * to specific registers or stack locations. This function will perform the
   * liveness analysis and register allocation.
   *
   * @param L   The list of instructions with temps
   * @return    A pair of the number of used registers and the original list of
   *            instructions with all temps replaced with registers or stack
   *            locations
   *)
  fun allocate (f, L) = let
        val live  = P.time ("Liveness", fn () => Liveness.compute L)
        val table = HT.mkTable (AS.oper_hash, AS.oper_equal)
                               (length L, G.NotFound)
        val graph_rec = UDG.graph ("allocation", table, List.length L)
        val G.GRAPH graph = graph_rec
        val _ = P.time ("Make graph", fn () => app (make_graph graph_rec) live)
        val _ = P.time ("Update weights", fn () => update_weights graph_rec)

        fun less (n1, n2) = let
              val n1data : node_data = #node_info graph n1
              val n2data : node_data = #node_info graph n2
            in
              !(#weight n1data) > !(#weight n2data)
            end

        val pq = PQ.create (#size graph ()) less
        val _ = P.time ("Create PQ", fn () =>
                  #forall_nodes graph (fn (nid, data) =>
                    if !(#color data) = ~2 then PQ.insert (pq, nid)
                    else (#in_seo data) := true))

        val order = P.time ("Generate SEO", fn () => generate_seo graph_rec pq)
        val _ = P.time ("Coloring", fn () => app (color graph_rec) order)
        val _ = if not (Options.opt_on 1) then ()
                else P.time ("Coalescing", fn () => app (coalesce graph_rec) L)

        (* Adhere to callee/caller register saving conventions *)
        val L = P.time ("Caller/callee", fn () => let
                    val L = ListPair.foldr (caller_save graph_rec) [] (L, live)
                    val L' = callee_save graph_rec L
                  in L' end)

        val L' = P.time ("Apply coloring", fn () => apply_coloring L graph_rec)

        (* DOT - file formatters *)
        fun format_node (id, data : node_data) = let
              val opers = HT.foldi (fn (oper, id', L) =>
                                      if id = id' then oper::L else L)
                                   [] (#graph_info graph)
              val color = !(#color data)
              val operstr = foldl (op ^) "" (map Assem.format_operand opers)
            in
              "label=\"" ^ operstr ^ "\", style=filled, fillcolor=" ^
                Int.toString id ^ ", colorscheme=paired12"
            end
        fun format_edge _ = "arrowhead=\"none\""

        val _ = Flag.guard Options.flag_dotalloc Dotfile.mkdot
                           (Options.filename () ^ "." ^ Label.name f,
                            format_node, format_edge, graph_rec)
      in
        (* The result of an unused DIV or MOD operation cannot be elimitated
           by neededness analysis, but it never gets colored, so throw it away
           here *)
        filter_instrs L'
      end
end
