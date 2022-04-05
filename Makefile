TARGET := iphone:clang:14.4
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PencilChargingIndicator14

PencilChargingIndicator14_FILES = Tweak.x $(wildcard *.m)
PencilChargingIndicator14_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += pencilchargingindicator14prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
