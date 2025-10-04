#!/bin/bash

mkdir -p "${BINARIES_DIR}/zedmdos"         	|| exit 0
mkdir -p "${BINARIES_DIR}/zedmdos/configs" 	|| exit 0
mkdir -p "${BINARIES_DIR}/zedmdos/colorization" || exit 0
mkdir -p "${BINARIES_DIR}/zedmdos/EFI"     || exit 1

cp -pr "${BINARIES_DIR}/efi-part/EFI/BOOT" "${BINARIES_DIR}/zedmdos/EFI"  || exit 1
cp "${BR2_EXTERNAL_ZEDMDOS_PATH}/board/zedmdos-x64/grub.cfg" "${BINARIES_DIR}/zedmdos/EFI/BOOT/grub.cfg" || exit 1
cp "${BINARIES_DIR}/initrd.gz"          "${BINARIES_DIR}/zedmdos/"        || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs"    "${BINARIES_DIR}/zedmdos/zedmdos" || exit 1
cp "${BINARIES_DIR}/bzImage"            "${BINARIES_DIR}/zedmdos/linux"   || exit 1

cp "${BINARIES_DIR}/zedmdos.ini.sample" "${BINARIES_DIR}/zedmdos/configs/zedmdos.ini.sample"   || exit 1
cp "${BINARIES_DIR}/dmdserver.ini"      "${BINARIES_DIR}/zedmdos/configs/dmdserver.ini.sample" || exit 1

ZVERSION=$(cat "${TARGET_DIR}/etc/zedmdos.version")

cd "${BINARIES_DIR}/zedmdos" && zip -qr "${BINARIES_DIR}/zedmdos-x64-${ZVERSION}.zip" * || exit 1
echo "${BINARIES_DIR}/zedmdos-x64-${ZVERSION}.zip" >&2
