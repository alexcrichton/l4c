(* L5 Compiler
 * Peephole optimizations
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)
signature PEEPHOLE =
sig
  val optimize : Assem.instr list -> Assem.instr list
end

structure Peephole :> PEEPHOLE =
struct

  structure A = Assem
  structure W = Word32

  val two  = Word32.fromInt 2
  val one  = Word32.fromInt 1
  val zero = Word32.fromInt 0

  fun log2 n = if n = one then zero else one + log2 (n div two)
  fun ispow2 n = if n = one then true
                 else if Word32.andb (n, one) = one then false
                 else if n = zero then false
                 else if n < zero then false
                 else ispow2 (n div two)

  fun optimize ((i as A.BINOP (A.MUL, oper, A.IMM (n, s))) :: L) =
        if ispow2 n then A.BINOP (A.LSH, oper, A.IMM (log2 n, s)) :: optimize L
        else i :: optimize L
    | optimize ((i as A.BINOP (A.DIV, oper, A.IMM (n, s))) :: L) =
        if ispow2 n then A.BINOP (A.RSH, oper, A.IMM (log2 n, s)) :: optimize L
        else i :: optimize L
    | optimize ((i as A.BINOP (A.MOD, oper, A.IMM (n, s))) :: L) =
        if ispow2 n then A.BINOP (A.AND, oper, A.IMM (n - one, s)) :: optimize L
        else i :: optimize L
    | optimize (i :: L) = i :: (optimize L)
    | optimize [] = []

end
