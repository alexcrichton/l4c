(* L5 Compiler
 * Control flow graph simplifier - coalesces nodes in the CFG
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure CFGCoalesce :> OPTIMIZATION =
struct

structure G = Graph

fun copy_edge_s (G.GRAPH g) nid (_, dest, data) =
      #add_edge g (nid, dest, data)

fun copy_edge_d (G.GRAPH g) nid (src, _, data) =
      if nid = src then () else #add_edge g (src, nid, data)

(* merge : graph * int -> unit
 *
 * We can merge blocks A and B if A is the only successor of B and B is the
 * only predecessor of A, or if A is empty.
 *)
fun merge (G.GRAPH g, nid) =
    let val succs = #succ g nid in
      if length succs <> 1 then ()
      else let val succ = hd succs in
        if not (length (#pred g succ) = 1 orelse
                length (#node_info g nid) = 0 orelse
                #has_edge g (succ, nid)) then ()
        else (
            (* 1: Copy all edges out of B to A *)
            app (copy_edge_s (G.GRAPH g) nid) (#out_edges g succ);
            (* 2: Copy all edges in to A to B *)
            app (copy_edge_d (G.GRAPH g) nid) (#in_edges g succ);
            (* 3: Append statements in A to B *)
            #add_node g (nid, (#node_info g nid) @ (#node_info g succ));
            (* 4: If A was the entry to the graph, make B the new entry *)
            case #entries g ()
              of [e] => if e <> succ then () else #set_entries g [nid]
               | _   => ();
            (* 5: Delete A *)
            #remove_node g succ;
            (* 6: See if we can coalesce on node A again *)
            merge (G.GRAPH g, nid)
        )
      end
    end

(*fun optimize L = (CFG.app_block merge L; L)*)
fun optimize L = (
      app (fn (_, _, _, g) => merge (g, 0)) L;
(*      app (fn (_, _, _, g) => merge (g, 2)) L;*)
    L)

end
