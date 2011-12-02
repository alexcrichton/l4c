(* L5 Compiler
 * Peephole / tail-call recursion optimizations
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
structure Peephole :> CODEGEN_OPTIMIZATION =
struct

  structure A = Assem
  structure W = Word32

  val two  = Word32.fromInt 2
  val one  = Word32.fromInt 1
  val zero = Word32.fromInt 0

  (* log2 : Word32.word -> Word32.word
   * Takes the log base 2 of the argument, assuming it's a power of two
   *)
  fun log2 n = if n = one then zero else one + log2 (n div two)

  (* ispow2 : Word32.word -> bool
   * Tests whether the argument is a power of two
   *)
  fun ispow2 n = if n = one then true
                 else if Word32.andb (n, one) = one then false
                 else if n = zero then false
                 else if n < zero then false
                 else ispow2 (n div two)

  (* isret : A.instr list -> bool * A.instr list
   *
   * Meant to be used to determine whether a CALL instruction should be
   * considered as a tail-call recursion candidate. If there are only MOV
   * instructions between registers/temps between this CALL and a RET, then this
   * is a candidate for tail-call recursion.
   *
   * @param L the list of instructions which come immediately after the CALL
   * @return a tuple where the first element is whether the CALL instruction
   *         should be considered for optimization, and the second argument is
   *         all instructions which came after the RET (eliminating those
   *         between the CALL and RET), or the initial given list otherwise.
   *)
  fun isret (A.RET :: L) = (true, L)
    | isret ((i as A.MOV ((A.REG _ | A.TEMP _), (A.REG _ | A.TEMP _))) :: L) =
        let val (ret, L') = isret L in
          (ret, if ret then L' else i :: L')
        end
    | isret L = (false, L)

  (* fixargs : A.instr list -> A.instr list
   *
   * Once a CALL is determined as being a candidate for tail-call recursion,
   * this function will go backwards in the instruction sequence and fix
   * arguments which were placed on the stack. Instead of placing them in our
   * own stack frame, we must go place them where we found the initial
   * arguments. This is as easy as changing STACK registers to the appropriate
   * STACKARG registers.
   *
   * @param L the list of register to alter.
   * @return the list of registers with necessary STACK registers changed to
   *         a STACKARG register
   *)
  fun fixargs (A.MOV (A.REG (A.STACK n, t), s) :: L) =
        A.MOV (A.REG (A.STACKARG (n div 8), t), s) :: fixargs L
    | fixargs (A.BINOP (oper, A.REG (A.STACK n, t), s) :: L) =
        A.BINOP (oper, A.REG (A.STACKARG (n div 8), t), s) :: fixargs L
    | fixargs ((i as A.CALL _) :: L) = i :: L
    | fixargs (x :: L) = x :: fixargs L
    | fixargs [] = []

  (* peep : Label.label -> (A.instr list * A.instr list) -> A.instr list
   *
   * Performs peephole optimizations on the given lists.
   *
   * @param l the name of the function currently being optimized
   * @param L the instructions which have been looked at so far, in reverse
   *        order. Initially an empty list.
   * @param R the instructions to optimize
   * @return the optimized instructions
   *)
  fun peep l (L, (i as A.BINOP (A.MUL, oper, A.IMM (n, s))) :: R) =
        if ispow2 n then
          peep l (A.BINOP (A.LSH, oper, A.IMM (log2 n, s)) :: L, R)
        else peep l (i :: L, R)
    | peep l (L, (i as A.BINOP (A.DIV, oper, A.IMM (n, s))) :: R) =
        if ispow2 n then
          peep l (A.BINOP (A.RSH, oper, A.IMM (log2 n, s)) :: L, R)
        else peep l (i :: L, R)
    | peep l (L, (i as A.BINOP (A.MOD, oper, A.IMM (n, s))) :: R) =
        if ispow2 n then
          peep l (A.BINOP (A.AND, oper, A.IMM (n - one, s)) :: L, R)
        else peep l (i :: L, R)
    | peep l (L, A.BINOP (CMP, d as A.IMM _, s) ::
                  (j as A.JMP (_, SOME (A.EQ | A.NEQ))) :: R) =
        peep l (j :: A.BINOP (CMP, s, d) :: L, R)
    | peep l (L, (c as A.CALL (A.LABELOP l', n)) :: R) = let
        val (ret, R') = isret R
      in
        if Label.equal (l, l') andalso ret then
          peep l (A.CALL (A.LABELOP l', ~n) :: fixargs L, R')
        else peep l (c :: L, R)
      end
    | peep l (L, i :: R) = peep l (i :: L, R)
    | peep _ (L, []) = rev L

  fun optimize i L = peep i ([], L)

end
