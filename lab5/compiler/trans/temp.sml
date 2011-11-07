(* L4 Compiler
 * Temporaries
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature TEMP =
sig
  type temp
  type ord_key = temp

  val reset : unit -> unit  (* resets temp numbering *)
  val new : unit -> temp  (* returns a unique new temp *)
  val name : temp -> string  (* returns the name of a temp *)
  val number : temp -> int
  val hash : temp -> word (* returns the hashcode of this temp *)
  val equals : temp * temp -> bool (* checks whether the temps are in order *)
  val compare : temp * temp -> order (* comparison function *)
end

structure Temp :> TEMP =
struct
  type temp = int
  type ord_key = temp

  local
    val counter = ref 1
  in
    (* warning: calling reset() may jeopardize uniqueness of temps! *)
    fun reset () = ( counter := 1 )
    fun new () = !counter before ( counter := !counter + 1 )
  end

  fun number t = t

  fun name t = "%t" ^ Int.toString t

  fun hash t = Word.fromInt t

  fun compare ts = Int.compare ts

  fun equals ts = (compare ts = EQUAL)
end

structure TempSet = BinarySetFn(Temp)
