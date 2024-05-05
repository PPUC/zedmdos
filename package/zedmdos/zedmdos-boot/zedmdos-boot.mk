################################################################################
#
# zedmdos-boot
#
################################################################################

ZEDMDOS_BOOT_VERSION = 1.0
ZEDMDOS_BOOT_LICENSE = GPL
ZEDMDOS_BOOT_SOURCE=

define ZEDMDOS_BOOT_INSTALL_CONFIG
	mkdir -p $(TARGET_DIR)/etc/init.d
	cp $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-boot/zedmdos.ini.sample               $(BINARIES_DIR)/zedmdos.ini.sample
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-boot/init.service        $(TARGET_DIR)/etc/init.d/S03init
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-boot/default-dmd.service $(TARGET_DIR)/etc/init.d/S60default-dmd
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-boot/connman.service     $(TARGET_DIR)/etc/init.d/S45connman # replace the default one
	mkdir -p $(TARGET_DIR)/etc/connman
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-boot/connman-main.conf   $(TARGET_DIR)/etc/connman/main.conf
endef

ZEDMDOS_BOOT_POST_INSTALL_TARGET_HOOKS += ZEDMDOS_BOOT_INSTALL_CONFIG

$(eval $(generic-package))
