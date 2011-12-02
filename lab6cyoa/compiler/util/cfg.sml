(* L5 Compiler
 * Control flow graph utility functions
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature CFG =
sig
  val map_stms : (Tree.stm -> Tree.stm) -> Tree.cfg_func list -> unit

  val app_block : (Tree.cfgraph * int -> unit) -> Tree.cfg_func list -> unit

  val rev_postorder : Tree.cfgraph -> (int list * int array)

  val postorder : Tree.cfgraph -> int list

  val dominates : Tree.cfgraph -> (int * int) -> bool
end

structure CFG :> CFG =
struct

  structure G = Graph
  structure A = Array
  structure DA = DynArray

  (* genorder : (foldl | foldr) -> graph -> (int list * int array)
   *
   * Generates the reverse postorder ordering of the nodes of the given graph.
   * This list is used to iterate over the graph in generating dominance
   * frontiers.
   *
   * @return a pair where the first list is the order of nodes in reverse
   *         postorder and the second is an array where each index corresponds
   *         to a node and the value is the position in the reverse postorder
   *)
  fun genorder fold (G.GRAPH g) = let
        val entry = hd (#entries g ())
        val order = A.array (#capacity g (), ~1)
        fun remap (node, ~2) = ()
          | remap (node, number) = A.update (order, number, node)
        val postorder = GraphDFS.postorder_numbering (G.GRAPH g) entry
        val _ = A.appi remap postorder
      in
        (fold (fn (i, L) => if i <> ~1 then i::L else L) [] order, postorder)
      end

  fun rev_postorder g = genorder A.foldl g

  fun postorder g = #1 (genorder A.foldr g)

  (* map_stms (T.stm -> T.stm) -> T.cfg -> unit
   *
   * Applies the given transformation f to every statement in the CFG.
   * The blocks are traversed in reverse postorder ordering.
   *)
  fun map_stms f L = let
        fun mapg (_, _, _, G.GRAPH g) = let
              val order = #1 (rev_postorder (G.GRAPH g))
            in
              app (fn nid => #add_node g (nid, map f (#node_info g nid))) order
            end
      in
        app mapg L
      end

  (* app_block : (('n, 'e, 'g) G.graph * int) -> T.cfg -> unit
   *
   * Applies the given function to each block in each CFG. The blocks are
   * traversed in reverse postorder ordering. The function may modify the
   * graph but it must do so in such a way that the postordering of the
   * graph is not changed. The only exception to this rule is that the
   * function may delete nodes from the graph.
   *)
  fun app_block f (L : Tree.cfg_func list) = let
        fun appg (_, _, _, G.GRAPH g) =
              app (fn nid => if #has_node g nid then f (G.GRAPH g, nid) else ())
                  (#1 (rev_postorder (G.GRAPH g)))
      in
         app appg L
      end

  fun dominates (G.GRAPH g) (id1, id2) =
        if id1 = id2 then true
        else let val idoms = #graph_info g in
          if DA.sub (idoms, id2) = id2 then false
          else dominates (G.GRAPH g) (id2, DA.sub (idoms, id2))
        end

end
