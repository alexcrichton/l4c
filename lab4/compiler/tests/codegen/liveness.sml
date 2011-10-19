structure LivenessTest :> TESTCASE =
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

  val l1 = A.label ()
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

  fun test_comments_and_directives () =
    equals (Liveness.compute [mov (t4, t2), com(), dir(), mov (t2, t4)])
                             [[t2], [t4], [t4], [t4]]

  fun test_binops () =
    equals (Liveness.compute [add (t4, t2, t1), mov (t2, t4), mul (t1, t2, t3)])
                            [[t1, t2, t3], [t3, t4], [t2, t3]]

  fun test_div () =
    equals (Liveness.compute [adiv (t1, t2, t3)]) [[t2, t3]]

  fun test_movflag () =
    equals (Liveness.compute [A.LABEL l1, A.MOVFLAG (t1, A.LT), A.JMPC (l1, t1)])
                             [[], [], [t1]]

  val tests = [("test_comments_and_directives", test_comments_and_directives),
               ("test_binops", test_binops),
               ("test_mov_has_interfere", test_mov_has_interfere),
               ("test_mov_has_interfere2", test_mov_has_interfere2),
               ("test_mov_has_interfere3", test_mov_has_interfere3),
               ("test_div", test_div),
               ("test_movflag", test_movflag)]

end
