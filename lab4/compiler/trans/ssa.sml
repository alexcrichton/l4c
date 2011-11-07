signature SSA =
sig
  val ssa : Tree.cfg -> unit
  val dessa : Tree.cfg -> Tree.program
end

structure SSA :> SSA =
struct

  open Debug

  structure G = Graph
  structure A = Array
  structure S = IntBinarySet
  structure L = List
  structure T = Tree
  structure P = Profile
  structure HT = HashTable
  structure TM = BinaryMapFn(Temp)

  (* genorder : graph -> (int list * int array)
   *
   * Generates the reverse postorder ordering of the nodes of the given graph.
   * This list is used to iterate over the graph in generating dominance
   * frontiers.
   *
   * @return a pair where the first list is the order of nodes in reverse
   *         postorder and the second is an array where each index corresponds
   *         to a node and the value is the position in the reverse postorder
   *)
  fun genorder (G.GRAPH g) = let
        val entry = List.hd (#entries g ())
        val order = A.array (#capacity g (), ~1)
        fun remap (node, ~2) = ()
          | remap (node, number) = A.update (order, number, node)
        val postorder = GraphDFS.postorder_numbering (G.GRAPH g) entry
        val _ = A.appi remap postorder
      in
        (A.foldl (fn (i, L) => if i <> ~1 then i::L else L) [] order, postorder)
      end

  (* idoms : ('n, 'e, 'g) Graph.graph -> int array
   *
   * Calculates the immediate dominators for every node in the given graph. This
   * algorithm is the one explained at the link below. The paper describing
   * this method is titled  "A Simple, Fast Dominance Algorithm"
   *
   * @param g the graph to calculate the idom array for
   * @return an array of dominators where the index of the array corresponds to
   *         the node ID number, and the value of the array corresponds to the
   *         node which is the immediate dominator of this node.
   *
   * @see http://www.cs.rice.edu/~keith/EMBED/dom.pdf
   *)
  fun idoms (G.GRAPH g) = let
        val _ = debug "idoms"
        val entry = List.hd (#entries g ())
        val (order, postorder) = genorder (G.GRAPH g)
        val doms = A.array (#capacity g (), ~1)
        val _ = gverbose (fn () => dump_list Int.toString order)

        fun compare (n1, n2) = Int.compare (A.sub (postorder, n1),
                                            A.sub (postorder, n2))

        fun intersect (b1, b2) = if compare (b1, b2) = EQUAL then b1 else let
              fun find (finger, other) = if compare (finger, other) <> LESS then
                                           finger
                                         else let
                                           val finger' = A.sub (doms, finger)
                                         in
                                           if finger' = ~1 then
                                             raise Fail "invariant bad!"
                                           else find (finger', other)
                                         end
              val b1' = find (b1, b2)
              val b2' = find (b2, b1')
            in intersect (b1', b2') end

        fun update_node ~1 = false
          | update_node b = let
              val _ = verbose ("idoms: updating - " ^ Int.toString b)
              val new_idom = ref ~1
              fun update_pred p = if A.sub(doms, p) = ~1 then ()
                                  else if (!new_idom) = ~1 then new_idom := p
                                  else new_idom := intersect (p, !new_idom)
            in
              app update_pred (#pred g b);
              if !new_idom = ~1 then raise Fail "negative one!" else ();
              if A.sub(doms, b) = (!new_idom) then false
              else (A.update (doms, b, !new_idom); true)
            end

        fun change () = let
              val _ = verbose "idoms: changing"
              fun modify (id, changed) = if id = entry then changed
                                         else update_node id orelse changed
              (* Iterate in reverse postorder *)
              val changed = foldl modify false order
            in
              if changed then change () else ()
            end
      in
        A.update (doms, entry, entry); change (); doms
      end

  (* idf : IntBinarySet.set array -> IntBinarySet.set -> IntBinarySet.set
   *
   * Calculates the iterated dominance frontier of a set.
   *
   * @param doms the dominance frontier of each node in the graph
   * @param set  the initial set of nodes in question. The iterated dominance
   *             frontier will be calculated over these elements.
   * @return The dominance frontier of a set. If the set is the set of all nodes
   *         where a variable is defined, then the returned set is the set of
   *         all nodes which need a phi function for this variable.
   *)
  fun idf doms set = let
        val df = ref set

        fun calculate () = let
              val set' = S.union (set, !df)
              fun union_dfs (node, df) = S.union (df, A.sub (doms, node))
              val set'' = S.foldl union_dfs S.empty set'
              val changed = not (S.equal (!df, set''))
            in
              df := set''; if changed then calculate () else ()
            end
      in
        calculate (); !df
      end

  (* dom_frontiers : graph -> S.set array
   *
   * Calculates the dominance frontier for all nodes in the given graph.
   * @return an array where each index corresponds to the same numbered node
   *         in the graph and the value is the set of all nodes which is
   *         considered the dominance frontier of the node in the graph.
   *)
  fun dom_frontiers (G.GRAPH g) = let
        val _ = debug "dom_frontiers"
        val nodes = S.fromList (map #1 (#nodes g ()))
        val idom = idoms (G.GRAPH g)

        val _ = gverbose (fn () => dump_arri Int.toString idom)
        val df's = A.array (#capacity g (), S.empty)
        val (order, _) = genorder (G.GRAPH g)
        val order = rev order

        (* Returns true if a isn't the immediate dominator of b *)
        fun not_idom a b = (A.sub (idom, b) <> a)

        fun df_local a = S.fromList (L.filter (not_idom a) (#succ g a))
        fun df_up (a, c) = if not_idom a c then S.empty
                           else S.filter (not_idom a) (A.sub (df's, c))

        (* This is quadratic - it shouldn't be   FIXME, TODO, XXX *)
        fun df a = let
              fun union (c, set) = if not_idom a c then set
                                   else S.union (set, df_up (a, c))
            in
              A.update (df's, a, S.foldl union (df_local a) nodes)
            end
      in
        app df order; df's
      end

  (* find_defs : graph -> (Temp, S.set) HT.table * (Temp, T.typ) HT.table
   *
   * Finds all locations in which temps are defined in the graph.
   * @return a table where keys are temps and the value are the set of locations
   *         where this temp is defined. Each location is defined by it's ID
   *         in the graph.
   *)
  fun find_defs (G.GRAPH g) = let
        val _ = verbose "processing stms..."
        val entry = List.hd (#entries g ())
        val defs = HT.mkTable (Temp.hash, Temp.equals)
                              (100, Fail "Temp not found")
        fun process_stms id (T.MOVE (T.TEMP ((t, _), typ), _)) = let
              val set = case HT.find defs t
                          of SOME s => s
                           | NONE   => S.singleton entry
              val _ = gverbose (fn () => Temp.name t ^ " => " ^
                                         dump_is set ^ " + " ^
                                         Int.toString id)
            in HT.insert defs (t, S.add (set, id)) end
          | process_stms _ _ = ()
      in
        #forall_nodes g (fn (id, stms) => app (process_stms id) stms);
        defs
      end

  (* find_phis : graph * (Temp, S.set) HT.table -> (int, TS.set) HT.table
   *
   * Finds where all phi functions should go in the given graph.
   * @param g the graph
   * @param defs a table of temps to a set of locations where this temp is
   *        defined. See #find_defs
   * @return a table where each key is a node ID and the value is a set of
   *         temps which need phi functions at this node.
   *)
  fun find_phis (G.GRAPH g, defs) = let
        val df's = dom_frontiers (G.GRAPH g)
        val phis = HT.mkTable (Word.fromInt, op =)
                              (97, Fail "Node not found")
        fun process_defs (temp, nodes) = let
              val tphis = idf df's nodes
              fun process_phis nid = let
                    val set = case HT.find phis nid
                                of SOME s => s
                                 | NONE   => TempSet.empty
                  in
                    HT.insert phis (nid, TempSet.add (set, temp))
                  end
            in
              S.app process_phis tphis
            end
      in
        HT.appi process_defs defs; phis
      end

  (* place_phis : graph * (int, TS.set) HT.table -> unit
   *
   * Places all phi functions into the graph.
   * @param g the graph
   * @param phis a table of node ids to sets of temps where each set of temps
   *        corresponds to the set of temps which need phi functions at
   *        the node.
   * @note the phi functions don't have any value after this, they're all empty
   *       and need to be filled in later.
   *)
  fun place_phis (G.GRAPH g, phis) = let
        fun process_node (id, stms) = let
              val p = case HT.find phis id
                        of SOME s => s
                         | NONE   => TempSet.empty
              fun create_phi (temp, L) =
                    (T.MOVE (T.TEMP ((temp, ref ~1), T.QUAD), T.PHI []))::L
            in
              #add_node g (id, TempSet.foldl create_phi stms p)
            end
      in
        #forall_nodes g process_node
      end

  (* number_temps : graph * (Temp.temp * typ) list -> int TM.map array
   *
   * Walks through the graph, numbering all temps with their correct SSA values.
   *
   * @param g the graph
   * @param args the arguments to the function that this graph represents. These
   *        are needed to create the initial set of temp numberings
   * @return an array where each index corresponds to a graph node and the value
   *         is the set of known numbers for variables when exiting that node
   *)
  fun number_temps (G.GRAPH g, args) = let
        val tvals = HT.mkTable (Temp.hash, Temp.equals)
                               (97, Fail "Temp not found!")
        val visited = A.array (#capacity g (), false)
        val vmaps   = A.array (#capacity g (), TM.empty)

        fun visit_node (nid, map) = let
              (* Update a temp's global next number in the hash table,
                 returning the modified set and the new number *)
              fun update (t, n, map) = let
                    val num = case HT.find tvals t
                                of SOME n => n
                                 | NONE   => 0
                  in
                    HT.insert tvals (t, num + 1); n := num;
                    TM.insert (map, t, num)
                  end

              (* Process an expression, updating all temps to have value
                 numbers *)
              fun process_exp (T.TEMP ((t, n), _), map) =
                    (n := valOf (TM.find (map, t)))
                | process_exp (T.BINOP (_, e1, e2), map) =
                    (process_exp (e1, map); process_exp (e2, map))
                | process_exp (T.CALL (_, _, L), m) =
                    app (fn (e, _) => process_exp (e, m)) L
                | process_exp (T.MEM (e, _), map) = process_exp (e, map)
                | process_exp _ = () (* PHI and CONST *)

              (* Process a statement, possibly altering the table of
                 currently defined variables, and also altering the
                 instruction to have temps numbered correctly. *)
              fun process_stm ((T.GOTO (_, SOME e) | T.RETURN e |
                                T.COND e), map) =
                    (process_exp (e, map); map)
                | process_stm (T.MOVE (e1, e2), map) =
                   (process_exp (e2, map);
                    case e1
                      of T.TEMP ((t, n), _) => update (t, n, map)
                       | e => (process_exp (e, map); map))
                | process_stm (_, map) = map

              val stms = #node_info g nid
            in
              (* If we've already visited this node, then there is
                 nothing to do, otherwise we should process all
                 statements, mark ourselves as visited, and then visit
                 all of our successors with our resulting map of
                 variables *)
              if A.sub (visited, nid) then ()
              else let
                val map' = foldl process_stm map stms
              in
                A.update (visited, nid, true);
                A.update (vmaps, nid, map');
                app (fn id => visit_node (id, map')) (#succ g nid)
              end
            end

        (* The initial set has all arguments with number 0 *)
        val initial = foldl (fn ((t, _), s) => (HT.insert tvals (t, 1);
                                                TM.insert (s, t, 0)))
                            TM.empty args
      in
        visit_node (List.hd (#entries g ()), initial); vmaps
      end

  (* fix_phis : graph * int TM.map array -> unit
   *
   * Fixes all PHI functions in the graph to be a PHI of the correct set of
   * arguments.
   *)
  fun fix_phis (G.GRAPH g, vmaps) = let
        fun update_phi preds (T.MOVE (tmp as T.TEMP ((t, _), s), T.PHI _)) = let
              fun getnum pred = valOf (TM.find (A.sub (vmaps, pred), t))
              val nums = foldl (fn (pred, s) => (S.add (s, getnum pred)
                                                 handle Option => s))
                               S.empty preds
            in
              T.MOVE (tmp, T.PHI (map (fn n => (t, ref n)) (S.listItems nums)))
            end
          | update_phi _ stm = stm
        fun fix_node (node, stms) = let
              val stms' = map (update_phi (#pred g node)) stms
            in #add_node g (node, stms') end
      in #forall_nodes g fix_node end

  (* ssa_graph : graph * (Temp.temp * int) list -> unit
   *
   * Helper function to transform the given graph into SSA form. The argument
   * list is used for value numbering of all temps in the graph.
   *)
  fun ssa_graph (grec, args) = let
        val G.GRAPH g = grec
        val defs  = P.time ("Finding definitions", fn () => find_defs grec)
        val phis  = P.time ("Finding phis", fn () => find_phis (grec, defs))
        val _     = P.time ("Placing phis", fn () => place_phis (grec, phis))
        val vmaps = P.time ("Numbering temps", fn () =>
                                                    number_temps (grec, args))
        val _     = P.time ("Fixing phis", fn () => fix_phis (grec, vmaps))
      in () end

  (* ssa : Tree.cfg -> unit
   *
   * Transform the given control flow graph into SSA form, modifying the graph
   * in place
   * @param P the CFG to modify
   *)
  fun ssa P = app (fn (id, _, args, cfg) => (debug ("\n" ^ Label.name id);
                                             ssa_graph (cfg, args))) P

  (* build_temp_maps : graph * (Temp.temp * T.typ) -> (int * T.typ) TM.map array
   *
   * Builds an array of temp maps. For the returned array, each index
   * corresponds to the id of a node, and the value is a mapping of temps to
   * numbers. These maps symbolize the currently known number of temps at the
   * exit from this node.
   *)
  fun build_temp_maps (G.GRAPH g, args) = let
        val arr = A.array (#capacity g (), TM.empty)
        val visited = A.array (#capacity g (), false)

        fun update_map (T.MOVE (T.TEMP ((t, ref n), typ), _), m) =
              TM.insert (m, t, (n, typ))
          | update_map (_, m) = m

        fun visit_node m id = if A.sub (visited, id) then () else let
              val stms = #node_info g id
              val m' = foldl update_map m stms
            in
              A.update (visited, id, true);
              A.update (arr, id, m');
              app (visit_node m') (#succ g id)
            end

        val initial = foldl (fn ((t, typ), s) => TM.insert (s, t, (0, typ)))
                            TM.empty args
      in visit_node initial (List.hd (#entries g ())); arr end

  (* remove_phis : graph -> Graph.node_id * T.stm list -> unit
   *
   * Removes all phi functions from the graph by inserting basic blocks along
   * each incoming edge.
   *)
  fun remove_phis (G.GRAPH g, vmaps) (nid, stms) = let
        val preds = #pred g nid
        val pred_stms = HT.mkTable (Word.fromInt, op =)
                                   (length preds, Subscript)

        fun getphi (T.MOVE (T.TEMP (t, _), T.PHI _)) = SOME t
          | getphi _ = NONE

        fun process_phi (phi as (tmp, n)) = let
              fun add_moves id = let
                    val set = A.sub (vmaps, id)
                    val L = case TM.find (set, tmp)
                              of SOME (m, typ) => if !n = m then [] else
                                  [T.MOVE (T.TEMP (phi, typ),
                                   T.TEMP ((tmp, ref m), typ))]
                               | NONE   => []
                    val LP = case HT.find pred_stms id
                               of SOME p => p
                                | NONE => []
                  in HT.insert pred_stms (id, LP @ L) end
            in app add_moves preds end

        fun modify_cfg (id, _, typ) = let
              val L = HT.lookup pred_stms id
              val _ = G.remove_edge (G.GRAPH g) (id, nid)
              val new_id = #new_id g ()
            in
              #add_node g (new_id, L);
              #add_edge g (id, new_id, typ);
              #add_edge g (new_id, nid, T.ALWAYS)
            end handle Subscript => ()

        val phis = List.mapPartial getphi stms
        val _ = app process_phi phis
        val _ = #add_node g (nid, List.drop (stms, length phis))
      in app modify_cfg (#in_edges g nid) end

  (* flatten : graph -> T.stm list
   *
   * Flattens the given graph into a statement list.
   *)
  fun flatten (G.GRAPH g) = let
        fun label id = Label.literal (#name g ^ "_" ^ Int.toString id)
        fun extract_cond L = case List.nth (L, length L - 1)
                               of T.COND e => (e, List.take (L, length L -1))
                                | _ => raise Fail "End of cond block not a cond"

        val entry = List.hd (#entries g ())
        val visited = A.array (#capacity g (), false)
        val skipped = ref [] (* node_ids skipped by BRANCH edges *)

        fun dfs nid = if A.sub (visited, nid) then [T.GOTO (label nid, NONE)]
                      else let
              val _ = A.update (visited, nid, true)
              val L = (T.LABEL (label nid))::(#node_info g nid)
            in
              case #out_edges g nid
                of [] => L
                 | [(_, id, T.ALWAYS)] => L @ (dfs id)
                 | [(_, id, T.BRANCH)] => (skipped := id::(!skipped);
                                           L @ [T.GOTO (label id, NONE)])
                 | ([(_, tid, T.TRUE), (_, fid, T.FALSE)] |
                    [(_, fid, T.FALSE), (_, tid, T.TRUE)]) => let
                      val (e, L') = extract_cond L
                      val e' = T.BINOP (T.XOR,
                                        T.CONST (Word32.fromInt 1, T.WORD), e)
                      val L'' = L' @ [T.GOTO (label fid, SOME e')]
                    in
                      L'' @ dfs tid @ dfs fid
                    end
                 | _ => raise Fail "Invalid graph successors"
            end
        val folded = dfs entry
      in foldl (fn (nid, L) => L @ (dfs nid)) folded (!skipped) end

  (* dessa : Tree.cfg -> Tree.program
   *
   * Takes an SSA-form CFG and converts it into lists of instructions for
   * each function.
   * @param cfg the program of cfgs to convert
   * @return the program with each cfg flattened into a list
   *)
  fun dessa [] = []
    | dessa ((id, typ, args, cfg)::L) = let
        val G.GRAPH g = cfg
        val vmaps = P.time ("Building maps...",
                            fn () => build_temp_maps (cfg, args))
        val _ = P.time ("Removing PHI",
                            fn () => #forall_nodes g (remove_phis (cfg, vmaps)))
      in
        (id, typ, args, flatten cfg) :: (dessa L)
      end
end
