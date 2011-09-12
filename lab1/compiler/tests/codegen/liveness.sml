signature LIVENESSTEST =
sig
  val tests : (string * (unit -> unit)) list
end

structure LivenessTest :> LIVENESSTEST =
struct

  open TestUtils
  structure A = Assem

  fun temps_from nil = []
  |   temps_from (A.TEMP(t)::L) = t :: temps_from L
  |   temps_from (_::L) = temps_from L

  fun sets_eq S L = let
    val temps = temps_from L
  in
    if TempSet.equal (S, TempSet.addList (TempSet.empty, temps)) then ()
    else raise Failure
  end

  fun equals (set::L) (expected::L') = (sets_eq set expected; equals L L')
  |   equals nil nil = ()
  |   equals _ _ = raise Failure

  fun test_ret_no_interfere () =
    equals (Liveness.compute [ret]) [[]]

  val t1 = tmp()
  val t2 = tmp()
  val t3 = tmp()
  val t4 = tmp()

  fun test_mov_has_interfere () =
    equals (Liveness.compute [mov (t1, t2)]) [[t2]]

  fun test_mov_has_interfere2 () =
    equals (Liveness.compute [mov (t1, t2), mov (t3, t4)]) [[t2, t4], [t4]]

  fun test_mov_has_interfere3 () =
    equals (Liveness.compute [mov (t4, t2), mov (t3, t4)]) [[t2], [t4]]

  val tests = [("test_ret_no_interfere", test_ret_no_interfere),
               ("test_mov_has_interfere", test_mov_has_interfere),
               ("test_mov_has_interfere2", test_mov_has_interfere2),
               ("test_mov_has_interfere3", test_mov_has_interfere3)]

end
