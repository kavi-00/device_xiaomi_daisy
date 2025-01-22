#
# Copyright (C) 2024 The VoltageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o_mr1.mk)

# Inherit from daisy device
AB_OTA_UPDATER := false
$(call inherit-product, device/xiaomi/daisy/device.mk)

# Inherit some common VoltageOS stuff.
$(call inherit-product, vendor/voltage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := sakura
PRODUCT_NAME := voltage_sakura
BOARD_VENDOR := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi 6 Pro
PRODUCT_MANUFACTURER := Xiaomi
TARGET_VENDOR := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

#VoltageOS Stuff
VOLTAGE_BUILD_TYPE := UNOFFICIAL
TARGET_BOOT_ANIMATION_RES := 1080
EXTRA_UDFPS_ANIMATIONS := false
USE_MOTO_CALCULATOR := false
# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED := true
# Blur
TARGET_ENABLE_BLUR := false
# Pixel Stuff
TARGET_INCLUDE_PIXEL_CHARGER := true
TARGET_CALL_RECORDING_SUPPORTED := true
TARGET_GAPPS_ARCH := arm64
# Quick Tap
TARGET_SUPPORTS_QUICK_TAP := false

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sakura-user 9 PKQ1.180917.001 V12.0.1.0.PDICNXM release-keys"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := "xiaomi/sakura/sakura:9/PKQ1.180917.001/V12.0.1.0.PDICNXM:user/release-keys"
