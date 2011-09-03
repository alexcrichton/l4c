(* L1 Compiler
 * Simple structure for cleanly handling input parameters
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Annotations: Alex Vaynberg <alv@andrew.cmu.edu>
 *) 

signature FLAG =
sig
  type flag

  val flag : string -> flag	(* create a new flag that is not set *)
  val not : flag -> flag	(* reverses the meaning of flag being set *)

  val set : flag -> unit	(* set a flag *)
  val unset : flag -> unit	(* unset a flag *)
  val isset : flag -> bool	(* check if the flag is set *)

  val guard : flag -> ('a -> unit) -> 'a -> unit 
				(* return a function that runs only if flag is set *)
  val guards : flag list -> ('a -> unit) -> 'a -> unit
				(* return a function that runs only if all flags are set *)
  val someguards : flag list -> ('a -> unit) -> 'a -> unit
				(* return a func that runs if one of flags is set *)

  (* get a function that runs the first one if flag is set, or second one if it is not *)
  val branch : flag -> ('a -> 'b) * ('a -> 'b) -> 'a -> 'b

  val show : flag -> string (* returns string that contains the setting of the flag *)
end

structure Flag :> FLAG =
struct
  datatype flag = FLAG of {name : string, value : bool ref, post : bool -> bool}

  fun flag name = FLAG {name = name, value = ref false, post = fn b => b}

  fun set (FLAG f) = #value f := true
  fun unset (FLAG f) = #value f := false
  fun not (FLAG {name, value, post}) =
	FLAG {name = name, value = value, post = fn b => Bool.not (post b)}

  fun isset (FLAG f) = (#post f) (! (#value f))

  fun guard fl f x = if isset fl then f x else ()
  fun guards fls f x = if List.all isset fls then f x else ()
  fun someguards fls f x = if List.exists isset fls then f x else ()

  fun branch fl (f, g) = if isset fl then f else g

  fun show (FLAG f) = "flag " ^ #name f ^ " = " ^ Bool.toString (! (#value f))
end
