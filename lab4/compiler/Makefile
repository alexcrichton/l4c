# the following are SML-NJ specific defines
SML = sml
MLTON = mlton -const "Exn.keepHistory true" -default-ann "redundantMatch warn" -default-ann "sequenceNonUnit warn" -output
MLTON_TARG = bin/mlton-l3c

# buildid target "redundant" if called from ../Makefile, but who cares?

l3c: parse FORCE
	echo 'use "compile-l3c.sml";' | ${SML}

mlton-l3c: sources.mlb mlton-parse FORCE
	$(MLTON) $(MLTON_TARG) sources.mlb

parse/l3.lex.sml: parse/l3.lex
	ml-lex parse/l3.lex

parse/l3.grm.sml: parse/l3.grm
	ml-yacc parse/l3.grm

parse: parse/l3.lex.sml parse/l3.grm.sml

mlton-parse/l3.lex.sml: parse/l3.lex
	mllex parse/l3.lex

mlton-parse/l3.grm.sml: parse/l3.grm
	mlyacc parse/l3.grm

mlton-parse: mlton-parse/l3.lex.sml mlton-parse/l3.grm.sml

sources.mlb: sources.cm mlton-parse
	${RM} sources.mlb
	cp sources.cm sources-mlton.cm
	echo "top/go.sml" >> sources-mlton.cm
	cm2mlb sources-mlton.cm > sources.mlb

clean:
	find . -type d -name .cm | xargs rm -rf
	${RM} parse/*.lex.* parse/*.grm.*
	find . -type f | grep '~$$' | xargs ${RM}
	${RM} bin/l3c.heap.* $(MLTON_TARG)
	${RM} sources.mlb sources-mlton.cm

TAGS: clean
	${RM} TAGS
	bin/create-tags *.cm *.sml */*.lex */*.grm */*.sml

FORCE: 
