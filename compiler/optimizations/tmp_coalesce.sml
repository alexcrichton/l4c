(* L5 Compiler
 * Temp coalescing
 *
 * Our compiler often generates code of the form:
 *   t1 = <exp>
 *   t2 = t1
 * Because we're in SSA, we can eliminate t1 here. While register coalescing
 * may take care of this on its own, register allocation will be faster and
 * give better results if we do it on the IR itself.
 *
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure TMPCoalesce :> CFG_OPTIMIZATION =
struct
  structure HT = HashTable
  structure T  = Tree

  fun mape tbl (T.TEMP (tmp, typ)) =
        (case HT.find tbl tmp
           of SOME tmp2 => T.TEMP (tmp2, typ)
            | NONE => T.TEMP (tmp, typ))
    (*| mape tbl (T.PHI L) = T.PHI (map (mape tbl) L)*) (* TODO *)
    | mape tbl (T.BINOP (oper, e1, e2)) =
        T.BINOP (oper, mape tbl e1, mape tbl e2)
    | mape tbl (T.CALL (e, typ, args)) =
        T.CALL (mape tbl e, typ, map (fn (e, t) => (mape tbl e, typ)) args)
    | mape tbl (T.LOAD (e, typ)) = T.LOAD (mape tbl e, typ)
    | mape _ e = e

  fun maps tbl (T.MOVE (t1, t, e2 as (T.TEMP _))) =
        (case mape tbl e2
           of T.TEMP (t2, typ2) => (HT.insert tbl (t1, t2); T.NOP)
            | _ => raise Fail "Temp coalescing broken")
    | maps tbl (T.STORE (e1, t, e2)) = T.STORE (mape tbl e1, t, mape tbl e2)
    | maps tbl (T.GOTO (l, SOME e)) = T.GOTO (l, SOME (mape tbl e))
    | maps tbl (T.COND e) = T.COND (mape tbl e)
    | maps tbl (T.RETURN e) = T.RETURN (mape tbl e)
    | maps tbl s = s

  fun optimize cfg = let
        val tbl = HT.mkTable (T.tmphash, T.tmpequals)
                             (97, Fail "Temp coalescing hashtable error")
      in
        CFG.map_stms (maps tbl) cfg;
        cfg
      end
end
