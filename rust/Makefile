RUSTC = rustc

all: l4c
l4c: bin/l4c

bin/l4c: parse/parser $(wildcard **/*.rs) l4c.rc
	@mkdir -p bin
	$(RUSTC) l4c.rc -o $@
.PHONY: l4c

clean: parseclean
	rm -rf *.dSYM l4c l4c-test

test:
	$(RUSTC) --test l4c.rc -o bin/l4c-test
	./bin/l4c-test

-include parse/parse.mk
