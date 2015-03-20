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
LOCAL_CFLAGS+= -O2

# We need this because the current asm generates the following link error:
# requires unsupported dynamic reloc R_ARM_REL32; recompile with -fPIC
# Bug: 16853291
LOCAL_LDFLAGS := -Wl,-Bsymbolic

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/Tremolo

LOCAL_ARM_MODE := arm

LOCAL_MODULE := libvorbisidec

include $(BUILD_SHARED_LIBRARY)
