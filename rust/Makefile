SML = sml
HEAP = parse/parser.heap.x86-darwin

all: parse/parser

$(HEAP): parse/l5.lex.sml parse/l5.grm.sml $(wildcard parse/*.sml)
	echo 'use "parse/compile-parser.sml";' | ${SML}

parse/parser: parse/sources.cm $(HEAP)

parse/l5.lex.sml: parse/l5.lex
	ml-lex parse/l5.lex

parse/l5.grm.sml: parse/l5.grm
	ml-yacc parse/l5.grm

clean:
	rm -f parse/l5.grm.* parse/l5.lex.* parse/*.heap.*
	find parse -type d -name .cm | xargs rm -rf
