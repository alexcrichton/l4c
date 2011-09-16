(* L1 Compiler
 * Assembly Code Generator for FAKE assembly
 * Author: Alex Vaynberg <alv@andrew.cmu.edu>
 * Based on code by: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Implements a "convenient munch" algorithm
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
      let val operator = munch_op binop
        val t1 = AS.TEMP(Temp.new())
        val t2 = AS.TEMP(Temp.new())
      in
        munch_exp t1 e1
        @ munch_exp t2 e2
        @ [AS.BINOP(operator, d, t1, t2)]
      end

  (* munch_stm : T.stm -> AS.instr list *)
  (* munch_stm stm generates code to execute stm *)
  fun munch_stm (T.MOVE(T.TEMP(t1), e2)) = munch_exp (AS.TEMP(t1)) e2
    (* return e is implemented as %eax <- e *)
    | munch_stm (T.RETURN(e)) = munch_exp (AS.REG(AS.EAX)) e @ [AS.RET]

  fun codegen_temps nil = nil
    | codegen_temps (stmt::stmts) = munch_stm stmt @ codegen_temps stmts

  fun codegen stmts = Allocation.allocate (codegen_temps stmts)

end
