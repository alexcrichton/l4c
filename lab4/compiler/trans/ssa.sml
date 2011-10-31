signature SSA_ =
sig
  val idoms : ('n, 'e, 'g) Graph.graph -> int array
  val dom_frontiers : ('n, 'e, 'g) Graph.graph -> IntBinarySet.set array
end

structure SSA :> SSA_ =
struct

  structure G = Graph
  structure A = Array

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
end
