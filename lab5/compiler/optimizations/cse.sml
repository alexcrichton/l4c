(* L5 Compiler
 * Common Subexpression Elimination
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure CSE :> OPTIMIZATION =
struct
  structure HT = HashTable
  structure T  = Tree
  structure W  = Word

  fun typ_equal (T.WORD, T.WORD) = true
    | typ_equal (T.QUAD, T.QUAD) = true
    | typ_equal _ = false

  (* Completely arbitrary type hash function *)
  fun typ_hash T.WORD = Word.fromInt 5
    | typ_hash T.QUAD = Word.fromInt 11

  fun exp_equal (T.TEMP (t1, typ1), T.TEMP (t2, typ2)) =
        T.tmpequals (t1, t2) andalso typ_equal (typ1, typ2)
    | exp_equal (T.CONST (w1, typ1), T.CONST (w2, typ2)) =
        Word32Signed.eq_ (w1, w2) andalso typ_equal (typ1, typ2)
    | exp_equal (T.BINOP (oper1, e11, e12), T.BINOP (oper2, e21, e22)) =
        oper1 = oper2 andalso exp_equal (e11, e21) andalso exp_equal (e12, e22)
    | exp_equal _ = false

  fun exp_hash _ = W.fromInt 0
  (*val zero = W.fromInt 0
  val one  = W.fromInt 1
  fun exp_hash (T.TEMP (t, typ)) = W.xorb (tmphash t, typ_hash typ)
    | exp_hash (T.PHI L) =
        foldl (fn (tmp, h) => W.xorb (W.<< (h, one), tmphash tmp)) zero L
    | exp_hash (T.CONST (w, typ)) = W.xorb (w, typ_hash typ)
    | exp_hash (T.BINOP (oper, e1, e2)) = *)

  fun lookup tbl e =
        (case HT.find tbl e
           of SOME e' => e'
            | NONE => mape tbl e)

  and mape tbl (T.BINOP (oper, e1, e2)) =
        T.BINOP (oper, lookup tbl e1, lookup tbl e2)
    | mape tbl (T.CALL (l, t, args)) =
        T.CALL (l, t, map (fn (e, t) => (lookup tbl e, t)) args)
    | mape tbl (T.MEM (e, t)) = (T.MEM (lookup tbl e, t))
    | mape _ e = e

  fun maps tbl (T.MOVE (e1, e2)) = let
        val e1' = lookup tbl e1
      in
        case HT.find tbl e2
          of SOME e => T.MOVE (e1', e)
           | NONE => (HT.insert tbl (e2, e1'); T.MOVE (e1', mape tbl e2))
      end
    | maps tbl (T.GOTO (l, SOME e)) = T.GOTO (l, SOME (lookup tbl e))
    | maps tbl (T.COND e) = T.COND (lookup tbl e)
    | maps tbl (T.RETURN e) = T.RETURN (lookup tbl e)
    | maps _ s = s

  fun optimize cfg = let
        val tbl = HT.mkTable (exp_hash, exp_equal)
                             (97, Fail "CSE hashtable error")
      in
        CFG.map_stms (maps tbl) cfg;
        cfg
      end
end
