TARGET := iphone:clang:14.4

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PencilChargingIndicator14Prefs

PencilChargingIndicator14Prefs_FILES = PCIRootListController.m
PencilChargingIndicator14Prefs_FRAMEWORKS = UIKit
PencilChargingIndicator14Prefs_PRIVATE_FRAMEWORKS = Preferences
PencilChargingIndicator14Prefs_INSTALL_PATH = /Library/PreferenceBundles
PencilChargingIndicator14Prefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
