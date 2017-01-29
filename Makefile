include $(THEOS)/makefiles/common.mk

# TARGET = simulator:clang

TWEAK_NAME = InternalLock
InternalLock_FILES = Tweak.xm
InternalLock_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

SUBPROJECTS += preferences
include $(THEOS_MAKE_PATH)/aggregate.mk
