RUSTC = rustc
RUSTFLAGS =
SOURCES = $(shell find src -name '*.rs')

all: bin/driver l4c
l4c: bin/l4c
opt: l4c
opt: RUSTFLAGS += --opt-level=3
dbg: l4c
dbg: RUSTFLAGS += -Z debug-info

check:
	$(RUSTC) $(RUSTFLAGS) src/l4c.rs --no-trans

bin/l4c: $(SOURCES)
	@mkdir -p bin
	$(RUSTC) $(RUSTFLAGS) src/l4c.rs -o $@
.PHONY: l4c

clean:
	rm -rf bin

bin/driver: driver.go
	@mkdir -p bin
	go build -o $@ $<

test: RUSTFLAGS += -A dead-code
test:
	$(RUSTC) $(RUSTFLAGS) --test src/l4c.rs -o bin/l4c-test
	./bin/l4c-test
