# the following are SML-NJ specific defines
SML = sml
MLTON = mlton -const "Exn.keepHistory true" -default-ann "redundantMatch warn" -default-ann "sequenceNonUnit warn" -output
MLTON_TARG = bin/mlton-l4c

# buildid target "redundant" if called from ../Makefile, but who cares?

l4c: parse FORCE
	echo 'use "compile-l4c.sml";' | ${SML}

mlton-l4c: sources.mlb mlton-parse FORCE
	$(MLTON) $(MLTON_TARG) sources.mlb

parse/l4.lex.sml: parse/l4.lex
	ml-lex parse/l4.lex

parse/l4.grm.sml: parse/l4.grm
	ml-yacc parse/l4.grm

parse: parse/l4.lex.sml parse/l4.grm.sml

mlton-parse/l4.lex.sml: parse/l4.lex
	mllex parse/l4.lex

mlton-parse/l4.grm.sml: parse/l4.grm
	mlyacc parse/l4.grm

mlton-parse: mlton-parse/l4.lex.sml mlton-parse/l4.grm.sml

sources.mlb: sources.cm mlton-parse
	${RM} sources.mlb
	cp sources.cm sources-mlton.cm
	echo "top/go.sml" >> sources-mlton.cm
	cm2mlb sources-mlton.cm > sources.mlb

clean:
	find . -type d -name .cm | xargs rm -rf
	${RM} parse/*.lex.* parse/*.grm.*
	find . -type f | grep '~$$' | xargs ${RM}
	${RM} bin/l4c.heap.* $(MLTON_TARG)
	${RM} sources.mlb sources-mlton.cm

TAGS: clean
	${RM} TAGS
	bin/create-tags *.cm *.sml */*.lex */*.grm */*.sml

FORCE: 
