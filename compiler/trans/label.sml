(* L5 Compiler
 * Labels
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature LABEL =
sig
  type label

  val new : string -> label
  val literal : string -> label
  val extfunc : string -> label
  val intfunc : string -> label
  val scoped_func : string * string -> label
  val vtable : string -> label
  val name : label -> string
  val str : label -> string
  val hash : label -> word
  val equal : label * label -> bool
  val compare : label * label -> order
  val isfunc : label -> bool
end

structure Label :> LABEL =
struct
  datatype typ = EXTFUNC | INTFUNC | LITERAL | SCOPED of string | GENERIC of int
                         | VTABLE
  type label = string * typ

  local
    val counter = ref 1
  in
    (* new : string -> label
     *
     * Creates a new label with the brief description. The description should
     * be able to become a valid assembly label when output as a string. A
     * unique integer will also be associated with this label, so care need
     * not be taken to create a unique string. The label will be the result
     * of the concatenation of the label and the number
     *
     * @param str the string description of this label.
     *)
    fun new str = (str, GENERIC(!counter)) before (counter := !counter + 1)
  end

  fun literal str = (str, LITERAL)

  fun extfunc str = (str, EXTFUNC)
  fun intfunc str = (str, INTFUNC)
  fun scoped_func (scope, str) = (str, SCOPED scope)
  fun vtable str = (str, VTABLE)

  val extprefix = if SMLofNJ.SysInfo.getOSName () = "Darwin" then "_" else ""

  fun name (s, GENERIC i) = "L" ^ s ^ Int.toString i
    | name (s, LITERAL) = "L" ^ s
    | name (s, INTFUNC) = extprefix ^ "_c0_" ^ s
    | name (s, SCOPED scope)  = extprefix ^ "_c0_" ^ scope ^ "$$" ^ s
    | name (s, EXTFUNC) = extprefix ^ s
    | name (s, VTABLE) = extprefix ^ "_c0_vtable$" ^ s

  fun str (s, SCOPED scope) = scope ^ "$$" ^ s
    | str (s, _) = s
  fun isfunc (_, (EXTFUNC | INTFUNC)) = true
    | isfunc _ = false
  fun hash label = HashString.hashString (name label)
  fun compare (l1, l2) = String.compare (name l1, name l2)
  fun equal ts = (compare ts = EQUAL)
end
