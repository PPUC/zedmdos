################################################################################
#
# io-boards
#
################################################################################

IO_BOARDS_VERSION = 3f6eeaad92624d6aceafffa079670d51194be1f6
IO_BOARDS_SITE = $(call github,PPUC,io-boards,$(IO_BOARDS_VERSION))
IO_BOARDS_LICENSE = GPLv3
IO_BOARDS_LICENSE_FILES = LICENSE

define IO_BOARDS_POST_INSTALL_STAGING_INCLUDES
  mkdir -p $(STAGING_DIR)/usr/include/io-boards
  cp $(@D)/src/PPUCPlatforms.h         $(STAGING_DIR)/usr/include/io-boards/
  cp $(@D)/src/EventDispatcher/Event.h $(STAGING_DIR)/usr/include/io-boards/
endef

IO_BOARDS_POST_INSTALL_STAGING_HOOKS += IO_BOARDS_POST_INSTALL_STAGING_INCLUDES

IO_BOARDS_INSTALL_STAGING = YES

$(eval $(generic-package))
