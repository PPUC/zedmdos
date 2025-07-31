################################################################################
#
# python-sdl2
#
################################################################################

PYTHON_SDL2_VERSION = 0.9.17
PYTHON_SDL2_SOURCE = python-sdl2-$(PYTHON_SDL2_VERSION).tar.gz
PYTHON_SDL2_SITE = $(call github,py-sdl,py-sdl2,$(PYTHON_SDL2_VERSION))
PYTHON_SDL2_SETUP_TYPE = setuptools

$(eval $(python-package))
