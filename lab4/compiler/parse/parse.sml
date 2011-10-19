(* L3 Compiler
 * Parsing
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Glueing together the pieces produced by ML-Lex and ML-Yacc
 *)

signature PARSE =
sig
  (* parse filename = ast
   * will raise ErrorMsg.Error in case of lexing or parsing error
   *)
  val parse : string -> Ast.program
end

structure Parse :> PARSE =
struct 

  structure L3LrVals = L3LrValsFn (structure Token = LrParser.Token)
  structure L3Lex = L3LexFn (structure Tokens = L3LrVals.Tokens)
  structure L3Parse = Join (structure ParserData = L3LrVals.ParserData
                            structure Lex = L3Lex
                            structure LrParser = LrParser)

  (* Main parsing function *)
  fun parse filename =
      SafeIO.withOpenIn filename (fn instream =>
        let 
	  val _ = ErrorMsg.reset() (* no errors, no messages so far *)
	  val _ = ParseState.setfile filename (* start at position 0 in filename *)
	  fun parseerror (s, p1, p2) = ErrorMsg.error (ParseState.ext (p1,p2)) s
	  val lexer = LrParser.Stream.streamify
			  (L3Lex.makeLexer (fn _ => TextIO.input instream))
	  (* 0 = no error correction, 15 = reasonable lookahead for correction *)
	  val (absyn, _) = L3Parse.parse(0, lexer, parseerror, ())
          val _ = if !ErrorMsg.anyErrors
		  then raise ErrorMsg.Error
		  else ()
	in
	  absyn
	end)
      handle LrParser.ParseError => raise ErrorMsg.Error (* always preceded by msg *)
           | e as IO.Io _ => ( ErrorMsg.error NONE (exnMessage e);
                               raise ErrorMsg.Error )
           (* moved here for portability between v110.59 and later versions *)
	   (* was: L3Lex.LexError => ... *)
           | e => ( ErrorMsg.error NONE "lexer error" ;
                    raise ErrorMsg.Error )

end
