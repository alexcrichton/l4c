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
   | ASM of string
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
   | ASM of string
   | DIRECTIVE of string
   | COMMENT of string

  (* functions that format assembly output *)

  fun format_reg EAX = "%eax"
    | format_reg EBX = "%ebx"
    | format_reg ECX = "%ecx"
    | format_reg EDX = "%edx"
    | format_reg EDI = "%edi"
    | format_reg ESI = "%esi"
    | format_reg R8D = "%r8d"
    | format_reg R9D = "%r9d"
    | format_reg R10D = "%r10d"
    | format_reg R11D = "%r11d"
    | format_reg R12D = "%r12d"
    | format_reg R13D = "%r13d"
    | format_reg R14D = "%r14d"
    | format_reg R15D = "%r15d"
    | format_reg (STACK n) = "-" ^ Int.toString (n * 4) ^ "(%esp)"

  fun format_binop ADD = "add"
    | format_binop SUB = "sub"
    | format_binop MUL = "imul"
    | format_binop DIV = "idiv"
    | format_binop MOD = "idiv"

  fun format_operand (IMM(n))  = "$" ^ Word32Signed.toString(n)
    | format_operand (TEMP(t)) = Temp.name(t)
    | format_operand (REG(r))  = format_reg r

  fun format_instr (BINOP(oper, d, s1, s2)) =
      format_binop oper ^ " " ^ format_operand s2  ^
      (if oper = DIV orelse oper = MOD then "" else
        ", " ^ format_operand d)
    | format_instr (MOV(REG(d), REG(s))) =
        if d = s then "" else
          "mov " ^ format_operand (REG s) ^ ", " ^ format_operand (REG d)
    | format_instr (MOV(d, s)) =
        "mov " ^ format_operand s ^ ", " ^ format_operand d
    | format_instr (ASM str) = str
    | format_instr (DIRECTIVE str) = "\r" ^ str
    | format_instr (COMMENT str) = "/* " ^ str ^ "*/"
    | format_instr (RET) = "ret"

  fun instr_expand (BINOP (DIV, d, s1, s2)) = [
        MOV (REG(EAX), s1),
        ASM "cltd",
        BINOP (DIV, d, s1, s2),
        MOV (d, REG(EAX))
      ]
    | instr_expand (BINOP (MOD, d, s1, s2)) = [
        MOV (REG(EAX), s1),
        ASM "cltd",
        BINOP (DIV, d, s1, s2),
        MOV (d, REG(EDX))
      ]
    | instr_expand (BINOP (oper, REG d, s1, REG s2)) =
        if d = s2 andalso oper = SUB then [
          BINOP (SUB, REG d, REG s2, s1),
          ASM ("neg " ^ format_operand (REG d))
        ] else if d = s2 then [
          BINOP (oper, REG d, REG s2, s1)
        ] else [
          MOV (s1, REG d),
          BINOP (oper, REG d, s1, REG s2)
        ]
    | instr_expand i = [i]

  fun format instr = String.concat (map (fn s => "\t" ^ format_instr s ^ "\n")
                                        (instr_expand instr))

end
