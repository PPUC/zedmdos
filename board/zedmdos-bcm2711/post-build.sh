#!/bin/bash

cp "${BR2_EXTERNAL_ZEDMDOS_PATH}/board/zedmdos-bcm2711/inittab" "${TARGET_DIR}/etc/inittab" || exit 1
