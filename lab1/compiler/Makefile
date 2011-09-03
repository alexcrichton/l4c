# the following are SML-NJ specific defines
SML = sml
MLTON = mlton -const "Exn.keepHistory true" -default-ann "redundantMatch warn" -default-ann "sequenceNonUnit warn" -output
MLTON_TARG = bin/mlton-l1c

# buildid target "redundant" if called from ../Makefile, but who cares?

l1c: parse FORCE
	echo 'use "compile-l1c.sml";' | ${SML}

mlton-l1c: sources.mlb mlton-parse FORCE
	$(MLTON) $(MLTON_TARG) sources.mlb

parse/l1.lex.sml: parse/l1.lex
	ml-lex parse/l1.lex

parse/l1.grm.sml: parse/l1.grm
	ml-yacc parse/l1.grm

parse: parse/l1.lex.sml parse/l1.grm.sml

mlton-parse/l1.lex.sml: parse/l1.lex
	mllex parse/l1.lex

mlton-parse/l1.grm.sml: parse/l1.grm
	mlyacc parse/l1.grm

mlton-parse: mlton-parse/l1.lex.sml mlton-parse/l1.grm.sml

sources.mlb: sources.cm mlton-parse
	${RM} sources.mlb
	cp sources.cm sources-mlton.cm
	echo "top/go.sml" >> sources-mlton.cm
	cm2mlb sources-mlton.cm > sources.mlb

clean:
	find . -type d -name .cm | xargs rm -rf
	${RM} parse/*.lex.* parse/*.grm.*
	find . -type f | grep '~$$' | xargs ${RM}
	${RM} bin/l1c.heap.* $(MLTON_TARG)
	${RM} sources.mlb sources-mlton.cm

TAGS: clean
	${RM} TAGS
	bin/create-tags *.cm *.sml */*.lex */*.grm */*.sml

FORCE: 
