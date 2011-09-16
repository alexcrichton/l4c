structure CodegenTest :> TESTCASE =
struct

  open TestUtils
  structure A = Assem
  structure T = Tree

  val eax = A.REG A.EAX
  val ebx = A.REG A.EBX
  val ecx = A.REG A.ECX

  fun equals L expected = let
    val actual = String.concat (map A.format L)
  in
    if actual = expected then ()
    else (print ("Expected:\n" ^ expected ^ "\nGot:\n" ^ actual); raise Failure)
  end

  val zero = T.CONST (Word32.fromInt 0)

  fun test_mod() =
    equals (Codegen.codegen [T.RETURN (T.BINOP(T.MOD, zero, zero))])
      ("\tmov $0, %ebx\n\tmov $0, %eax\n\tcltd\n\tidiv %ebx\n" ^
       "\tmov %edx, %eax\n\tret\n")
  fun test_div() =
    equals (Codegen.codegen [T.RETURN (T.BINOP(T.DIV, zero, zero))])
      "\tmov $0, %ebx\n\tmov $0, %eax\n\tcltd\n\tidiv %ebx\n\tret\n"

  val tests = [("test_div", test_div), ("test_mod", test_mod)]

end
