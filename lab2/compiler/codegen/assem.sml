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

  (* format_reg : reg -> string
   *
   * @param reg the register to convert to a name
   * @return the string representation of the given register in x86
   *)
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
    (* We'll have a stack frame eventually... *)
    | format_reg (STACK n) = "-" ^ Int.toString (n * 4) ^ "(%rsp)"

  (* format_binop : operation -> string
   *
   * @param oper the operation to convert to a string
   * @return the x86 instruction name. All are suffixed with 'l' for now to
   *         force 32 bit arithmetic.
   *)
  fun format_binop ADD = "addl"
    | format_binop SUB = "subl"
    | format_binop MUL = "imull"
    | format_binop DIV = "idivl"
    | format_binop MOD = "idivl"

  (* format_operand : operand -> string
   *
   * @param operand the operand to convert
   * @return the string representation of the given operand in x86 assembly
   *)
  fun format_operand (IMM(n))  = "$" ^ Word32Signed.toString(n)
    | format_operand (TEMP(t)) = Temp.name(t)
    | format_operand (REG(r))  = format_reg r

  (* format_instr : instr -> string
   *
   * Takes an instruction and formats it into a string (raw assembly). This
   * formatting assumes that preprocessing has already happened, such that if
   * you format a DIV instruction, it assumes that the dividend is in %eax and
   * %edx is the sign extension of %eax, etc.
   *
   * @param I the instruction to format
   * @return the instruction formatted.
   *)
  fun format_instr (BINOP(oper, d, s1, s2)) =
      format_binop oper ^ " " ^ format_operand s2 ^
      (if oper = DIV orelse oper = MOD then "" else ", " ^ format_operand d)
    | format_instr (MOV(TEMP _, _)) = ""
    (* If we're moving between the same registers, then no need to format
       the result, we can optimize the instruction away *)
    | format_instr (MOV(REG d, REG s)) =
        if d = s then "" else
          "movl " ^ format_operand (REG s) ^ ", " ^ format_operand (REG d)
    | format_instr (MOV(d, s)) =
        "movl " ^ format_operand s ^ ", " ^ format_operand d
    | format_instr (ASM str) = str
    | format_instr (DIRECTIVE str) = str
    | format_instr (COMMENT str) = "/* " ^ str ^ "*/"
    | format_instr (RET) = "ret"

  (* instr_expand : instr -> instr list
   *
   * Takes an abstract assembly instruction and expands it into a list of
   * instructions which are needed to execute the abstract instruction. This is
   * needed to account for the oddities of x86 such as for the DIV or MOD
   * operations always working on %eax and %edx.
   *
   * @param I the instruction to expand
   * @return L a list of instructions which should be passed to format_intstr
   *)
  fun instr_expand (BINOP (DIV, d, s1, s2)) = [
        MOV (REG(EAX), s1), (* DIV and MOD are odd X86 instructions... *)
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
    (* If we assume the destination of a binop is always a register, then the
       clause below this one is much easier *)
    | instr_expand (BINOP (oper, REG (STACK n), s1, s2)) = [
        MOV (REG R15D, s1),
        BINOP (oper, REG R15D, REG R15D, s2),
        MOV (REG (STACK n), REG R15D)
      ]
    (* Sometimes we can clobber the destination, but not if one of the operands
       is also the destination. Another special case is a form of subtraction
       where we can't override one of the operands. To get around this, we
       perform subtraction the other way and then negate the result. *)
    | instr_expand (BINOP (oper, REG d, s1, REG s2)) =
        if d = s2 andalso oper = SUB then [
          BINOP (SUB, REG d, REG s2, s1),
          ASM ("neg " ^ format_operand (REG d))
        ] else if d = s2 then [
          BINOP (oper, REG d, REG s2, s1)
        ] else [
          MOV (REG d, s1),
          BINOP (oper, REG d, s1, REG s2)
        ]
    | instr_expand (BINOP (oper, d, s1, s2)) = [
        MOV (d, s1),
        BINOP (oper, d, s1, s2)
      ]
    (* Can't move between two memory locations... *)
    | instr_expand (MOV (REG (STACK n1), REG (STACK n2))) = [
        MOV (REG R15D, REG (STACK n2)),
        MOV (REG (STACK n1), REG R15D)
      ]
    | instr_expand i = [i]

  (* format : instr -> string
   *
   * Generates a string which is a scrap of assembly which is required to
   * fully execute the given instruction. The abstract assembly instruction
   * may be formatted into multiple instructions.
   *
   * @param instr the instruction to format
   * @return the string of assembly necessary to execute the instruction
   *)
  fun format instr = let
        fun finstr i =  let val s = format_instr i in
                          if s = "" then s else
                          (case i of (DIRECTIVE _) => "" | _ => "\t") ^ s ^ "\n"
                        end
      in
        String.concat (map finstr (instr_expand instr))
      end

end