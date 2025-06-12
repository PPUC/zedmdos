################################################################################
#
# zedmdos-system
#
################################################################################

ZEDMDOS_SYSTEM_VERSION = 1.0-dev
ZEDMDOS_SYSTEM_LICENSE = GPL
ZEDMDOS_SYSTEM_SOURCE=

define ZEDMDOS_SYSTEM_INSTALL_CONFIG
	mkdir -p $(TARGET_DIR)/etc/init.d
	cp $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/zedmdos.ini.sample               $(BINARIES_DIR)/zedmdos.ini.sample
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/inittab             $(TARGET_DIR)/etc/inittab
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/date.service        $(TARGET_DIR)/etc/init.d/S01date
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/init.service        $(TARGET_DIR)/etc/init.d/S03init
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/default-dmd.service $(TARGET_DIR)/etc/init.d/S60default-dmd
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/connman.service     $(TARGET_DIR)/etc/init.d/S45connman # replace the default one
	mkdir -p $(TARGET_DIR)/etc/connman
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/connman-main.conf   $(TARGET_DIR)/etc/connman/main.conf
	echo $(ZEDMDOS_SYSTEM_VERSION) > ${TARGET_DIR}/etc/zedmdos.version

	# usbmount
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/usbmount/zedmdos-mount     $(TARGET_DIR)/usr/bin/zedmdos-mount
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/usbmount/zedmdos-usbmount  $(TARGET_DIR)/usr/bin/zedmdos-usbmount
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/usbmount/usbmount.conf     $(TARGET_DIR)/etc/usbmount/usbmount.conf
	install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-system/usbmount/usbmount.rules    $(TARGET_DIR)/lib/udev/rules.d/usbmount.rules
	# remove directory created by usbmount
	rm -rf $(TARGET_DIR)/media/usb*
endef

ZEDMDOS_SYSTEM_POST_INSTALL_TARGET_HOOKS += ZEDMDOS_SYSTEM_INSTALL_CONFIG

define ZEDMDOS_SYSTEM_INSTALL_SSHD_CONFIG
	sed -i -e s+"^#PermitRootLogin.*"+"PermitRootLogin yes"+ $(TARGET_DIR)/etc/ssh/sshd_config
	sed -i -e s+"^# sshd        Starts sshd."+"grep -qE '^sshd_enabled=1$$' /boot/configs/zedmdos.ini || exit 0"+ $(TARGET_DIR)/etc/init.d/S50sshd
endef

# openssh as prerequisite to configure sshd_config
# usbmount as prerequisite to override conf files
ZEDMDOS_SYSTEM_DEPENDENCIES += openssh usbmount
ZEDMDOS_SYSTEM_POST_INSTALL_TARGET_HOOKS += ZEDMDOS_SYSTEM_INSTALL_SSHD_CONFIG

$(eval $(generic-package))
