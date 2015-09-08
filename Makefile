export CARGO_TARGET_DIR := $(PWD)/target

all:
	cargo build --release
	(cd driver && cargo build)
