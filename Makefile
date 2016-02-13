DESTDIR ?= ${DISCIMAGE}
TARGET_PRODUCT ?= jacinto6evm
SRCDIR = ./targetfs/${TARGET_PRODUCT}

prefix = /usr
etcdir = /etc
bindir = ${prefix}/bin
incdir = ${prefix}/include
libdir = ${prefix}/lib

all:

install: 
	mkdir -p ${DESTDIR}${etcdir}
	mkdir -p ${DESTDIR}${bindir}
	mkdir -p ${DESTDIR}${incdir}
	mkdir -p ${DESTDIR}${libdir}
	cp -ar ${SRCDIR}/etc/* ${DESTDIR}${etcdir}
	cp -ar ${SRCDIR}/bin/* ${DESTDIR}${bindir}
	cp -ar ${SRCDIR}/include/* ${DESTDIR}${incdir}
	cp -ar ${SRCDIR}/lib/* ${DESTDIR}${libdir}
