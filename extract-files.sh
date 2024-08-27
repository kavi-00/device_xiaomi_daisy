#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib64/libvendor.goodix.hardware.fingerprint@1.0-service.so)
            "${PATCHELF_0_8}" --remove-needed "libprotobuf-cpp-lite.so" "${2}"
            ;;
        vendor/lib64/libgf_hal.so)
            # NOP gf_hal_test_notify_acquired_info()
            "${SIGSCAN}" -p "10 03 00 d0 11 52 46 f9" -P "10 03 00 d0 1f 20 03 d5" -f "${2}"
            ;;
        vendor/lib/libchromaflash.so)
            ;&
        vendor/lib/libarcsoft_high_dynamic_range.so)
            ;&
        vendor/lib/libdualcameraddm.so)
            ;&
        vendor/lib/libseemore.so)
            ;&
        vendor/lib/liboptizoom.so)
            ;&
        vendor/lib/libubifocus.so)
            ;&
        vendor/lib/libvidhance.so)
            "${PATCHELF}" --replace-needed "libstdc++.so" "libstdc++_vendor.so" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=daisy
export DEVICE_COMMON=msm8953-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
