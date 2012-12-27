(* L5 Compiler
 * IR architecture-specifics
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 *)

signature TREE_ARCH =
sig
  val ptrsize : int
  val intsize : int
end

structure TreeArch32 :> TREE_ARCH =
struct
  val ptrsize = 4
  val intsize = 4
end

structure TreeArch64 :> TREE_ARCH =
struct
  val ptrsize = 8
  val intsize = 4
end
