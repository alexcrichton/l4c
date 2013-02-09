RUSTC = rustc
RUSTFLAGS = -W unused-imports
SOURCES = $(shell find . -name '*.rs' -or -name '*.rc')

all: bin/driver l4c
l4c: bin/l4c
opt: l4c
opt: RUSTFLAGS += --opt-level=3
dbg: l4c
dbg: RUSTFLAGS += -Z debug-info

check:
	$(RUSTC) $(RUSTFLAGS) l4c.rc --no-trans

bin/l4c: parse/parser $(SOURCES)
	@mkdir -p bin
	$(RUSTC) $(RUSTFLAGS) l4c.rc -o $@
.PHONY: l4c

clean: parseclean
	rm -rf bin

bin/driver: driver.go
	@mkdir -p bin
	go build -o $@ $<

test:
	$(RUSTC) $(RUSTFLAGS) --test l4c.rc -o bin/l4c-test
	./bin/l4c-test

-include parse/parse.mk
