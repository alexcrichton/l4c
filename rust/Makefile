RUSTC = rustc

all: l4c

l4c: parse/parser
	$(RUSTC) l4c.rc
.PHONY: l4c

clean: parseclean
	rm -rf *.dSYM l4c l4c-test

test:
	$(RUSTC) --test l4c.rc -o l4c-test
	./l4c-test

-include parse/parse.mk
