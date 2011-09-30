(* L2 Compiler
 * Assem
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
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

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP
                     | AND | OR  | XOR | LSH | RSH

  datatype condition = LT | LTE | EQ | NEQ

  datatype instr =
     BINOP of operation * operand * operand * operand
   | MOV of operand * operand
   | MOVFLAG of operand * condition
   | JMP of Label.label * condition option
   | RET
   | ASM of string
   | LABEL of Label.label
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

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP
                     | AND | OR  | XOR | LSH | RSH

  datatype condition = LT | LTE | EQ | NEQ

  datatype instr =
     BINOP of operation * operand * operand * operand
   | MOV of operand * operand
   | MOVFLAG of operand * condition
   | JMP of Label.label * condition option
   | RET
   | ASM of string
   | LABEL of Label.label
   | DIRECTIVE of string
   | COMMENT of string

  (* Commonly used registers *)
  val eax  = REG EAX
  val edx  = REG EDX
  val ecx  = REG ECX
  val r15d = REG R15D

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

  (* format_reg8 : reg -> string
   *
   * @param reg the register to convert to a name
   * @return the string representation of the lowest byte of the given
   *         register in x86
   *)
  fun format_reg8 EAX  = "%al"
    | format_reg8 EBX  = "%bl"
    | format_reg8 ECX  = "%cl"
    | format_reg8 EDX  = "%dl"
    | format_reg8 R8D  = "%r8b"
    | format_reg8 R9D  = "%r9b"
    | format_reg8 R10D = "%r10b"
    | format_reg8 R11D = "%r11b"
    | format_reg8 R12D = "%r12b"
    | format_reg8 R13D = "%r13b"
    | format_reg8 R14D = "%r14b"
    | format_reg8 R15D = "%r15b"
    | format_reg8 r = raise Fail ("Cannot get lower 8 bits of " ^ format_reg r)

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
    | format_binop CMP = "cmpl"
    | format_binop AND = "andl"
    | format_binop OR  = "orl"
    | format_binop XOR = "xorl"
    | format_binop LSH = "sall"
    | format_binop RSH = "sarl"

  (* format_operand : operand -> string
   *
   * @param operand the operand to convert
   * @return the string representation of the given operand in x86 assembly
   *)
  fun format_operand (IMM n)  = "$" ^ Word32Signed.toString n
    | format_operand (TEMP t) = Temp.name t
    | format_operand (REG r)  = format_reg r

  (* format_operand8 : operand -> string
   *
   * @param operand the operand to convert
   * @return the string representation of the given operand in x86 assembly
   *)
  fun format_operand8 (REG r) = format_reg8 r
    | format_operand8 oper    = format_operand oper

  (* format_condition : condition option -> string
   *
   * @param condition the condition to convert
   * @return the string representation of the given condition
   *)
  fun format_condition (SOME LT)  = "jl"
    | format_condition (SOME LTE) = "jle"
    | format_condition (SOME EQ)  = "jz"
    | format_condition (SOME NEQ) = "jnz"
    | format_condition NONE = "jmp"

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
      format_binop oper ^ " " ^ (if oper = LSH orelse oper = RSH then
                                 format_operand8 s2 else format_operand s2) ^
      (if oper = DIV orelse oper = MOD then "" else ", " ^ format_operand d)
    | format_instr (MOV(TEMP _, _)) = ""
    (* If we're moving between the same registers, then no need to format
       the result, we can optimize the instruction away *)
    | format_instr (MOV(REG d, REG s)) =
        if d = s then "" else
          "movl " ^ format_operand (REG s) ^ ", " ^ format_operand (REG d)
    | format_instr (MOV(d, s)) =
        "movl " ^ format_operand s ^ ", " ^ format_operand d
    | format_instr (JMP (l, jmp)) = format_condition jmp ^ " " ^ Label.name l
    | format_instr (MOVFLAG (d,_)) = "movzbl " ^ format_operand8 d ^
                                     ", " ^ format_operand d
    | format_instr (ASM str) = str
    | format_instr (DIRECTIVE str) = str
    | format_instr (LABEL l) = Label.name l ^ ":"
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
  fun instr_expand (oper as BINOP (DIV, d, s1, s2)) = [
        MOV (eax, s1), ASM "cltd", oper, MOV (d, eax)]
    | instr_expand (oper as BINOP (MOD, d, s1, s2)) = [
        MOV (eax, s1), ASM "cltd", oper, MOV (d, edx)]
    (* Assume the destination of all binary operations is in a register *)
    | instr_expand (BINOP (oper, d as REG (STACK _), s1, s2)) =
        [MOV (r15d, s1)] @ instr_expand (BINOP (oper, r15d, r15d, s2)) @
        [MOV (d, r15d)]
    | instr_expand (BINOP (CMP, _, s1 as REG (STACK _), s2 as REG (STACK _))) =
        [MOV (r15d, s1), BINOP (CMP, r15d, r15d, s2)]
    | instr_expand (BINOP (LSH, REG ECX, s1, s2 as REG _)) = [
        MOV (ecx, s2), MOV (r15d, s1), BINOP (LSH, r15d, s1, ecx), MOV (ecx, r15d)]
    | instr_expand (BINOP (RSH, REG ECX, s1, s2 as REG _)) = [
        MOV (ecx, s2), MOV (r15d, s1), BINOP (RSH, r15d, s1, ecx), MOV (ecx, r15d)]
    | instr_expand (BINOP (LSH, d, s1, s2 as REG _)) = [
        MOV (ecx, s2), MOV (d, s1), BINOP (LSH, d, s1, ecx)]
    | instr_expand (BINOP (RSH, d, s1, s2 as REG _)) = [
        MOV (ecx, s2), MOV (d, s1), BINOP (RSH, d, s1, ecx)]
    (* Sometimes we can clobber the destination, but not if one of the operands
       is also the destination. Another special case is a form of subtraction
       where we can't override one of the operands. To get around this, we
       perform subtraction the other way and then negate the result. *)
    | instr_expand (binop as BINOP (oper, REG d, s1, REG s2)) =
        if d = s2 andalso oper = SUB then [
          BINOP (SUB, REG d, REG s2, s1),
          ASM ("neg " ^ format_operand (REG d))]
        else if d = s2 then [BINOP (oper, REG d, REG s2, s1)]
        else [MOV (REG d, s1), binop]
    | instr_expand (binop as BINOP (oper, d, s1, s2)) = [MOV (d, s1), binop]
    | instr_expand (MOVFLAG (oper, cond)) = let
        val instr = case cond of LT => "setl" | LTE => "setle"
                               | EQ => "sete" | NEQ => "setne"
      in
        (* Can't use set<c> on stack, edi, or esi... *)
        if (case oper of REG (STACK _) => true | REG ESI => true
                       | REG EDI => true | _ => false) then [
          ASM (instr ^ " " ^ format_operand8 r15d),
          MOVFLAG (r15d, cond), MOV (oper, r15d)
        ] else [
          ASM (instr ^ " " ^ format_operand8 oper),
          MOVFLAG (oper, cond)
        ]
      end
    (* Can't move between two memory locations... *)
    | instr_expand (MOV (s1 as REG (STACK _), s2 as REG (STACK _))) = [
        MOV (r15d, s2), MOV (s1, r15d)]
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
                          (case i of (DIRECTIVE _) => ""
                                   | (LABEL _)     => ""
                                   | _ => "\t") ^ s ^ "\n"
                        end
      in
        String.concat (map finstr (instr_expand instr))
      end

end
