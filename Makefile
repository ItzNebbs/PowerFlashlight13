include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PowerFlashlight13
$(TWEAK_NAME)_FILES = $(wildcard *.xm)
$(TWEAK_NAME)_FRAMEWORKS = UIKit AudioToolbox
$(TWEAK_NAME)_CFLAGS = -Wno-error -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
include $(THEOS_MAKE_PATH)/aggregate.mk