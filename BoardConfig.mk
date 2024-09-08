#
# Copyright (C) 2019 The TwrpBuilder Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
SOONG_ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_veux
TARGET_RECOVERY_DEVICE_MODULES := libinit_veux

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
PRODUCT_PLATFORM := holi
TARGET_BOOTLOADER_BOARD_NAME := holi
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := xiaomi_sm6375
TARGET_BOARD_PLATFORM_GPU := qcom-adreno619
QCOM_BOARD_PLATFORMS += xiaomi_sm6375

# Kernel
VENDOR_CMDLINE := "androidboot.hardware=qcom \
                   androidboot.memcg=1 \
		   androidboot.selinux=permissive \
                   androidboot.usbcontroller=4e00000.dwc3 \
                   cgroup.memory=nokmem,nosocket \
                   loop.max_part=7 \
                   msm_rtb.filter=0x237 \
                   service_locator.enable=1 \
                   swiotlb=0 \
                   pcie_ports=compat \
                   iptable_raw.raw_before_defrag=1 \
                   ip6table_raw.raw_before_defrag=1 \
                   androidboot.init_fatal_reboot_target=recovery"

BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_BOOT_HEADER_VERSION := 3
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/$(PRODUCT_RELEASE_NAME)/Image

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE) --board ""


# BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/$(PRODUCT_RELEASE_NAME)/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# Kenel dtbo
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/$(PRODUCT_RELEASE_NAME)/dtbo.img

#A/B
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

# Avb
BOARD_AVB_ENABLE := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
# BOARD_DTBOIMG_PARTITION_SIZE := 25165824
# BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm system system_ext vendor product
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # BOARD_SUPER_PARTITION_SIZE - 4MB

# System as root
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# Crypto
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
			     
# TWRP specific build flags
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 200
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := false
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_FRAMERATE := 60
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko"
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone20/temp"
TW_BATTERY_SYSFS_WAIT_SECONDS := 5
TW_BACKUP_EXCLUSIONS := /data/fonts

# Ofox flags
FOX_VIRTUAL_AB_DEVICE := 1
OF_FLASHLIGHT_ENABLE := 0
OF_IGNORE_LOGICAL_MOUNT_ERRORS := 1
OF_USE_GREEN_LED := 0
OF_MAINTAINER := Me

# screen settings
OF_SCREEN_H := 2400
OF_STATUS_H := 100
OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1

# TWRP Debug Flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

################### ############################################
# MANDATORY FLAGS # These flags HAVE TO be set/changed by you! #
################### ############################################

# Device codename
# Default (if not set): N/A
SHRP_DEVICE_CODE := veux

# Path of your SHRP device tree
# Replace <device-brand> with the device brand name
# (SHRP_DEVICE_CODE will expand to the above variable so check if that is correct)
SHRP_PATH := device/xiaomi/$(SHRP_DEVICE_CODE)

# Maintainer name
# Default (if not set): N/A
SHRP_MAINTAINER := ragebreaker

# Recovery Type (for "About" section only)
# Default (if not set): N/A
SHRP_REC_TYPE := Normal

# Device Type (for "About" section only)
# Default (if not set): N/A
SHRP_DEVICE_TYPE := A/B

# Your device's recovery path, dont use blindly
# Default (if not set): N/A
SHRP_REC := /dev/block/bootdevice/by-name/recovery

# Use this flag only if SHRP_REC is set
# Default (if not set): N/A
SHRP_HAS_RECOVERY_PARTITION := true

# Use this flag only if your device is A/B or Virtual A/B.
# Default (if not set): N/A
SHRP_AB := true

################### ################################################################################
# IMPORTANT FLAGS # These are usually good to check - at least if the defaults are what you expect #
################### ################################################################################

# Emergency DownLoad mode (0 = no EDL mode, 1 = EDL mode available)
# Default (if not set): 0
SHRP_EDL_MODE := 1

# Internal storage path
# Default (if not set): /sdcard
SHRP_INTERNAL := /sdcard

# External SDcard path
# Default (if not set): /
SHRP_EXTERNAL := /external_sd

# USB OTG path
# Default (if not set): /
SHRP_OTG := /usb_otg

# Flashlight: (0 = disable, 1 = enable)
# Default (if not set): 0
SHRP_FLASH := 1

################## #########################################################################
# OPTIONAL FLAGS # Stuff which highly depends on your device and / or personal preferences #
################## #########################################################################

# SHRP padding flag (for rounded corner devices only)
# You have to change these values according to your device's roundness.
# Default (for RIGHT): 20
SHRP_STATUSBAR_RIGHT_PADDING := 5
# Default (for LEFT): 20
SHRP_STATUSBAR_LEFT_PADDING := 5

# For notch devices
# Default (if not set): N/A
SHRP_NOTCH := true

# SHRP Express, enables on-the-fly theme patching (also persistent) + persistent lock
# Default (if not set): N/A
# SHRP_EXPRESS := true

# SHRP Express use Data save shrp files inside /data instead of /system
# Note - SHRP_EXPRESS must be true to use this flag otherwise it won't work.
# Default (if not set) will use /system if SHRP_EXPRESS true otherwise will use legacy method of patching
# SHRP_EXPRESS_USE_DATA := true

# SHRP Dark mode, use this flag to have dark theme set by default
# Default (if not set) is not using DARK mode
SHRP_DARK := true

# Custom led paths for flashlight
# Find yours then replace the examples here
SHRP_CUSTOM_FLASHLIGHT := true
SHRP_FONP_1 := /sys/class/leds/mmc1::/brightness
SHRP_FONP_2 := /sys/class/leds/mmc0::/brightness
# SHRP_FONP_3 := /sys/class/leds/led:switch/brightness

# Max brightness of flashlight
# You can also check the above led paths in Android when you turn on flashlight
SHRP_FLASH_MAX_BRIGHTNESS := 255

# Force mount system in /system despite SAR policy
# Useful for maintaining backwards compatibility and/or Samsung devices
# Default (if not set) is to follow the SAR policy
# SHRP_NO_SAR_AUTOMOUNT := true

# Do not include the SHRP theming system
# Useful to save space for devices with a smaller recovery partition
# Default (if not set) is full theming support
# SHRP_LITE := true
