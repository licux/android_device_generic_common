#
# Copyright (C) 2015 The Android-x86 Open Source Project
#
# Licensed under the GNU General Public License Version 2 or later.
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.gnu.org/licenses/gpl.html
#

# Enable native bridge
WITH_NATIVE_BRIDGE := true

# Native Bridge ABI List
NATIVE_BRIDGE_ABI_LIST_32_BIT := armeabi-v7a armeabi

LOCAL_SRC_FILES := bin/enable_nativebridge

PRODUCT_COPY_FILES := $(foreach f,$(LOCAL_SRC_FILES),$(LOCAL_PATH)/$(f):system/$(f)) \
    $(LOCAL_PATH)/OEMBlackList:$(TARGET_COPY_OUT_VENDOR)/etc/misc/.OEMBlackList \
    $(LOCAL_PATH)/OEMWhiteList:$(TARGET_COPY_OUT_VENDOR)/etc/misc/.OEMWhiteList \
    $(LOCAL_PATH)/ThirdPartySO:$(TARGET_COPY_OUT_VENDOR)/etc/misc/.ThirdPartySO \

PRODUCT_PROPERTY_OVERRIDES := \
    ro.dalvik.vm.isa.arm=x86 \
    ro.enable.native.bridge.exec=1 \

ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.dalvik.vm.isa.arm64=x86_64 \
    ro.enable.native.bridge.exec64=1
endif

PRODUCT_DEFAULT_PROPERTY_OVERRIDES := ro.dalvik.vm.native.bridge=libnb.so

PRODUCT_PACKAGES := libnb


$(call inherit-product-if-exists,vendor/intel/houdini/houdini.mk)
