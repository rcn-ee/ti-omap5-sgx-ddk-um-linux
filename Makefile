TARGET_PRODUCT ?= ti335x_linux
ifneq ("${TARGET_PRODUCT}",$(filter "${TARGET_PRODUCT}","ti335x_linux" "ti437x_linux" "ti572x_linux" "ti654x_linux"))
$(error Unsupported TARGET_PRODUCT: ${TARGET_PRODUCT})
endif

ifeq (${DESTDIR},)
  $(error DESTDIR unset, if you wish to install to the rootfs of the current system set DESTDIR=/)
endif

WINDOW_SYSTEM ?= lws-generic
BUILD ?= release
SYSTEMD ?= false
UDEV ?= false

COMMONDIR := ./targetfs/common
PRODUCTDIR := ./targetfs/${TARGET_PRODUCT}/${WINDOW_SYSTEM}/${BUILD}

sysconfdir ?= /etc
bindir ?= /usr/bin
libdir ?= /usr/lib

.PHONY: all install clean
all: ;

install:
	# prime directories
	mkdir -p ${DESTDIR}/${bindir}
	mkdir -p ${DESTDIR}/${libdir}
	rm -rf ${COMMONDIR}/usr/lib
	# install
	if $(UDEV); then \
		mkdir -p ${COMMONDIR}/usr/lib/udev/rules.d/ ; \
		sed 's;{{BINDIR}};${bindir};g' \
			${COMMONDIR}/50-pvrsrvctl.rules.template \
		> ${COMMONDIR}/usr/lib/udev/rules.d/50-pvrsrvctl.rules ; \
		cp -R -P ${COMMONDIR}/usr/lib/*    ${DESTDIR}/${libdir} ; \
	elif $(SYSTEMD); then \
		mkdir -p ${COMMONDIR}/usr/lib/systemd/system/ ; \
		sed 's;{{BINDIR}};${bindir};g' \
			${COMMONDIR}/pvrsrvctl.service.template \
		> ${COMMONDIR}/usr/lib/systemd/system/pvrsrvctl.service ; \
		cp -R -P ${COMMONDIR}/usr/lib/*    ${DESTDIR}/${libdir} ; \
	else \
		mkdir -p ${DESTDIR}/${sysconfdir} ; \
		cp -R -P ${COMMONDIR}/etc/*     ${DESTDIR}/${sysconfdir} ; \
	fi
	cp -R -P ${PRODUCTDIR}/usr/bin/*    ${DESTDIR}/${bindir}
	cp -R -P ${PRODUCTDIR}/usr/lib/*    ${DESTDIR}/${libdir}
	# clean template dir
	rm -rf ${COMMONDIR}/usr/lib

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
