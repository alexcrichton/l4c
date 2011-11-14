(* L5 Compiler
 *
 * Control flow graph simplifier - prunes dead code from the CFG
 *
 * Removes all basic blocks which can never be reached as a result of normal
 * control flow, and also evaluates constant branches to prune one half of the
 * branch.
 *
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure CFGPrune :> OPTIMIZATION =
struct

structure G = Graph
structure L = List
structure T = Tree

fun remove (G.GRAPH g, nid, stms, branch) = let
      fun map_edge_typ T.TRUE  = true
        | map_edge_typ T.FALSE = false
        | map_edge_typ _ = raise Fail "Invalid edge type"

      fun modify_edge (src, dst, typ) =
          (Graph.remove_edge (G.GRAPH g) (src, dst);
          if branch <> map_edge_typ typ then ()
          else #add_edge g (src, dst, T.ALWAYS))

      val new_stms = List.take (stms, length stms - 1)
    in
      (* remove / update the edges *)
      app modify_edge (#out_edges g nid);
      (* remove the cond statement *)
      #add_node g (nid, new_stms)
    end

fun prune (G.GRAPH g, nid) =
    let val stms = #node_info g nid in
      if length stms = 0 then ()
      else let val last = L.last stms in
        case last
          of (T.COND (T.CONST (c, _))) =>
              (* We can prune one of the branches *)
              remove (G.GRAPH g, nid, stms, c = Word32.fromInt 1)
           | _ => ()
      end
    end

fun delete (G.GRAPH g) (nid, _) =
    if not (#has_node g nid) then () else let
      val (ins, outs) = (#in_edges g nid, #out_edges g nid)
      val root = hd (#entries g ())
    in
      if length ins <> 0 orelse nid = root then ()
      else (
        #remove_node g nid;
        app (delete (G.GRAPH g)) (map (fn e => (#2 e, [])) outs)
      )
    end

fun optimize L = (
      CFG.app_block prune L;
      app (fn (_, _, _, G.GRAPH g) => #forall_nodes g (delete (G.GRAPH g))) L;
      L
    )

end
