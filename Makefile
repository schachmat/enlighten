PROGNM =  enlighten
PREFIX ?= /usr/local
DOCDIR ?= $(DESTDIR)$(PREFIX)/share/man
LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
BINDIR ?= $(DESTDIR)$(PREFIX)/bin
ZSHDIR ?= $(DESTDIR)$(PREFIX)/share/zsh
BSHDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completions

include Makerules
CFLAGS += -Wno-disabled-macro-expansion

.PHONY: all bin clean clang-analyze cov-build doc install uninstall

all: dist bin doc

bin: dist
	@$(CC) $(CFLAGS) src/*.c -o dist/$(PROGNM)

clean:
	@rm -rf -- dist cov-int $(PROGNM).tgz make.sh ./src/*.plist

dist:
	@mkdir -p ./dist

doc: dist
	@(cd doc; \
		sphinx-build -b man -Dversion=$(VER) \
			-d doctree -E . ../dist $(PROGNM).rst; \
		rm -r -- doctree; \
	)


cov-build: dist
	@cov-build --dir cov-int ./make.sh
	@tar czvf $(PROGNM).tgz cov-int

clang-analyze:
	@(pushd ./src; clang-check -analyze ./*.c)

install:
	@install -Dm755 dist/$(PROGNM) $(BINDIR)/$(PROGNM)
	@install -Dm755 dist/$(PROGNM).1 $(DOCDIR)/man1/$(PROGNM).1
	@install -Dm755 90-backlight.rules $(LIBDIR)/udev/rules.d/90-backlight.rules

uninstall:
	@rm -f -- $(BINDIR)/$(PROGNM)
	@rm -f -- $(DOCDIR)/$(PROGNM).1
	@rm -f -- $(LIBDIR)/udev/rules.d/90-backlight.rules
