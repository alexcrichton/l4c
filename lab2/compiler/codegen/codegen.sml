(* L2 Compiler
 * Codegen
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature CODEGEN =
sig
  val codegen : Tree.stm list -> Assem.instr list
end

structure Codegen :> CODEGEN =
struct
  structure T = Tree
  structure AS = Assem

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

  (* munch_exp : AS.operand -> T.exp -> AS.instr list *)
  (* munch_exp d e
   * generates instructions to achieve d <- e
   * d must be TEMP(t) or REG(r)
   *)
  fun munch_exp d (T.CONST n) = [AS.MOV(d, AS.IMM(n))]
    | munch_exp d (T.TEMP t)  = [AS.MOV(d, AS.TEMP(t))]
    | munch_exp d (T.BINOP (binop, e1, e2)) = munch_binop d (binop, e1, e2)
    | munch_exp d (T.TERN (e, et, ef)) = let
        val (lFalse, lEnd) = (AS.label(), AS.label())
        val cond = munch_conditional lFalse e
      in
        cond @ munch_exp d et @ [AS.JMP (lEnd, NONE), AS.LABEL lFalse] @
          munch_exp d ef @ [AS.LABEL lEnd]
      end

  and munch_half oper (T.TEMP t) = (AS.TEMP t, [])
    (*| munch_half oper (e as T.CONST n) =
        if oper <> AS.DIV andalso oper <> AS.MOD then (AS.IMM n, [])
        else let val t = AS.TEMP(Temp.new()) in (t, munch_exp t e) end*)
    | munch_half oper e =
        let val t = AS.TEMP(Temp.new()) in (t, munch_exp t e) end

  (* munch_binop : AS.operand -> T.binop * T.exp * T.exp -> AS.instr list *)
  (* munch_binop d (binop, e1, e2)
   * generates instruction to achieve d <- e1 binop e2
   * d must be TEMP(t) or REG(r)
   *)
  and munch_binop d (binop, e1, e2) =
      let
        val oper = munch_op binop
        val (t1, t1instrs) = munch_half oper e1
        val (t2, t2instrs) = munch_half oper e2
        val instr = AS.BINOP (oper, d, t1, t2)
      in
        t1instrs @ t2instrs @
        (case binop
           of T.LT  => [instr, AS.MOVFLAG (d, AS.LT)]
            | T.LTE => [instr, AS.MOVFLAG (d, AS.LTE)]
            | T.EQ  => [instr, AS.MOVFLAG (d, AS.EQ)]
            | T.NEQ => [instr, AS.MOVFLAG (d, AS.NEQ)]
            | _     => [instr])
      end

  and munch_conditional dest (T.CONST w) =
        if Word32Signed.ZERO <> w then [] else [AS.JMP(dest, NONE)]
    | munch_conditional dest (T.TEMP n) =
        [AS.BINOP (AS.TST, AS.REG AS.EAX, AS.TEMP n, AS.TEMP n),
         AS.JMP(dest, SOME(AS.NEQ))]
    | munch_conditional dest (T.BINOP (oper, e1, e2)) = let
        val (t1, t1instrs) = munch_half AS.CMP e1
        val (t2, t2instrs) = munch_half AS.CMP e2
        val cond = case oper of T.LT => AS.LT | T.LTE => AS.LTE
                              | T.EQ => AS.EQ | T.NEQ => AS.NEQ
                              | T.XOR => AS.NEQ
                              | _ => raise Fail "wut?"
      in
        t1instrs @ t2instrs @
          [AS.BINOP (AS.CMP, AS.REG AS.EAX, t1, t2), AS.JMP(dest, SOME cond)]
      end
    | munch_conditional dest (T.TERN (e, et, ef)) = let
        val (falsel, endl) = (AS.label(), AS.label())
      in
        munch_conditional falsel e @
        munch_conditional dest et @
        [AS.JMP (endl, NONE), AS.LABEL falsel] @
        munch_conditional dest ef @
        [AS.LABEL endl]
      end

  (* munch_stm : AS.label -> AS.label -> T.stm -> AS.instr list
   *
   * Converts a statement of the IL into a list of assembly instructions.
   *
   * @param exp the expression to convert
   * @return L a list of abstract assembly instructions with temps
   *)
  fun munch_stm _ _ (T.MOVE (T.TEMP t1, e2)) = munch_exp (AS.TEMP t1) e2
    | munch_stm _ _ (T.RETURN e) = munch_exp (AS.REG AS.EAX) e @ [AS.RET]
    | munch_stm l _ T.CONTINUE   = [AS.JMP (l, NONE)]
    | munch_stm _ l T.BREAK      = [AS.JMP (l, NONE)]
    | munch_stm _ _ (T.WHILE (e, S)) = let
        val (lStart, lEnd) = (AS.label (), AS.label ())
        val cond = munch_conditional lEnd e
        val body = munch_stmts lStart lEnd S
      in
        (AS.LABEL lStart) :: cond @ body @
          [AS.JMP (lStart, NONE), AS.LABEL lEnd]
      end
    | munch_stm c b (T.IF (e, S, S')) = let
        val (lElse, lEnd) = (AS.label (), AS.label ())
        val cond = munch_conditional lElse e
        val bdy = munch_stmts c b S
        val els = munch_stmts c b S'
      in
        cond @ bdy @ [AS.JMP (lEnd, NONE), AS.LABEL lElse] @ els @
          [AS.LABEL lEnd]
      end
    | munch_stm _ _ _ = raise Fail "Invalid IR"
  and munch_stmts c b stmts = foldr (op @) [] (map (munch_stm c b) stmts)

  (* codegen : T.stm list -> AS.instr list
   *
   * Performs code generation on a list of statements of the intermediate
   * language. The assembly instructions returned have no temps. The registers
   * are all allocated and ready to be formatted into real assemly.
   *
   * @param stmts a list of statements in the intermediate language
   * @return a list of instructions with allocated registers
   *)
  fun codegen stmts = let val label = AS.label () in
        Allocation.allocate (munch_stmts label label stmts)
      end

end
