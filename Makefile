PPX_VERSION ?= $(shell node -p 'require("./package.json").version')
PPX_BINS = \
	ppx-sedlex-v$(PPX_VERSION)-linux-x64-4.02.3/ppx.exe \
	ppx-sedlex-v$(PPX_VERSION)-linux-x64-4.06.1/ppx.exe \
	ppx-sedlex-v$(PPX_VERSION)-darwin-x64-4.02.3/ppx.exe \
	ppx-sedlex-v$(PPX_VERSION)-darwin-x64-4.06.1/ppx.exe
#	ppx-sedlex-v$(PPX_VERSION)-win32-x64-4.02.3/ppx.exe
#	ppx-sedlex-v$(PPX_VERSION)-win32-x64-4.06.1/ppx.exe

.PHONY: all
all: clean build test

.PHONY: clean
clean:
	rm -r ppx/ ppx-sedlex-v*-*-*-* SHASUM256.txt

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

# FIXME: Jesus, dedupe this.
ppx-sedlex-v%-linux-x64-4.02.3/ppx.exe:
	$(get-ppx)

ppx-sedlex-v%-linux-x64-4.06.1/ppx.exe:
	$(get-ppx)

ppx-sedlex-v%-darwin-x64-4.02.3/ppx.exe:
	$(get-ppx)

ppx-sedlex-v%-darwin-x64-4.06.1/ppx.exe:
	$(get-ppx)

ppx-sedlex-v%-win32-x64-4.02.3/ppx.exe:
	$(get-ppx)

ppx-sedlex-v%-win32-x64-4.06.1/ppx.exe:
	$(get-ppx)
