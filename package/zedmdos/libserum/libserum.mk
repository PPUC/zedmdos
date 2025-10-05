################################################################################
#
# libserum
#
################################################################################
# Version: Commits on Aug 28, 2025
LIBSERUM_VERSION = ecf1fb6e9e0464593646150ca82ef6d5f177a113
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
