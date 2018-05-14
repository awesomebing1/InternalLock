include $(THEOS)/makefiles/common.mk

TARGET = iphone::6.1:6.1
BUNDLE_NAME = InternalLock
InternalLock_FILES = JOSRootListController.m
InternalLock_INSTALL_PATH = /Library/PreferenceBundles
InternalLock_FRAMEWORKS = UIKit
InternalLock_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/InternalLock.plist$(ECHO_END)
