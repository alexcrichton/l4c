structure AssemTest :> TESTCASE =
struct

  open TestUtils
  structure A = Assem

  fun equals s1 s2 = if s1 = s2 then () else
    (print ("Expected: \n" ^ s2); print ("\nGot: \n" ^ s1); raise Failure)

  val eax = A.REG A.EAX
  val ebx = A.REG A.EBX
  val ecx = A.REG A.ECX

  fun test_mov() = equals (A.format (mov(eax, ebx))) "\tmov %ebx, %eax\n"
  fun test_mod() = equals (A.format (amod(eax, ebx, ecx)))
                    "\tmov %ebx, %eax\n\tcltd\n\tidiv %ecx\n\tmov %edx, %eax\n"
  fun test_sub() = equals (A.format (sub(eax, ebx, ecx)))
                          "\tmov %ebx, %eax\n\tsub %ecx, %eax\n"
  fun test_sub2() = equals (A.format (sub(eax, eax, ebx)))
                          "\tsub %ebx, %eax\n"
  fun test_sub3() = equals (A.format (sub(eax, ebx, eax)))
                          "\tsub %ebx, %eax\n\tneg %eax\n"
  fun test_div() = equals (A.format (adiv(eax, ebx, ecx)))
                          "\tmov %ebx, %eax\n\tcltd\n\tidiv %ecx\n"
  fun test_div2() = equals (A.format (adiv(ecx, ebx, ecx)))
                    "\tmov %ebx, %eax\n\tcltd\n\tidiv %ecx\n\tmov %eax, %ecx\n"

  val tests = [("test_mov", test_mov), ("test_sub", test_sub),
               ("test_sub2", test_sub2), ("test_sub3", test_sub3),
               ("test_mod", test_mod), ("test_div", test_div)]

end
