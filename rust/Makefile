all: l4c

l4c: parse/parser
	rustc l4c.rc
.PHONY: l4c

clean: parseclean
	rm -rf *.dSYM l4c

-include parse/parse.mk
