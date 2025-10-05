################################################################################
#
# libserum
#
################################################################################
# Version: Commits on Oct 5, 2025
LIBSERUM_VERSION = 7d7f6a6d4cd7e791c865cc75721e1896126bac5f
LIBSERUM_SITE = $(call github,PPUC,libserum_concentrate,$(LIBSERUM_VERSION))
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
