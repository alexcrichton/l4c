(* L5 Compiler
 * Codegen
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature CODEGEN =
sig
  structure Assem : ASSEM
  structure Runtime : RUNTIME where Assem = Assem
  structure Trans : TRANS
  val codegen : Tree.program -> Assem.instr list
end

functor Codegen (structure AS : ASSEM;
                 structure TR : TRANS;
                 sharing TR.Arch = AS.Arch.TArch) :> CODEGEN where Assem = AS =
struct
  structure Assem   = AS
  structure Trans   = TR
  structure Runtime = Runtime(AS)
  structure Arch    = AS.Arch
  structure T       = Tree
  structure P       = Profile
  structure IBM     = IntBinaryMap
  structure HT      = HashTable
  structure Alloc   = Allocation(AS)
  structure Peep    = Peephole(AS)

  fun munch_cond T.LT  = AS.LT
    | munch_cond T.LTE = AS.LTE
    | munch_cond T.GT  = AS.GT
    | munch_cond T.GTE = AS.GTE
    | munch_cond T.EQ  = AS.EQ
    | munch_cond T.NEQ = AS.NEQ
    | munch_cond T.XOR = AS.NEQ
    | munch_cond _     = raise Fail "not a condition"

  fun munch_op T.ADD = AS.ADD
    | munch_op T.SUB = AS.SUB
    | munch_op T.MUL = AS.MUL
    | munch_op T.DIV = AS.DIV
    | munch_op T.MOD = AS.MOD
    | munch_op T.AND = AS.AND
    | munch_op T.OR  = AS.OR
    | munch_op T.XOR = AS.XOR
    | munch_op T.LSH = AS.LSH
    | munch_op T.RSH = AS.RSH
    | munch_op cond  = AS.CMP (munch_cond cond)

  val munch_typ = Arch.size
  fun ret_reg typ = AS.REG (Arch.ret_reg, munch_typ typ)

  (* Returns true if the operator evaluates to a bool *)
  fun eval_bool (T.LT | T.LTE | T.GT | T.GTE | T.EQ | T.NEQ) = true
    | eval_bool _  = false

  fun munch_temp ts (t, typ) =
        case HT.find ts t
          of NONE => let val oper = AS.TEMP (Temp.new(), munch_typ typ) in
                       HT.insert ts (t, oper); oper
                     end
           | SOME oper => if AS.size oper = munch_typ typ then oper
                          else raise Fail "differing sizes of temps"

  (* munch_exp : AS.operand -> T.exp -> AS.instr list
   *
   * generates instructions to achieve d <- e, d must be TEMP(t) or REG(r)
   * @param d the destination of the expression
   * @param exp the expression to convert
   * @return the instructions needed to move the result of the expression into
   *         the destination
   *)
  fun munch_exp ts d (T.CONST (n, typ)) = [AS.MOV(d, AS.IMM (n, munch_typ typ))]
    | munch_exp ts d (T.TEMP (t, typ)) = [AS.MOV (d, munch_temp ts (t, typ))]
    | munch_exp ts d (T.BINOP (binop, e1, e2)) =
        munch_half2 (fn (t1, t2) => AS.BINOP (munch_op binop, d, t1, t2))
                    ts e1 e2
    | munch_exp ts d (T.LOAD (a, typ)) =
        munch_half1 (fn t => AS.MOV (d, AS.MEM (AS.MOP t, munch_typ typ))) ts a
    | munch_exp ts d (T.CALL (l, t, L)) = let
          fun eval ((e, t), (i, T, I)) = let val (d, ds) = munch_half ts e in
                (i - 1, (d, t)::T, ds @ I)
              end
          val (callable, CI) = munch_half ts l
          (* evaluate all arguments, generating their results *)
          val (_, T, I) = foldr eval (length L - 1, [], []) L
          (* move the result into the argument registers *)
          fun dst i t = if i < Arch.arg_regs then AS.REG (Arch.arg_reg i, t)
                        else AS.MEM (AS.STACK ((i - Arch.arg_regs) *
                                               Arch.TArch.ptrsize), t)
          fun mv ((s, t), (i, L)) =
                (i - 1, AS.MOV (dst i (munch_typ t), s)::L)
          val (_, moves) = foldr mv (length T - 1, []) T
        in
          CI @ I @ moves @ [AS.CALL (callable, length L), AS.MOV (d, ret_reg t)]
        end
    | munch_exp _ d (T.ELABEL l) = [AS.MOV (d, AS.LABELOP l)]
    | munch_exp _ _ (T.PHI _) = raise Fail "Invalid expression"

  (* munch_half : T.typ -> T.exp -> (AS.operand * AS.instr list)
   *
   * Generates the minimum amount of instructions necessary to move the result
   * of the specified expression into an operand.
   *
   * @param typ the size of the destination and intermediate temps
   * @param exp the expression to shove into a register
   * @return the result of the computation and the instructions necessary to
   *         perform the computation
   *)
  and munch_half ts (T.TEMP (t, typ)) = (munch_temp ts (t, typ), [])
    | munch_half _ (T.CONST (n, typ)) = (AS.IMM (n, munch_typ typ), [])
    | munch_half _ (T.ELABEL l) = (AS.LABELOP l, [])
    | munch_half ts e = let
        fun guess_size (T.CONST (_, t) | T.TEMP (_, t) | T.LOAD (_, t) |
                        T.CALL (_, t, _)) = munch_typ t
          | guess_size (T.BINOP (oper, e1, e2)) =
            if eval_bool oper then Arch.intsize else let
              val (e1t, e2t) = (guess_size e1, guess_size e2)
            in
              if e1t = Arch.ptrsize orelse e2t = Arch.ptrsize then Arch.ptrsize
              else Arch.intsize
            end
          | guess_size _ = raise Fail "Invalid expression!"
        val t = AS.TEMP(Temp.new(), guess_size e)
      in (t, munch_exp ts t e) end

  and munch_half1 f ts e = let val (t, instrs) = munch_half ts e in
        instrs @ [f t]
      end
  and munch_half2 f ts e1 e2 = let
        val (t1, instrs1) = munch_half ts e1
        val (t2, instrs2) = munch_half ts e2
      in instrs1 @ instrs2 @ [f (t1, t2)] end

  (* munch_conditional : Label.label -> T.exp -> Assem.instr list
   *
   * Generates the instructions needed to jump to the specified label if the
   * expression evaluates to true.
   *
   * @param dest the destination to jump to if the expression is true
   * @param exp  the expression to evaluate
   * @return the instructions necessary to perform this conditional
   *)
  and munch_conditional ts dest (T.BINOP (oper, e1, e2)) =
        munch_half2 (fn (t1, t2) => AS.JMP (dest, SOME (munch_cond oper, t1, t2)))
                     ts e1 e2
    | munch_conditional ts dest (T.CONST (n, sz)) =
        if n <> Word32Signed.ZERO then [AS.JMP (dest, NONE)] else []
    | munch_conditional ts dest e =
        munch_half1 (fn t => AS.JMP (dest, SOME (AS.NEQ, t,
                                     AS.IMM (Word32Signed.ZERO, AS.size t))))
                    ts e

  (* munch_stm : T.typ -> T.stm -> AS.instr list
   *
   * Converts a statement of the IL into a list of assembly instructions.
   *
   * @param typ the return type of the current function
   * @param exp the expression to convert
   * @return L a list of abstract assembly instructions with temps
   *)
  fun munch_stm ts _ (T.MOVE (t, typ, e)) =
        munch_exp ts (munch_temp ts (t, typ)) e
    | munch_stm ts _ (T.STORE (a, typ, e)) = let
        val (t, instrs) = munch_half ts a
      in
        instrs @ munch_exp ts (AS.MEM (AS.MOP t, munch_typ typ)) e
      end
    | munch_stm ts t (T.RETURN e) = let
        val tmp = AS.TEMP (Temp.new(), munch_typ t)
      in
        munch_exp ts tmp e @ [AS.MOV (ret_reg t, tmp), AS.RET]
      end
    | munch_stm _ _ (T.LABEL l) = [AS.LABEL l]
    | munch_stm _ _ (T.GOTO (l, NONE)) = [AS.JMP (l, NONE)]
    | munch_stm ts _ (T.GOTO (l, SOME e)) = munch_conditional ts l e
    | munch_stm _ _ T.NOP = []
    | munch_stm _ _ _ = raise Fail "Invalid IR"
  and munch_stmts ts t stmts = foldr (op @) [] (map (munch_stm ts t) stmts)

  (* stack_size : T.stm list -> int
   *
   * Computes the amount of stack space needed for the given function
   *)
  fun stack_size I = let
        val ptrsz = Arch.TArch.ptrsize
        val intsz = Arch.TArch.intsize
        fun build_maps (AS.MEM (AS.STACKLOC n, s), (w, q)) =
              (if s = Arch.ptrsize then
                case IBM.find (q, n)
                  of SOME _ => (w, q)
                   | NONE   => (w, IBM.insert (q, n, ptrsz * IBM.numItems q))
              else
                case IBM.find (w, n)
                  of SOME _ => (w, q)
                   | NONE   => (IBM.insert (w, n, intsz * IBM.numItems w), q))
          | build_maps (i, maps) = maps

        val (ints, ptrs) = AS.fold_operands build_maps (IBM.empty,IBM.empty) I
        val local_bytes = intsz * IBM.numItems ints + ptrsz * IBM.numItems ptrs

        (* Returns the maximum amount of stack slots needed to call functions *)
        fun max_call (AS.CALL (_, a), n) = Int.max (a - Arch.arg_regs, n)
          | max_call (_, n) = n
        val max_args = foldr max_call 0 I
        val stack_bytes = Arch.align_stack (max_args * ptrsz + local_bytes)

        (* Maps stack locations to the correct place *)
        fun map_op (AS.MEM (AS.STACKARG n, s)) =
              AS.MEM (AS.STACK (ptrsz * (n + 1) + stack_bytes), s)
          | map_op (AS.MEM (AS.STACKLOC n, s)) = let
              val off = if s = Arch.ptrsize then valOf(IBM.find (ptrs, n))
                        else (valOf(IBM.find (ints, n)) + ptrsz*IBM.numItems ptrs)
            in
              AS.MEM (AS.STACK (off + stack_bytes - local_bytes), s)
            end
          | map_op oper = oper

      in
        (AS.map_operands map_op I, stack_bytes)
      end

  (* munch_function : T.typ * (Temp.temp * T.typ) list * T.stm list
   *                    -> AS.instr list
   *
   * Converts and IR function into allocated assembly.
   * @param T the list of temps that are arguments to this function. The list
   *        represents the order of the arguments as well.
   * @param L the list of statements that comprise this function.
   * @return the assembly instructions for the function
   *)
  fun munch_function (id, t, T, L) = let
        fun alter_ret post (AS.RET, L) = post @ AS.RET :: L
          | alter_ret _ (i, L) = i :: L
        (* Initialize the mapping of temps to operands with the arguments to
         * this function. If the argument comes from a register, then actually
         * move it into a temp and record the temp. Otherwise, just leave it on
         * the stack and reference the stack location to avoid unnecessary
         * creation of temps. *)
        val ts = HT.mkTable (T.tmphash, T.tmpequals) (97, Fail "Temp bug")
        fun mkargs i [] = []
          | mkargs i ((t, typ)::L) = let
              val t' = munch_typ typ
              val (instrs, oper) =
                    if i >= Arch.arg_regs then
                      ([], AS.MEM (AS.STACKARG (i - Arch.arg_regs), t'))
                    else let val dst = AS.TEMP (t, t') in
                      ([AS.MOV (dst, AS.REG (Arch.arg_reg i, t'))], dst)
                    end
            in
              HT.insert ts ((t, ref 0), oper);
              instrs @ mkargs (i + 1) L
            end
        val argmvs = mkargs 0 T

        fun constrain (x :: L) = AS.constrain x @ constrain L
          | constrain [] = []

        val L' = P.time ("Munching", fn () => constrain (munch_stmts ts t L))
        val L'' = if not (Options.opt_on 2) then L'
                  else P.time ("Peephole", fn() => Peep.optimize id L')
        val instrs = AS.LABEL (Label.literal (Label.str id ^ "_start")) ::
                       argmvs @ L''
        val assem = Alloc.allocate (id, instrs)

        (* Make sure we have a stack for this function *)
        val sp = AS.REG (Arch.sp, Arch.ptrsize)
        fun add_sp i = AS.BINOP(AS.ADD, sp, sp,
                                 AS.IMM (Word32.fromInt i, Arch.ptrsize))
        val (assem', offset) = stack_size assem
      in
        add_sp (~offset) :: foldr (alter_ret [add_sp offset]) [] assem'
      end

  (* codegen : T.program -> AS.instr list
   *
   * Performs code generation on a list of statements of the intermediate
   * language. The assembly instructions returned have no temps. The registers
   * are all allocated and ready to be formatted into real assemly.
   *
   * @param stmts a list of statements in the intermediate language
   * @return a list of instructions with allocated registers
   *)
  fun codegen program = let
        fun geni ((id, st), t, T, L) =
              (if st then [] else [AS.DIRECTIVE (".globl " ^ Label.name id)])
                @ (AS.LABEL id) :: munch_function (id, t, T, L)
      in
        (foldr (op @) [] (map geni program))
      end

end
