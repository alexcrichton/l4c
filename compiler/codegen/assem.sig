signature ASSEM_ARCH =
sig
  structure TArch : TREE_ARCH

  eqtype reg
  eqtype size
  val caller_regs : reg list
  val callee_regs : reg list
  val arg_regs : int
  val num_regs : int

  val reg_num : reg -> int
  val num_reg : int -> reg
  val arg_reg : int -> reg
  val name : reg -> string

  val sp : reg
  val ret_reg : reg
  val size : Tree.typ -> size
  val bytes : size -> int
  val ptrsize : size
  val intsize : size

  val align_stack : int -> int
end

signature ASSEM =
sig
  structure Arch : ASSEM_ARCH

  datatype operand =
     IMM     of Word32.word * Arch.size
   | REG     of Arch.reg * Arch.size
   | TEMP    of Temp.temp * Arch.size
   | MEM     of mloc * Arch.size
   | LABELOP of Label.label
  and mloc = MOP of operand | STACK of int | STACKARG of int | STACKLOC of int

  structure OperandSet : ORD_SET where type Key.ord_key = operand

  datatype condition = LT | LTE | GT | GTE | EQ | NEQ

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP of condition
                     | AND | OR  | XOR | LSH | RSH

  val commutative : operation -> bool

  datatype instr =
     BINOP of operation * operand * operand * operand
   | MOV of operand * operand
   | JMP of Label.label * (condition * operand * operand) option
   | RET
   | CALL of operand * int
   | ASM of string
   | LABEL of Label.label
   | DIRECTIVE of string
   | COMMENT of string

  val size : operand -> Arch.size
  val format : instr list -> string
  val format_instr : instr -> string
  val format_operand : operand -> string
  val compare : operand * operand -> order
  val oper_hash : operand -> word
  val oper_equal : operand * operand -> bool
  val num_loc : (int * Arch.size) -> operand

  val map_operands : (operand -> operand) -> instr list -> instr list
  val fold_operands : (operand * 'a -> 'a) -> 'a -> instr list -> 'a
  val constrain : instr -> instr list
  val instr_expand : instr -> instr list

  (* precolor : A.instr * RS.set -> RS.set
   *
   * Adds precolored registers to the given set so that the registers are
   * available during allocation.
   *)
  val precolor : instr * OperandSet.set -> OperandSet.set
end
