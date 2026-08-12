FINALPACKAGE = 1
INSTALL_TARGET_PROCESSES = SpringBoard
export ARCHS = arm64 arm64e
export THEOS_PACKAGE_SCHEME = rootless
export TARGET = iphone:clang:16.5:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MagSafeEnabler
$(TWEAK_NAME)_FILES = $(TWEAK_NAME).xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
