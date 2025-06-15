################################################################################
#
# libppuc
#
################################################################################
# Version: Commits on Jun 28, 2025
LIBPPUC_VERSION = 0df00b506af9afb5e190056cdd2b294cd356e749
LIBPPUC_SITE = $(call github,PPUC,libppuc,$(LIBPPUC_VERSION))
LIBPPUC_LICENSE = GPLv3
LIBPPUC_LICENSE_FILES = LICENSE

LIBDMDUTIL_DEPENDENCIES = io-boards libserialport libyaml-cpp

LIBPPUC_CONF_OPTS += -DPLATFORM=linux
LIBPPUC_CONF_OPTS += -DBUILD_STATIC=off
LIBPPUC_INSTALL_STAGING = YES

$(eval $(cmake-package))
