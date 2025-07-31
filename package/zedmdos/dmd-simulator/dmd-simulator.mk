################################################################################
#
# DMD_SIMULATOR
#
################################################################################
DMD_SIMULATOR_VERSION = 779c90a83dc9a68fded6dd4757bd7282b6d0b624
DMD_SIMULATOR_SITE =  $(call github,batocera-linux,dmd-simulator,$(DMD_SIMULATOR_VERSION))
DMD_SIMULATOR_SETUP_TYPE = pep517
DMD_SIMULATOR_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
