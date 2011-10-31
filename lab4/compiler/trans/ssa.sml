signature SSA =
sig
  val idoms : ('n, 'e, 'g) Graph.graph -> int array
  val dom_frontiers : ('n, 'e, 'g) Graph.graph -> IntBinarySet.set array
  val idf : IntBinarySet.set array -> IntBinarySet.set -> IntBinarySet.set
end

structure SSA :> SSA =
struct

  structure G = Graph
  structure A = Array
  structure S = IntBinarySet
  structure L = List

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
        val entry = List.nth (#entries g (), 0)
        val size = #size g ()
        val order = A.array (size, ~1)
        val _ = A.appi (fn (node, number) => A.update (order, size - 1 - number,
                                                       node))
                       (GraphDFS.postorder_numbering (G.GRAPH g) entry)
        val doms = A.array (size, ~1)

        fun intersect (b1, b2) = if b1 = b2 then b1 else let
              fun find (finger, other) = if finger >= other then finger
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

        fun update_node b = let
              val new_idom = ref ~1
              fun update_pred p = if A.sub(doms, p) = ~1 then ()
                                  else if (!new_idom) = ~1 then new_idom := p
                                  else new_idom := intersect (p, !new_idom)
            in
              app update_pred (#pred g b);
              if A.sub(doms, b) = (!new_idom) then false
              else (A.update (doms, b, !new_idom); true)
            end

        fun change () = let
              fun modify (id, changed) = update_node id orelse changed
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
        val nodes = S.fromList (L.map #1 (#nodes g ()))
        val idom = idoms (G.GRAPH g)
        val df's = A.array (#order g (), S.empty)

        (* Returns true if a isn't the immediate dominator of b *)
        fun not_idom a b = (A.sub (idom, b) <> a)

        fun df_local a = S.fromList (L.filter (not_idom a) (#succ g a))
        fun df_up (a, c) = if not_idom a c then S.empty else
                            S.filter (not_idom a) (A.sub (df's, c))

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
end
