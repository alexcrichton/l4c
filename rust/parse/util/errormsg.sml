(* L5 Compiler
 * Error messages
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Annotations: Alex Vaynberg <alv@andrew.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature ERRORMSG =
sig
  (* clears out all errors from the system *)
  val reset : unit -> unit

  (* global flag that indicates whether there were errors *)
  val anyErrors : bool ref

  (* sets the error flag and prints out an error message, does NOT raise ERROR *)
  val error : Mark.ext option -> string -> unit
  (* same, but does not increment error count *)
  val warn : Mark.ext option -> string -> unit

  (* generic code stopping exception *)
  exception Error
end

structure ErrorMsg :> ERRORMSG =
struct
  (* Initial values of compiler state variables *)
  val anyErrors = ref false

  fun reset() = ( anyErrors := false )

  fun perr s = TextIO.output (TextIO.stdErr, s)
  fun msg str ext note =
      (anyErrors := true;
       Option.map (perr o Mark.show) ext;
       List.app perr [":", str, ":", note, "\n"])

  fun error ext note = (anyErrors := true; msg "error" ext note)
  fun warn ext note = msg "warning" ext note

  (* Print the given error message and then abort compilation *)
  exception Error
end
