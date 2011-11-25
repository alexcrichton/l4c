(* L5 Compiler
 * Lexer
 * Author: Alex Crichton <acrichto@andrew.cmu.edu>
 * Author: Robbie McElrath <rmcelrat@andrew.cmu.edu>
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

  fun number parseFn (yyt, yyp) =
      let
        val ext = ParseState.ext (yyp, yyp + size yyt)
        val numOpt = parseFn yyt
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
%header (functor L5LexFn(structure Tokens : L5_TOKENS));
%full
%s COMMENT COMMENT_LINE;

id = [A-Za-z_][A-Za-z0-9_]*;
decnum = 0|([1-9][0-9]*);
hexnum = 0[xX][0-9a-fA-F]+;

ws = [\ \t\011\013\012];

%%

<INITIAL> {ws}+       => (lex ());
<INITIAL> \n          => (ParseState.newline(yypos); lex());

<INITIAL> ","         => (Tokens.COMMA (yypos, yypos + size yytext));
<INITIAL> "."         => (Tokens.PERIOD (yypos, yypos + size yytext));

<INITIAL> "{"         => (Tokens.LBRACE (yypos, yypos + size yytext));
<INITIAL> "}"         => (Tokens.RBRACE (yypos, yypos + size yytext));
<INITIAL> "("         => (Tokens.LPAREN (yypos, yypos + size yytext));
<INITIAL> ")"         => (Tokens.RPAREN (yypos, yypos + size yytext));
<INITIAL> "["         => (Tokens.LBRACKET (yypos, yypos + size yytext));
<INITIAL> "]"         => (Tokens.RBRACKET (yypos, yypos + size yytext));

<INITIAL> ";"         => (Tokens.SEMI (yypos, yypos + size yytext));
<INITIAL> "?"         => (Tokens.QUESTION (yypos, yypos + size yytext));
<INITIAL> ":"         => (Tokens.COLON (yypos, yypos + size yytext));
<INITIAL> "->"        => (Tokens.ARROW (yypos, yypos + size yytext));
<INITIAL> "::"        => (Tokens.CONS (yypos, yypos + size yytext));

<INITIAL> "="         => (Tokens.ASSIGN (yypos, yypos + size yytext));
<INITIAL> "+="        => (Tokens.PLUSEQ (yypos, yypos + size yytext));
<INITIAL> "-="        => (Tokens.MINUSEQ (yypos, yypos + size yytext));
<INITIAL> "*="        => (Tokens.STAREQ (yypos, yypos + size yytext));
<INITIAL> "/="        => (Tokens.SLASHEQ (yypos, yypos + size yytext));
<INITIAL> "%="        => (Tokens.PERCENTEQ (yypos, yypos + size yytext));
<INITIAL> "&="        => (Tokens.ANDEQ (yypos, yypos + size yytext));
<INITIAL> "^="        => (Tokens.XOREQ (yypos, yypos + size yytext));
<INITIAL> "|="        => (Tokens.OREQ (yypos, yypos + size yytext));
<INITIAL> "<<="       => (Tokens.LSHIFTEQ (yypos, yypos + size yytext));
<INITIAL> ">>="       => (Tokens.RSHIFTEQ (yypos, yypos + size yytext));

<INITIAL> "+"         => (Tokens.PLUS (yypos, yypos + size yytext));
<INITIAL> "-"         => (Tokens.MINUS (yypos, yypos + size yytext));
<INITIAL> "*"         => (Tokens.STAR (yypos, yypos + size yytext));
<INITIAL> "/"         => (Tokens.SLASH (yypos, yypos + size yytext));
<INITIAL> "%"         => (Tokens.PERCENT (yypos, yypos + size yytext));
<INITIAL> "<"         => (Tokens.LESS (yypos, yypos + size yytext));
<INITIAL> "<="        => (Tokens.LESSEQ (yypos, yypos + size yytext));
<INITIAL> ">"         => (Tokens.GREATER (yypos, yypos + size yytext));
<INITIAL> ">="        => (Tokens.GREATEREQ (yypos, yypos + size yytext));
<INITIAL> "=="        => (Tokens.EQUALS (yypos, yypos + size yytext));
<INITIAL> "!="        => (Tokens.NEQUALS (yypos, yypos + size yytext));
<INITIAL> "&&"        => (Tokens.ANDAND (yypos, yypos + size yytext));
<INITIAL> "||"        => (Tokens.PIPEPIPE (yypos, yypos + size yytext));
<INITIAL> "&"         => (Tokens.AND (yypos, yypos + size yytext));
<INITIAL> "^"         => (Tokens.CARET (yypos, yypos + size yytext));
<INITIAL> "|"         => (Tokens.PIPE (yypos, yypos + size yytext));
<INITIAL> "<<"        => (Tokens.LSHIFT (yypos, yypos + size yytext));
<INITIAL> ">>"        => (Tokens.RSHIFT (yypos, yypos + size yytext));

<INITIAL> "!"         => (Tokens.BANG (yypos, yypos + size yytext));
<INITIAL> "~"         => (Tokens.TILDE (yypos, yypos + size yytext));

<INITIAL> "--"        => (Tokens.MINUSMINUS (yypos, yypos + size yytext));
<INITIAL> "++"        => (Tokens.PLUSPLUS (yypos, yypos + size yytext));

<INITIAL> "return"      => (Tokens.RETURN (yypos, yypos + size yytext));
<INITIAL> "while"       => (Tokens.WHILE (yypos, yypos + size yytext));
<INITIAL> "if"          => (Tokens.IF (yypos, yypos + size yytext));
<INITIAL> "else"        => (Tokens.ELSE (yypos, yypos + size yytext));
<INITIAL> "break"       => (Tokens.BREAK (yypos, yypos + size yytext));
<INITIAL> "continue"    => (Tokens.CONTINUE (yypos, yypos + size yytext));
<INITIAL> "for"         => (Tokens.FOR (yypos, yypos + size yytext));
<INITIAL> "int"         => (Tokens.INT (yypos, yypos + size yytext));
<INITIAL> "bool"        => (Tokens.BOOL (yypos, yypos + size yytext));
<INITIAL> "true"        => (Tokens.TRUE (yypos, yypos + size yytext));
<INITIAL> "false"       => (Tokens.FALSE (yypos, yypos + size yytext));
<INITIAL> "NULL"        => (Tokens.NULL (yypos, yypos + size yytext));
<INITIAL> "struct"      => (Tokens.STRUCT (yypos, yypos + size yytext));
<INITIAL> "alloc"       => (Tokens.ALLOC (yypos, yypos + size yytext));
<INITIAL> "alloc_array" => (Tokens.ALLOCARR (yypos, yypos + size yytext));
<INITIAL> "typedef"     => (Tokens.TYPEDEF (yypos, yypos + size yytext));
<INITIAL> "class"       => (Tokens.CLASS (yypos, yypos + size yytext));
<INITIAL> "new"         => (Tokens.NEW (yypos, yypos + size yytext));
<INITIAL> "extends"     => (Tokens.EXTENDS (yypos, yypos + size yytext));

<INITIAL> {decnum}    => (number Word32Signed.fromString (yytext, yypos));
<INITIAL> {hexnum}    => (number Word32Signed.fromHexString (yytext, yypos));

<INITIAL> {id}        => (if not (Symbol.valid yytext) then
                            (ErrorMsg.error (ParseState.ext (yypos, yypos))
                                       ("'" ^ yytext ^ "' cannot be a symbol");
                            lex ())
                          else let
                            val id = Symbol.symbol yytext
                          in
                            if Symbol.istype yytext then
                              (Tokens.TYPE (id, yypos, yypos + size yytext))
                            else
                              Tokens.IDENT (id, yypos, yypos + size yytext)
                          end);

<INITIAL> "/*"        => (YYBEGIN COMMENT; enterComment yypos; lex());
<INITIAL> "*/"        => (ErrorMsg.error (ParseState.ext (yypos, yypos))
                                          "unbalanced comments";
                          lex());

<INITIAL> "//"        => (YYBEGIN COMMENT_LINE; lex());
<INITIAL> .           => (ErrorMsg.error (ParseState.ext (yypos,yypos))
                              ("illegal character: \"" ^ yytext ^ "\"");
                          lex ());

<COMMENT> "/*"        => (enterComment yypos; lex());
<COMMENT> "*/"        => (if exitComment () then YYBEGIN INITIAL else ();
                          lex());
<COMMENT> \n          => (ParseState.newline yypos; lex ());
<COMMENT> .           => (lex());

<COMMENT_LINE> \n     => (ParseState.newline yypos; YYBEGIN INITIAL; lex());
<COMMENT_LINE> .      => (lex());
