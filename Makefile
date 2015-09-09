export CARGO_TARGET_DIR := $(PWD)/target

all:
	(cd driver && cargo build --release)
