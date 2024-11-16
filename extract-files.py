#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import extract_utils.tools

extract_utils.tools.DEFAULT_PATCHELF_VERSION = '0_18'

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/qcom-caf/msm8996',
    'hardware/xiaomi',
    'vendor/xiaomi/msm8953-common',
]

blob_fixups: blob_fixups_user_type = {
    ('vendor/lib/libchromaflash.so', 'vendor/lib/libarcsoft_high_dynamic_range.so', 'vendor/lib/libdualcameraddm.so', 'vendor/lib/libseemore.so', 'vendor/lib/liboptizoom.so', 'vendor/lib/libubifocus.so', 'vendor/lib/libvidhance.so'): blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
    'vendor/lib/libmmcamera_tuning.so': blob_fixup()
        .remove_needed('libmm-qcamera.so'),
    'vendor/lib64/hw/gf_fingerprint.goodix.default.so': blob_fixup()
        .replace_needed('libvendor.goodix.hardware.fingerprint@1.0.so', 'vendor.goodix.hardware.fingerprint@1.0.so'),
    'vendor/lib64/libgf_hal.so': blob_fixup()
        .sig_replace('10 03 00 D0 11 52 46 F9', '10 03 00 D0 1F 20 03 D5'),
    'vendor/lib64/libvendor.goodix.hardware.fingerprint@1.0-service.so': blob_fixup()
        .remove_needed('libprotobuf-cpp-lite.so')
        .replace_needed('libvendor.goodix.hardware.fingerprint@1.0.so', 'vendor.goodix.hardware.fingerprint@1.0.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'daisy',
    'xiaomi',
    blob_fixups=blob_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'msm8953-common', module.vendor
    )
    utils.run()
