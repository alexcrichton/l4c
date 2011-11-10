(* L5 Compiler
 * Control flow graph utility functions
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature CFG =
sig
  val map_stms : (Tree.stm -> Tree.stm) -> Tree.cfg -> unit

  val rev_postorder : ('n, 'e, 'g) Graph.graph -> (int list * int array)

  val postorder : ('n, 'e, 'g) Graph.graph -> int list
end

structure CFG :> CFG =
struct

  structure G = Graph
  structure A = Array

  (* rev_postorder : graph -> (int list * int array)
   *
   * Generates the reverse postorder ordering of the nodes of the given graph.
   * This list is used to iterate over the graph in generating dominance
   * frontiers.
   *
   * @return a pair where the first list is the order of nodes in reverse
   *         postorder and the second is an array where each index corresponds
   *         to a node and the value is the position in the reverse postorder
   *)
  fun rev_postorder (G.GRAPH g) = let
        val entry = List.hd (#entries g ())
        val order = A.array (#capacity g (), ~1)
        fun remap (node, ~2) = ()
          | remap (node, number) = A.update (order, number, node)
        val postorder = GraphDFS.postorder_numbering (G.GRAPH g) entry
        val _ = A.appi remap postorder
      in
        (A.foldl (fn (i, L) => if i <> ~1 then i::L else L) [] order, postorder)
      end

  fun postorder g = #1 (rev_postorder g)

  fun map_stms f cfg = let
        fun mapg (_, _, _, G.GRAPH g) = let
              val order = postorder (G.GRAPH g)
            in
              app (fn nid => #add_node g (nid, map f (#node_info g nid))) order
            end
      in
        app mapg cfg
      end

end
