(* L5 Compiler
 * Common Subexpression Elimination
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure CSE :> CFG_OPTIMIZATION =
struct
  structure T  = Tree
  structure W  = Word32

  val zero = W.fromInt 0
  val one  = W.fromInt 1
  val prime1 = W.fromInt 17
  val prime2 = W.fromInt 23

  (* typ_hash : T.typ -> W.word
   * Completely arbitrary type hash function
   *)
  fun typ_hash T.INT = W.fromInt 5
    | typ_hash T.PTR = W.fromInt 11

  (* oper_hash : T.binop -> W.word
   * Completely arbitrary binop hash function
   *)
  and oper_hash T.ADD = W.fromInt 2
    | oper_hash T.SUB = W.fromInt 3
    | oper_hash T.MUL = W.fromInt 5
    | oper_hash T.DIV = W.fromInt 7
    | oper_hash T.MOD = W.fromInt 11
    | oper_hash T.LT  = W.fromInt 13
    | oper_hash T.LTE = W.fromInt 17
    | oper_hash T.GT  = W.fromInt 19
    | oper_hash T.GTE = W.fromInt 23
    | oper_hash T.EQ  = W.fromInt 29
    | oper_hash T.NEQ = W.fromInt 31
    | oper_hash T.AND = W.fromInt 37
    | oper_hash T.OR  = W.fromInt 41
    | oper_hash T.XOR = W.fromInt 43
    | oper_hash T.LSH = W.fromInt 47
    | oper_hash T.RSH = W.fromInt 53

  (* order_exp : T.exp -> T.exp
   *
   * Canonicalizes all of the terms in the given expression. This makes
   * CSE much easier and more effective
   *)
  fun order_exp (T.BINOP (o1, T.BINOP (o2, e1, e2), e3)) =
        if o1 = o2 andalso T.associative o1 then
          order_exp (T.BINOP (o1, e1, T.BINOP (o2, e2, e3)))
        else T.BINOP (o1, order_exp (T.BINOP (o2, e1, e2)), order_exp e3)
    | order_exp (e as T.BINOP (_, T.CONST _, T.CONST _)) = e
    | order_exp (T.BINOP (oper, e1, e2 as T.CONST _)) =
        if T.commutative oper then order_exp (T.BINOP (oper, e2, e1))
        else T.BINOP (oper, order_exp e1, e2)
    | order_exp (T.BINOP (oper, e1, e2)) =
        T.BINOP (oper, order_exp e1, order_exp e2)
    | order_exp (T.MEM (e, t)) = T.MEM (order_exp e, t)
    | order_exp (T.CALL (e, t, L)) =
        T.CALL (order_exp e, t, map (fn (e, t) => (order_exp e, t)) L)
    | order_exp e = e

  (* order_stm : T.stm -> T.stm
   * Canonicalizes all of the expressions in the given statement.
   *)
  fun order_stm (T.MOVE (e1, e2)) = T.MOVE (order_exp e1, order_exp e2)
    | order_stm (T.GOTO (l, SOME e)) = T.GOTO (l, SOME (order_exp e))
    | order_stm (T.COND e) = T.COND (order_exp e)
    | order_stm (T.RETURN e) = T.RETURN (order_exp e)
    | order_stm s = s

  (*fun exp_equal (T.TEMP (t1, typ1), T.TEMP (t2, typ2)) =
        T.tmpequals (t1, t2) andalso typ1 = typ2
    | exp_equal (T.CONST (w1, typ1), T.CONST (w2, typ2)) =
        Word32Signed.eq_ (w1, w2) andalso typ1 = typ2
    | exp_equal (T.BINOP (oper1, e11, e12), T.BINOP (oper2, e21, e22)) =
        oper1 = oper2 andalso exp_equal (e11, e21) andalso exp_equal (e12, e22)
    | exp_equal _ = false*)

  (*fun exp_hash (T.TEMP (t, typ)) =
        W.fromInt (Word.toInt (T.tmphash t)) * typ_hash typ
    | exp_hash (T.PHI L) = zero
    | exp_hash (T.CONST (w, typ)) = w * typ_hash typ
    | exp_hash (T.BINOP (oper, e1, e2)) =
        oper_hash oper + prime1 * exp_hash e1 + prime2 * exp_hash e2
    | exp_hash (T.CALL (id, t, L)) = zero
    | exp_hash (T.MEM (e, t)) = zero*)

  (* resolve : order * (unit -> order) -> order
   *
   * Resolves two different orderings, but in a way such that one always takes
   * precedence over the other. The given continuation is only evaluated if
   * necessary
   *)
  fun resolve (EQUAL, f) = f ()
    | resolve (order, _) = order

  (* exp_compare : T.exp * T.exp -> order
   * Compares two expressions, assuming they are canonicalized
   *)
  fun exp_compare (T.TEMP (t1, typ1), T.TEMP (t2, typ2)) =
        resolve (T.tmpcompare (t1, t2),
                 fn () => W.compare (typ_hash typ1, typ_hash typ2))
    | exp_compare (T.TEMP _, _) = LESS
    | exp_compare (_, T.TEMP _) = GREATER
    | exp_compare (T.CONST (w1, t1), T.CONST (w2, t2)) =
        resolve (W.compare (w1, w2),
                 fn () => W.compare (typ_hash t1, typ_hash t2))
    | exp_compare (T.CONST _, _) = LESS
    | exp_compare (_, T.CONST _) = GREATER
    | exp_compare (T.BINOP (o1, e11, e12), T.BINOP (o2, e21, e22)) =
        resolve (W.compare (oper_hash o1, oper_hash o2),
                 fn () => resolve (exp_compare (e11, e21),
                                   fn () => exp_compare (e12, e22)))
    | exp_compare (T.BINOP _, _) = LESS
    | exp_compare (_, T.BINOP _) = GREATER
    | exp_compare (_, (T.PHI _ | T.MEM _ | T.CALL _ | T.ELABEL _)) = GREATER

  structure ET = BinaryMapFn(struct
                               type ord_key = T.exp
                               val compare = exp_compare
                             end)

  (* lookup : T.exp ET.table -> T.exp -> T.exp
   *
   * Performs CSE
   * @param tbl the table of known expression mappings
   * @param e the expression to eliminate parts of possibly
   *)
  fun lookup tbl (g as (graph, id)) e = let val e' = mape tbl g e in
        (case ET.find (tbl, e')
          of SOME (e'', nid) => if CFG.dominates graph (nid, id) then e''
                                else e'
           | NONE => e')
      end

  (* mape : T.exp ET.table -> T.exp -> T.exp
   * Performs CSE on the given expression, recursively replacing all components
   * of this expression.
   *)
  and mape tbl g (T.BINOP (oper, e1, e2)) =
        T.BINOP (oper, lookup tbl g e1, lookup tbl g e2)
    | mape tbl g (T.CALL (l, t, args)) =
        T.CALL (lookup tbl g l, t, map (fn (e, t) => (lookup tbl g e, t)) args)
    | mape tbl g (T.MEM (e, t)) = (T.MEM (lookup tbl g e, t))
    | mape _ _ e = e

  (* maps : T.stm * (T.exp ET.table * T.stm list) ->
   *                                              (T.exp ET.table * T.stm list)
   * Performs CSE on a statement, return the modified statement and updated
   * table if necessary.
   *)
  fun maps (graph, id) (T.MOVE (e1 as T.TEMP _, e2), (tbl, stms)) = (let
        val (e2', nid) = valOf (ET.find (tbl, lookup tbl (graph, id) e2))
        val _ = if CFG.dominates graph (nid, id) then () else raise Option
      in
        (tbl, T.MOVE (e1, e2') :: stms)
      end handle Option => let
        val e2' = lookup tbl (graph, id) e2
        val (k, v) = case e2'
                       of (T.TEMP _ | T.CONST _) => (e1, e2')
                        | _ => (e2', e1)
      in
        (ET.insert (tbl, k, (v, id)), T.MOVE (e1, e2') :: stms)
      end)
    | maps g (T.MOVE (e1, e2), (tbl, stms)) =
        (tbl, T.MOVE (lookup tbl g e1, lookup tbl g e2) :: stms)
    | maps g (T.GOTO (l, SOME e), (tbl, stms)) =
        (tbl, T.GOTO (l, SOME (lookup tbl g e)) :: stms)
    | maps g (T.COND e, (tbl, stms)) = (tbl, T.COND (lookup tbl g e) :: stms)
    | maps g (T.RETURN e, (tbl, stms)) = (tbl, T.RETURN (lookup tbl g e) :: stms)
    | maps _ (i, (tbl, stms)) = (tbl, i :: stms)

  fun optimize [] = []
    | optimize ((id, t, args, g) :: L) = let
        val Graph.GRAPH graph = g
        val visited = Array.array (#capacity graph (), false)
        fun walk et id = if Array.sub (visited, id) then () else let
              val stms = #node_info graph id
              val stms' = map order_stm stms
              val (et', stms'') = foldl (maps (g, id)) (et, []) stms'
            in
              Array.update (visited, id, true);
              #add_node graph (id, rev stms'');
              app (walk et') (#succ graph id)
            end
        val _ = walk ET.empty (hd (#entries graph ()))
      in
        (id, t, args, g) :: optimize L
      end
end
