DESTDIR ?= ${DISCIMAGE}
SRCDIR = ./targetfs

prefix = /usr
libdir = ${prefix}/lib
bindir = ${prefix}/bin
incdir = ${prefix}/include

all:

install: 
	mkdir -p ${DESTDIR}${libdir}
	mkdir -p ${DESTDIR}${incdir}
	mkdir -p ${DESTDIR}${bindir}
	cp -ar ${SRCDIR}/lib/* ${DESTDIR}${libdir}
	cp -ar ${SRCDIR}/include/* ${DESTDIR}${incdir}
	cp -ar ${SRCDIR}/bin/* ${DESTDIR}${bindir}
