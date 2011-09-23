signature TESTUTILS =
sig
  exception Failure

  val tmp : unit -> Assem.operand
  val mov : (Assem.operand * Assem.operand) -> Assem.instr
  val com : unit -> Assem.instr
  val dir : unit -> Assem.instr

  val add : (Assem.operand * Assem.operand * Assem.operand) -> Assem.instr
  val sub : (Assem.operand * Assem.operand * Assem.operand) -> Assem.instr
  val mul : (Assem.operand * Assem.operand * Assem.operand) -> Assem.instr
  val adiv : (Assem.operand * Assem.operand * Assem.operand) -> Assem.instr
  val amod : (Assem.operand * Assem.operand * Assem.operand) -> Assem.instr
  val stack : int -> Assem.operand

  val runtests : (string * (unit -> unit)) list -> unit
end

signature TESTCASE =
sig
  val tests : (string * (unit -> unit)) list
end

structure TestUtils :> TESTUTILS =
struct
  exception Failure
  structure A = Assem
  structure T = Temp

  fun tmp () = A.TEMP(T.new())
  fun mov (a, b) = A.MOV (a, b)

  fun add (a, b, c) = A.BINOP (A.ADD, a, b, c)
  fun sub (a, b, c) = A.BINOP (A.SUB, a, b, c)
  fun mul (a, b, c) = A.BINOP (A.MUL, a, b, c)
  fun adiv (a, b, c) = A.BINOP (A.DIV, a, b, c)
  fun amod (a, b, c) = A.BINOP (A.MOD, a, b, c)
  fun dir () = A.DIRECTIVE ("I'm a directive!")
  fun com () = A.COMMENT ("I'm a comment!")

  fun stack n = A.REG (A.STACK n)

  fun runtests nil = ()
  |   runtests ((s, t)::L) = (
    print s;
    print "... ";
    (t(); print "passed") handle Failure => (print "failed");
    print "\n";
    runtests L
  )

end;
