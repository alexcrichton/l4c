(* L5 Compiler
 * Peephole optimizations
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

  fun log2 n = if n = one then zero else one + log2 (n div two)
  fun ispow2 n = if n = one then true
                 else if Word32.andb (n, one) = one then false
                 else if n = zero then false
                 else if n < zero then false
                 else ispow2 (n div two)

  fun isret (A.RET :: _) = true
    | isret (A.MOV ((A.REG _ | A.TEMP _), (A.REG _ | A.TEMP _)) :: L) = isret L
    | isret _ = false

  fun optimize l ((i as A.BINOP (A.MUL, oper, A.IMM (n, s))) :: L) =
        if ispow2 n then
          optimize l (A.BINOP (A.LSH, oper, A.IMM (log2 n, s))::L)
        else i :: optimize l L
    | optimize l ((i as A.BINOP (A.DIV, oper, A.IMM (n, s))) :: L) =
        if ispow2 n then
          optimize l (A.BINOP (A.RSH, oper, A.IMM (log2 n, s))::L)
        else i :: optimize l L
    | optimize l ((i as A.BINOP (A.MOD, oper, A.IMM (n, s))) :: L) =
        if ispow2 n then
          optimize l (A.BINOP (A.AND, oper, A.IMM (n - one, s))::L)
        else i :: optimize l L
    | optimize l (A.BINOP (CMP, d as A.IMM _, s) ::
                (j as A.JMP (_, SOME (A.EQ | A.NEQ))) :: L) =
        A.BINOP (CMP, s, d) :: j :: optimize l L
    | optimize l (i :: L) = i :: (optimize l L)
    | optimize _ [] = []

end
