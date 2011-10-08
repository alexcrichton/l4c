(* L3 Compiler
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

  fun arg_reg 0 = AS.REG AS.EDI
    | arg_reg 1 = AS.REG AS.ESI
    | arg_reg 2 = AS.REG AS.EDX
    | arg_reg 3 = AS.REG AS.ECX
    | arg_reg 4 = AS.REG AS.R8D
    | arg_reg 5 = AS.REG AS.R9D
    | arg_reg n = raise Fail "args in stack locations is scary"

  (* munch_exp : AS.operand -> T.exp -> AS.instr list
   *
   * generates instructions to achieve d <- e, d must be TEMP(t) or REG(r)
   * @param d the destination of the expression
   * @param exp the expression to convert
   * @return the instructions needed to move the result of the expression into
   *         the destination
   *)
  fun munch_exp d (T.CONST n) = [AS.MOV(d, AS.IMM(n))]
    | munch_exp d (T.TEMP t)  = [AS.MOV(d, AS.TEMP(t))]
    | munch_exp d (T.BINOP (binop, e1, e2)) = munch_binop d (binop, e1, e2)
    | munch_exp d (T.CALL (l, L)) = let
          fun eval (e, (T, I)) = let val t = AS.TEMP (Temp.new()) in
                                   (t::T, (munch_exp t e) @ I)
                                 end
          val (T, I) = foldr eval ([], []) L
          val temps = map (fn _ => AS.TEMP (Temp.new())) AS.caller_regs
          val pushes = ListPair.map (fn t => AS.MOV t) (temps, AS.caller_regs)
          val pops   = ListPair.map (fn t => AS.MOV t) (AS.caller_regs, temps)
          fun mv (AS.REG (AS.STACK _), s) = raise Fail "figure me out"
            | mv t = AS.MOV t
          val moves = ListPair.map mv (List.tabulate (length T, arg_reg), T)
          val post = if length L <= 6 then [] else [AS.BINOP (AS.ADD64, AS.REG AS.ESP,
                                    AS.IMM (Word32.fromInt (8 * (length L - 6))))]
        in
          I @ pushes @ rev moves @ (AS.CALL (l, length L))::post @ pops @
          [AS.MOV (d, AS.REG AS.EAX)]
        end

  (* munch_half : AS.binop -> T.exp -> (AS.operand * AS.instr list)
   *
   * Generates the minimum amount of instructions necessary to move the result
   * of the specified expression into an operand. This is conditional based
   * on the binop because some x86 instructions have weird conditions on what
   * their operands can be.
   *
   * @param oper the operation that this expression is a half of
   * @param exp the expression to shove into a register
   * @return the result of the computation and the instructions necessary to
   *         perform the computation
   *)
  and munch_half oper (T.TEMP t) = (AS.TEMP t, [])
    | munch_half (AS.DIV | AS.MOD | AS.CMP) (e as T.CONST n) = let
        val t = AS.TEMP(Temp.new())
      in (t, munch_exp t e) end
    | munch_half _ (T.CONST n) = (AS.IMM n, [])
    | munch_half oper e =
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
        val (t1, t1instrs) = munch_half oper e1
        val (t2, t2instrs) = munch_half oper e2
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
                else
                  [AS.MOV (d, t1), AS.MOV (AS.REG AS.ECX, t2),
                   AS.BINOP (oper, d, AS.REG AS.ECX)]
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
    | munch_conditional dest (T.TEMP n) =
        [AS.BINOP (AS.CMP, AS.TEMP n, AS.IMM Word32Signed.ZERO),
         AS.JMP(dest, SOME(AS.NEQ))]
    | munch_conditional dest (f as T.CALL _) = let val t = Temp.new() in
        munch_exp (AS.TEMP t) f @ munch_conditional dest (T.TEMP t)
      end
    | munch_conditional dest (T.BINOP (oper, e1, e2)) = let
        val (t1, t1instrs) = munch_half AS.CMP e1
        val (t2, t2instrs) = munch_half AS.CMP e2
        val cond = case oper of T.LT => AS.LT | T.LTE => AS.LTE
                              | T.EQ => AS.EQ | T.NEQ => AS.NEQ
                              | T.XOR => AS.NEQ
                              | _ => raise Fail "wut?"
      in
        t1instrs @ t2instrs @
          [AS.BINOP (AS.CMP, t1, t2), AS.JMP(dest, SOME cond)]
      end

  (* munch_stm : T.stm -> AS.instr list
   *
   * Converts a statement of the IL into a list of assembly instructions.
   *
   * @param exp the expression to convert
   * @return L a list of abstract assembly instructions with temps
   *)
  fun munch_stm (T.MOVE (T.TEMP t1, e2)) = munch_exp (AS.TEMP t1) e2
    | munch_stm (T.RETURN e) = munch_exp (AS.REG AS.EAX) e @ [AS.RET]
    | munch_stm (T.LABEL l)  = [AS.LABEL l]
    | munch_stm (T.GOTO (l, NONE)) = [AS.JMP (l, NONE)]
    | munch_stm (T.GOTO (l, SOME e)) = munch_conditional l e
    | munch_stm _ = raise Fail "Invalid IR"
  and munch_stmts stmts = foldr (op @) [] (map munch_stm stmts)

  (* munch_function : Temp.temp list -> T.stm list -> AS.instr list
   *
   * Converts and IR function into allocated assembly.
   * @param T the list of temps that are arguments to this function. The list
   *        represents the order of the arguments as well.
   * @param L the list of statements that comprise this function.
   * @return the assembly instructions for the function
   *)
  fun munch_function (T, L) = let
        (* Move the arguments to the function from their specified registers
           into the temps of the arguments *)
        val srcs     = List.tabulate (length T, arg_reg)
        val dests    = map (fn t => AS.TEMP t) T
        val argmvs   = ListPair.map (fn t => AS.MOV t) (dests, srcs)

        val L' = P.time ("Munching", fn () => argmvs @ munch_stmts L)
        val (max_reg, assem) = Allocation.allocate L'
        val stack_loc = Int.max (max_reg + 1, AS.reg_num (AS.STACK 0))
        (* Save/restore callee save registers *)
        val save_srcs = List.filter (fn AS.REG r => max_reg >= AS.reg_num r
                                      | _ => raise Fail "callee_regs bad")
                                    AS.callee_regs
        val save_dsts = List.tabulate (List.length save_srcs,
                                    fn i => AS.REG (AS.num_reg (i + stack_loc)))
        val saves    = ListPair.map (fn t => AS.MOV t) (save_dsts, save_srcs)
        val restores = ListPair.map (fn t => AS.MOV t) (save_srcs, save_dsts)

        (* Make sure we have a stack for this function *)
        val stack_start = AS.reg_num (AS.STACK 0)
        fun add_rsp i = AS.BINOP(AS.ADD64, AS.REG AS.ESP,
                                 AS.IMM (Word32.fromInt i))

        val max = stack_loc + (List.length save_srcs)
        val offset =
              if max < stack_start then 8
              else let val s = (max - stack_start + 1) * 4 in
                if s mod 16 = 8 then s else ((s + 8) div 16) * 16 + 8
              end
        val prologue = add_rsp (~offset) :: saves
        val epilogue = restores @ [add_rsp offset]
        fun alter_ret (AS.RET, L) = epilogue @ AS.RET :: L
          | alter_ret (i, L) = i :: L
      in
        prologue @ foldr alter_ret [] assem
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
        fun geni (id, T, L) = let
            in
              if length T > 6 then raise Fail "7+ args = bad" else ();
              (AS.LABEL id) :: munch_function (T, L)
            end
      in
        foldr (op @) [] (map geni program)
      end

end
