DESTDIR ?= ${DISCIMAGE}
SRCDIR = ./targetfs

prefix = /usr
libdir = ${prefix}/lib
incdir = ${prefix}/include
bindir = ${prefix}/bin
shrdir = ${prefix}/share

all:

install: 
	mkdir -p ${DESTDIR}${libdir}
	mkdir -p ${DESTDIR}${incdir}
	mkdir -p ${DESTDIR}${bindir}
	mkdir -p ${DESTDIR}${shrdir}
	cp -ar ${SRCDIR}/lib/* ${DESTDIR}${libdir}
	cp -ar ${SRCDIR}/include/* ${DESTDIR}${incdir}
	cp -ar ${SRCDIR}/bin/* ${DESTDIR}${bindir}
	cp -ar ${SRCDIR}/share/* ${DESTDIR}${shrdir}
