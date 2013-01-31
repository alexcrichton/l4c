RUSTC = rustc
SOURCES = $(shell find . -name '*.rs' -or -name '*.rc')

all: driver l4c
l4c: bin/l4c
opt: l4c
opt: RUSTC = rustc --opt-level=3
dbg: l4c
dbg: RUSTC = rustc -g

check:
	$(RUSTC) l4c.rc --no-trans

bin/l4c: parse/parser $(SOURCES)
	@mkdir -p bin
	$(RUSTC) l4c.rc -o $@
.PHONY: l4c

clean: parseclean
	rm -rf bin

driver: driver.go
	go build $<

test:
	$(RUSTC) --test l4c.rc -o bin/l4c-test
	./bin/l4c-test

-include parse/parse.mk
