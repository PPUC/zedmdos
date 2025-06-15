################################################################################
#
# libdmdutil
#
################################################################################
# Version: Commits on Mar 6, 2025
LIBDMDUTIL_VERSION = b8389b319cd9d1d38deaf107ae160733249b30d8
LIBDMDUTIL_SITE = $(call github,vpinball,libdmdutil,$(LIBDMDUTIL_VERSION))
LIBDMDUTIL_LICENSE = GPLv3
LIBDMDUTIL_LICENSE_FILES = LICENSE
LIBDMDUTIL_DEPENDENCIES = libserialport sockpp cargs libzedmd libserum libpupdmd
LIBDMDUTIL_SUPPORTS_IN_SOURCE_BUILD = NO

LIBDMDUTIL_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBDMDUTIL_CONF_OPTS += -DBUILD_STATIC=OFF
LIBDMDUTIL_CONF_OPTS += -DPLATFORM=linux
LIBDMDUTIL_CONF_OPTS += -DPOST_BUILD_COPY_EXT_LIBS=OFF

ifeq ($(BR2_aarch64),y)
	LIBDMDUTIL_CONF_OPTS += -DARCH=$(BUILD_ARCH)
endif

# Install to staging to build Visual Pinball Standalone
LIBDMDUTIL_INSTALL_STAGING = YES

define LIBDMDUTIL_INSTALL_SERVER
   $(INSTALL) -D -m 0755 $(LIBDMDUTIL_BUILDDIR)/dmdserver $(TARGET_DIR)/usr/bin/dmdserver
   install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/libdmdutil/dmdserver-retry.sh $(TARGET_DIR)/usr/bin/dmdserver-retry
   mkdir -p $(TARGET_DIR)/etc/init.d
   install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/libdmdutil/dmd_server.service $(TARGET_DIR)/etc/init.d/S50dmd_server
   install -m 0644 $(@D)/dmdserver.ini $(BINARIES_DIR)/dmdserver.ini
   sed -i -e s+'^Addr = localhost$$'+'Addr = 0.0.0.0'+ $(BINARIES_DIR)/dmdserver.ini
   # disable pixelcade and enable zedmd by default (both are causing issues cause of the current detection way)
   sed -i -z -e s+'Set to 1 if Pixelcade is attached\nEnabled = 1'+"Set to 1 if Pixelcade is attached\nEnabled = 0"+ $(BINARIES_DIR)/dmdserver.ini
   mkdir -p $(TARGET_DIR)/usr/share/dmdserver
   cp $(BINARIES_DIR)/dmdserver.ini $(TARGET_DIR)/usr/share/dmdserver/default-config.ini
endef

LIBDMDUTIL_POST_INSTALL_TARGET_HOOKS += LIBDMDUTIL_INSTALL_SERVER

$(eval $(cmake-package))
