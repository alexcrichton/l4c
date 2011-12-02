(* L5 Compiler
 * Assem
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature ASSEM =
sig
  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | ESP | EBP  | STACK of int | STACKARG of int
               | STACKLOC of int

  datatype size = QUAD | WORD

  datatype operand =
     IMM of Word32.word * size
   | REG of reg * size
   | TEMP of Temp.temp * size
   | MEM of operand * size
   | LABELOP of Label.label

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP
                     | AND | OR  | XOR | LSH | RSH

  datatype condition = LT | LTE | GT | GTE | EQ | NEQ

  datatype instr =
     BINOP of operation * operand * operand
   | MOV of operand * operand
   | MOVFLAG of operand * condition
   | JMP of Label.label * condition option
   | RET
   | CALL of operand * int
   | ASM of string
   | LABEL of Label.label
   | DIRECTIVE of string
   | COMMENT of string

  type ord_key = operand

  val caller_regs : reg list
  val callee_regs : reg list

  val size : operand -> size
  val format : instr -> string
  val format_operand : operand -> string
  val compare : operand * operand -> order
  val oper_hash : operand -> word
  val oper_equal : operand * operand -> bool
  val reg_num : reg -> int
  val num_reg : int -> reg
  val arg_reg : int -> reg
end

structure Assem :> ASSEM =
struct
  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | ESP | EBP  | STACK of int | STACKARG of int
               | STACKLOC of int

  datatype size = QUAD | WORD

  datatype operand =
     IMM of Word32.word * size
   | REG of reg * size
   | TEMP of Temp.temp * size
   | MEM of operand * size
   | LABELOP of Label.label

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP
                     | AND | OR  | XOR | LSH | RSH

  datatype condition = LT | LTE | GT | GTE | EQ | NEQ

  datatype instr =
     BINOP of operation * operand * operand
   | MOV of operand * operand
   | MOVFLAG of operand * condition
   | JMP of Label.label * condition option
   | RET
   | CALL of operand * int
   | ASM of string
   | LABEL of Label.label
   | DIRECTIVE of string
   | COMMENT of string

  type ord_key = operand

  val caller_regs = [ECX, EDX, ESI, EDI, R8D, R9D, R10D, R11D]
  val callee_regs = [EBX, R12D, R13D, R14D, R15D, EBP]

  fun format_size s =
        if Flag.isset Options.flag_types then
          case s of WORD => ":32" | QUAD => ":64"
        else ""

  fun size (MEM (_, t) | REG (_, t) |
            TEMP (_, t) | IMM(_, t)) = t
    | size (LABELOP _) = QUAD

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
    | format_reg (STACK n) = Int.toString n ^ "(%rsp)"
    | format_reg (STACKLOC n) = "%rsp[" ^ Int.toString n ^ "]"
    | format_reg (STACKARG n) = "arg[" ^ Int.toString n ^ "]"

  (* format_reg64 : reg -> string
   *
   * @param reg the register to convert to a name
   * @return the string representation of the given register in x86
   *)
  fun format_reg64 EAX = "%rax"
    | format_reg64 EBX = "%rbx"
    | format_reg64 ECX = "%rcx"
    | format_reg64 EDX = "%rdx"
    | format_reg64 EDI = "%rdi"
    | format_reg64 ESI = "%rsi"
    | format_reg64 ESP = "%rsp"
    | format_reg64 EBP = "%rbp"
    | format_reg64 R8D = "%r8"
    | format_reg64 R9D = "%r9"
    | format_reg64 R10D = "%r10"
    | format_reg64 R11D = "%r11"
    | format_reg64 R12D = "%r12"
    | format_reg64 R13D = "%r13"
    | format_reg64 R14D = "%r14"
    | format_reg64 R15D = "%r15"
    | format_reg64 (STACK n) = Int.toString n ^ "(%rsp)"
    | format_reg64 (STACKLOC n) = "%rsp[" ^ Int.toString n ^ "]"
    | format_reg64 (STACKARG n) = "arg[" ^ Int.toString n ^ "]"

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
    | format_reg8 EBP  = "%bpl"
    | format_reg8 r = raise Fail ("Cannot get lower 8 bits of " ^ format_reg r)

  (* format_binop : operation -> string
   *
   * @param oper the operation to convert to a string
   * @return the x86 instruction name. All are suffixed with 'l' for now to
   *         force 32 bit arithmetic.
   *)
  fun format_binop ADD = "add"
    | format_binop SUB = "sub"
    | format_binop MUL = "imul"
    | format_binop DIV = "idiv"
    | format_binop MOD = "idiv"
    | format_binop CMP = "cmp"
    | format_binop AND = "and"
    | format_binop OR  = "or"
    | format_binop XOR = "xor"
    | format_binop LSH = "sal"
    | format_binop RSH = "sar"

  fun format_suffix ((REG (_, QUAD) | MEM (_, QUAD) | TEMP (_, QUAD)),
                     (REG (_, WORD) | MEM (_, WORD) | TEMP (_, WORD))) = "slq"
    | format_suffix ((REG (_, QUAD) | MEM (_, QUAD) | TEMP (_, QUAD)), _) = "q"
    | format_suffix (_, (REG (_, QUAD) | MEM (_, QUAD) | TEMP (_, QUAD))) =
        "ERROR"
    | format_suffix _ = "l"

  (* format_operand : operand -> string
   *
   * @param operand the operand to convert
   * @return the string representation of the given operand in x86 assembly
   *)
  fun format_operand (IMM (n, size))  = "$" ^ Word32Signed.toString n
                                      ^ format_size size
    | format_operand (TEMP (t, size)) = Temp.name t ^ format_size size
    | format_operand (REG (r, size)) = (if size = WORD then format_reg r
                                       else format_reg64 r) ^ format_size size
    | format_operand (MEM (r, size))  = "(" ^ format_operand r ^ ")"
                                      ^ format_size size
    | format_operand (LABELOP l) = Label.name l ^ "(%rip)"

  (* format_operand8 : operand -> string
   *
   * @param operand the operand to convert
   * @return the string representation of the given operand in x86 assembly
   *)
  fun format_operand8 (REG (r, _)) = format_reg8 r
    | format_operand8 (IMM (n, size)) =
        format_operand (IMM (Word32.andb (n, Word32.fromInt 255), size))
    | format_operand8 oper    = format_operand oper

  (* format_condition : condition option -> string
   *
   * @param condition the condition to convert
   * @return the string representation of the given condition
   *)
  fun format_condition (SOME LT)  = "jl"
    | format_condition (SOME LTE) = "jle"
    | format_condition (SOME GT)  = "jg"
    | format_condition (SOME GTE) = "jge"
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
      format_binop oper ^ format_suffix (d, s) ^ " " ^
        (if oper = LSH orelse oper = RSH then
         format_operand8 s else format_operand s) ^
      (if oper = DIV orelse oper = MOD then "" else ", " ^ format_operand d)
    (* unallocated temp, but instruction needs to happen for memory access*)
    | format_instr (MOV (TEMP _, s as MEM _)) = "cmpl $0, " ^ format_operand s
    | format_instr (MOV (d as (REG (STACK _, QUAD) | MEM (_, QUAD)),
                         s as REG (sr as _, WORD))) =
        "movslq " ^ format_operand s ^ ", " ^ format_operand (REG (sr, QUAD)) ^
        "\n\tmovq " ^ format_operand (REG (sr, QUAD)) ^ ", " ^ format_operand d
    | format_instr (MOV (d, s)) =
        "mov" ^ format_suffix (d, s) ^ " " ^ format_operand s ^ ", " ^
                 format_operand d
    | format_instr (JMP (l, jmp)) = format_condition jmp ^ " " ^ Label.name l
    | format_instr (MOVFLAG (d as REG (_, QUAD), _)) =
        "movzbq " ^ format_operand8 d ^ ", " ^ format_operand d
    | format_instr (MOVFLAG (d, _)) =
        "movzbl " ^ format_operand8 d ^ ", " ^ format_operand d
    | format_instr (CALL (LABELOP l, _)) = "callq " ^ Label.name l
    | format_instr (CALL (oper, _)) = "callq *" ^ format_operand oper
    | format_instr (ASM str) = str
    | format_instr (DIRECTIVE str) = str
    | format_instr (LABEL l) = Label.name l ^ ":"
    | format_instr (COMMENT str) = "/* " ^ str ^ "*/"
    | format_instr (RET) = "ret"

  (* swap{l,r} : size -> operand
   *
   * Generates the swap register for the given size
   *)
  fun swapl s = REG (R11D, s)
  fun swapr s = REG (R10D, s)

  (* findr : operand -> (instr list * operand)
   *
   * Resolves the source of an instruction into a pure register using 'swapr'
   * @param oper the operand to resolve
   * @return the instructions necessary to compute the pure register and the
   *         pure operand as a register. The operand will have the result of
   *         the given operand when the instructions are executed.
   *)
  fun findr (MEM (r, size)) = let
        val (rinstrs, r') = findr r
      in
        (rinstrs @ [MOV (swapr size, MEM (r', size))], swapr size)
      end
    | findr (s as REG (STACK _, size)) = ([MOV (swapr size, s)], swapr size)
    | findr (s as LABELOP _) = ([MOV (swapr QUAD, s)], swapr QUAD)
    | findr r = ([], r)

  (* resolve_mem : operand * operand -> (instr list * operand * operand)
   *
   * Resolves two memory operands such that the returned operands have at most
   * one memory access.
   *
   * @param (d, s) the destination and source operands for an instruction. The
   * @return the instructions necessary to calculate the new destination and
   *         source, and a d', and s' such that at most one of them is a memory
   *         reference.
   *)
  fun resolve_mem (MEM (d as REG (STACK _, _), size), s) = let
        val (sinstrs, s') = findr s
      in
        (sinstrs @ [MOV (swapl QUAD, d)], MEM (swapl QUAD, size), s')
      end
    | resolve_mem (d as (REG (STACK _, _) | MEM _), s) = let
        val (sinstrs, s') = findr s
      in
        (sinstrs, d, s')
      end
    | resolve_mem (d, MEM (s as REG (STACK _, _), size)) =
        ([MOV (swapr QUAD, s)], d, MEM (swapr QUAD, size))
    | resolve_mem (d, s) = ([], d, s)

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
  fun instr_expand (BINOP (oper as (DIV | MOD), d, s as IMM (_, size))) =
        [MOV (swapl size, s)] @ instr_expand (BINOP (oper, d, swapl size))
    | instr_expand (BINOP (oper as (DIV | MOD), d, s)) = let val typ = size d in
        instr_expand (MOV (REG (EAX, typ), d)) @
          [ASM "cltd", BINOP (oper, d, s)] @
          instr_expand (MOV (d, REG (if oper = MOD then EDX else EAX, typ)))
      end
    | instr_expand (BINOP (oper as (RSH | LSH), d, s as IMM _)) = let
        val (instrs, d', s') = resolve_mem (d, s)
      in instrs @ [BINOP (oper, d', s')] end
    | instr_expand (BINOP (oper as (RSH | LSH), d, s)) = let
        val (instrs, d', s') = resolve_mem (d, s)
        val ecx = REG (ECX, size d)
      in instrs @ [MOV (ecx, s'), BINOP (oper, d', ecx)] end
    | instr_expand (BINOP (CMP, d as IMM _, s)) = let
        val (instrs, d', s') = resolve_mem (d, s)
        val typ = size d
      in instrs @ [MOV (swapl typ, d), BINOP (CMP, swapl typ, s)] end
    | instr_expand (BINOP (oper, d, s)) = let
        val (instrs, d', s') = resolve_mem (d, s)
      in
        case d'
          of (REG (STACK _, size) | MEM (_, size)) =>
              if oper = MUL then
                instrs @ [MOV (swapl size, d'), BINOP (oper, swapl size, s'),
                          MOV (d', swapl size)]
              else instrs @ [BINOP (oper, d', s')]
           | _ => instrs @ [BINOP (oper, d', s')]
      end
    | instr_expand (MOVFLAG (d, cond)) = let
        val instr = case cond of LT => "setl" | LTE => "setle"
                               | GT => "setg" | GTE => "setge"
                               | EQ => "sete" | NEQ => "setne"
      in
        case d of (REG (STACK _, size) | MEM (_, size)) =>
              [ASM (instr ^ " " ^ format_operand8 (swapl size)),
               MOVFLAG (swapl size, cond), MOV (d, swapl size)]
           | _ => [ASM (instr ^ " " ^ format_operand8 d), MOVFLAG (d, cond)]
      end
    | instr_expand (MOV ops) = let
        val (instrs, d, s) = resolve_mem ops
      in
        instrs @ [MOV (d, s)]
      end
    | instr_expand (CALL (LABELOP l, n)) =
        (* tail-recursive calls are encoded with negative argument numbers *)
        if n >= 0 then [CALL (LABELOP l, n)]
        else [JMP (Label.literal (Label.str l ^ "_start"), NONE)]
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

  (* reg_num : reg -> int
   *
   * Converts a register to it's specified number
   * @param reg the register to convert
   * @return the number corresponding to this register
   *)
  fun reg_num R11D = ~1
    | reg_num R10D = 0
    | reg_num R9D  = 1
    | reg_num R8D  = 2
    | reg_num ECX  = 3
    | reg_num EDX  = 4
    | reg_num ESI  = 5
    | reg_num EDI  = 6
    | reg_num EAX  = 7
    | reg_num EBX  = 8
    | reg_num R12D = 9
    | reg_num R13D = 10
    | reg_num R14D = 11
    | reg_num R15D = 12
    | reg_num EBP  = 13
    | reg_num (STACKLOC n) = n + 14
    | reg_num (STACKARG n) = 0
    | reg_num (STACK n) = 0
    | reg_num r = raise Fail (format_reg r ^ " is a scary register")

  (* num_reg : int -> reg
   *
   * Converts an integer to it's specified register
   * @param x the number of the register
   * @return the register corresponding to this number
   *)
  fun num_reg ~1 = R11D
    | num_reg  0 = R10D
    | num_reg  1 = R9D
    | num_reg  2 = R8D
    | num_reg  3 = ECX
    | num_reg  4 = EDX
    | num_reg  5 = ESI
    | num_reg  6 = EDI
    | num_reg  7 = EAX
    | num_reg  8 = EBX
    | num_reg  9 = R12D
    | num_reg 10 = R13D
    | num_reg 11 = R14D
    | num_reg 12 = R15D
    | num_reg 13 = EBP
    | num_reg  n = STACKLOC (n - 14)

  (* arg_reg : size -> int -> operand
   *
   * Maps an argument number to its register / stack location
   *)
  fun arg_reg 0 = EDI
    | arg_reg 1 = ESI
    | arg_reg 2 = EDX
    | arg_reg 3 = ECX
    | arg_reg 4 = R8D
    | arg_reg 5 = R9D
    | arg_reg n = STACKARG (n - 6)

  (* compare : (operand * operand) -> order
   *
   * Defines an ordering of operands so they can be inserted into sets.
   * @param (r1, r2) the register pair to compare
   * @return the comparison of r1 to r2
   *)
  fun compare (REG (r1, _), REG (r2, _)) = Int.compare (reg_num r1, reg_num r2)
    | compare (TEMP (t1, _), TEMP (t2, _)) = Temp.compare (t1, t2)
    | compare (IMM _, IMM _) = EQUAL
    | compare (MEM _, MEM _) = EQUAL
    | compare (LABELOP _, LABELOP _) = EQUAL
    | compare (IMM _, _)  = LESS
    | compare (_, IMM _)  = GREATER
    | compare (TEMP _, _) = LESS
    | compare (_, TEMP _) = GREATER
    | compare (MEM _, _) = LESS
    | compare (_, MEM _) = GREATER
    | compare (LABELOP _, _) = LESS
    | compare (_, LABELOP _) = GREATER

  (* oper_equal : operand * operand -> bool
   *
   * Checks if two operands are equal
   *)
  fun oper_equal t = (compare t = EQUAL)

  (* oper_hash : operand -> word
   *
   * Hashes an operand
   *)
  fun oper_hash (IMM _ | MEM _ | LABELOP _) = Word.fromInt ~1
    | oper_hash (REG (r, _)) = Word.fromInt (reg_num r)
    | oper_hash (TEMP (t, _)) = (Temp.hash t) + (Word.fromInt 15)

end

structure OperandSet = BinarySetFn(Assem)
