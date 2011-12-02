(* L5 Compiler
 *
 * Phi function simplifier - removes any phi functions which are just a function
 * of a single temp. The phi function is completely removed and all instances
 * of the result of the phi function are also deleted.
 *
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure SimpPhis :> CFG_OPTIMIZATION =
struct

  structure T = Tree
  structure G = Graph
  structure HT = HashTable

  (* remove_phis : graph -> hash_table
   * Removes singleton phi functions from the cfg
   *)
  fun remove_phis (G.GRAPH g) = let
        val table = HT.mkTable (T.tmphash, T.tmpequals)
                               (29, Fail "Remove phis failed")
        fun filter_stm (T.MOVE (T.TEMP (t, _), T.PHI [t'])) =
              (HT.insert table (t, t'); NONE)
          | filter_stm s = SOME s
      in
        #forall_nodes g (fn (nid, stms) =>
                            #add_node g (nid, List.mapPartial filter_stm stms));
        table
      end

  fun map_tmp m t = (case HT.find m t
                       of SOME t' => t'
                        | NONE    => t)

  fun map_exp m (T.TEMP (t, typ)) = T.TEMP (map_tmp m t, typ)
    | map_exp m (T.PHI L) = T.PHI (map (map_tmp m) L)
    | map_exp m (T.BINOP (oper, e1, e2)) =
        T.BINOP (oper, map_exp m e1, map_exp m e2)
    | map_exp m (T.CALL (e, typ, L)) =
        T.CALL (map_exp m e, typ, map (fn (e, typ) => (map_exp m e, typ)) L)
    | map_exp m (T.MEM (e, t)) = T.MEM (map_exp m e, t)
    | map_exp _ e = e

  fun map_stm m (T.MOVE (e1, e2)) = T.MOVE (map_exp m e1, map_exp m e2)
    | map_stm m (T.GOTO (l, SOME e)) = T.GOTO (l, SOME (map_exp m e))
    | map_stm m (T.COND e) = T.COND (map_exp m e)
    | map_stm m (T.RETURN e) = T.RETURN (map_exp m e)
    | map_stm _ s = s

  fun optimize [] = []
    | optimize ((cfg as (_, _, _, g)) :: L) = let
        val mapping = remove_phis g
        val _ = CFG.map_stms (map_stm mapping) [cfg]
      in
        cfg::(optimize L)
      end

end
