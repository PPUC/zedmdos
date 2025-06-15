################################################################################
#
# sockpp
#
################################################################################
# Version: Commits on Mar 30, 2025
SOCKPP_VERSION = afdeacba9448c7a77194eed6ab8e1c0b1653c79a
SOCKPP_SITE = $(call github,fpagliughi,sockpp,$(SOCKPP_VERSION))
SOCKPP_LICENSE = BSD-3-Clause
SOCKPP_LICENSE_FILES = LICENSE
SOCKPP_DEPENDENCIES =
SOCKPP_SUPPORTS_IN_SOURCE_BUILD = NO

SOCKPP_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release

SOCKPP_INSTALL_STAGING = YES

$(eval $(cmake-package))
