(* L2 Compiler
 * Labels
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
 *)

signature LABEL =
sig
  type label

  val reset : unit -> unit  (* resets label numbering *)
  val new : unit -> label  (* returns a unique new label *)
  val name : label -> string  (* returns the name of a label *)
  val number : label -> int (* returns the unique identifier *)
  val compare : label * label -> order (* comparison function *)
end

structure Label :> LABEL =
struct
  type label = int

  local
    val counter = ref 1
  in
    fun reset () = (counter := 1)
    fun new () = !counter before (counter := !counter + 1)
  end

  fun name t = ".l" ^ Int.toString t
  fun number t = t
  fun compare (t1, t2) = Int.compare (t1, t2)
end
