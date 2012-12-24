all: l4c

l4c: parse/parser
	rustc l4c.rc
.PHONY: l4c

clean: parseclean
	rm -rf *.dSYM l4c

test:
	rustc l4c.rc --test -o l4c-test
	./l4c-test

-include parse/parse.mk
