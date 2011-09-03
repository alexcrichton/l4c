(* L1 Compiler
 * Assembly language
 * Author: Kaustuv Chaudhuri <kaustuv+@andrew.cmu.edu>
 * Modified By: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Currently just a pseudo language with 3-operand
 * instructions and arbitrarily many temps
 *
 * We write
 *
 * BINOP  operand1 <- operand2,operand3
 * MOV    operand1 <- operand2
 *
 *)

signature ASSEM =
sig
  datatype reg = EAX

  datatype operand =
	   IMM of Word32.word
	 | REG of reg
	 | TEMP of Temp.temp

  datatype operation = ADD | SUB| MUL | DIV | MOD

  datatype instr =
	   BINOP of operation * operand * operand * operand
	 | MOV of operand * operand
	 | DIRECTIVE of string
	 | COMMENT of string

  val format : instr -> string
end

structure Assem :> ASSEM = 
struct

  datatype reg = EAX

  datatype operand =
	   IMM of Word32.word
	 | REG of reg
	 | TEMP of Temp.temp

  datatype operation = ADD | SUB| MUL | DIV | MOD

  datatype instr =
	   BINOP of operation * operand * operand * operand
	 | MOV of operand * operand
	 | DIRECTIVE of string
	 | COMMENT of string

  (* functions that format assembly output *)

  fun format_reg EAX = "%eax"

  fun format_binop ADD = "ADD"
    | format_binop SUB = "SUB"
    | format_binop MUL = "MUL"
    | format_binop DIV = "DIV"
    | format_binop MOD = "MOD"

  fun format_operand (IMM(n)) = "$" ^ Word32Signed.toString(n)
    | format_operand (TEMP(t)) = Temp.name(t)
    | format_operand (REG(r)) = format_reg r

  fun format (BINOP(oper, d, s1, s2)) =
	"\t" ^ format_binop oper
	^ "\t" ^ format_operand d
	^ " <- " ^ format_operand s1
	^ "," ^ format_operand s2 ^ "\n"
    | format (MOV(d, s)) =
	"\t" ^ "MOV"
	^ "\t" ^ format_operand d
	^ " <- " ^ format_operand s ^ "\n"
    | format (DIRECTIVE(str)) =
	"\t" ^ str ^ "\n"
    | format (COMMENT(str)) =
	"\t" ^ "/* " ^ str ^ "*/\n"

end
