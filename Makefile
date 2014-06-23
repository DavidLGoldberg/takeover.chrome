.PHONY: build

build:
	([ -d build ] && rm -rf build) || true
	mkdir build
	cp -R src/* build/
	cp node_modules/glg-toolkit/build/* build/
