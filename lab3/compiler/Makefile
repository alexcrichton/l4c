# the following are SML-NJ specific defines
SML = sml
MLTON = mlton -const "Exn.keepHistory true" -default-ann "redundantMatch warn" -default-ann "sequenceNonUnit warn" -output
MLTON_TARG = bin/mlton-l2c

# buildid target "redundant" if called from ../Makefile, but who cares?

l2c: parse FORCE
	echo 'use "compile-l2c.sml";' | ${SML}

mlton-l2c: sources.mlb mlton-parse FORCE
	$(MLTON) $(MLTON_TARG) sources.mlb

parse/l2.lex.sml: parse/l2.lex
	ml-lex parse/l2.lex

parse/l2.grm.sml: parse/l2.grm
	ml-yacc parse/l2.grm

parse: parse/l2.lex.sml parse/l2.grm.sml

mlton-parse/l2.lex.sml: parse/l2.lex
	mllex parse/l2.lex

mlton-parse/l2.grm.sml: parse/l2.grm
	mlyacc parse/l2.grm

mlton-parse: mlton-parse/l2.lex.sml mlton-parse/l2.grm.sml

sources.mlb: sources.cm mlton-parse
	${RM} sources.mlb
	cp sources.cm sources-mlton.cm
	echo "top/go.sml" >> sources-mlton.cm
	cm2mlb sources-mlton.cm > sources.mlb

clean:
	find . -type d -name .cm | xargs rm -rf
	${RM} parse/*.lex.* parse/*.grm.*
	find . -type f | grep '~$$' | xargs ${RM}
	${RM} bin/l2c.heap.* $(MLTON_TARG)
	${RM} sources.mlb sources-mlton.cm

TAGS: clean
	${RM} TAGS
	bin/create-tags *.cm *.sml */*.lex */*.grm */*.sml

FORCE: 
