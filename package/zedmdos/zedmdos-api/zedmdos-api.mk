################################################################################
#
# zedmdos-api
#
################################################################################

ZEDMDOS_API_VERSION = 1.0
ZEDMDOS_API_LICENSE = GPL
ZEDMDOS_API_SOURCE=

define ZEDMDOS_API_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/zedmd-api/www
	cp -pr $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-api/www $(TARGET_DIR)/usr/share/zedmd-api/
	install -m 0644 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-api/logo.png $(TARGET_DIR)/usr/share/zedmd-api/logo.png
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-api/zedmdos-api.py $(TARGET_DIR)/usr/bin/zedmdos-api
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-api/zedmdos-api.service $(TARGET_DIR)/etc/init.d/S70zedmdos-api
endef

$(eval $(generic-package))
