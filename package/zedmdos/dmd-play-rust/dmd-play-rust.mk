################################################################################
#
# DMD_PLAY_RUST
#
################################################################################
DMD_PLAY_RUST_VERSION = 7cf7e95a7047669a77389f7e4c668a46bf943e1f
DMD_PLAY_RUST_SITE =  $(call github,batocera-linux,dmd-play-rust,$(DMD_PLAY_RUST_VERSION))

define DMD_PLAY_RUST_DMD_PLAY_SYMLINK
	ln -sf dmd-play-rust $(TARGET_DIR)/usr/bin/dmd-play
endef

ifeq ($(BR2_PACKAGE_DMD_PLAY_RUST_DMD_PLAY_BIN),y)
DMD_PLAY_RUST_POST_INSTALL_TARGET_HOOKS += DMD_PLAY_RUST_DMD_PLAY_SYMLINK
endif

$(eval $(cargo-package))
