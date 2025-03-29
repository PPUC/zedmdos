################################################################################
#
# DMD_SIMULATOR
#
################################################################################
DMD_SIMULATOR_VERSION = 542ebf9950964ce503772d33a70dfeee9ba04eac
DMD_SIMULATOR_SITE =  $(call github,batocera-linux,dmd-simulator,$(DMD_SIMULATOR_VERSION))

define DMD_SIMULATOR_INSTALL_DMD_SIMULATOR
	mkdir -p $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/dmd-play.py $(TARGET_DIR)/usr/bin/dmd-play
endef

DMD_SIMULATOR_POST_INSTALL_TARGET_HOOKS += DMD_SIMULATOR_INSTALL_DMD_SIMULATOR

$(eval $(generic-package))
