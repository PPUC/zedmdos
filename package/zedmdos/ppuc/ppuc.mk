################################################################################
#
# ppuc
#
################################################################################
# Version: Commits on Aug 26, 2025
PPUC_VERSION = d8526772f8b60006753f4a7b53517024a527b975
PPUC_SITE = $(call github,PPUC,ppuc,$(PPUC_VERSION))
PPUC_LICENSE = GPLv3
PPUC_LICENSE_FILES = LICENSE

PPUC_DEPENDENCIES = libdmdutil libpinmame cargs yaml-cpp sdl3 sdl3_image libppuc libframeutil

PPUC_CONF_OPTS += -DPLATFORM=linux

define PPUC_INSTALL_TARGET_CMDS
    # copy to target
    $(INSTALL) -D -m 0755 $(@D)/ppuc-pinmame $(TARGET_DIR)/usr/bin/ppuc-pinmame
    $(INSTALL) -D -m 0755 $(@D)/ppuc-backbox $(TARGET_DIR)/usr/bin/ppuc-backbox
endef

$(eval $(cmake-package))
