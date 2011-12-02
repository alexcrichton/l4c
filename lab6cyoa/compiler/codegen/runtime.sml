signature RUNTIME =
sig
  val instrs : Assem.instr list
end

structure Runtime :> RUNTIME =
struct
  open Assem

  fun immq n = IMM (Word32.fromInt n, QUAD)
  val null = immq 0
  val add8 = BINOP (ADD, REG (ESP, QUAD), IMM (Word32.fromInt 8, QUAD))
  val sub8 = BINOP (ADD, REG (ESP, QUAD), IMM (Word32.fromInt ~8, QUAD))
  val arg0 = REG (arg_reg 0, QUAD)
  val eaxq = REG (EAX, QUAD)

  val instrs = [
    (* raise_segv *)
    LABEL (Label.extfunc "raise_segv"),
    MOV (eaxq, null),
    MOV (REG (EAX, WORD), MEM (eaxq, WORD)),

    (* salloc, safe allocate a block of memory *)
    LABEL (Label.extfunc "salloc"),
    sub8,
    CALL (LABELOP (Label.extfunc "calloc"), 2),
    BINOP (CMP, eaxq, null),
    JMP (Label.extfunc "raise_segv", SOME EQ),
    add8,
    RET,

    (* salloc_array, safe allocate an array *)
    LABEL (Label.extfunc "salloc_array"),
    ASM ("pushq " ^ format_operand arg0),
    BINOP (CMP, arg0, null),
    JMP (Label.extfunc "raise_segv", SOME LT),
    BINOP (MUL, arg0, REG (arg_reg 1, QUAD)),
    BINOP (ADD, arg0, immq 8),
    MOV (REG (arg_reg 1, QUAD), immq 1),
    CALL (LABELOP (Label.extfunc "calloc"), 2),
    BINOP (CMP, eaxq, null),
    JMP (Label.extfunc "raise_segv", SOME EQ),
    ASM ("popq " ^ format_operand arg0),
    MOV (MEM (eaxq, WORD), REG (arg_reg 0, WORD)),
    BINOP (ADD, eaxq, immq 8),
    RET
  ]

end
