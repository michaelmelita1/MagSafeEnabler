FINALPACKAGE = 1
THEOS_PACKAGE_SCHEME=rootless
export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MagSafeEnabler

$(TWEAK_NAME)_FILES = $(TWEAK_NAME).x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"
include $(THEOS_MAKE_PATH)/aggregate.mk