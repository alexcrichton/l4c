structure AssemTest :> TESTCASE =
struct

  open TestUtils
  structure A = Assem

  fun equals s1 s2 = if s1 = s2 then () else
    (print ("Expected: \n" ^ s2); print ("\nGot: \n" ^ s1); raise Failure)

  val eax = A.REG A.EAX
  val ebx = A.REG A.EBX
  val ecx = A.REG A.ECX

  val tests = [
    ("test_mov", fn () => equals (A.format (mov(eax, ebx)))
                 "\tmov %ebx, %eax\n"),
    ("test_mod", fn () => equals (A.format (amod(eax, ebx, ecx)))
                 "\tmov %ebx, %eax\n\tcltd\n\tidiv %ecx\n\tmov %edx, %eax\n"),
    ("test_sub", fn () => equals (A.format (sub(eax, ebx, ecx)))
                 "\tmov %ebx, %eax\n\tsub %ecx, %eax\n"),
    ("test_sub2", fn () => equals (A.format (sub(eax, eax, ebx)))
                 "\tsub %ebx, %eax\n"),
    ("test_sub3", fn () => equals (A.format (sub(eax, ebx, eax)))
                 "\tsub %ebx, %eax\n\tneg %eax\n"),
    ("test_sub4", fn () => equals (A.format (sub(eax, eax, ebx)))
                 "\tsub %ebx, %eax\n"),
    ("test_div", fn () => equals (A.format (adiv(eax, ebx, ecx)))
                 "\tmov %ebx, %eax\n\tcltd\n\tidiv %ecx\n"),
    ("test_div2", fn () => equals (A.format (adiv(ecx, ebx, ecx)))
                 "\tmov %ebx, %eax\n\tcltd\n\tidiv %ecx\n\tmov %eax, %ecx\n"),
    ("test_mov2", fn () => equals (A.format (mov(stack 1, stack 2)))
                 "\tmov -8(%rsp), %r15d\n\tmov %r15d, -4(%rsp)\n"),
    ("test_add", fn () => equals (A.format (add(stack 1, stack 2, stack 3)))
                 "\tmov -12(%rsp), %r15d\n\tadd -8(%rsp), %r15d\n\tmov %r15d, -4(%rsp)\n"),
    ("test_add2", fn () => equals (A.format (add(eax, stack 2, stack 3)))
                 "\tmov -8(%rsp), %eax\n\tadd -12%(rsp), %eax\n"),
    ("test_add3", fn () => equals (A.format (add(stack 1, eax, stack 3)))
                 "\tmov -12(%rsp), %r15d\n\tadd %eax, %r15d\n\tmov %r15d, -4(%rsp)\n"),
    ("test_add4", fn () => equals (A.format (add(stack 1, stack 3, eax)))
                 "\tmov %eax, %r15d\n\tadd -12%(rsp), %r15d\n\tmov %r15d, -4(%rsp)\n"),
    ("test_add5", fn () => equals (A.format (add(eax, ebx, eax)))
                 "\tadd %ebx, %eax\n")
  ]
end
