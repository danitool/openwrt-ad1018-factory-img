#!/bin/sh

# Warning: firmware size limit = 40 MB

VERSION=3013
FWNAME="openwrt-sercomm_ad1018-factory_${VERSION}"

FW_BOOT_VERSION=1.1.3.0
SC_ROOTFS_LIBS_VER=1001

ROOTFS_FILE=openwrt.bin
LIB_FILE=rootfs_lib.jffs2
CFERAM_FILE=cfevfesram.jffs2.img

BUILDPATH=`pwd`
TMP="$BUILDPATH/tmp"

echo -e '\E[32;40m'"Making AD1018 factory image" && tput sgr0

cp openwrt-*-factory.bin ${TMP}/$ROOTFS_FILE

cd ${TMP}/
echo -e "${ROOTFS_FILE}\t$FWNAME" > ver_info
echo -e "${CFERAM_FILE}\t${FW_BOOT_VERSION}" >> ver_info
echo -e "${LIB_FILE}\t${SC_ROOTFS_LIBS_VER}" >> ver_info

echo -e '\nFiles:'
ls -l ../hostTools/${CFERAM_FILE}
ls -l ../hostTools/${LIB_FILE}
ls -l ${ROOTFS_FILE}

# prepare the non encrypted image
echo -e '\nmake image...'
../hostTools/make_img \
		-r ${ROOTFS_FILE} \
		-b ../hostTools/${CFERAM_FILE} \
		-l ../hostTools/${LIB_FILE} \
		-p ../hostTools/pid \
		-v ver_info \
		-f \
		-o AD1018-not_encrypted.img
echo -e 'make image done'

# make the encrypted image
../hostTools/make_img \
		-e \
		-i AD1018-not_encrypted.img \
		-o ${FWNAME}.img

# move the created image image	
echo -e "\nmoving image"
mv -v ${FWNAME}.img "$BUILDPATH"/
echo -e "done\n"
