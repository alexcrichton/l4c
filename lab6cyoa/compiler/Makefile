# the following are SML-NJ specific defines
SML = sml
MLTON = mlton -const "Exn.keepHistory true" -default-ann "redundantMatch warn" -default-ann "sequenceNonUnit warn" -output
MLTON_TARG = bin/mlton-l5c

# buildid target "redundant" if called from ../Makefile, but who cares?

l4c: l5c
l5c: parse FORCE
	echo 'use "compile-l5c.sml";' | ${SML}

mlton-l5c: sources.mlb mlton-parse FORCE
	$(MLTON) $(MLTON_TARG) sources.mlb

parse/l5.lex.sml: parse/l5.lex
	ml-lex parse/l5.lex

parse/l5.grm.sml: parse/l5.grm
	ml-yacc parse/l5.grm

parse: parse/l5.lex.sml parse/l5.grm.sml

mlton-parse/l5.lex.sml: parse/l5.lex
	mllex parse/l5.lex

mlton-parse/l5.grm.sml: parse/l5.grm
	mlyacc parse/l5.grm

mlton-parse: mlton-parse/l5.lex.sml mlton-parse/l5.grm.sml

sources.mlb: sources.cm mlton-parse
	${RM} sources.mlb
	cp sources.cm sources-mlton.cm
	echo "top/go.sml" >> sources-mlton.cm
	cm2mlb sources-mlton.cm > sources.mlb

clean:
	find . -type d -name .cm | xargs rm -rf
	${RM} parse/*.lex.* parse/*.grm.*
	find . -type f | grep '~$$' | xargs ${RM}
	${RM} bin/l5c.heap.* $(MLTON_TARG)
	${RM} sources.mlb sources-mlton.cm

TAGS: clean
	${RM} TAGS
	bin/create-tags *.cm *.sml */*.lex */*.grm */*.sml

FORCE: 

pdf:
	pdflatex README.tex