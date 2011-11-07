(* L5 Compiler
 * Phi function simplifier - removes any phi functions with a single node
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure SimpPhis :> OPTIMIZATION =
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

fun remap (G.GRAPH g) mapping = let
      fun map_tmp t = (case HT.find mapping t
                         of SOME t' => t'
                          | NONE    => t)

      fun map_exp (T.TEMP (t, typ)) = T.TEMP (map_tmp t, typ)
        | map_exp (T.PHI L) = T.PHI (map map_tmp L)
        | map_exp (T.BINOP (oper, e1, e2)) =
            T.BINOP (oper, map_exp e1, map_exp e2)
        | map_exp (T.CALL (l, typ, L)) =
            T.CALL (l, typ, map (fn (e, typ) => (map_exp e, typ)) L)
        | map_exp (T.MEM (e, t)) = T.MEM (map_exp e, t)
        | map_exp e = e

      fun map_stm (T.MOVE (e1, e2)) = T.MOVE (map_exp e1, map_exp e2)
        | map_stm (T.GOTO (l, SOME e)) = T.GOTO (l, SOME (map_exp e))
        | map_stm (T.COND e) = T.COND (map_exp e)
        | map_stm (T.RETURN e) = T.RETURN (map_exp e)
        | map_stm s = s
    in
      #forall_nodes g (fn (nid, stms) =>
                            #add_node g (nid, map map_stm stms));
      G.GRAPH g
    end

fun optimize [] = []
  | optimize ((lbl, typ, args, g)::L) = let
      val mapping = remove_phis g
    in
      (lbl, typ, args, remap g mapping)::(optimize L)
    end

end
