SML = sml

all: parse/parser

parse/parser: parse/l5.grm.sml parse/l5.lex.sml $(wildcard parse/*.sml)
	echo 'use "parse/compile-parser.sml";' | ${SML}

parse/l5.lex.sml: parse/l5.lex
	ml-lex parse/l5.lex

parse/l5.grm.sml: parse/l5.grm
	ml-yacc parse/l5.grm

clean:
	rm -f parse/l5.grm.* parse/l5.lex.*
