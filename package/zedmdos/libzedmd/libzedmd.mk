################################################################################
#
# libzedmd
#
################################################################################
# Version: Commits on Feb 16, 2025
LIBZEDMD_VERSION = 893e59cc2f671be17455a68837f4618936006785
LIBZEDMD_SITE = $(call github,PPUC,libzedmd,$(LIBZEDMD_VERSION))
LIBZEDMD_LICENSE = GPLv3
LIBZEDMD_LICENSE_FILES = LICENSE
LIBZEDMD_DEPENDENCIES = libserialport sockpp
LIBZEDMD_SUPPORTS_IN_SOURCE_BUILD = NO

LIBZEDMD_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBZEDMD_CONF_OPTS += -DBUILD_STATIC=OFF
LIBZEDMD_CONF_OPTS += -DPLATFORM=linux
LIBZEDMD_CONF_OPTS += -DPOST_BUILD_COPY_EXT_LIBS=OFF

ifeq ($(BR2_aarch64),y)
	LIBZEDMD_CONF_OPTS += -DARCH=$(BUILD_ARCH)
endif

# Install to staging to build Visual Pinball Standalone
LIBZEDMD_INSTALL_STAGING = YES

$(eval $(cmake-package))
