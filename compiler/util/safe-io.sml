(* L5 Compiler
 * Safe(r) I/O functions
 * Author: Frank Pfenning <fp@cs.cmu.edu>
 *)

signature SAFE_IO =
sig
  (* withOpenIn fileName (fn instream => body) = result
     opens fileName for input to obtain instream and evaluates body.
     The file is closed during normal and abnormal exit of body.
  *)
  val withOpenIn : string -> (TextIO.instream -> 'a) -> 'a

  (* withOpenOut fileName (fn outstream => body) = result
     opens fileName for output to obtain outstream and evaluates body.
     The file is closed during normal and abnormal exit of body.
  *)
  val withOpenOut : string -> (TextIO.outstream -> 'a) -> 'a
end

structure SafeIO :> SAFE_IO =
struct

  (* result of a computation *)
  datatype 'a Result = Value of 'a | Exception of exn


  (* withOpenIn fileName (fn instream => body) = result
     opens fileName for input to obtain instream and evaluates body.
     The file is closed during normal and abnormal exit of body.
  *)
  fun withOpenIn (fileName) (scope) =
      let
	val instream = TextIO.openIn fileName
	(* val _ = fileOpenMsg (fileName) *)
	val result = Value (scope instream) handle exn => Exception (exn)
	(* val _ = fileCloseMsg (fileName) *)
	val _ = TextIO.closeIn instream
      in
	case result
	  of Value (x) => x
	   | Exception (exn) => raise exn
      end

  (* withOpenOut fileName (fn outstream => body) = result
     opens fileName for input to obtain outstream and evaluates body.
     The file is closed during normal and abnormal exit of body.
  *)
  fun withOpenOut (fileName) (scope) =
      let
	val outstream = TextIO.openOut fileName
	(* val _ = fileOpenMsg (fileName) *)
	val result = Value (scope outstream) handle exn => Exception (exn)
	(* val _ = fileCloseMsg (fileName) *)
	val _ = TextIO.closeOut outstream
      in
	case result
	  of Value (x) => x
	   | Exception (exn) => raise exn
      end
end
