signature SSA =
sig
  val idoms : ('n, 'e, 'g) Graph.graph -> int array
  val dom_frontiers : ('n, 'e, 'g) Graph.graph -> IntBinarySet.set array
  val idf : IntBinarySet.set array -> IntBinarySet.set -> IntBinarySet.set
  val ssa : Tree.program -> unit
end

structure SSA :> SSA =
struct

  open Debug

  structure G = Graph
  structure A = Array
  structure S = IntBinarySet
  structure L = List
  structure T = Tree
  structure HT = HashTable
  structure TM = BinaryMapFn(Temp)

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
        val size = #capacity g ()
        val order = A.array (size, ~1)
        fun remap (node, ~2) = ()
          | remap (node, number) = A.update (order, number, node)
        val postorder = GraphDFS.postorder_numbering (G.GRAPH g) entry
        val _ = A.appi remap postorder
        val doms = A.array (size, ~1)
        val _ = gverbose (fn () => dump_arr Int.toString order)

        fun compare (n1, n2) = Int.compare (A.sub (postorder, n1),
                                            A.sub(postorder, n2))

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
              val changed = A.foldr modify false order
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

  fun dom_frontiers (G.GRAPH g) = let
        val _ = debug "dom_frontiers"
        val nodes = S.fromList (map #1 (#nodes g ()))
        val idom = idoms (G.GRAPH g)

        val _ = gverbose (fn () => dump_arri Int.toString idom)
        val df's = A.array (#capacity g (), S.empty)

        (* Returns true if a isn't the immediate dominator of b *)
        fun not_idom a b = (A.sub (idom, b) <> a)

        fun df_local a = S.fromList (L.filter (not_idom a) (#succ g a))
        fun df_up (a, c) = if not_idom a c then S.empty
                           else S.filter (not_idom a) (A.sub (df's, c))

        (* This is quadratic - it shouldn't be   FIXME, TODO, XXX *)
        fun df (a, _) = let
              fun union (c, set) = if not_idom a c then set
                                   else S.union (set, df_up (a, c))
            in
              A.update (df's, a, S.foldl union (df_local a) nodes)
            end
      in
        #forall_nodes g df; df's
      end

  fun ssa P = let
        fun gssa (G.GRAPH g) = let
              (* Calculate where temps are defined *)
              val _ = verbose "processing stms..."
              val entry = List.hd (#entries g ())
              val defs = HT.mkTable (Temp.hash, Temp.equals)
                                    (100, Fail "Temp not found")
              fun process_stms id (T.MOVE (T.TEMP (t, _, _), _)) = let
                    val set = case HT.find defs t
                                of SOME s => s
                                 | NONE   => S.singleton entry
                    val _ = gverbose (fn () => Temp.name t ^ " => " ^
                                               dump_is set ^ " + " ^
                                               Int.toString id)
                  in HT.insert defs (t, S.add (set, id)) end
                | process_stms _ _ = ()
              val _ = #forall_nodes g
                        (fn (id, stms) => app (process_stms id) stms)

              (* Calculate where we need phi functions *)
              val _ = verbose "processing defs..."
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
              val _ = HT.appi process_defs defs

              (* Place the phi functions *)
              val _ = verbose "processing nodes..."
              fun process_node (id, stms) = let
                    val p = case HT.find phis id
                              of SOME s => s
                               | NONE   => TempSet.empty
                    fun create_phi (temp, L) =
                          (T.MOVE (T.TEMP (temp, ref ~1, T.QUAD), T.PHI []))::L
                  in
                    #add_node g (id, TempSet.foldl create_phi stms p)
                  end
              val _ = #forall_nodes g process_node

              (* Number the temps *)
              val tvals = HT.mkTable (Temp.hash, Temp.equals)
                                     (97, Fail "Temp not found!")
              val visited = A.array (#capacity g (), false)
              fun visit_node (nid, map) = let
                    fun process_exp (T.TEMP (t, n, _), map) =
                          n := valOf (TM.find (map, t))
                      | process_exp (T.BINOP (_, e1, e2), map) =
                          (process_exp (e1, map); process_exp (e2, map))
                      | process_exp (T.CALL (_, _, L), map) =
                          app (fn (e, _) => process_exp (e, map)) L
                      | process_exp (T.MEM (e, _), map) = process_exp (e, map)
                      | process_exp _ = () (* PHI and CONST *)

                    fun process_stm ((T.RETURN e | T.COND e |
                                      T.GOTO (_, SOME e)), map) =
                          (process_exp (e, map); map)
                      | process_stm (T.MOVE (e1, e2), map) = let
                          val _ = process_exp (e2, map)
                          val map' = case e1
                                       of T.TEMP (t, n, _) => update (t, n, map)
                                        | e => (process_exp (e, map); map)
                        in
                        end
                      | process_stm (_, map) = map (* GOTO NONE, LABEL *)

                    val _ = A.update (visited, nid, true)
                    val stms = #node_info g nid
                  in
                  end
              val _ = visit_node (entry, TM.empty)
            in
              ()
            end
      in
        app (fn (id, _, _, cfg) => (debug ("\n" ^ Label.name id); gssa cfg)) P
      end
end
