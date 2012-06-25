(* L5 Compiler
 * Positional Markers
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Annotations / bugfixes: Alex Vaynberg <alv@andrew.cmu.edu>
 *)

signature MARK =
sig
  type ext = (int * int) * (int * int) * string  (* position *)

  val show : ext -> string	(* converts the data into human readable form *)

  type 'a marked		(* value with positional information *)

  (* INTRODUCTION FUNCTIONS for type 'a marked *)

  (* put together a value and positional information *)
  val mark : 'a * ext -> 'a marked

  (* put together a value and an option of positional information *)
  val mark' : 'a * ext option -> 'a marked

  (* mark the value with no positional information *) 
  val naked : 'a -> 'a marked

  (* ELIMINATION FUNCTIONS for type a' marked *)

  (* data: remove the markings *)
  val data : 'a marked -> 'a

  (* ext: retrieve positional information from marked value*)
  val ext : 'a marked -> ext option


  (* USEFUL TOOLS *)

  (* wrap:
   * returns SOME of positional information unit that contains each one in the list
   * NONE if such wrap is not possible (spans several files, etc.)
   *)
  val wrap : ext option list -> ext option

  (* map: make your function keep positional information *)
  val map : ('a -> 'b) -> 'a marked -> 'b marked
  (* map': similar to map, but f can now use positional information
   * and preserve it at the same time 
   *) 
  val map' : ('a marked -> 'b) -> 'a marked -> 'b marked
end
  
structure Mark :> MARK =
struct
  type ext = (int * int) * (int * int) * string

  fun pos (row, 0) = Int.toString row
    | pos (row, col) = Int.toString row ^ "." ^ Int.toString col

  fun show (l, r, file) = file ^ ":" ^ pos l ^ "-" ^ pos r

  type 'a marked = 'a * ext option

  fun mark (d, e) = (d, SOME e)
  fun mark' (d, e) = (d, e)
  fun naked d = (d, NONE)

  fun data (d, e) = d
  fun ext (d, e) = e

  fun extmin ((l1, c1), (l2, c2)) =
	if l1 < l2 then (l1, c1)
	else
	  if l1 > l2 then (l2, c2)
	  else (l1, Int.min (c1, c2))
  fun extmax ((l1, c1), (l2, c2)) =
	if l1 > l2 then (l1, c1)
	else
	  if l1 > l2 then (l2, c2)
	  else (l1, Int.min (c1, c2))

  fun wrap [] = NONE
    | wrap (e :: []) = e
    | wrap (e :: el) =
      (case wrap el of
	   NONE => NONE
	 | SOME (el1, el2, elf) =>
	   (case e of
		SOME (e1, e2, ef) =>
		if String.compare (ef, elf) = EQUAL then
		    SOME (extmin (e1, el1), extmax (e2, el2), ef)
		else NONE
	      | NONE => SOME (el1, el2, elf)))


  fun map f (d, e) = (f d, e)
  fun map' f (m as (d, e)) = (f m, e)
end
