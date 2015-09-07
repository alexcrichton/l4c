export CARGO_TARGET_DIR := $(PWD)/target

all:
	cargo build
	(cd driver && cargo build)
