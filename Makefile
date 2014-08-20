.PHONY: build test

build:
	polymer-build src/ build/
	[ -d build/polymer ] || mkdir build/polymer
	cp node_modules/polymer/* build/polymer

test: build
	polymer-build watch ./src src/ build/
