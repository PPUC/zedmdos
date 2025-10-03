################################################################################
#
# DMD_SIMULATOR
#
################################################################################
DMD_SIMULATOR_VERSION = 6298b07d0a083f4531236adb54d4d272e82f297b
DMD_SIMULATOR_SITE =  $(call github,batocera-linux,dmd-simulator,$(DMD_SIMULATOR_VERSION))
DMD_SIMULATOR_SETUP_TYPE = pep517
DMD_SIMULATOR_DEPENDENCIES = host-python-hatchling

define DMD_SIMULATOR_DMD_PLAY_SYMLINK
	ln -sf dmd-play-python $(TARGET_DIR)/usr/bin/dmd-play
endef

ifeq ($(BR2_PACKAGE_DMD_SIMULATOR_DMD_PLAY_BIN),y)
DMD_SIMULATOR_POST_INSTALL_TARGET_HOOKS += DMD_SIMULATOR_DMD_PLAY_SYMLINK
endif

$(eval $(python-package))
