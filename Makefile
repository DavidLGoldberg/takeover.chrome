.PHONY: build test

build:
	node_modules/polymer-build/bin/polymer-build src/ build/
	[ -d build/polymer ] || mkdir build/polymer
	cp node_modules/polymer/* build/polymer

test: build
	polymer-build watch ./src src/ build/
