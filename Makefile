BUILDDIR  ?= $(CURDIR)/build
LDFLAGS   +=-s -w
VERSION   = 1.0.0
PREFIX	  = /usr/bin
MANPREFIX = /usr/local/share/man

linux:
	mkdir -p ${BUILDDIR}
	GOOS=linux go build \
	     -ldflags="${LDFLAGS}" \
	     -o ${BUILDDIR}/meowfetch main.go

install: linux
	cp -f ${BUILDDIR}/meowfetch ${PREFIX}/
	chmod 755 ${PREFIX}/meowfetch
	mkdir -p ${MANPREFIX}/man1
	sed "s/{VERSION}/${VERSION}/g" < meowfetch.1 > ${MANPREFIX}/man1/meowfetch.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/meowfetch.1

uninstall:
	rm -rf ${PREFIX}/meowfetch
	rm -rf ${MANPREFIX}/man1/meowfetch

.PHONY: run
run:
	go run main.go

.PHONY: clean
clean:
	rm -rf ${BUILDDIR}/*
	go clean -v ./...
	@echo "Done."
