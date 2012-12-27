(* common interface to both x86 and x64 *)
signature INTEL =
sig
  datatype opsize = QUAD | WORD
  include ASSEM_ARCH where type size = opsize

  (* requirements for precoloring *)
  val eax : reg
  val ecx : reg
  val edx : reg
  val swapl : reg
  val swapr : reg

  val name8  : reg -> string
  val name32 : reg -> string
  val name64 : reg -> string
  val load_label : (string * Label.label) -> string
end

structure ArchX64 :> INTEL =
struct
  structure TArch = TreeArch64

  datatype reg = EAX | EBX  | ECX  | EDX  | EDI  | ESI  | R8D
               | R9D | R10D | R11D | R12D | R13D | R14D | R15D
               | ESP | EBP
  datatype opsize = QUAD | WORD
  type size = opsize

  (* generic architecture requirements *)
  val caller_regs = [ECX, EDX, ESI, EDI, R8D, R9D, R10D, R11D, EAX]
  val callee_regs = [EBX, R12D, R13D, R14D, R15D, EBP]
  val (arg_regs, num_regs) = (6, 14)
  val (sp, ret_reg)        = (ESP, EAX)
  val (ptrsize, intsize)   = (QUAD, WORD)
  fun size Tree.PTR = QUAD | size Tree.INT = WORD
  fun bytes QUAD = TArch.ptrsize | bytes WORD = TArch.intsize

  (* x64 requires the stack to be 16-byte aligned, but the CALL instruction
   * pushes 8 bytes of data, so we need it to be 8 mod 16 byte aligned
   *)
  fun align_stack sz = ((sz - 8) div 16) * 16 + 24

  (* intel requirements *)
  val swapl = R11D
  val swapr = R10D
  val (eax, ecx, edx) = (EAX, ECX, EDX)
  fun load_label (s, l) = "leaq " ^ Label.name l ^ "(%rip), " ^ s

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
    | reg_num ESP  = raise Fail "bad"

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
    | num_reg  _ = raise Fail "too high a number for num_reg"

  fun arg_reg 0 = EDI
    | arg_reg 1 = ESI
    | arg_reg 2 = EDX
    | arg_reg 3 = ECX
    | arg_reg 4 = R8D
    | arg_reg 5 = R9D
    | arg_reg _ = raise Fail "too high a number for arg_reg"

  fun name R11D = "%r11d"
    | name R10D = "%r10d"
    | name R9D  = "%r9d"
    | name R8D  = "%r8d"
    | name ECX  = "%ecx"
    | name EDX  = "%edx"
    | name ESI  = "%esi"
    | name EDI  = "%edi"
    | name EAX  = "%eax"
    | name EBX  = "%ebx"
    | name R12D = "%r12d"
    | name R13D = "%r13d"
    | name R14D = "%r14d"
    | name R15D = "%r15d"
    | name EBP  = "%ebp"
    | name ESP  = "%esp"

  val name32 = name

  (* format_reg64 : reg -> string
   *
   * @param reg the register to convert to a name
   * @return the string representation of the given register in x86
   *)
  fun name64 EAX  = "%rax"
    | name64 EBX  = "%rbx"
    | name64 ECX  = "%rcx"
    | name64 EDX  = "%rdx"
    | name64 EDI  = "%rdi"
    | name64 ESI  = "%rsi"
    | name64 ESP  = "%rsp"
    | name64 EBP  = "%rbp"
    | name64 R8D  = "%r8"
    | name64 R9D  = "%r9"
    | name64 R10D = "%r10"
    | name64 R11D = "%r11"
    | name64 R12D = "%r12"
    | name64 R13D = "%r13"
    | name64 R14D = "%r14"
    | name64 R15D = "%r15"

  (* name8 : reg -> string
   *
   * @param reg the register to convert to a name
   * @return the string representation of the lowest byte of the given
   *         register in x86
   * @see http://msdn.microsoft.com/en-us/library/ff561499(v=vs.85).aspx
   *)
  fun name8 EAX  = "%al"
    | name8 EBX  = "%bl"
    | name8 ECX  = "%cl"
    | name8 EDX  = "%dl"
    | name8 ESI  = "%sil"
    | name8 EDI  = "%dil"
    | name8 R8D  = "%r8b"
    | name8 R9D  = "%r9b"
    | name8 R10D = "%r10b"
    | name8 R11D = "%r11b"
    | name8 R12D = "%r12b"
    | name8 R13D = "%r13b"
    | name8 R14D = "%r14b"
    | name8 R15D = "%r15b"
    | name8 EBP  = "%bpl"
    | name8 ESP  = "%spl"

end

structure ArchX86 :> INTEL =
struct
  structure TArch = TreeArch32

  datatype reg = EAX | EBX | ECX | EDX | EDI | ESI | ESP | EBP
  datatype opsize = WORD | QUAD
  type size = opsize

  (* architecture things *)
  val caller_regs          = [ECX, EDX, EAX]
  val callee_regs          = [EBX, ESI, EDI, EBP]
  val (arg_regs, num_regs) = (0, 5)
  val (sp, ret_reg)        = (ESP, EAX)
  val (ptrsize, intsize)   = (WORD, WORD)
  fun size (Tree.PTR | Tree.INT) = WORD
  fun bytes WORD = TArch.intsize | bytes QUAD = raise Fail "quad bad on x86"

  (* x86 requires the stack to be 16-byte aligned, but the CALL instruction
   * pushes 4 bytes of data, so we need it to be 12 mod 16 byte aligned
   *)
  fun align_stack sz = ((sz - 8) div 16) * 16 + 28

  (* intel things *)
  val swapl = EBX
  val swapr = ESI
  val (eax, ecx, edx) = (EAX, ECX, EDX)
  fun load_label (s, l) = "movl $" ^ Label.name l ^ ", " ^ s

  fun reg_num EBX = ~1
    | reg_num ESI = 0
    | reg_num ECX = 1
    | reg_num EDX = 2
    | reg_num EAX = 3
    | reg_num EDI = 4
    | reg_num EBP = 5
    | reg_num ESP = raise Fail "bad"

  fun num_reg ~1 = EBX
    | num_reg 0 = ESI
    | num_reg 1 = ECX
    | num_reg 2 = EDX
    | num_reg 3 = EAX
    | num_reg 4 = EDI
    | num_reg 5 = EBP
    | num_reg _ = raise Fail "too high a number for num_reg"

  fun arg_reg _ = raise Fail "too high a number for arg_reg"

  fun name ECX  = "%ecx"
    | name EDX  = "%edx"
    | name ESI  = "%esi"
    | name EDI  = "%edi"
    | name EAX  = "%eax"
    | name EBX  = "%ebx"
    | name EBP  = "%ebp"
    | name ESP  = "%esp"

  val name32 = name

  fun name64 _ = raise Fail "no 64-bit registers on x86"

  (* http://msdn.microsoft.com/en-us/library/ff561502(v=vs.85) notes that there
   * is no way to access the lower 8 bits of some registers
   *)
  fun name8 EAX  = "%al"
    | name8 EBX  = "%bl"
    | name8 ECX  = "%cl"
    | name8 EDX  = "%dl"
    | name8 _   = raise Fail "Can't format lower 8 bits"
end

functor IntelAssem(A : INTEL) :> ASSEM =
struct
  structure IR   = AssemIR(A)
  structure Arch = A
  open IR

  val sp = if A.TArch.ptrsize = 8 then A.name64 A.sp else A.name32 A.sp

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
    | format_binop AND = "and"
    | format_binop OR  = "or"
    | format_binop XOR = "xor"
    | format_binop LSH = "sal"
    | format_binop RSH = "sar"
    | format_binop (CMP _) = "cmp"

  fun format_size s =
        if Flag.isset Options.flag_types then
          case s of A.WORD => ":32" | A.QUAD => ":64"
        else ""

  fun format_suffix ((REG (_, A.QUAD) | MEM (_, A.QUAD) | TEMP (_, A.QUAD)),
                     (REG (_, A.WORD) | MEM (_, A.WORD) | TEMP (_, A.WORD))) = "slq"
    | format_suffix ((REG (_, A.QUAD) | MEM (_, A.QUAD) | TEMP (_, A.QUAD)), _) = "q"
    | format_suffix (_, (REG (_, A.QUAD) | MEM (_, A.QUAD) | TEMP (_, A.QUAD))) =
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
    | format_operand (REG (r, size)) = (if size = A.WORD then Arch.name32 r
                                        else Arch.name64 r) ^ format_size size
    | format_operand (MEM (r, size))  = format_loc r ^ format_size size
    | format_operand (LABELOP l) = raise Fail "label!"

  and format_loc (MOP oper) = "(" ^ format_operand oper ^ ")"
    | format_loc (STACK n) = Int.toString n ^ "(" ^ sp ^ ")"
    | format_loc (STACKLOC n) = sp ^ "[" ^ Int.toString n ^ "]"
    | format_loc (STACKARG n) = "arg[" ^ Int.toString n ^ "]"

  (* format_operand8 : operand -> string
   *
   * @param operand the operand to convert
   * @return the string representation of the given operand in x86 assembly
   *)
  fun format_operand8 (REG (r, _)) = Arch.name8 r
    | format_operand8 (IMM (n, size)) =
        format_operand (IMM (Word32.andb (n, Word32.fromInt 255), size))
    | format_operand8 oper = format_operand oper

  (* format_condition : condition option -> string
   *
   * @param condition the condition to convert
   * @return the string representation of the given condition
   *)
  fun format_condition LT  = "l"
    | format_condition LTE = "le"
    | format_condition GT  = "g"
    | format_condition GTE = "ge"
    | format_condition EQ  = "e"
    | format_condition NEQ = "ne"

  fun binop2 f1 f2 oper s1 s2 = format_binop oper ^ format_suffix (s1, s2) ^
                                  " " ^ f2 s2 ^ ", " ^ f1 s1
  val binop  = binop2 format_operand format_operand
  val binop8 = binop2 format_operand format_operand8
  fun binop1 oper s = format_binop oper ^ format_suffix (s, s) ^ " " ^
                        format_operand s

  (* swap{l,r} : size -> operand
   *
   * Generates the swap register for the given size
   *)
  fun swapl s = REG (A.swapl, s)
  fun swapr s = REG (A.swapr, s)

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
  fun format_instr (BINOP (CMP cond, d, s1, s2)) = let
        val r8 = format_operand8 d handle Fail _ => Arch.name8 A.swapl
      in
        binop (CMP cond) s1 s2 ^
        "\n\tset" ^ format_condition cond ^ " " ^ r8 ^
        "\n\tmovzb" ^ format_suffix (d, d) ^ " " ^ r8 ^ ", " ^
                       format_operand d
      end
    | format_instr (BINOP (oper as (LSH | RSH), d, _, s)) = binop8 oper d s
    | format_instr (BINOP (oper as (DIV | MOD), _, _, s)) = binop1 oper s
    | format_instr (BINOP (oper, d, _, s)) = binop oper d s
    (* unallocated temp, but instruction needs to happen for memory access*)
    | format_instr (MOV (d, LABELOP l)) = Arch.load_label (format_operand d, l)
    | format_instr (MOV (TEMP _, s as MEM _)) = "cmpl $0, " ^ format_operand s
    | format_instr (MOV (d, s)) =
        "mov" ^ format_suffix (d, s) ^ " " ^ format_operand s ^ ", " ^
                 format_operand d
    | format_instr (JMP (l, NONE)) = "jmp " ^ Label.name l
    | format_instr (JMP (l, SOME (cond, s1, s2))) =
        binop (CMP cond) s1 s2 ^
        "\n\tj" ^ format_condition cond ^ " " ^ Label.name l
    | format_instr (CALL (oper as LABELOP l, _)) = "call " ^ Label.name l
    | format_instr (CALL (oper, _)) = "call *" ^ format_operand oper
    | format_instr (ASM str) = str
    | format_instr (DIRECTIVE str) = str
    | format_instr (LABEL l) = Label.name l ^ ":"
    | format_instr (COMMENT str) = "/* " ^ str ^ " */"
    | format_instr (RET) = "ret"

  val dummy = REG (A.swapl, A.ptrsize)

  (* findr : operand -> (instr list * operand)
   *
   * Resolves the source of an instruction into a pure register using 'swapr'
   * @param oper the operand to resolve
   * @return the instructions necessary to compute the pure register and the
   *         pure operand as a register. The operand will have the result of
   *         the given operand when the instructions are executed.
   *)
  fun findr (MEM (MOP s, sz)) = let val (instrs, s') = findr s in
        (instrs @ [MOV (swapr sz, MEM (MOP s', sz))], swapr sz)
      end
    | findr (s as MEM _) = ([MOV (swapr (size s), s)], swapr (size s))
    | findr (s as LABELOP _) = ([MOV (swapr A.ptrsize, s)], swapr A.ptrsize)
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
  fun resolve_mem (MEM (MOP (d as MEM _), sz), s) = let val (I, s') = findr s in
        (I @ [MOV (swapl A.ptrsize, d)], MEM (MOP (swapl A.ptrsize), sz), s')
      end
    | resolve_mem (d as MEM _, s) = let val (sinstrs, s') = findr s in
        (sinstrs, d, s')
      end
    | resolve_mem (d, MEM (MOP (s as MEM _), sz)) =
        ([MOV (swapr A.ptrsize, s)], d, MEM (MOP (swapr A.ptrsize), sz))
    | resolve_mem (d, s) = ([], d, s)

  fun resolve ops f = let val (instrs, o1, o2) = resolve_mem ops in
        instrs @ f (o1, o2)
      end

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
  fun instr_expand (BINOP (oper as (DIV | MOD), d, _, s as IMM (_, size))) =
        [MOV (swapl size, s)] @ instr_expand (BINOP(oper, d, dummy, swapl size))
    | instr_expand (BINOP (oper as (DIV | MOD), d, _, s)) = let
        val typ = size d
      in
        instr_expand (MOV (REG (A.eax, typ), d)) @
          [ASM "cltd", BINOP (oper, d, dummy, s)] @
          instr_expand (MOV (d, REG (if oper = MOD then A.edx else A.eax,
                                     typ)))
      end

      (* x86 shift right/left can either be an immediate or %cl *)
    | instr_expand (BINOP (oper as (RSH | LSH), d, _, s as IMM _)) =
        resolve (d, s) (fn (d', s') => [BINOP (oper, d', dummy, s')])
    | instr_expand (BINOP (oper as (RSH | LSH), d, _, s)) = let
        val ecx = REG (A.ecx, size d)
      in
        resolve (d, s)
                (fn (d', s') => [MOV (ecx, s'), BINOP (oper, d', dummy, ecx)])
      end

      (* x86 multiplication can't have the destination of memory *)
    | instr_expand (BINOP (MUL, d as MEM (_, size), _, s)) =
        MOV (swapl size, d) :: instr_expand (BINOP (MUL, swapl size, dummy, s))
          @ [MOV (d, swapl size)]

      (* CMP into a memory location is tricky b/c of movzbl mem, mem *)
    | instr_expand (BINOP (oper as CMP _, d as MEM _, s1, s2)) =
        instr_expand (BINOP (oper, swapl (size d), s1, s2)) @
          [MOV (d, swapl (size d))]

      (* Generically make sure that not both operands are in memory *)
    | instr_expand (BINOP (oper as CMP _, d, s1, s2)) =
        resolve (s1, s2) (fn (s1', s2') => [BINOP (oper, d, s1', s2')])
    | instr_expand (BINOP (oper, d, _, s)) =
        resolve (d, s) (fn (d', s') => [BINOP (oper, d', dummy, s')])

      (* make sure both operands aren't in memory for the compare *)
    | instr_expand (JMP (dst, SOME (cond, s1, s2))) =
        resolve (s1, s2) (fn (s1', s2') => [JMP (dst, SOME (cond, s1', s2'))])

      (* can't move between two memory locations *)
    | instr_expand (MOV ops) = resolve ops (fn ops => [MOV ops])

      (* tail-recursive calls are encoded with negative argument numbers *)
    | instr_expand (CALL (LABELOP l, n)) =
        if n >= 0 then [CALL (LABELOP l, n)]
        else [JMP (Label.literal (Label.str l ^ "_start"), NONE)]
    | instr_expand i = [i]

  fun instr_comment i = let val L = instr_expand i in
        if List.length L = 1 then L
        else COMMENT (format_instr i) :: L
      end

  (* format : instr list -> string
   *
   * Generates a string which is a scrap of assembly which is required to
   * fully execute the given instruction list. The abstract assembly instruction
   * may be formatted into multiple instructions.
   *
   * @param L the instruction list to format
   * @return the string of assembly necessary to execute the instruction
   *)
  fun format L = let
        fun finstr i = let val s = format_instr i in
                         if s = "" then s else
                         (case i of (DIRECTIVE _) => ""
                                  | (LABEL _)     => ""
                                  | _ => "\t") ^ s ^ "\n"
                       end
      in
        String.concat (map finstr L)
      end

  fun precolor (BINOP ((DIV | MOD), _, _, _), set) =
        OperandSet.addList (set, [REG (A.eax, A.ptrsize),
                                  REG (A.edx, A.ptrsize)])
    | precolor (BINOP ((RSH | LSH), _, _, IMM _), set) = set
    | precolor (BINOP ((RSH | LSH), _, _, _), set) =
        OperandSet.add (set, REG (A.ecx, A.ptrsize))
    | precolor (_, set) = set

  (* TODO: catch REG (STACKARG) dependencies ? *)

    (* x86 IMUL requires that the destination not be in memory *)
  fun constrain2 f (MUL, d as MEM (_, sz), s) = let
        val t = TEMP (Temp.new(), sz)
      in MOV (t, d) :: constrain2 f (MUL, t, s) @ [MOV (d, t)] end
    (* x86 requires that the rhs of a CMP is not an immediate *)
    | constrain2 f (oper as (CMP _), s1 as IMM (_, sz), s2) = let
        val t = TEMP (Temp.new (), sz)
      in MOV (t, s1) :: constrain2 f (oper, t, s2) end
    (* x86 can't support two memory operands *)
    | constrain2 f (oper, d as MEM _, s as MEM (_, ssz)) = let
        val t = TEMP (Temp.new (), ssz)
      in MOV (t, s) :: constrain2 f (oper, d, t) end
    (* x86 only operates on same-size operands *)
    | constrain2 f (oper, d, s) =
        if size d = size s then [f (d, s)]
        else let val t = TEMP (Temp.new (), size d) in
          MOV (t, s) :: constrain2 f (oper, d, t)
        end

  fun isimm (IMM _) = true | isimm _ = false

  fun revc LT  = GT
    | revc LTE = GTE
    | revc GT  = LT
    | revc GTE = LTE
    | revc EQ  = EQ
    | revc NEQ = NEQ

  fun constrain (BINOP (oper as CMP _, d as MEM _, s1, s2)) =
        constrain (BINOP (oper, swapl (size d), s1, s2)) @
          [MOV (d, swapl (size d))]
    | constrain (BINOP (oper as CMP cond, d, s1 as IMM _, s2)) =
        constrain2 (fn (s1, s2) => BINOP (CMP (revc cond), d, s1, s2))
                   (oper, s2, s1)
    | constrain (BINOP (oper as CMP _, d, s1, s2)) =
        constrain2 (fn (s1, s2) => BINOP (oper, d, s1, s2))
                   (oper, s1, s2)
    | constrain (BINOP (oper, d, s1, s2)) = let
        fun done (d, s) = BINOP (oper, d, d, s)
      in
        if isimm s1 andalso commutative oper then
          MOV (d, s2) :: constrain2 done (oper, d, s1)
        else if not (oper_equal (d, s2)) then
          MOV (d, s1) :: constrain2 done (oper, d, s2)
        else if commutative oper then
          MOV (d, s2) :: constrain2 done (oper, d, s1)
        else raise Fail "do some work"
      end
    | constrain (JMP (dest, SOME (cond, s1, s2))) =
        constrain2 (fn (s1, s2) => JMP (dest, SOME (cond, s1, s2)))
                   (CMP cond, s1, s2)
    | constrain (MOV (d, (MEM (MOP (i as IMM _), sz)))) = let
        val t = TEMP (Temp.new(), sz)
      in [MOV (t, i), MOV (d, MEM (MOP t, sz))] end
    | constrain (MOV ((MEM (MOP (i as IMM _), sz)), s)) = let
        val t = TEMP (Temp.new(), sz)
      in [MOV (t, i), MOV (MEM (MOP t, sz), s)] end
    | constrain i = [i]

end

structure X64Codegen = Codegen(structure AS = IntelAssem(ArchX64);
                               structure TR = Trans64)

structure X86Codegen = Codegen(structure AS = IntelAssem(ArchX86);
                               structure TR = Trans32)
