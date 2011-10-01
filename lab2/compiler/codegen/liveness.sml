(* L2 Compiler
 * Liveness
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

structure TempSet = BinarySetFn(Temp)

signature LIVENESS =
sig
  val compute : Assem.instr list -> TempSet.set list

  exception BadInstruction of Assem.instr
end

structure Liveness :> LIVENESS =
struct

  structure A = Assem
  structure HT = HashTable

  type temp  = Temp.temp
  type label = int
  exception BadInstruction of Assem.instr

  (* 3-tuple where the elements are:
   *    A.operand list - all x for use(l, x)
   *    temp option - SOME x if def(l, x), or NONE
   *    label list - all l' where succ(l, l')
   *)
  type rule = A.operand list * temp option * label list

  (* rulegen : (A.label -> label) -> (label * Assem.instr) -> rule
   *
   * @param l the label of the current instruction
   * @param i the instruction to generate a rule for
   * @return a rule representing the current instruction
   *)
  fun rulegen f (l, A.BINOP(_, A.TEMP d, s1, s2)) = ([s1, s2], SOME d, [l + 1])
  |   rulegen f (l, A.BINOP(_, _, s1, s2)) = ([s1, s2], NONE, [l + 1])
  |   rulegen f (l, A.MOV(A.TEMP d, s)) = ([s], SOME d, [l + 1])
  |   rulegen f (l, A.MOV(A.REG _, s)) = ([s], NONE, [l + 1])
  |   rulegen f (l, A.MOVFLAG(A.TEMP d, _)) = ([], SOME d, [l + 1])
  |   rulegen f (l, A.MOVFLAG(A.REG _, _)) = ([], NONE, [l + 1])
  |   rulegen f (l, A.JMP (lbl, _)) = ([], NONE, [f lbl, l + 1])
  |   rulegen f (l, A.DIRECTIVE _) = ([], NONE, [l + 1])
  |   rulegen f (l, A.COMMENT _) = ([], NONE, [l + 1])
  |   rulegen f (l, A.RET) = ([], NONE, [])
  |   rulegen f (l, A.LABEL _) = ([], NONE, [l + 1])
  |   rulegen f (_, i) = raise BadInstruction i

  (* add_uses : temp list -> TempSet ref -> bool
   *
   * @param L a list of temps to add to the set
   * @param set the set of temps to add to
   * @return true if any temp was added
   *)
  fun add_uses L set = let
    val set' = TempSet.addList (!set, L)
  in
    if TempSet.numItems(set') = TempSet.numItems (!set) then false
    else (set := set'; true)
  end

  (* add_succ : (temp option * (label -> TempSet ref)) -> label list
   *             -> TempSet ref -> bool
   *
   * Add all successor temps to the current set of live temps.
   *
   * @param def a temp which is defined on the current line or NONE
   * @param f a function which goes from a label to the currently known set of
   *        live variables at that line.
   * @param L a list of labels which the currently line can go to.
   * @param set the set of live temps at the current line.
   * @return true if anything was added to the set
   *)
  fun add_succ _ nil _ = false
  |   add_succ (def, f) (x::L) set = let
    (* Recursively add in all other successors first *)
    val added = add_succ (def, f) L set

    (* If our current line defines a temp, then we should not be adding that
       temp to the list of live variables in the set. Generate a list of
       temps the current successor line will add to our set *)
    val succ_set = case def of
      SOME(t) => (TempSet.delete (!(f x), t) handle NotFound => !(f x))
      | _     => !(f x)
    val added_succ = add_uses (TempSet.listItems succ_set) set
  in added orelse added_succ end

  (* process : (rule * TempSet.set ref) list -> (label -> TempSet.set ref)
   *           -> bool
   *
   * @param rule list a list of pairs of rules and corresponding currently
   *        known TempSet.set references of interefering variables.
   * @param rule_fn the function which goes from a label to the currently known
   *        set of live variables for that function.
   * @return true if any temp was ever added to any live set for any instruction
   *)
  fun process (((uses, def, succ), set)::L) rule_fn = let
    (* Recursively process all other rules first (heuristically better) *)
    val changed = process L rule_fn

    (* Extract all A.TEMP instances in the operands we use for this rule *)
    val temp_uses = List.foldl (fn (A.TEMP(t), L) => t::L | (_, L)  => L)
                               [] uses
    val added_uses = add_uses temp_uses set
    val added_succ = add_succ (def, rule_fn) succ set
  in
    changed orelse added_uses orelse added_succ
  end
  |  process _ _ = false

  (* munge : (rule * TempSet.set ref) list -> (label -> TempSet.set ref) -> unit
   *
   * Runs 'process' on the given list until process returns false.
   *)
  fun munge rulesets f =
    if process rulesets f then munge rulesets f else ()

  (* compute : Assem.instr list -> TempSet.set list
   *
   * Performs liveness analysis on the given list of instructions.
   * @param L the list of assembly instructions with temps
   * @return a same-size list where each temp set corresponds to the list of
   *         live variables at that instruction.
   *)
  fun compute L = let
    val labels = HT.mkTable (Label.hash, Label.equal)
                            (32, Fail "Label not found")

    (* give_labels : label -> rule list -> (label * rule) list
     *
     * @param int the initial label to give out
     * @param L the list of rules to assign labels to
     * @return a list of pairs of labels and rules
     *)
    fun give_labels _ [] = []
    |   give_labels i ((a as A.LABEL l)::L) = (HT.insert labels (l, i);
                                               (i, a)::(give_labels (i + 1) L))
    |   give_labels i (a::L) = (i, a)::(give_labels (i + 1) L)

    val rules = List.map (rulegen (HT.lookup labels)) (give_labels 0 L)
    val rulesets = List.map (fn rule => (rule, ref TempSet.empty)) rules
  in
    (munge rulesets (fn label =>
       (#2 (List.nth (rulesets, label))) handle Subscript => ref TempSet.empty
     ));
    List.map (fn (_, r) => !r) rulesets
  end

end
