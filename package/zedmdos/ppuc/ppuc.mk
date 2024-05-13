################################################################################
#
# ppuc
#
################################################################################
# Version: Commits on May 12, 2024
PPUC_VERSION = 6bd992fb008ffa314685a558e50d7b51615cb798
PPUC_SITE = $(call github,PPUC,ppuc,$(PPUC_VERSION))
PPUC_LICENSE = GPLv3
PPUC_LICENSE_FILES = LICENSE

LIBDMDUTIL_DEPENDENCIES = libdmdutil libpinmame cargs yaml-cpp openal libppuc

PPUC_CONF_OPTS += -DPLATFORM=linux

define PPUC_INSTALL_TARGET_CMDS
    # copy to target
    $(INSTALL) -D -m 0755 $(@D)/ppuc_pinmame $(TARGET_DIR)/usr/bin/ppuc
endef

$(eval $(cmake-package))
