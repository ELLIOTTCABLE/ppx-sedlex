PPX_VERSION ?= $(shell node -p 'require("./package.json").version')
PPX_BINS = \
	sedlex-ppx-v$(PPX_VERSION)-linux-x64/ppx.exe \
	sedlex-ppx-v$(PPX_VERSION)-darwin-x64/ppx.exe
#	sedlex-ppx-v$(PPX_VERSION)-win32-x64/ppx.exe

.PHONY: all
all: clean build test

.PHONY: clean
clean:
	rm -r ppx/ sedlex-ppx-v*-*-* SHASUM256.txt

.PHONY: test
test: $(PPX_BINS)
	shasum -c SHASUM256.txt
	node test.js

.PHONY: build
build: clean SHASUM256.txt

SHASUM256.txt: $(PPX_BINS)
	shasum -a 256 $^ > $@

get-ppx = \
	curl -O -L https://github.com/ELLIOTTCABLE/sedlex/releases/download/v$(*F)/$(@D).zip && \
	unzip -d ppx $(@D).zip $(@F) && \
	mv ppx $(@D) && \
	rm $(@D).zip && \
	touch $@

sedlex-ppx-v%-linux-x64/ppx.exe:
	$(get-ppx)

sedlex-ppx-v%-darwin-x64/ppx.exe:
	$(get-ppx)

sedlex-ppx-v%-win32-x64/ppx.exe:
	$(get-ppx)
