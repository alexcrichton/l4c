(* L4 Compiler
 * Codegen
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature CODEGEN =
sig
  val codegen : Tree.program -> Assem.instr list
end

structure Codegen :> CODEGEN =
struct
  structure T = Tree
  structure AS = Assem
  structure P = Profile

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
    | munch_op _     = AS.CMP (* LT, LTE, EQ, NEQ *)

  (* munch_exp : AS.operand -> T.exp -> AS.instr list
   *
   * generates instructions to achieve d <- e, d must be TEMP(t) or REG(r)
   * @param d the destination of the expression
   * @param exp the expression to convert
   * @return the instructions needed to move the result of the expression into
   *         the destination
   *)
  fun munch_exp d (T.CONST n) = [AS.MOV(d, AS.IMM(n))]
    | munch_exp d (T.TEMP (t, T.WORD)) = [AS.MOV(d, AS.TEMP t)]
    | munch_exp d (T.TEMP (t, T.QUAD)) = [AS.MOV(d, AS.O64 (AS.TEMP t))]
    | munch_exp d (T.BINOP (T.DIV, e1, T.CONST n)) =
        if Word32.compare (n, Word32.fromInt 1) = EQUAL then munch_exp d e1
        else munch_binop d (T.DIV, e1, T.CONST n)
    | munch_exp d (T.BINOP (binop, e1, e2)) = munch_binop d (binop, e1, e2)
    | munch_exp d (T.MEM a) = let val instrs = munch_exp (AS.O64 d) a in
        instrs @ [AS.MOV(d, AS.MEM d)]
      end
    | munch_exp d (T.CALL (l, t, L)) = let
          fun argdest typ n = let
                val t = case AS.arg_reg n
                          of AS.REG (AS.STACKARG n) => AS.REG (AS.STACK (8 * n))
                           | _ => AS.TEMP (Temp.new())
              in
                if typ = T.QUAD then AS.O64 t else t
              end

          fun eval ((e, t), (i, T, I)) = let val d = argdest t i in
                                           (i - 1, d::T, (munch_exp d e) @ I)
                                         end
          val (_, T, I) = foldr eval (length L - 1, [], []) L
          fun mv (s as AS.TEMP _, (i, L)) =
                (i - 1, AS.MOV(AS.arg_reg i, s)::L)
            | mv (_, (i, L)) = (i - 1, L)
          val (_, moves) = foldr mv (length T - 1, []) T
          val ret' = AS.REG AS.EAX
          val ret = case t of T.QUAD => AS.O64 ret' | _ => ret'
        in
          I @ moves @ [AS.CALL (l, length L), AS.MOV (d, ret)]
        end

  (* munch_half : T.typ -> AS.binop -> T.exp -> (AS.operand * AS.instr list)
   *
   * Generates the minimum amount of instructions necessary to move the result
   * of the specified expression into an operand. This is conditional based
   * on the binop because some x86 instructions have weird conditions on what
   * their operands can be.
   *
   * @param typ the size of the destination and intermediate temps
   * @param oper the operation that this expression is a half of
   * @param exp the expression to shove into a register
   * @return the result of the computation and the instructions necessary to
   *         perform the computation
   *)
  and munch_half _ oper (T.TEMP (t, T.WORD)) = (AS.TEMP t, [])
    | munch_half _ oper (T.TEMP (t, T.QUAD)) = (AS.O64 (AS.TEMP t), [])
    | munch_half _ (AS.DIV | AS.MOD | AS.CMP) (e as T.CONST n) = let
        val t = AS.TEMP(Temp.new())
      in (t, munch_exp t e) end
    | munch_half _ _ (T.CONST n) = (AS.IMM n, [])
    | munch_half T.QUAD oper e =
        let val t = AS.O64(AS.TEMP(Temp.new())) in (t, munch_exp t e) end
    | munch_half T.WORD oper e =
        let val t = AS.TEMP(Temp.new()) in (t, munch_exp t e) end

  (* munch_binop : AS.operand -> T.binop * T.exp * T.exp -> AS.instr list
   *
   * Generates instruction to achieve d <- e1 binop e2, d must be TEMP(t) or
   * REG(r)
   *
   * @param d the destination of the binary operation
   * @param binop the binop going on
   * @param e1 the first expression of the binop
   * @param e2 the second expression of the binop
   * @return the list of instructions needed to perform the operation and move
   *         it into the destination register
   *)
  and munch_binop d (binop, e1, e2) =
      let
        val oper = munch_op binop
        val size = case d of AS.O64 _ => T.QUAD | _ => T.WORD
        val (t1, t1instrs) = munch_half size oper e1
        val (t2, t2instrs) = munch_half size oper e2
        fun eq_ops (AS.TEMP t1, AS.TEMP t2) = Temp.equals (t1, t2)
          | eq_ops (AS.REG a, AS.REG b) = (a = b)
          | eq_ops _ = false

        (* x86 has weird conditions on instructions. Catch those oddities here
           and expand a single binop into multiple instructions as necessary *)
        val instrs =
          case binop
            of (T.DIV | T.MOD) =>
                 [AS.MOV (AS.REG AS.EAX, t1), AS.ASM "cltd",
                  AS.BINOP (oper, AS.REG AS.EAX, t2),
                  AS.MOV (d, AS.REG (if binop = T.DIV then AS.EAX else AS.EDX))]
             | (T.RSH | T.LSH) =>
                if eq_ops (d, t2) then let val t = AS.TEMP (Temp.new()) in
                   [AS.MOV (t, t1), AS.MOV (AS.REG AS.ECX, t2),
                    AS.BINOP (oper, t, AS.REG AS.ECX), AS.MOV (d, t)]
                  end
                else (case t2
                        of AS.IMM _ => [AS.MOV (d, t1), AS.BINOP (oper, d, t2)]
                         | _ => [AS.MOV (d, t1), AS.MOV (AS.REG AS.ECX, t2),
                                 AS.BINOP (oper, d, AS.REG AS.ECX)])
             | _ => if not(eq_ops (d, t2)) then
                      [AS.MOV (d, t1), AS.BINOP (oper, d, t2)]
                    else if binop <> T.SUB then
                      [AS.MOV (d, t2), AS.BINOP (oper, d, t1)]
                    else let val t = AS.TEMP (Temp.new()) in
                      [AS.MOV (t, t1), AS.BINOP (oper, t, t2), AS.MOV (d, t)]
                    end
      in
        t1instrs @ t2instrs @ (case binop
           of T.LT  => instrs @ [AS.MOVFLAG (d, AS.LT)]
            | T.LTE => instrs @ [AS.MOVFLAG (d, AS.LTE)]
            | T.EQ  => instrs @ [AS.MOVFLAG (d, AS.EQ)]
            | T.NEQ => instrs @ [AS.MOVFLAG (d, AS.NEQ)]
            | _     => instrs)
      end

  (* munch_conditional : Label.label -> T.exp -> Assem.instr list
   *
   * Generates the instructions needed to jump to the specified label if the
   * expression evaluates to true.
   *
   * @param dest the destination to jump to if the expression is true
   * @param exp  the expression to evaluate
   * @return the instructions necessary to perform this conditional
   *)
  and munch_conditional dest (T.CONST w) =
        if Word32Signed.ZERO = w then [] else [AS.JMP(dest, NONE)]
    | munch_conditional dest (T.TEMP (n, T.WORD)) =
        [AS.BINOP (AS.CMP, AS.TEMP n, AS.IMM Word32Signed.ZERO),
         AS.JMP(dest, SOME(AS.NEQ))]
    | munch_conditional dest (T.TEMP (_, T.QUAD)) =
        raise Fail "64 bit bool in IR?"
    | munch_conditional dest (f as T.CALL _) = let val t = Temp.new() in
        munch_exp (AS.TEMP t) f @ munch_conditional dest (T.TEMP (t, T.WORD))
      end
    | munch_conditional dest (T.BINOP (oper, e1, e2)) = let
        val (t1, t1instrs) = munch_half T.WORD AS.CMP e1
        val (t2, t2instrs) = munch_half T.WORD AS.CMP e2
        val cond = case oper of T.LT => AS.LT | T.LTE => AS.LTE
                              | T.EQ => AS.EQ | T.NEQ => AS.NEQ
                              | T.XOR => AS.NEQ
                              | _ => raise Fail "wut?"
      in
        t1instrs @ t2instrs @
          [AS.BINOP (AS.CMP, t1, t2), AS.JMP(dest, SOME cond)]
      end
    | munch_conditional dest (T.MEM a) = let
        val (t, tinstrs) = munch_half T.WORD AS.CMP a
      in
        [AS.BINOP (AS.CMP, t, AS.IMM Word32Signed.ZERO),
         AS.JMP(dest, SOME(AS.NEQ))]
      end

  (* munch_stm : T.typ -> T.stm -> AS.instr list
   *
   * Converts a statement of the IL into a list of assembly instructions.
   *
   * @param typ the return type of the current function
   * @param exp the expression to convert
   * @return L a list of abstract assembly instructions with temps
   *)
  fun munch_stm _ (T.MOVE (T.TEMP (t, T.WORD), e)) = munch_exp (AS.TEMP t) e
    | munch_stm _ (T.MOVE (T.TEMP (t, T.QUAD), e)) =
        munch_exp (AS.O64 (AS.TEMP t)) e
    | munch_stm _ (T.MOVE (T.MEM a, e)) = let
        val t = AS.O64 (AS.TEMP (Temp.new()))
      in
        munch_exp t a @ munch_exp (AS.MEM t) e
      end
    | munch_stm t (T.RETURN e) = let
        val eax = AS.REG AS.EAX
        val dest = if t = T.QUAD then AS.O64 eax else eax
      in munch_exp dest e @ [AS.RET] end
    | munch_stm _ (T.LABEL l)  = [AS.LABEL l]
    | munch_stm _ (T.GOTO (l, NONE)) = [AS.JMP (l, NONE)]
    | munch_stm _ (T.GOTO (l, SOME e)) = munch_conditional l e
    | munch_stm _ _ = raise Fail "Invalid IR"
  and munch_stmts t stmts = foldr (op @) [] (map (munch_stm t) stmts)

  (* stack_size : T.stm list * int -> int
   *
   * Computes the amount of stack space needed for the given function
   *)
  fun stack_size (I, locals) = let
        (* Returns the maximum amount of stack slots needed to call functions *)
        fun max_call (AS.CALL (_, a), n) = Int.max (a - 6, n)
          | max_call (_, n) = n
        val max_args = foldr max_call 0 I
        val local_bytes = 4 * (Int.max (0, locals - (AS.reg_num (AS.STACKLOC 0)) + 1))
        val stack_bytes = ((max_args * 8 + local_bytes - 8) div 16) * 16 + 24
        (* Maps stack locations to the correct place *)
        fun map_op (AS.REG (AS.STACKARG n)) =
              AS.REG (AS.STACK (8 * (n+1) + stack_bytes))
          | map_op (AS.REG (AS.STACKLOC n)) =
              AS.REG (AS.STACK (n * 4 + stack_bytes - local_bytes))
          | map_op (AS.O64 oper) = AS.O64 (map_op oper)
          | map_op (AS.MEM oper) = AS.MEM (map_op oper)
          | map_op oper = oper

        fun map_instr (AS.BINOP (oper, op1, op2)) =
              AS.BINOP (oper, map_op op1, map_op op2)
          | map_instr (AS.MOV (op1, op2)) = AS.MOV (map_op op1, map_op op2)
          | map_instr (AS.MOVFLAG (op1, c)) = AS.MOVFLAG (map_op op1, c)
          | map_instr i = i
      in
        (map map_instr I, stack_bytes)
      end

  (* munch_function : Temp.temp list -> T.stm list -> AS.instr list
   *
   * Converts and IR function into allocated assembly.
   * @param T the list of temps that are arguments to this function. The list
   *        represents the order of the arguments as well.
   * @param L the list of statements that comprise this function.
   * @return the assembly instructions for the function
   *)
  fun munch_function (t, T, L) = let
        fun alter_ret post (AS.RET, L) = post @ AS.RET :: L
          | alter_ret _ (i, L) = i :: L
        (* Move the arguments to the function from their specified registers
           into the temps of the arguments *)
        val srcs     = List.tabulate (length T, AS.arg_reg)
        fun arg (t, typ) =
              if typ = T.WORD then AS.TEMP t else AS.O64 (AS.TEMP t)
        val dests    = map arg T
        val argmvs   = ListPair.map (fn t => AS.MOV t) (dests, srcs)

        (* Save/restore callee save registers *)
        val save_srcs = AS.callee_regs
        val save_dsts = map (fn _ => AS.TEMP (Temp.new())) save_srcs
        val saves    = ListPair.map (fn t => AS.MOV t) (save_dsts, save_srcs)
        val restores = ListPair.map (fn t => AS.MOV t) (save_srcs, save_dsts)

        val L' = P.time ("Munching", fn () => munch_stmts t L)
        val instrs = saves @ argmvs @ foldr (alter_ret restores) [] L'
        val (max, assem) = Allocation.allocate instrs

        (* Make sure we have a stack for this function *)
        val stack_start = AS.reg_num (AS.STACK 0)
        fun add_rsp i = AS.BINOP(AS.ADD, AS.O64 (AS.REG AS.ESP),
                                 AS.IMM (Word32.fromInt i))

        val (assem', offset) = stack_size (assem, max)
      in
        add_rsp (~offset) :: foldr (alter_ret [add_rsp offset]) [] assem'
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
        fun geni (id, t, T, L) = (AS.LABEL id) :: munch_function (t, T, L)
      in
        foldr (op @) [] (map geni program)
      end

end
