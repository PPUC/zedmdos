################################################################################
#
# libppuc
#
################################################################################
# Version: Commits on May 12, 2024
LIBPPUC_VERSION = ad4af67c58dd214e34a630b4503d1b751be50b38
LIBPPUC_SITE = $(call github,PPUC,libppuc,$(LIBPPUC_VERSION))
LIBPPUC_LICENSE = GPLv3
LIBPPUC_LICENSE_FILES = LICENSE

LIBDMDUTIL_DEPENDENCIES = io-boards libserialport libyaml-cpp

LIBPPUC_CONF_OPTS += -DPLATFORM=linux
LIBPPUC_CONF_OPTS += -DBUILD_STATIC=off
LIBPPUC_INSTALL_STAGING = YES

$(eval $(cmake-package))
