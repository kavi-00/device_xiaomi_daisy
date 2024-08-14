#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

blob_fixups: blob_fixups_user_type = {
    ('vendor/lib/libchromaflash.so', 'vendor/lib/libarcsoft_high_dynamic_range.so', 'vendor/lib/libdualcameraddm.so', 'vendor/lib/libseemore.so', 'vendor/lib/liboptizoom.so', 'vendor/lib/libubifocus.so', 'vendor/lib/libvidhance.so'): blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
    'vendor/lib64/libgf_hal.so': blob_fixup()
        .sig_replace('10 03 00 D0 11 52 46 F9', '10 03 00 D0 1F 20 03 D5'),
    'vendor/lib64/libvendor.goodix.hardware.fingerprint@1.0-service.so': blob_fixup()
        .remove_needed('libprotobuf-cpp-lite.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'daisy',
    'xiaomi',
    blob_fixups=blob_fixups,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(module, 'msm8953-common', module.vendor)
    utils.run()
