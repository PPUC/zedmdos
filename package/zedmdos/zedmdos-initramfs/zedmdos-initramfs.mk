################################################################################
#
# busybox_initramfs
#
################################################################################

ZEDMDOS_INITRAMFS_VERSION = 1.36.1
ZEDMDOS_INITRAMFS_SITE = http://www.busybox.net/downloads
ZEDMDOS_INITRAMFS_SOURCE = busybox-$(ZEDMDOS_INITRAMFS_VERSION).tar.bz2
ZEDMDOS_INITRAMFS_LICENSE = GPLv2
ZEDMDOS_INITRAMFS_LICENSE_FILES = LICENSE

ZEDMDOS_INITRAMFS_CFLAGS = $(TARGET_CFLAGS)
ZEDMDOS_INITRAMFS_LDFLAGS = $(TARGET_LDFLAGS)

ZEDMDOS_INITRAMFS_KCONFIG_FILE = $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-initramfs/busybox.config

INITRAMFS_DIR=$(BINARIES_DIR)/initramfs

# Allows the build system to tweak CFLAGS
ZEDMDOS_INITRAMFS_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	CFLAGS="$(ZEDMDOS_INITRAMFS_CFLAGS)"
ZEDMDOS_INITRAMFS_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	ARCH=$(KERNEL_ARCH) \
	PREFIX="$(INITRAMFS_DIR)" \
	EXTRA_LDFLAGS="$(ZEDMDOS_INITRAMFS_LDFLAGS)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CONFIG_PREFIX="$(INITRAMFS_DIR)" \
	SKIP_STRIP=y

ZEDMDOS_INITRAMFS_KCONFIG_OPTS = $(ZEDMDOS_INITRAMFS_MAKE_OPTS)

define ZEDMDOS_INITRAMFS_BUILD_CMDS
	$(ZEDMDOS_INITRAMFS_MAKE_ENV) $(MAKE) $(ZEDMDOS_INITRAMFS_MAKE_OPTS) -C $(@D)
endef

define ZEDMDOS_INITRAMFS_INSTALL_TARGET_CMDS
	mkdir -p $(INITRAMFS_DIR)
	cp $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/zedmdos-initramfs/init $(INITRAMFS_DIR)/init
	$(ZEDMDOS_INITRAMFS_MAKE_ENV) $(MAKE) $(ZEDMDOS_INITRAMFS_MAKE_OPTS) -C $(@D) install
	(cd $(INITRAMFS_DIR) && find . | cpio -H newc -o | gzip -9 > $(BINARIES_DIR)/initrd.gz)
endef

$(eval $(kconfig-package))