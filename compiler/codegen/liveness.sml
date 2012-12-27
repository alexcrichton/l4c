(* L5 Compiler
 * Liveness
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature LIVENESS =
sig
  structure Assem : ASSEM
  val compute : Assem.instr list -> Assem.OperandSet.set list
end

functor Liveness (A : ASSEM) :> LIVENESS where Assem = A =
struct
  structure Assem = A
  structure Arch  = A.Arch
  structure HT    = HashTable
  structure OS    = A.OperandSet

  type label = int

  (* 3-tuple where the elements are:
   *    A.operand list - all x for use(l, x)
   *    A.operand option - SOME x if def(l, x), or NONE
   *    label list - all l' where succ(l, l')
   *)
  type rule = A.operand list * A.operand list * label list

  fun reg r = A.REG (r, Arch.ptrsize)
  fun regs (A.MEM (A.MOP d, _) :: L) = regs (d :: L)
    | regs ((A.IMM _ | A.LABELOP _) :: L) = regs L
    | regs (x :: L) = x :: regs L
    | regs [] = []

  (* rulegen : (A.label -> label) -> (label * Assem.instr) -> rule
   *
   * @param l the label of the current instruction
   * @param i the instruction to generate a rule for
   * @return a rule representing the current instruction
   *)
  fun rulegen f (l, A.BINOP(_, A.MEM (A.MOP d, _), s1, s2)) =
        (regs [s1, s2, d], [], [l + 1]) : rule
    | rulegen f (l, A.BINOP(_, d, s1, s2)) = (regs [s1, s2], [d], [l + 1])
    | rulegen f (l, A.MOV(A.MEM (A.MOP d, _), s)) = (regs [s, d], [], [l + 1])
    | rulegen f (l, A.MOV(d, s)) = (regs [s], [d], [l + 1])
    | rulegen f (l, A.JMP (lbl, SOME (_, s1, s2))) =
        if Label.isfunc lbl then (regs [s1, s2], [], [l + 1])
        else (regs [s1, s2], [], [f lbl, l + 1])
    | rulegen f (l, A.JMP (lbl, NONE)) =
        if Label.isfunc lbl then ([], [], [])
        else ([], [], [f lbl])
    | rulegen _ (l, (A.DIRECTIVE _ | A.LABEL _ | A.COMMENT _)) = ([],[],[l + 1])
    | rulegen f (l, A.RET) = ([reg Arch.ret_reg], [], [])
    | rulegen f (l, A.CALL (callable, n)) =
        (regs (callable :: List.tabulate (Int.min (abs n, Arch.arg_regs),
                                          reg o Arch.arg_reg)),
         [reg Arch.ret_reg],
         if n < 0 then [] else [l + 1])
    | rulegen f (l, A.ASM s) = ([], [], [l + 1])

  (* add_uses : OS.set -> OS.set ref -> bool
   *
   * @param uses a list of operands to add to the set
   * @param set the set of operands to add to
   * @return true if any operand was added
   *)
  fun add_uses uses set = let
    val set' = OS.union (!set, uses)
  in
    if OS.numItems(set') = OS.numItems (!set) then false
    else (set := set'; true)
  end

  (* add_succ : (A.operand list * (label -> OS.set ref)) -> label list
   *             -> OS.set ref -> bool
   *
   * Add all successor operands to the current set of live operands.
   *
   * @param defs all operands defined on the current line
   * @param f a function which goes from a label to the currently known set of
   *        live operands at that line.
   * @param L a list of labels which the currently line can go to.
   * @param set the set of live operands at the current line.
   * @return true if anything was added to the set
   *)
  fun add_succ _ [] _ = false
    | add_succ (defs, f) (label::L) set = let
        (* Recursively add in all other successors first *)
        val added = add_succ (defs, f) L set

        (* If our current line defines an operand, then we should not be adding
           that temp to the list of live variables in the set. Generate a list
           of temps the current successor line will add to our set *)
        fun del_def (d, s) = OS.delete (s, d) handle NotFound => s
        val succ_set = foldl del_def (!(f label)) defs
        val added_succ = add_uses succ_set set
      in added orelse added_succ end

  (* process : (rule * OS.set ref) vector -> (label -> OS.set ref) -> bool
   *
   * @param rules a vector of pairs of rules and corresponding currently
   *        known OS.set references of interefering operands.
   * @param rule_fn the function which goes from a label to the currently known
   *        set of live variables for that function.
   * @return true if any operand was ever added to any live set for any
   *         instruction
   *)
  fun process rules rule_fn = let
        fun process_ruleset (((uses, def, succ) : rule, set), changed) = let
              val added_uses = add_uses (OS.fromList uses) set
              val added_succ = add_succ (def, rule_fn) succ set
            in
              changed orelse added_uses orelse added_succ
            end
      (* Start at the back, heuristically better *)
      in Vector.foldr process_ruleset false rules end

  (* munge : (rule * OS.set ref) vector -> (label -> OS.set ref) -> unit
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

    (* find all labels and add their location to our hash table *)
    fun find_labels _ [] = ()
      | find_labels i ((A.LABEL l)::L) =
          (HT.insert labels (l, i); find_labels (i + 1) L)
      | find_labels i (a::L) = find_labels (i + 1) L

    val _ = find_labels 0 L
    val rules = Vector.fromList L
    val rules = Vector.mapi (fn pair => (rulegen (HT.lookup labels) pair,
                                         ref OS.empty)) rules
    fun getsets label = (#2 (Vector.sub (rules, label)))
                        handle Subscript => ref OS.empty

    val _ = munge rules getsets
    val rulesets = Vector.foldr (fn ((_, ref s), L) => s::L) [] rules
  in
    ListPair.mapEq A.precolor (L, rulesets)
  end

end
