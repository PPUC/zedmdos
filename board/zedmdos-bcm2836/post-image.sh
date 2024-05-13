#!/bin/bash

mkdir -p "${BINARIES_DIR}/zedmdos"         || exit 0
mkdir -p "${BINARIES_DIR}/zedmdos/configs" || exit 0
cp "${BINARIES_DIR}/"*".dtb"            "${BINARIES_DIR}/zedmdos/"        || exit 1
cp "${BINARIES_DIR}/initrd.gz"          "${BINARIES_DIR}/zedmdos/"        || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs"    "${BINARIES_DIR}/zedmdos/zedmdos" || exit 1
cp "${BINARIES_DIR}/zImage"             "${BINARIES_DIR}/zedmdos/linux"   || exit 1
cp -pr "${BINARIES_DIR}/rpi-firmware/"* "${BINARIES_DIR}/zedmdos/"        || exit 1
cp "${BR2_EXTERNAL_ZEDMDOS_PATH}/board/zedmdos-bcm2836/cmdline.txt"  "${BINARIES_DIR}/zedmdos/" || exit 1
cp "${BR2_EXTERNAL_ZEDMDOS_PATH}/board/zedmdos-bcm2836/config.txt"   "${BINARIES_DIR}/zedmdos/" || exit 1

cp "${BINARIES_DIR}/zedmdos.ini.sample" "${BINARIES_DIR}/zedmdos/configs/zedmdos.ini.sample"   || exit 1
cp "${BINARIES_DIR}/dmdserver.ini"      "${BINARIES_DIR}/zedmdos/configs/dmdserver.ini.sample" || exit 1

ZVERSION=$(cat "${TARGET_DIR}/etc/zedmdos.version")

cd "${BINARIES_DIR}/zedmdos" && zip -qr "${BINARIES_DIR}/zedmdos-bcm2836-${ZVERSION}.zip" * || exit 1
echo "${BINARIES_DIR}/zedmdos-bcm2836-${ZVERSION}.zip" >&2
