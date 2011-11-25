(* L5 Compiler
 * Constant folding and propogation
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure CFold :> CFG_OPTIMIZATION =
struct
  structure T = Tree
  structure W32S = Word32Signed
  structure HT = HashTable
  structure G = Graph

  val zero = Word32.fromInt 0
  val one  = Word32.fromInt 1

  (* Fold a binop with two constant parameters *)
  fun fold_binop_const (oper, c1 as (w1, t1), c2 as (w2, t2)) = let
        fun conv_bool true  = (T.CONST (one, T.WORD), true)
          | conv_bool false = (T.CONST (zero, T.WORD), true)
        val t = if t1 = T.QUAD orelse t2 = T.QUAD then T.QUAD else T.WORD
      in case oper
           of T.ADD => (T.CONST  (W32S.add_ (w1, w2), t), true)
            | T.SUB => (T.CONST  (W32S.sub_ (w1, w2), t), true)
            | T.MUL => (T.CONST  (W32S.mul_ (w1, w2), t), true)
            | T.AND => (T.CONST  (W32S.and_ (w1, w2), t), true)
            | T.OR  => (T.CONST  (W32S.or_  (w1, w2), t), true)
            | T.XOR => (T.CONST  (W32S.xor_ (w1, w2), t), true)
            | T.LT  => conv_bool (W32S.lt_  (w1, w2))
            | T.LTE => conv_bool (W32S.lte_ (w1, w2))
            | T.GT  => conv_bool (W32S.gt_  (w1, w2))
            | T.GTE => conv_bool (W32S.gte_ (w1, w2))
            | T.EQ  => conv_bool (W32S.eq_  (w1, w2))
            | T.NEQ => conv_bool (W32S.neq_ (w1, w2))
            | T.LSH => (T.CONST  (W32S.lsh_  (w1, w2), t), true)
            | T.RSH => (T.CONST  (W32S.rsh_  (w1, w2), t), true)
            | (T.DIV | T.MOD) =>
                if not (W32S.candiv (w1, w2)) then
                  (T.BINOP (oper, T.CONST c1, T.CONST c2), false)
                else case oper
                       of T.DIV => (T.CONST (W32S.div_ (w1, w2), t), true)
                        | T.MOD => (T.CONST (W32S.mod_ (w1, w2), t), true)
                        | _ => raise Fail "smlnj is broken"
      end

  (* Fold a binop where one of its parameters is constant *)
  fun fold_simp (T.DIV, e1, c as T.CONST (w, t), p) =
        if w = one then (e1, p) else (T.BINOP (T.DIV, e1, c), p)
    | fold_simp (oper, c as T.CONST (w, t), e2, p) =
        (case (w = zero, w = one, oper)
           of ((false,true,T.MUL) | (true,false,T.ADD) |
               (true,false,T.XOR) | (true,false,T.OR)) => (e2, p)
            | ((true,false,T.MUL) | (true,false,T.AND)) =>
               if p then (T.CONST (zero, t), p) else (T.BINOP (oper, c, e2), p)
            | (_, _, oper) => (T.BINOP (oper, T.CONST (w, t), e2), p))
    | fold_simp (oper, e1, e2, p) = (T.BINOP (oper, e1, e2), p)

  (* Handle tree rotations then delegate to fold_simp *)
  fun fold_binop_1 tbl (oper1, c1 as (T.CONST _),
                    T.BINOP (oper2, c2 as (T.CONST _), e3), p) =
        if oper1 = oper2 andalso T.associative oper1 then (* rotation! *)
          fold_exp tbl (T.BINOP (oper1, folde tbl (T.BINOP (oper1, c1, c2)), e3))
        else if oper1 = oper2 andalso oper1 = T.SUB then
          fold_exp tbl (T.BINOP (T.ADD, folde tbl (T.BINOP (T.SUB, c1, c2)), e3))
        else
          fold_simp (oper1, c1, T.BINOP (oper2, c2, e3), p)
    | fold_binop_1 _ a = fold_simp a

  (* fold_exp : T.exp -> T.exp * bool
   *
   * Folds an expression. The bool in the return type is true if
   * the expresion can safely be optimized out (it's pure).
   *)
  and fold_exp tbl (T.TEMP (temp, typ)) =
        (case HT.find tbl temp
           of SOME c => (T.CONST c, true)
            | NONE   => (T.TEMP (temp, typ), true))
    | fold_exp tbl (T.MEM (e, t)) = (T.MEM (folde tbl e, t), false)
    | fold_exp tbl (T.CALL (l, t, P)) = let
        fun map_params (e, t) = (folde tbl e, t)
      in
        (T.CALL (l, t, map map_params P), false)
      end
    | fold_exp tbl (T.BINOP (oper, e1, e2)) = let
        val (e1', p1) = fold_exp tbl e1
        val (e2', p2) = fold_exp tbl e2
        val pure = p1 andalso p2
      in
        case (e1', e2')
          of (T.CONST c1, T.CONST c2) => fold_binop_const (oper, c1, c2)
           | (e, T.CONST (c as (w, t))) => (* move constant left if possible *)
              if T.commutative oper then fold_binop_1 tbl (oper, T.CONST c, e, pure)
              else if oper <> T.SUB then fold_binop_1 tbl (oper, e, T.CONST c, pure)
              else fold_binop_1 tbl (T.ADD, T.CONST (~w, t), e, pure)
           | (T.CONST c, e) => fold_binop_1 tbl (oper, T.CONST c, e, pure)
           | (e, e') => (T.BINOP (oper, e, e'), p1 andalso p2)
      end
    | fold_exp _ i = (i, true)

  and folde tbl e = #1 (fold_exp tbl e)

  fun folds tbl (T.MOVE (e1, e2)) = let
        val es = (folde tbl e1, folde tbl e2)
      in
        case es
          of (T.TEMP (temp, _), T.CONST c) => HT.insert tbl (temp, c)
           | _ => ();
        T.MOVE es
      end
    | folds tbl (T.GOTO (l, SOME e)) = T.GOTO (l, SOME (folde tbl e))
    | folds tbl (T.COND e) = T.COND (folde tbl e)
    | folds tbl (T.RETURN e) = T.RETURN (folde tbl e)
    | folds tbl s = s

  fun optimize cfg = let
        fun mapg (_, _, _, G.GRAPH g) = let
              val order = #1 (CFG.rev_postorder (G.GRAPH g))
              val ht = HT.mkTable (T.tmphash, T.tmpequals)
                                  (43, Fail "cprop ht error")
            in
              app (fn nid => #add_node g (nid, map (folds ht)
                                          (#node_info g nid))) order
            end
      in
        List.app mapg cfg; cfg
      end

end
