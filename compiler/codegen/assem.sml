(* L5 Compiler
 * Assem
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

functor AssemIR (Arch : ASSEM_ARCH) =
struct
  datatype operand =
     IMM     of Word32.word * Arch.size
   | REG     of Arch.reg * Arch.size
   | TEMP    of Temp.temp * Arch.size
   | MEM     of mloc * Arch.size
   | LABELOP of Label.label
  and mloc = MOP of operand | STACK of int | STACKARG of int | STACKLOC of int

  datatype condition = LT | LTE | GT | GTE | EQ | NEQ

  datatype operation = ADD | SUB | MUL | DIV | MOD | CMP of condition
                     | AND | OR  | XOR | LSH | RSH

  fun commutative (ADD | MUL | AND | OR | XOR) = true
    | commutative _ = false

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

  fun size (MEM (_, t) | REG (_, t) |
            TEMP (_, t) | IMM(_, t)) = t
    | size (LABELOP _) = Arch.ptrsize

  fun num_loc (n, s) = if n < Arch.num_regs then REG (Arch.num_reg n, s)
                       else MEM (STACKLOC (n - Arch.num_regs), s)

  (* compare : (operand * operand) -> order
   *
   * Defines an ordering of operands so they can be inserted into sets.
   * @param (r1, r2) the register pair to compare
   * @return the comparison of r1 to r2
   *)
  fun compare (REG (r1, _), REG (r2, _)) =
        Int.compare (Arch.reg_num r1, Arch.reg_num r2)
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
    | oper_hash (REG (r, _)) = Word.fromInt (Arch.reg_num r)
    | oper_hash (TEMP (t, _)) = (Temp.hash t) + (Word.fromInt 15)

  structure OperandSet = BinarySetFn(struct
                                       type ord_key = operand
                                       val compare = compare
                                     end)

  fun map_op f (MEM (MOP oper, s)) = MEM (MOP (f oper), s)
    | map_op f oper = f oper

  fun map_operands f (BINOP (oper, d, s1, s2) :: L) =
        BINOP (oper, map_op f d, map_op f s1, map_op f s2) :: map_operands f L
    | map_operands f (MOV (d, s) :: L) =
        MOV (map_op f d, map_op f s) :: map_operands f L
    | map_operands f (CALL (op1, n) :: L) =
        CALL (map_op f op1, n) :: map_operands f L
    | map_operands f (JMP (dst, SOME (cond, op1, op2)) :: L) =
        JMP (dst, SOME (cond, map_op f op1, map_op f op2)) :: map_operands f L
    | map_operands f (i :: L) = i :: map_operands f L
    | map_operands _ [] = []

  fun gop (MEM (MOP oper, _)) = oper
    | gop oper = oper

  fun fold_operands f a (BINOP (oper, d, s1, s2) :: L) =
        fold_operands f (f (gop s2, f (gop s1, f (gop d, a)))) L
    | fold_operands f a (MOV (d, s) :: L) =
        fold_operands f (f (gop s, f (gop d, a))) L
    | fold_operands f a ((CALL (op1, _)) :: L) =
        fold_operands f (f (gop op1, a)) L
    | fold_operands f a (JMP (_, SOME (_, op1, op2)) :: L) =
        fold_operands f (f (gop op2, f (gop op1, a))) L
    | fold_operands f a (i :: L) = fold_operands f a L
    | fold_operands _ a [] = a

end
