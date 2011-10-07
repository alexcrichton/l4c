(* L3 Compiler
 * Labels
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature LABEL =
sig
  type label

  val new : string -> label
  val literal : string -> label
  val name : label -> string
  val hash : label -> word
  val equal : label * label -> bool
  val compare : label * label -> order
end

structure Label :> LABEL =
struct
  type label = string * int

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
    fun new str = (str, !counter) before (counter := !counter + 1)
  end

  fun literal str = (str, 0)

  fun name (s, t) =
        if t <> 0 then "." ^ s ^ Int.toString t
        else if SMLofNJ.SysInfo.getOSName () = "Darwin" then "_" ^ s
        else s
  fun hash label = HashString.hashString (name label)
  fun compare (l1, l2) = String.compare (name l1, name l2)
  fun equal ts = (compare ts = EQUAL)
end
