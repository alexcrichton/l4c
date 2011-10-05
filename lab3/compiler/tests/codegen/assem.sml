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
                 "\tmovl %ebx, %eax\n"),
    ("test_mod", fn () => equals (A.format (amod(eax, ebx, ecx)))
                 "\tmovl %ebx, %eax\n\tcltd\n\tidivl %ecx\n\tmovl %edx, %eax\n"),
    ("test_sub", fn () => equals (A.format (sub(eax, ebx, ecx)))
                 "\tmovl %ebx, %eax\n\tsubl %ecx, %eax\n"),
    ("test_sub2", fn () => equals (A.format (sub(eax, eax, ebx)))
                 "\tsubl %ebx, %eax\n"),
    ("test_sub3", fn () => equals (A.format (sub(eax, ebx, eax)))
                 "\tsubl %ebx, %eax\n\tneg %eax\n"),
    ("test_sub4", fn () => equals (A.format (sub(eax, eax, ebx)))
                 "\tsubl %ebx, %eax\n"),
    ("test_div", fn () => equals (A.format (adiv(eax, ebx, ecx)))
                 "\tmovl %ebx, %eax\n\tcltd\n\tidivl %ecx\n"),
    ("test_div2", fn () => equals (A.format (adiv(ecx, ebx, ecx)))
                 "\tmovl %ebx, %eax\n\tcltd\n\tidivl %ecx\n\tmovl %eax, %ecx\n"),
    ("test_mov2", fn () => equals (A.format (mov(stack 1, stack 2)))
                 "\tmovl -8(%rsp), %r15d\n\tmovl %r15d, -4(%rsp)\n"),
    ("test_add", fn () => equals (A.format (add(stack 1, stack 2, stack 3)))
                 "\tmovl -8(%rsp), %r15d\n\taddl -12(%rsp), %r15d\n\tmovl %r15d, -4(%rsp)\n"),
    ("test_add2", fn () => equals (A.format (add(eax, stack 2, stack 3)))
                 "\tmovl -8(%rsp), %eax\n\taddl -12(%rsp), %eax\n"),
    ("test_add3", fn () => equals (A.format (add(stack 1, eax, stack 3)))
                 "\tmovl %eax, %r15d\n\taddl -12(%rsp), %r15d\n\tmovl %r15d, -4(%rsp)\n"),
    ("test_add4", fn () => equals (A.format (add(stack 1, stack 3, eax)))
                 "\tmovl -12(%rsp), %r15d\n\taddl %eax, %r15d\n\tmovl %r15d, -4(%rsp)\n"),
    ("test_add5", fn () => equals (A.format (add(eax, ebx, eax)))
                 "\taddl %ebx, %eax\n")
  ]
end
