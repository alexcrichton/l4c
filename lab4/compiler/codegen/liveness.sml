(* L4 Compiler
 * Liveness
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature LIVENESS =
sig
  val compute : Assem.instr list -> OperandSet.set list
end

structure Liveness :> LIVENESS =
struct

  structure A = Assem
  structure HT = HashTable
  structure OS = OperandSet

  type label = int

  (* 3-tuple where the elements are:
   *    A.operand list - all x for use(l, x)
   *    A.operand option - SOME x if def(l, x), or NONE
   *    label list - all l' where succ(l, l')
   *)
  type rule = A.operand list * A.operand list * label list

  fun mkreg r = A.REG (r, A.WORD)
  val eax = A.REG (A.EAX, A.WORD)
  val edx = A.REG (A.EDX, A.WORD)

  (* rulegen : (A.label -> label) -> (label * Assem.instr) -> rule
   *
   * @param l the label of the current instruction
   * @param i the instruction to generate a rule for
   * @return a rule representing the current instruction
   *)
  fun rulegen f (l, A.BINOP((A.DIV|A.MOD), A.MEM (d, _), A.MEM (s, _))) =
        ([edx, d, s], [], [l + 1])
    | rulegen f (l, A.BINOP((A.DIV|A.MOD), A.MEM (d, _), s)) =
        ([edx, d, s], [], [l + 1])
    | rulegen f (l, A.BINOP((A.DIV|A.MOD), d, s)) = ([edx, d, s], [d], [l + 1])
    | rulegen f (l, A.BINOP(_, A.MEM (d, _), A.MEM (s, _))) =
        ([d, s], [], [l + 1])
    | rulegen f (l, A.BINOP(_, A.MEM (d, _), s)) = ([d, s], [], [l + 1])
    | rulegen f (l, A.BINOP(_, d, s)) = ([d, s], [d], [l + 1])
    | rulegen f (l, A.MOV(A.MEM _, A.MEM _)) = raise Fail "no two mem"
    | rulegen f (l, A.MOV(A.MEM (d, _), s)) = ([s, d], [], [l + 1])
    | rulegen f (l, A.MOV(d, A.MEM (s, _))) = ([s], [d], [l + 1])
    | rulegen f (l, A.MOV(d, s)) = ([s], [d], [l + 1])
    | rulegen f (l, A.MOVFLAG(d, _)) = ([], [d], [l + 1])
    | rulegen f (l, A.JMP (lbl, _)) = ([], [], [f lbl, l + 1])
    | rulegen f (l, A.DIRECTIVE _) = ([], [], [l + 1])
    | rulegen f (l, A.COMMENT _) = ([], [], [l + 1])
    | rulegen f (l, A.RET) = (eax::(map mkreg A.callee_regs), [], [])
    | rulegen f (l, A.LABEL _) = ([], [], [l + 1])
    | rulegen f (l, A.CALL (_, n)) = (List.tabulate (n, mkreg o A.arg_reg),
                                      eax::(map mkreg A.caller_regs), [l + 1])
    | rulegen f (l, A.ASM s) =
        if s = "cltd" then ([], [A.REG (A.EDX, A.WORD)], [l + 1])
        else ([], [], [l + 1])

  (* add_uses : OS.set -> OS.set ref -> bool
   *
   * @param L a list of operands to add to the set
   * @param set the set of operands to add to
   * @return true if any operand was added
   *)
  fun add_uses L set = let
    val set' = OS.union (!set, L)
  in
    if OS.numItems(set') = OS.numItems (!set) then false
    else (set := set'; true)
  end

  (* add_succ : (A.operand option * (label -> OS.set ref)) -> label list
   *             -> OS.set ref -> bool
   *
   * Add all successor operands to the current set of live operands.
   *
   * @param def an operand which is defined on the current line or NONE
   * @param f a function which goes from a label to the currently known set of
   *        live operands at that line.
   * @param L a list of labels which the currently line can go to.
   * @param set the set of live operands at the current line.
   * @return true if anything was added to the set
   *)
  fun add_succ _ nil _ = false
    | add_succ (def, f) (x::L) set = let
    (* Recursively add in all other successors first *)
    val added = add_succ (def, f) L set

    (* If our current line defines an operand, then we should not be adding that
       temp to the list of live variables in the set. Generate a list of
       temps the current successor line will add to our set *)
    fun del_def (d, s) = OS.delete (s, d) handle NotFound => s
    val succ_set = foldl del_def (!(f x)) def
    val added_succ = add_uses succ_set set
  in added orelse added_succ end

  (* process : (rule * OS.set ref) list -> (label -> OS.set ref)
   *           -> bool
   *
   * @param rule list a list of pairs of rules and corresponding currently
   *        known OS.set references of interefering operands.
   * @param rule_fn the function which goes from a label to the currently known
   *        set of live variables for that function.
   * @return true if any operand was ever added to any live set for any
   *         instruction
   *)
  fun process (((uses, def, succ), set)::L) rule_fn = let
    (* Recursively process all other rules first (heuristically better) *)
    val changed = process L rule_fn

    val added_uses = add_uses (OS.addList (OS.empty, uses)) set
    val added_succ = add_succ (def, rule_fn) succ set
  in
    changed orelse added_uses orelse added_succ
  end
  |  process _ _ = false

  (* munge : (rule * OS.set ref) list ->
   *         (label -> OS.set ref) -> unit
   *
   * Runs 'process' on the given list until process returns false.
   *)
  fun munge rulesets f =
    if Profile.time ("process", fn () => process rulesets f)
    then munge rulesets f
    else ()

  (* compute : Assem.instr list -> OS.set list
   *
   * Performs liveness analysis on the given list of instructions.
   * @param L the list of assembly instructions with temps
   * @return a same-size list where each operand set corresponds to the list of
   *         live operands at that instruction.
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
      | give_labels i ((a as A.LABEL l)::L) = (HT.insert labels (l, i);
                                               (i, a)::(give_labels (i + 1) L))
      | give_labels i (a::L) = (i, a)::(give_labels (i + 1) L)

    val rules = map (rulegen (HT.lookup labels)) (give_labels 0 L)
    val rulesets = List.map (fn rule => (rule, ref OS.empty)) rules
    fun isreg (A.REG _) = true | isreg _ = false
    fun add_defs ((_, s), A.MOV _) = !s
      | add_defs (((_, ds, _), s), _) = OS.addList (!s, List.filter isreg ds)
  in
    (munge rulesets (fn label =>
       (#2 (List.nth (rulesets, label))) handle Subscript => ref OS.empty
     ));
    ListPair.map add_defs (rulesets, L)
  end

end
