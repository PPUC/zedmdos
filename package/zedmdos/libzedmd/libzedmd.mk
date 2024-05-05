################################################################################
#
# libzedmd
#
################################################################################
# Version: Commits on Apr 5, 2024
LIBZEDMD_VERSION = d7e79b09f82144ee6a017bbea074efc23316201e
LIBZEDMD_SITE = $(call github,PPUC,libzedmd,$(LIBZEDMD_VERSION))
LIBZEDMD_LICENSE = GPLv3
LIBZEDMD_LICENSE_FILES = LICENSE
LIBZEDMD_DEPENDENCIES = libserialport
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
