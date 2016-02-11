DESTDIR ?= ${DISCIMAGE}
TARGET_PRODUCT ?= jacinto6evm
SRCDIR = ./targetfs/${TARGET_PRODUCT}

prefix = /usr
etcdir = /etc
incdir = ${prefix}/include
libdir = ${prefix}/lib
locdir = ${prefix}/local

all:

install: 
	mkdir -p ${DESTDIR}${etcdir}
	mkdir -p ${DESTDIR}${incdir}
	mkdir -p ${DESTDIR}${libdir}
	mkdir -p ${DESTDIR}${locdir}
	cp -ar ${SRCDIR}/etc/* ${DESTDIR}${etcdir}
	cp -ar ${SRCDIR}/include/* ${DESTDIR}${incdir}
	cp -ar ${SRCDIR}/lib/* ${DESTDIR}${libdir}
	cp -ar ${SRCDIR}/local/* ${DESTDIR}${locdir}
