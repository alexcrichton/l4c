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
    | munch_exp d (T.BINOP (binop, e1, e2)) = let
        val oper = munch_op binop
        val (t1, t1instrs) = munch_half oper e1
        val (t2, t2instrs) = munch_half oper e2
        val instrs =
          case binop
            of (T.DIV | T.MOD) =>
                 [AS.MOV (AS.REG AS.EAX, t1), AS.ASM "cltd",
                  AS.BINOP (oper, AS.REG AS.EAX, t2),
                  AS.MOV (d, AS.REG (if binop = T.DIV then AS.EAX else AS.EDX))]
             | (T.RSH | T.LSH) =>
                  [AS.MOV (d, t1), AS.MOV (AS.REG AS.ECX, t2),
                   AS.BINOP (oper, d, AS.REG AS.ECX)]
             | _ => [AS.MOV (d, t1), AS.BINOP (oper, d, t2)]
      in
        t1instrs @ t2instrs @ (case binop
           of T.LT  => instrs @ [AS.MOVFLAG (d, AS.LT)]
            | T.LTE => instrs @ [AS.MOVFLAG (d, AS.LTE)]
            | T.EQ  => instrs @ [AS.MOVFLAG (d, AS.EQ)]
            | T.NEQ => instrs @ [AS.MOVFLAG (d, AS.NEQ)]
            | _     => instrs)
      end

  and munch_half (AS.DIV | AS.CMP | AS.MOD) e = let
        val t = AS.TEMP (Temp.new())
      in
        (t, munch_exp t e)
      end
    | munch_half _ (T.CONST n) = (AS.IMM n, [])
    | munch_half _ e = let val t = AS.TEMP (Temp.new()) in
        (t, munch_exp t e)
      end

  (* munch_conditional : Label.label -> T.exp -> AS.instr list
   *
   * Given a destination label and an expression, computes the instructions
   * such that the label is jumped to if the expression is true.
   *
   * @param dest the destination label if the expression is true
   * @param exp  the IR expression to be evaluated
   * @return the instruction list to jump if necessary
   *)
  and munch_conditional dest (T.CONST w) =
        if Word32Signed.ZERO = w then [] else [AS.JMP(dest, NONE)]
    | munch_conditional dest (T.TEMP n) =
        [AS.BINOP (AS.CMP, AS.TEMP n, AS.IMM Word32Signed.ZERO),
         AS.JMP(dest, SOME AS.NEQ)]
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

  (* codegen : T.stm list -> AS.instr list
   *
   * Performs code generation on a list of statements of the intermediate
   * language. The assembly instructions returned have no temps. The registers
   * are all allocated and ready to be formatted into real assemly.
   *
   * @param stmts a list of statements in the intermediate language
   * @return a list of instructions with allocated registers
   *)
  fun codegen stmts = Allocation.allocate (munch_stmts stmts)

end
