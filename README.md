# omap5-sgx-ddk-um-linux

This is the Texas Instruments Inc (TI) Driver Development Kit (DDK) for the SGX
graphics cores on TI Linux platforms. 

This package contains the user mode libraries and binaries for SGX. These user
mode libraries are developed by Imagination Technologies (IMG). TI provides
additional enhancements and integration for Linux OMAP.

The kernel mode drivers for SGX are available at:
https://git.ti.com/graphics/omap5-sgx-ddk-linux

## Highlights

This is version 1.17 of the TI DDK based on IMG's RTM drop (4948957) delivery to
TI.

DDK dependencies: glibc 2.35, libdrm 2.4.110

## Package Contents

### targetfs/

The 'targetfs' folder contains the user mode modules of SGX DDK for TI
platforms.


## TARGET SETUP

Consult the TI base system setup documentation for instructions on setting up
your target device including boot loader, kernel, and Arago filesystem. 


## INSTALL

The procedure to install the DDK user mode libraries is given below. Refer to
the README in https://git.ti.com/graphics/omap5-sgx-ddk-linux for building and
installing the kernel mode driver.

Untar the package and run the following commands on the host with the target
filesystem mounted:

```console
# cd <path_to_package>
# export DESTDIR=<path_to_target_root_filesystem>
# export TARGET_PRODUCT=<SoC value>_linux
```

Allowed values for the SoC are:
 - ti335x = All AM335x derivatives
 - ti437x = All AM437x derivatives
 - ti572x = All DRA7x and AM57xx derivatives
 - ti654x = All AM65x derivatives

```console
# sudo -E make install
```

## LOAD

The procedure to load the DDK kernel drivers is given below. 

### OMAP DRM

The pvrsrvkm driver is expected to be loaded before an OpenGLES application can
be exercised. The rc.pvr handles the loading of the necessary DRM driver.

```console
$ /etc/init.d/rc.pvr start
```

Please note that simply loading the kernel module is not enough. If you do not
wish to use this init script you will need to run the following before using the
device:

```console
$ pvrsrvctl --start --no-module
```

## TEST

The DDK has been verified using the glmark2-es2-drm test application that has
been included with the SDK file system. This application uses DRM/KMS and GBM to
render several test scenes to the display.
