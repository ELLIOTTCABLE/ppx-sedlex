PPX_VERSION ?= $(shell node -p 'require("./package.json").version')
PPX_BINS = \
	sedlex-ppx-linux64-v$(PPX_VERSION)/ppx.exe \
	sedlex-ppx-osx-v$(PPX_VERSION)/ppx.exe \
	sedlex-ppx-win64-v$(PPX_VERSION)/ppx.exe

.PHONY: all
all: clean build test

.PHONY: clean
clean:
	rm -rf sedlex-ppx-*-v* SHASUM256.txt

.PHONY: test
test: $(PPX_BINS)
	shasum -c SHASUM256.txt
	node test.js

.PHONY: build
build: clean SHASUM256.txt

SHASUM256.txt: $(PPX_BINS)
	shasum -a 256 $^ > $@

get-ppx = \
	curl -O -L https://github.com/ELLIOTTCABLE/sedlex/releases/download/v$(*F)/$(@D).zip; \
	unzip $(@D).zip ppx/$(@F); \
	mv ppx $(@D); \
	rm $(@D).zip; \
	touch $@

sedlex-ppx-linux64-v%/ppx.exe:
	$(get-ppx)

sedlex-ppx-osx-v%/ppx.exe:
	$(get-ppx)

sedlex-ppx-win64-v%/ppx.exe:
	$(get-ppx)
