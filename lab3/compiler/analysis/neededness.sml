(* L3 Compiler
 * Neededness Analysis / Dead Code Elimination
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature NEEDEDNESS =
sig
  val eliminate : Tree.program -> Tree.program
end

structure Neededness :> NEEDEDNESS =
struct
  structure TS = BinarySetFn(Temp)
  structure LS = IntBinarySet
  structure T = Tree
  structure HT = HashTable

  type label = int
  type temp = Temp.temp
                 (* uses        nec    stateful *) (* nec = subset of uses *)
  type exprule = temp list * temp list * bool
                 (* uses         def          succ         nec    stateful *)
  type stmrule = temp list * temp option * label list * temp list * bool

  fun rulegen_exp (T.TEMP t) = ([t], [], false)
    | rulegen_exp (T.CONST _) = ([], [], false)
    | rulegen_exp (T.BINOP (oper, e1, e2)) = let
        val (U1, N1, s1) = rulegen_exp e1
        val (U2, N2, s2) = rulegen_exp e2
        val U' = U1 @ U2
      in
        case oper
          of (T.DIV|T.MOD) => (U', U', true)
           | _ => (U', N1 @ N2, s1 orelse s2)
      end

  fun rulegen _ (l, T.MOVE (T.TEMP t, e)) = let val (U, N, s) = rulegen_exp e in
        (U, SOME t, [l + 1], N, s)
      end
    | rulegen f (l, T.GOTO (l', NONE)) = ([], NONE, [f l'], [], false)
    | rulegen f (l, T.GOTO (l', SOME e)) = let val (U, _, s) = rulegen_exp e in
        (U, NONE, [f l', l + 1], U, s)
      end
    | rulegen f (l, T.RETURN e) = let val (U, _, s) = rulegen_exp e in
        (U, NONE, [], U, s)
      end
    | rulegen f (l, T.LABEL _) = ([], NONE, [l + 1], [], false)
    | rulegen _ _ = raise Fail "Inalid instruction"

  (* lookup_needed : label list -> (label -> TS.set ref) -> TS.set -> TS.set
   *
   * Returns the union of the set of all needed variables for the list of
   * labels given.
   *)
  fun lookup_needed [] _ set = set
    | lookup_needed (l::L) f set = lookup_needed L f (TS.union (set, !(f l)))

  (* bubble_up : (rule * TS.set ref) -> (label -> TS.set ref) -> bool
   *
   * Copies all needed values from the successors of the given line into its
   * needed set unless this line defines the temp. This implements rule N2 from
   * the handout in lecture.
   *)
  fun bubble_up ((_,def,succ,_,_), set) lbl_fn = let
        (* get the set of variables needed by any successor statements *)
        val needed = lookup_needed succ lbl_fn TS.empty
        (* filter out the temp we define in this statement *)
        val needed' = case def of NONE => needed | SOME t' =>
                        TS.filter (fn t => not (Temp.equals (t,t'))) needed
        val set' = TS.union (!set, needed')
      in
        if TS.numItems set' = TS.numItems (!set) then false
        else (set := set'; true)
      end

  (* dependencies : (rule * TS.set ref) -> (label -> TS.set ref) -> bool
   *
   * Figures out which temps are needed because they are used to compute
   * the value of another needed value. This case only applies if we are
   * assigning to a temp that is needed later. This function implements rule
   * N3 from the handout in lecture.
   *)
  fun dependencies ((_,NONE,_,_,_), _) _ = false
    | dependencies ((uses,SOME t,succ,_,_), set) lbl_fn = let
        (* get the set of variables needed by any successor statements *)
        val needed = lookup_needed succ lbl_fn TS.empty
        (* check if the value we're assigning to is needed later on *)
        val set' = case TS.member (needed, t)
                     of true => TS.addList (!set, uses)
                      | false => !set
      in
        if TS.numItems set' = TS.numItems (!set) then false
        else (set := set'; true)
      end

  (* propogate (rule * TS.set ref) list -> (label -> TS.set ref) -> bool
   *
   * Applies the two neededness rules on the given list and returns true if any
   * of the needed sets change.
   *)
  fun propogate [] _ = false
    | propogate (l::L) lbl_fn = let
        val changed = propogate L lbl_fn
        val bubbled = bubble_up l lbl_fn
        val depd = dependencies l lbl_fn
      in
        changed orelse bubbled orelse depd
      end

  (* munge : (rule * TS.set ref) list -> (label -> TS.set ref) -> unit
   *
   * Runs 'propogate' on the given list until propogate returns false.
   *)
  fun munge needed f =
        if propogate needed f then munge needed f else ()

  (* filter : (rule * TS.set ref) list -> Tree.program ->
   *          (label -> TS.set ref) -> Tree.program
   *
   * Filters out any move statements that don't define something needed by a
   * successor and contain no side-effects.
   *)
  fun filter [] [] _ = []
    | filter (((_,SOME t,succ,_,effects), _)::L)
             ((s as (T.MOVE _))::S) lbl_fn = let
          val needed = lookup_needed succ lbl_fn TS.empty
        in
          case (TS.member (needed, t)) orelse effects
            of true  => s::(filter L S lbl_fn)
             | false => filter L S lbl_fn (* delete the statement *)
        end
    | filter (l::L) (s::S) lbl_fn = s::(filter L S lbl_fn)
    | filter _ _ _ = raise Fail "Lists have different size"

  (* eliminate : Tree.program -> Tree.program
   *
   * Eliminates unneeded code from the given program
   *)
  fun eliminate L = let
        val labels = HT.mkTable (Label.hash, Label.equal)
                                (32, Fail "Label not found")

        fun assign_labels _ [] = []
          | assign_labels n ((s as T.LABEL l)::L) = (HT.insert labels (l, n);
                                              (n, s)::(assign_labels (n + 1) L))
          | assign_labels n (s::L) = (n, s)::(assign_labels (n + 1) L)

        val rules = map (rulegen (HT.lookup labels)) (assign_labels 0 L)
        (* initialize the needed sets with the temps in the nec list *)
        val needed = map (fn rule as (_,_,_,nec,_) =>
                          (rule, ref (TS.addList (TS.empty, nec)))) rules
        val lbl_fn = (fn label => (#2 (List.nth (needed, label)))
                                  handle Subscript => ref TS.empty)
      in
        munge needed lbl_fn;
        filter needed L lbl_fn
      end
end
