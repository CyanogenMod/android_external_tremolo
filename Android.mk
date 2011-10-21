LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES = \
	Tremolo/bitwise.c \
	Tremolo/codebook.c \
	Tremolo/dsp.c \
	Tremolo/floor0.c \
	Tremolo/floor1.c \
	Tremolo/floor_lookup.c \
	Tremolo/framing.c \
	Tremolo/mapping0.c \
	Tremolo/mdct.c \
	Tremolo/misc.c \
	Tremolo/res012.c \
	Tremolo/treminfo.c \
	Tremolo/vorbisfile.c

ifeq ($(TARGET_ARCH),arm)
LOCAL_SRC_FILES += \
	Tremolo/bitwiseARM.s \
	Tremolo/dpen.s \
	Tremolo/floor1ARM.s \
	Tremolo/mdctARM.s
LOCAL_CFLAGS += \
    -D_ARM_ASSEM_
else
LOCAL_CFLAGS += \
    -DONLY_C
endif
ifeq ($(findstring -O, $(TARGET_GLOBAL_CFLAGS)),)
LOCAL_CFLAGS+= -O2
endif

# Workaround for linaro-gcc bug 913528/upstream gcc bug 51794
LOCAL_CFLAGS+=$(call cc-option -fno-modulo-sched)

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/Tremolo

LOCAL_ARM_MODE := arm

LOCAL_MODULE := libvorbisidec

include $(BUILD_SHARED_LIBRARY)
