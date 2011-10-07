(* L3 Compiler
 * Assem
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature ASSEM =
sig
  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | STACK of int | ESP | EBP

  datatype operand =
     IMM of Word32.word
   | REG of reg
   | TEMP of Temp.temp

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP
                     | AND | OR  | XOR | LSH | RSH | ADD64

  datatype condition = LT | LTE | EQ | NEQ

  datatype instr =
     BINOP of operation * operand * operand
   | PUSH of operand
   | POP of operand
   | MOV of operand * operand
   | MOVFLAG of operand * condition
   | JMP of Label.label * condition option
   | RET
   | CALL of Label.label * int
   | ASM of string
   | LABEL of Label.label
   | DIRECTIVE of string
   | COMMENT of string

  type ord_key = operand

  val caller_regs : operand list
  val callee_regs : operand list

  val format : instr -> string
  val compare : operand * operand -> order
  val reg_num : reg -> int
  val num_reg : int -> reg
end

structure Assem :> ASSEM =
struct
  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | STACK of int | ESP | EBP

  datatype operand =
     IMM of Word32.word
   | REG of reg
   | TEMP of Temp.temp

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP
                     | AND | OR  | XOR | LSH | RSH | ADD64

  datatype condition = LT | LTE | EQ | NEQ

  datatype instr =
     BINOP of operation * operand * operand
   | PUSH of operand
   | POP of operand
   | MOV of operand * operand
   | MOVFLAG of operand * condition
   | JMP of Label.label * condition option
   | RET
   | CALL of Label.label * int
   | ASM of string
   | LABEL of Label.label
   | DIRECTIVE of string
   | COMMENT of string

  type ord_key = operand

  val caller_regs = [REG EAX, REG ECX, REG EDX , REG ESI, REG EDI,
                     REG R8D, REG R9D, REG R10D, REG R11D]
  val callee_regs = [REG EBX, REG R12D, REG R13D, REG R14D, REG R15D]

  (* reg_num : reg -> int
   *
   * Converts a register to it's specified number
   * @param reg the register to convert
   * @return the number corresponding to this register
   *)
  fun reg_num EAX = 1
    | reg_num EBX = 2
    | reg_num ECX = 3
    | reg_num EDX = 4
    | reg_num EDI = 5
    | reg_num ESI = 6
    | reg_num R8D = 7
    | reg_num R9D = 8
    | reg_num R10D = 9
    | reg_num R11D = 10
    | reg_num R12D = 11
    | reg_num R13D = 12
    | reg_num R14D = 13
    | reg_num (STACK n) = n + 13
    | reg_num R15D = raise Fail "r15d is a scary register"

  (* num_reg : int -> reg
   *
   * Converts an integer to it's specified register
   * @param x the number of the register
   * @return the register corresponding to this number
   *)
  fun num_reg 1  = EAX
    | num_reg 2  = EBX
    | num_reg 3  = ECX
    | num_reg 4  = EDX
    | num_reg 5  = EDI
    | num_reg 6  = ESI
    | num_reg 7  = R8D
    | num_reg 8  = R9D
    | num_reg 9  = R10D
    | num_reg 10 = R11D
    | num_reg 11 = R12D
    | num_reg 12 = R13D
    | num_reg 13 = R14D (* TODO: use r15d if only 14 regs *)
    | num_reg x  = STACK (x - 13)

  (* compare : (reg * reg) -> order
   *
   * Defines an ordering of registers so they can be inserted into sets.
   * @param (r1, r2) the register pair to compare
   * @return the comparison of r1 to r2
   *)
  fun compare (REG r1, REG r2) = Int.compare (reg_num r1, reg_num r2)
    | compare (TEMP t1, TEMP t2) = Temp.compare (t1, t2)
    | compare (IMM w1, IMM w2) = Word32.compare (w1, w2)
    | compare (IMM _, _)  = LESS
    | compare (_, IMM _)  = GREATER
    | compare (TEMP _, _) = LESS
    | compare (_, TEMP _) = GREATER

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
    | format_reg ESP = "%esp"
    | format_reg EBP = "%ebp"
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
   * @see http://msdn.microsoft.com/en-us/library/ff561499(v=vs.85).aspx
   *)
  fun format_reg8 EAX  = "%al"
    | format_reg8 EBX  = "%bl"
    | format_reg8 ECX  = "%cl"
    | format_reg8 EDX  = "%dl"
    | format_reg8 ESI  = "%sil"
    | format_reg8 EDI  = "%dil"
    | format_reg8 R8D  = "%r8b"
    | format_reg8 R9D  = "%r9b"
    | format_reg8 R10D = "%r10b"
    | format_reg8 R11D = "%r11b"
    | format_reg8 R12D = "%r12b"
    | format_reg8 R13D = "%r13b"
    | format_reg8 R14D = "%r14b"
    | format_reg8 R15D = "%r15b"
    | format_reg8 r = raise Fail ("Cannot get lower 8 bits of " ^ format_reg r)

  (* format_reg64 : reg -> string
   *
   * @param reg the register to convert to a name
   * @return the string representation of the 8-bytes of the given
   *         register in x86
   *)
  fun format_reg64 EAX  = "%rax"
    | format_reg64 EBX  = "%rbx"
    | format_reg64 ECX  = "%rcx"
    | format_reg64 EDX  = "%rdx"
    | format_reg64 ESI  = "%rsi"
    | format_reg64 EDI  = "%rdi"
    | format_reg64 ESP  = "%rsp"
    | format_reg64 EBP  = "%rbp"
    | format_reg64 R8D  = "%r8"
    | format_reg64 R9D  = "%r9"
    | format_reg64 R10D = "%r10"
    | format_reg64 R11D = "%r11"
    | format_reg64 R12D = "%r12"
    | format_reg64 R13D = "%r13"
    | format_reg64 R14D = "%r14"
    | format_reg64 R15D = "%r15"
    | format_reg64 r = raise Fail ("Cannot get 8-bytes of " ^ format_reg r)

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
    | format_operand8 (IMM n) =
        format_operand (IMM (Word32.andb (n, Word32.fromInt 255)))
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
  fun format_instr (BINOP(oper, d, s)) =
      format_binop oper ^ " " ^ (if oper = LSH orelse oper = RSH then
                                 format_operand8 s else format_operand s) ^
      (if oper = DIV orelse oper = MOD then "" else ", " ^ format_operand d)
    | format_instr (MOV(REG d, REG s)) =
        if d = s then "" else
          "movl " ^ format_operand (REG s) ^ ", " ^ format_operand (REG d)
    | format_instr (MOV(d, s)) =
        "movl " ^ format_operand s ^ ", " ^ format_operand d
    | format_instr (JMP (l, jmp)) = format_condition jmp ^ " " ^ Label.name l
    | format_instr (MOVFLAG (d,_)) = "movzbl " ^ format_operand8 d ^
                                     ", " ^ format_operand d
    | format_instr (CALL (l, _)) = "callq " ^ Label.name l
    | format_instr (ASM str) = str
    | format_instr (PUSH (REG s)) = "pushq " ^ format_reg64 s
    | format_instr (POP (REG d)) = "popq " ^ format_reg64 d
    | format_instr (DIRECTIVE str) = str
    | format_instr (LABEL l) = Label.name l ^ ":"
    | format_instr (COMMENT str) = "/* " ^ str ^ "*/"
    | format_instr (RET) = "ret"
    | format_instr _ = raise Fail "Invalid instruction"

  val r15d = REG R15D

  (* instr_expand : instr -> instr list
   *
   * Takes an abstract assembly instruction and expands it into a list of
   * instructions which are needed to execute the abstract instruction. This is
   * needed to account for the oddities of x86 such as for the DIV or MOD
   * operations always working on %eax and %edx.
   *
   * @param I the instruction to expand
   * @return L a list of instructions which should be passed to format_instr
   *)
  fun instr_expand (BINOP (oper, d as REG (STACK _), s)) =
        [MOV (r15d, d), BINOP (oper, r15d, s), MOV (d, r15d)]
    | instr_expand (MOVFLAG (d, cond)) = let
        val instr = case cond of LT => "setl" | LTE => "setle"
                               | EQ => "sete" | NEQ => "setne"
      in
        case d of REG (STACK _) =>
              [ASM (instr ^ " " ^ format_operand8 r15d),
               MOVFLAG (r15d, cond), MOV (d, r15d)]
           | _ => [ASM (instr ^ " " ^ format_operand8 d), MOVFLAG (d, cond)]
      end
    (* Can't move between two memory locations... *)
    | instr_expand (MOV (d as REG (STACK _), s as REG (STACK _))) =
        [MOV (r15d, s), MOV (d, r15d)]
    | instr_expand (PUSH (s as REG (STACK _))) =
        [MOV (r15d, s), PUSH (r15d)]
    | instr_expand (POP (d as REG (STACK _))) =
        [POP (r15d), MOV (d, r15d)]
    | instr_expand (LABEL l) =
        if Label.compare (l, Label.literal "main") <> EQUAL then [LABEL l]
        else [LABEL (Label.literal "_c0_main"), LABEL l]
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

structure OperandSet = BinarySetFn(Assem)
