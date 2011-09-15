(* L1 Compiler
 * Assembly language
 * Author: Kaustuv Chaudhuri <kaustuv+@andrew.cmu.edu>
 * Modified By: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Currently just a pseudo language with 3-operand
 * instructions and arbitrarily many temps
 *
 * We write
 *
 * BINOP  operand1 <- operand2,operand3
 * MOV    operand1 <- operand2
 *
 *)

signature ASSEM =
sig
  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | STACK of int

  datatype operand =
     IMM of Word32.word
   | REG of reg
   | TEMP of Temp.temp

  datatype operation = ADD | SUB | MUL | DIV | MOD

  datatype instr =
     BINOP of operation * operand * operand * operand
   | MOV of operand * operand
   | RET
   | DIRECTIVE of string
   | COMMENT of string

  val format : instr -> string
end

structure Assem :> ASSEM =
struct

  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | STACK of int

  datatype operand =
     IMM of Word32.word
   | REG of reg
   | TEMP of Temp.temp

  datatype operation = ADD | SUB | MUL | DIV | MOD

  datatype instr =
     BINOP of operation * operand * operand * operand
   | MOV of operand * operand
   | RET
   | DIRECTIVE of string
   | COMMENT of string

  (* functions that format assembly output *)

  fun format_reg EAX = "%eax"
  |   format_reg EBX = "%ebx"
  |   format_reg ECX = "%ecx"
  |   format_reg EDX = "%edx"
  |   format_reg EDI = "%edi"
  |   format_reg ESI = "%esi"
  |   format_reg R8D = "%r8d"
  |   format_reg R9D = "%r9d"
  |   format_reg R10D = "%r10d"
  |   format_reg R11D = "%r11d"
  |   format_reg R12D = "%r12d"
  |   format_reg R13D = "%r13d"
  |   format_reg R14D = "%r14d"
  |   format_reg R15D = "%r15d"
  |   format_reg (STACK n) = "todo"

  fun format_binop ADD = "add"
    | format_binop SUB = "sub"
    | format_binop MUL = "mul"
    | format_binop DIV = "idiv"
    | format_binop MOD = "mod"

  fun format_operand (IMM(n))  = "$" ^ Word32Signed.toString(n)
    | format_operand (TEMP(t)) = Temp.name(t)
    | format_operand (REG(r))  = format_reg r

  fun format (BINOP(DIV, d, s1, s2)) =
      "\tmov " ^ format_operand s1 ^ ", %eax\n" ^
      "\tmov $0, %edx\n" ^
      "\t" ^ format_binop DIV ^ " " ^ format_operand s2 ^ "\n" ^
      "\tmov %eax, " ^ format_operand d ^ "\n"
    | format (BINOP(oper, d, s1, s2)) =
      "\tmov " ^ format_operand s1 ^ ", " ^ format_operand d ^ "\n" ^
      "\t" ^ format_binop oper ^ " " ^ format_operand s2 ^ ", "
           ^ format_operand d ^ "\n"
    | format (MOV(d, s)) =
        "\t" ^ "mov" ^ " " ^ format_operand s ^ ", " ^ format_operand d ^ "\n"
    | format (DIRECTIVE(str)) = str ^ "\n"
    | format (COMMENT(str)) = "\t" ^ "/* " ^ str ^ "*/\n"
    | format (RET) = "\tret\n"

end
