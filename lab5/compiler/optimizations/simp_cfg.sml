(* L5 Compiler
 * Control flow graph simplifier - coalesces nodes in the CFG
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure SimpCFG :> OPTIMIZATION =
struct

structure G = Graph
structure A = Array

fun copy_edge_s (G.GRAPH g) nid (_, dest, data) =
      if nid = dest then () else #add_edge g (nid, dest, data)

fun copy_edge_d (G.GRAPH g) nid (src, _, data) =
      if nid = src then () else #add_edge g (src, nid, data)

(* merge : graph * bool array * int -> unit
 * We iterate manually because we're modifying the structure of the graph,
 * so using an iterator from the CFG structure wouldn't work.
 *
 * We can merge blocks A and B if A is the only successor of B and B is the
 * only predecessor of A, or if A is empty.
 *)
fun merge (G.GRAPH g, visited, nid) =
      if A.sub (visited, nid) then ()
      else (
        A.update (visited, nid, true);
        let val succ = #succ g nid in
          if length succ <> 1 then ()
          else (
            if not (length (#pred g (hd succ)) = 1 orelse
                    length (#node_info g nid) = 0) then ()
            else (
              (* 1: Copy all edges out of B to A *)
              app (copy_edge_s (G.GRAPH g) nid) (#out_edges g (hd succ));
              (* 2: Copy all edges in to B to A *)
              app (copy_edge_d (G.GRAPH g) nid) (#in_edges g (hd succ));
              (* 3: Append statements in B to A *)
              #add_node g (nid, (#node_info g nid) @ (#node_info g (hd succ)));
              (* 4: Delete B *)
              #remove_node g (hd succ)
            )
          )
        end;
        (* Iterate over successors *)
        app (fn nid' => merge (G.GRAPH g, visited, nid')) (#succ g nid)
      )

fun optimize_cfg (cfg as (_, _, _, G.GRAPH g)) =
      (merge (G.GRAPH g, A.array (#capacity g (), false),
                 List.hd (#entries g ()));
      cfg)

fun optimize L = map optimize_cfg L

end
