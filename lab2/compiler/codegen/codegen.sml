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

  (* munch_exp : AS.operand -> T.exp -> AS.instr list *)
  (* munch_exp d e
   * generates instructions to achieve d <- e
   * d must be TEMP(t) or REG(r)
   *)
  fun munch_exp d (T.CONST(n)) = [AS.MOV(d, AS.IMM(n))]
    | munch_exp d (T.TEMP(t))  = [AS.MOV(d, AS.TEMP(t))]
    | munch_exp d (T.BINOP(binop, e1, e2)) =
        munch_binop d (binop, e1, e2)

  (* munch_binop : AS.operand -> T.binop * T.exp * T.exp -> AS.instr list *)
  (* munch_binop d (binop, e1, e2)
   * generates instruction to achieve d <- e1 binop e2
   * d must be TEMP(t) or REG(r)
   *)
  and munch_binop d (binop, e1, e2) =
      let
        (* gen_temp : T.exp -> AS.operand * AS.instr list
         * Generates a temp variable to hold the result of T.exp and returns the
         * instructions necessary to create the temp.
         *)
        fun gen_temp e =
          let val t = AS.TEMP(Temp.new()) in (t, munch_exp t e) end
        (* calculate : T.exp -> AS.operand * AS.instr list
         * Takes an expression and returns the minimal number of instructions
         * to get it into a destination operand. For CONSTs and TEMPs, this
         * attempts to return just that destination. We have to make a special
         * exception for the DIV and MOD operations, however, because their
         * arguments must be a register, not an IMM.
         *)
        fun calculate (T.TEMP t)  = (AS.TEMP t, [])
          | calculate (T.CONST n) =
              if binop = T.DIV orelse binop = T.MOD then gen_temp (T.CONST n)
              else (AS.IMM n, [])
          | calculate e = gen_temp e
        val (t1, t1instrs) = calculate e1
        val (t2, t2instrs) = calculate e2
      in
        t1instrs @ t2instrs @ [AS.BINOP(munch_op binop, d, t1, t2)]
      end

  (* munch_stm : T.stm -> AS.instr list
   *
   * Converts a statement of the IL into a list of assembly instructions.
   *
   * @param exp the expression to convert
   * @return L a list of abstract assembly instructions with temps
   *)
  fun munch_stm (T.MOVE(T.TEMP(t1), e2)) = munch_exp (AS.TEMP(t1)) e2
    (* return e is implemented as %eax <- e *)
    | munch_stm (T.RETURN(e)) = munch_exp (AS.REG(AS.EAX)) e @ [AS.RET]
    | munch_stm _ = raise Fail "Invalid IL"

  (* codegen : T.stm list -> AS.instr list
   *
   * Performs code generation on a list of statements of the intermediate
   * language. The assembly instructions returned have no temps. The registers
   * are all allocated and ready to be formatted into real assemly.
   *
   * @param stmts a list of statements in the intermediate language
   * @return a list of instructions with allocated registers
   *)
  fun codegen stmts =
    Allocation.allocate (foldr (op @) [] (map munch_stm stmts))

end
