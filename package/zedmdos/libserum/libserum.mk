################################################################################
#
# libserum
#
################################################################################
# Version: Commits on Jan 8, 2024
LIBSERUM_VERSION = b69d2b436bc93570a2e7e78d0946cd3c43f7aed5
LIBSERUM_SITE = $(call github,zesinger,libserum,$(LIBSERUM_VERSION))
LIBSERUM_LICENSE = GPLv2+
LIBSERUM_LICENSE_FILES = LICENSE.md
LIBSERUM_DEPENDENCIES = 
LIBSERUM_SUPPORTS_IN_SOURCE_BUILD = NO

LIBSERUM_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBSERUM_CONF_OPTS += -DBUILD_STATIC=OFF
LIBSERUM_CONF_OPTS += -DPLATFORM=linux

ifeq ($(BR2_aarch64),y)
	LIBSERUM_CONF_OPTS += -DARCH=$(BUILD_ARCH)
endif

# Install to staging (to build Visual Pinball Standalone for example)
LIBSERUM_INSTALL_STAGING = YES

$(eval $(cmake-package))
