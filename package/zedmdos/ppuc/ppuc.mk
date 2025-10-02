################################################################################
#
# ppuc
#
################################################################################
# Version: Commits on Jun 13, 2024
PPUC_VERSION = dfc6f008f59cfd7ff25da250d6b8eab14c216428
PPUC_SITE = $(call github,PPUC,ppuc,$(PPUC_VERSION))
PPUC_LICENSE = GPLv3
PPUC_LICENSE_FILES = LICENSE

PPUC_DEPENDENCIES = libdmdutil libpinmame cargs yaml-cpp sdl3 sdl3_image libppuc

PPUC_CONF_OPTS += -DPLATFORM=linux

define PPUC_INSTALL_TARGET_CMDS
    # copy to target
    $(INSTALL) -D -m 0755 $(@D)/ppuc-pinmame $(TARGET_DIR)/usr/bin/ppuc-pinmame
    $(INSTALL) -D -m 0755 $(@D)/ppuc-backbox $(TARGET_DIR)/usr/bin/ppuc-backbox
endef

$(eval $(cmake-package))
