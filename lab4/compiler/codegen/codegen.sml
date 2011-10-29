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
  structure TR = Trans
  structure T = Tree
  structure AS = Assem
  structure P = Profile
  structure IBM = IntBinaryMap

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

  fun munch_typ T.WORD = AS.WORD
    | munch_typ T.QUAD = AS.QUAD

  fun size (AS.MEM (_, t) | AS.REG (_, t) |
            AS.TEMP (_, t) | AS.IMM(_, t)) = t

  (* munch_exp : AS.operand -> T.exp -> AS.instr list
   *
   * generates instructions to achieve d <- e, d must be TEMP(t) or REG(r)
   * @param d the destination of the expression
   * @param exp the expression to convert
   * @return the instructions needed to move the result of the expression into
   *         the destination
   *)
  fun munch_exp d (T.CONST (n, typ)) = [AS.MOV(d, AS.IMM (n, munch_typ typ))]
    | munch_exp d (T.TEMP (t, typ)) = [AS.MOV(d, AS.TEMP (t, munch_typ typ))]
    | munch_exp d (T.BINOP (binop, e1, e2)) = munch_binop d (binop, e1, e2)
    | munch_exp d (T.MEM (a, typ)) = let
        val t = AS.TEMP (Temp.new(), AS.QUAD)
        val instrs = munch_exp t a
      in
        instrs @ [AS.MOV(d, AS.MEM (t, munch_typ typ))]
      end
    | munch_exp d (T.CALL (l, t, L)) = let
          fun argdest typ n =
                case AS.arg_reg n
                  of AS.STACKARG n => AS.REG (AS.STACK (8 * n), munch_typ typ)
                   | _ => AS.TEMP (Temp.new(), munch_typ typ)

          fun eval ((e, t), (i, T, I)) = let val d = argdest t i in
                                           (i - 1, d::T, (munch_exp d e) @ I)
                                         end
          val (_, T, I) = foldr eval (length L - 1, [], []) L
          fun mv (s as (AS.TEMP (_, typ)), (i, L)) =
                (i - 1, AS.MOV(AS.REG(AS.arg_reg i, typ), s)::L)
            | mv (_, (i, L)) = (i - 1, L)
          val (_, moves) = foldr mv (length T - 1, []) T
          val ret = AS.REG (AS.EAX, munch_typ t)
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
  and munch_half oper (T.TEMP (t, typ)) = (AS.TEMP (t, munch_typ typ), [])
    | munch_half (AS.DIV | AS.MOD | AS.CMP) (e as T.CONST (_, typ)) = let
        val t = AS.TEMP(Temp.new(), munch_typ typ)
      in (t, munch_exp t e) end
    | munch_half _ (T.CONST (n, typ)) = (AS.IMM (n, munch_typ typ), [])
    | munch_half oper e = let
        fun guess_size (T.CONST (_, t) | T.TEMP (_, t) | T.MEM (_, t) |
                        T.CALL (_, t, _)) = munch_typ t
          | guess_size (T.BINOP (_, e1, e2)) = let
              val (e1t, e2t) = (guess_size e1, guess_size e2)
            in
              if e1t = AS.QUAD orelse e2t = AS.QUAD then AS.QUAD else AS.WORD
            end
        val t = AS.TEMP(Temp.new(), guess_size e)
      in (t, munch_exp t e) end

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
        fun promote r = if size r = AS.QUAD then ([], r)
                        else let val t = AS.TEMP (Temp.new(), AS.QUAD) in
                          ([AS.MOV(t, r)], t)
                        end
        val (t1, t2, t2instrs) =
          if size t1 = AS.QUAD orelse size t2 = AS.QUAD then let
              val (t1instrs', t1') = promote t1
              val (t2instrs', t2') = promote t2
            in
              (t1', t2', t2instrs @ t1instrs' @ t2instrs')
            end
          else (t1, t2, t2instrs)
        fun eq_ops (AS.TEMP (t1, _), AS.TEMP (t2, _)) = Temp.equals (t1, t2)
          | eq_ops (AS.REG (a, _), AS.REG (b, _)) = (a = b)
          | eq_ops _ = false

        fun reg r = AS.REG (r, size t1)
        val d' = if size d <> size t1 then AS.TEMP (Temp.new(), AS.QUAD)
                 else d
        (* x86 has weird conditions on instructions. Catch those oddities here
           and expand a single binop into multiple instructions as necessary *)
        val instrs =
          case binop
            of (T.DIV | T.MOD) =>
                 [AS.MOV (reg AS.EAX, t1), AS.ASM "cltd",
                  AS.BINOP (oper, reg AS.EAX, t2),
                  AS.MOV (d, reg (if binop = T.DIV then AS.EAX else AS.EDX))]
             | (T.RSH | T.LSH) =>
                if eq_ops (d, t2) then let
                    val t = AS.TEMP(Temp.new(), size t1)
                  in
                   [AS.MOV (t, t1), AS.MOV (reg AS.ECX, t2),
                    AS.BINOP (oper, t, reg AS.ECX), AS.MOV (d, t)]
                  end
                else (case t2
                        of AS.IMM _ => [AS.MOV (d, t1), AS.BINOP (oper, d, t2)]
                         | _ => [AS.MOV (d, t1), AS.MOV (reg AS.ECX, t2),
                                 AS.BINOP (oper, d, reg AS.ECX)])
             | _ => if not(eq_ops (d', t2)) then
                      [AS.MOV (d', t1), AS.BINOP (oper, d', t2)]
                    else if binop <> T.SUB then
                      [AS.MOV (d', t2), AS.BINOP (oper, d', t1)]
                    else let val t = AS.TEMP (Temp.new(), size t1) in
                      [AS.MOV (t, t1), AS.BINOP (oper, t, t2), AS.MOV (d', t)]
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
  and munch_conditional dest (T.CONST (w, T.WORD)) =
        if Word32Signed.ZERO = w then [] else [AS.JMP(dest, NONE)]
    | munch_conditional dest (T.TEMP (n, T.WORD)) =
        [AS.BINOP (AS.CMP, AS.TEMP (n, AS.WORD), AS.IMM (Word32Signed.ZERO, AS.WORD)),
         AS.JMP(dest, SOME(AS.NEQ))]
    | munch_conditional dest (f as T.CALL _) = let val t = Temp.new() in
        munch_exp (AS.TEMP (t, AS.WORD)) f @
          munch_conditional dest (T.TEMP (t, T.WORD))
      end
    | munch_conditional dest (T.BINOP (oper, e1, e2)) = let
        val (t1, t1instrs) = munch_half AS.CMP e1
        val (t2, t2instrs) = munch_half AS.CMP e2
        val _ = if size t1 <> size t2 then raise Fail "diff size" else ()
        val cond = case oper of T.LT => AS.LT | T.LTE => AS.LTE
                              | T.EQ => AS.EQ | T.NEQ => AS.NEQ
                              | T.XOR => AS.NEQ
                              | _ => raise Fail "wut?"
      in
        t1instrs @ t2instrs @
          [AS.BINOP (AS.CMP, t1, t2), AS.JMP(dest, SOME cond)]
      end
    | munch_conditional dest (T.MEM (a, T.WORD)) = let
        val (t, tinstrs) = munch_half AS.CMP a
      in
        [AS.BINOP (AS.CMP, t, AS.IMM (Word32Signed.ZERO, size t)),
         AS.JMP(dest, SOME(AS.NEQ))]
      end
    | munch_conditional _ _ = raise Fail "bad types in munch_conditional"

  (* munch_stm : T.typ -> T.stm -> AS.instr list
   *
   * Converts a statement of the IL into a list of assembly instructions.
   *
   * @param typ the return type of the current function
   * @param exp the expression to convert
   * @return L a list of abstract assembly instructions with temps
   *)
  fun munch_stm _ (T.MOVE (T.TEMP (t, typ), e)) =
        munch_exp (AS.TEMP (t, munch_typ typ)) e
    | munch_stm _ (T.MOVE (T.MEM (a, typ), e)) = let
        val t = AS.TEMP (Temp.new(), AS.QUAD)
      in
        munch_exp t a @ munch_exp (AS.MEM (t, munch_typ typ)) e
      end
    | munch_stm t (T.RETURN e) = munch_exp (AS.REG (AS.EAX, t)) e @ [AS.RET]
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
        fun build_map_ops (AS.REG (AS.STACKLOC n, s), (w, q)) =
              (if s = AS.QUAD then
                case IBM.find (q, n)
                  of SOME _ => (w, q)
                   | NONE   => (w, IBM.insert (q, n, 8 * IBM.numItems q))
              else
                case IBM.find (w, n)
                  of SOME _ => (w, q)
                   | NONE   => (IBM.insert (w, n, 4 * IBM.numItems w), q))
          | build_map_ops (AS.MEM (r, _), maps) = build_map_ops (r, maps)
          | build_map_ops (i, maps) = maps

        fun build_maps ((AS.BINOP (_, o1, o2) | AS.MOV (o1, o2)), maps) =
              build_map_ops (o1, (build_map_ops (o2, maps)))
          | build_maps (AS.MOVFLAG (oper, _), maps) = build_map_ops (oper, maps)
          | build_maps (_, maps) = maps
        val (words, quads) = foldl build_maps (IBM.empty, IBM.empty) I
        val local_bytes = 4 * IBM.numItems words + 8 * IBM.numItems quads

        (* Returns the maximum amount of stack slots needed to call functions *)
        fun max_call (AS.CALL (_, a), n) = Int.max (a - 6, n)
          | max_call (_, n) = n
        val max_args = foldr max_call 0 I
        val stack_bytes = ((max_args * 8 + local_bytes - 8) div 16) * 16 + 24

        (* Maps stack locations to the correct place *)
        fun map_op (AS.REG (AS.STACKARG n, s)) =
              AS.REG (AS.STACK (8 * (n+1) + stack_bytes), s)
          | map_op (AS.REG (AS.STACKLOC n, s)) = let
              val off = if s = AS.QUAD then valOf(IBM.find (quads, n))
                        else (valOf(IBM.find (words, n)) + 8*IBM.numItems quads)
            in
              AS.REG (AS.STACK (off + stack_bytes - local_bytes), s)
            end
          | map_op (AS.MEM (oper, t)) = AS.MEM (map_op oper, t)
          | map_op oper = oper

        fun map_instr (AS.BINOP (oper, op1, op2)) =
              AS.BINOP (oper, map_op op1, map_op op2)
          | map_instr (AS.MOV (op1, op2)) = AS.MOV (map_op op1, map_op op2)
          | map_instr (AS.MOVFLAG (op1, c)) = AS.MOVFLAG (map_op op1, c)
          | map_instr i = i
      in
        (map map_instr I, stack_bytes)
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
  fun munch_function (t, T , L) = let
        fun alter_ret post (AS.RET, L) = post @ AS.RET :: L
          | alter_ret _ (i, L) = i :: L
        (* Move the arguments to the function from their specified registers
           into the temps of the arguments *)
        fun mkarg i = let val (_, typ) = List.nth (T, i) in
                        AS.REG (AS.arg_reg i, munch_typ typ)
                      end
        val srcs     = List.tabulate (length T, mkarg)
        val dests    = map (fn (t, typ) => AS.TEMP (t, munch_typ typ)) T
        val argmvs   = ListPair.map (fn t => AS.MOV t) (dests, srcs)

        (* Save/restore callee save registers *)
        val save_srcs = map (fn r => AS.REG (r, AS.QUAD)) AS.callee_regs
        val save_dsts = map (fn _ => AS.TEMP (Temp.new(), AS.QUAD)) save_srcs
        val saves    = ListPair.map (fn t => AS.MOV t) (save_dsts, save_srcs)
        val restores = ListPair.map (fn t => AS.MOV t) (save_srcs, save_dsts)

        val L' = P.time ("Munching", fn () => munch_stmts (munch_typ t) L)
        val instrs = saves @ argmvs @ foldr (alter_ret restores) [] L'
        val (max, assem) = Allocation.allocate instrs

        (* Make sure we have a stack for this function *)
        val stack_start = AS.reg_num (AS.STACK 0)
        fun add_rsp i = AS.BINOP(AS.ADD, AS.REG (AS.ESP, AS.QUAD),
                                 AS.IMM (Word32.fromInt i, AS.QUAD))

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
