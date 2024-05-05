################################################################################
#
# libdmdutil
#
################################################################################
# Version: Commits on May 11, 2024
LIBDMDUTIL_VERSION = fc29cd7d8271c34999a125fbbc123a71ace571c9
LIBDMDUTIL_SITE = $(call github,vpinball,libdmdutil,$(LIBDMDUTIL_VERSION))
LIBDMDUTIL_LICENSE = BSD-3-Clause
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
   mkdir -p $(TARGET_DIR)/etc/init.d
   install -m 0755 $(BR2_EXTERNAL_ZEDMDOS_PATH)/package/zedmdos/libdmdutil/dmd_server.service $(TARGET_DIR)/etc/init.d/S50dmd_server
   install -m 0644 $(@D)/dmdserver.ini $(BINARIES_DIR)/dmdserver.ini
endef

LIBDMDUTIL_POST_INSTALL_TARGET_HOOKS += LIBDMDUTIL_INSTALL_SERVER

$(eval $(cmake-package))
