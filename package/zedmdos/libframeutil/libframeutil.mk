################################################################################
#
# libframeutil
#
################################################################################
# Version: Commits on Oct 5, 2025
LIBFRAMEUTIL_VERSION = 30048ca23d41ca0a8f7d5ab75d3f646a19a90182
LIBFRAMEUTIL_SITE = $(call github,ppuc,libframeutil,$(LIBFRAMEUTIL_VERSION))
LIBFRAMEUTIL_LICENSE = GPLv3
LIBFRAMEUTIL_LICENSE_FILES = LICENSE

define LIBFRAMEUTIL_POST_INSTALL_STAGING_INCLUDES
  mkdir -p $(STAGING_DIR)/usr/include/
  cp $(@D)/include/FrameUtil.h $(STAGING_DIR)/usr/include/
endef

LIBFRAMEUTIL_POST_INSTALL_STAGING_HOOKS += LIBFRAMEUTIL_POST_INSTALL_STAGING_INCLUDES

LIBFRAMEUTIL_INSTALL_STAGING = YES

$(eval $(generic-package))
