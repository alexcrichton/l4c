(* L1 Compiler
 * Lexer
 * Author: Kaustuv Chaudhuri <kaustuv+@cs.cmu.edu>
 * Modified: Frank Pfenning <fp@cs.cmu.edu>
 *
 * Modified: Anand Subramanian <asubrama@andrew.cmu.edu> Fall 2010
 * Lexes forward compatible fragment of C0
 *
 * Update this file to lex the necessary keywords and other tokens
 * in order to make the grammar forward compatible with C0.
 *)

structure A = Ast
structure S = Symbol

type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue,pos) Tokens.token

local
  val commentLevel = ref 0
  val commentPos = ref 0
in
  fun enterComment yypos =
      ( commentLevel := !commentLevel + 1 ;
        commentPos := yypos )

  fun exitComment () =
      ( commentLevel := !commentLevel - 1 ;
        !commentLevel = 0 )

  fun number (yyt, yyp) =
      let
        val ext = ParseState.ext (yyp, yyp + size yyt)
        val numOpt = Word32Signed.fromString yyt
                     handle Overflow =>
                            ( ErrorMsg.error ext
                                ("integral constant `" ^ yyt ^ "' too large") ;
                              NONE )
      in
        case numOpt
          of NONE => ( ErrorMsg.error ext
                     ("cannot parse integral constant `" ^ yyt ^ "'");
                      Tokens.INTCONST (Word32Signed.ZERO, yyp, yyp + size yyt) )
          | SOME n => Tokens.INTCONST (n,yyp,yyp + size yyt)
      end

  fun eof () =
      ( if (!commentLevel > 0)
          then (ErrorMsg.error (ParseState.ext (!commentPos,!commentPos))
                "unterminated comment")
          else ();
            Tokens.EOF (0,0) )    (* bogus position information; unused *)

end

%%
%header (functor L1LexFn(structure Tokens : L1_TOKENS));
%full
%s COMMENT COMMENT_LINE;

id = [A-Za-z_][A-Za-z0-9_]*;
decnum = [0-9][0-9]*;

ws = [\ \t\012];

%%

<INITIAL> {ws}+       => (lex ());
<INITIAL> \n          => (ParseState.newline(yypos); lex());

<INITIAL> "{"         => (Tokens.LBRACE (yypos, yypos + size yytext));
<INITIAL> "}"         => (Tokens.RBRACE (yypos, yypos + size yytext));
<INITIAL> "("         => (Tokens.LPAREN (yypos, yypos + size yytext));
<INITIAL> ")"         => (Tokens.RPAREN (yypos, yypos + size yytext));

<INITIAL> ";"         => (Tokens.SEMI (yypos, yypos + size yytext));

<INITIAL> "="         => (Tokens.ASSIGN (yypos, yypos + size yytext));
<INITIAL> "+="        => (Tokens.PLUSEQ (yypos, yypos + size yytext));
<INITIAL> "-="        => (Tokens.MINUSEQ (yypos, yypos + size yytext));
<INITIAL> "*="        => (Tokens.STAREQ (yypos, yypos + size yytext));
<INITIAL> "/="        => (Tokens.SLASHEQ (yypos, yypos + size yytext));
<INITIAL> "%="        => (Tokens.PERCENTEQ (yypos, yypos + size yytext));

<INITIAL> "+"         => (Tokens.PLUS (yypos, yypos + size yytext));
<INITIAL> "-"         => (Tokens.MINUS (yypos, yypos + size yytext));
<INITIAL> "*"         => (Tokens.STAR (yypos, yypos + size yytext));
<INITIAL> "/"         => (Tokens.SLASH (yypos, yypos + size yytext));
<INITIAL> "%"         => (Tokens.PERCENT (yypos, yypos + size yytext));

<INITIAL> "return"    => (Tokens.RETURN (yypos, yypos + size yytext));
<INITIAL> "int"       => (Tokens.INT (yypos, yypos + size yytext));

<INITIAL> {decnum}    => (number (yytext, yypos));

<INITIAL> {id}        => (if not (Symbol.valid yytext) then
                            (ErrorMsg.error (ParseState.ext (yypos, yypos))
                                       ("'" ^ yytext ^ "' cannot be a symbol");
                            lex ())
                          else let
                            val id = Symbol.symbol yytext
                          in
                            Tokens.IDENT (id, yypos, yypos + size yytext)
                          end);

<INITIAL> "/*"        => (YYBEGIN COMMENT; enterComment yypos; lex());
<INITIAL> "*/"        => (ErrorMsg.error (ParseState.ext (yypos, yypos)) "unbalanced comments";
                          lex());

<INITIAL> "//"        => (YYBEGIN COMMENT_LINE; lex());
<INITIAL> "#"         => (YYBEGIN COMMENT_LINE; lex());
<INITIAL> .           => (ErrorMsg.error (ParseState.ext (yypos,yypos))
                              ("illegal character: \"" ^ yytext ^ "\"");
                          lex ());

<COMMENT> "/*"        => (enterComment yypos; lex());
<COMMENT> "*/"        => (if exitComment () then YYBEGIN INITIAL else (); lex());
<COMMENT> \n          => (ParseState.newline yypos; lex ());
<COMMENT> .           => (lex());

<COMMENT_LINE> \n     => (ParseState.newline yypos; YYBEGIN INITIAL; lex());
<COMMENT_LINE> .      => (lex());
