RUSTC = rustc

all: l4c

l4c: parse/parser
	@mkdir -p bin
	$(RUSTC) l4c.rc -o bin/l4c
.PHONY: l4c

clean: parseclean
	rm -rf *.dSYM l4c l4c-test

test:
	$(RUSTC) --test l4c.rc -o l4c-test
	./l4c-test

-include parse/parse.mk
