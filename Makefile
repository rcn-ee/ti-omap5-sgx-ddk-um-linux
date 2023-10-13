TARGET_PRODUCT ?= ti335x_linux
ifneq ("${TARGET_PRODUCT}",$(filter "${TARGET_PRODUCT}","ti335x_linux" "ti437x_linux" "ti572x_linux" "ti654x_linux"))
$(error Unsupported TARGET_PRODUCT: ${TARGET_PRODUCT})
endif
WINDOW_SYSTEM ?= lws-generic
BUILD ?= release

COMMONDIR = ./targetfs/common
PRODUCTDIR = ./targetfs/${TARGET_PRODUCT}/${WINDOW_SYSTEM}/${BUILD}

sysconfdir ?= /etc
bindir ?= /usr/bin
libdir ?= /usr/lib

.PHONY: all install clean
all: ;

install:
	# prime directories
	mkdir -p ${DESTDIR}/${sysconfdir}
	mkdir -p ${DESTDIR}/${bindir}
	mkdir -p ${DESTDIR}/${libdir}
	# install
	cp -R -P ${COMMONDIR}/etc/*     ${DESTDIR}/${sysconfdir}
	cp -R -P ${PRODUCTDIR}/usr/bin/*    ${DESTDIR}/${bindir}
	cp -R -P ${PRODUCTDIR}/usr/lib/*    ${DESTDIR}/${libdir}

clean:
	$(info Removing init scripts in favor of common ones)
	find targetfs -wholename '*/ti*_*/*/etc/*' -delete
	$(info Removing bad pkgconfigs)
	find targetfs -wholename '*lws-generic/*/usr/lib/pkgconfig*' -delete
	$(info Remvoing unnecessary log files)
	find targetfs -name '*.log' -delete
	$(info Remvoing files with invalid license)
	rg -i 'confidential' targetfs/ --files-with-matches | \
		while IFS='\n' read -r line; do \
			echo "$$line" ; \
			rm "$$line" ; \
		done
	$(info Remvoing empty directories)
	find targetfs/ -type d -empty -delete
