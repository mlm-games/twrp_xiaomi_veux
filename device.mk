# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Base configuration for the product build
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure the product to support 64-bit only architecture
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Include GSI (Generic System Image) keys for signing the build
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable Virtual A/B OTA updates, which allow seamless system updates
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure storage emulation, typically to replace physical SD cards with emulated storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Include common TWRP configurations
$(call inherit-product, vendor/twrp/config/common.mk)

# A/B OTA post-installation configuration
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Include the script for OTA pre-optimization
PRODUCT_PACKAGES += \
    otapreopt_script

# Boot control packages—required for managing the bootloader in recovery mode
PRODUCT_PACKAGES += \
    bootctrl.veux.recovery \
    android.hardware.boot@1.1-impl-qti.recovery

# Include additional debugging tools for boot control
PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Set the shipping API level to 30 (corresponding to Android 11)
PRODUCT_SHIPPING_API_LEVEL := 30

# Set the target VNDK (Vendor Native Development Kit) version to 31 (corresponding to Android 12)
PRODUCT_TARGET_VNDK_VERSION := 31

# Soong namespaces—this is used to specify the directories where Soong (Android's build system) should look for modules
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Enable dynamic partitions, which allow for flexible partition layouts
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Additional kernel modules required for TWRP, specific to MIUI-based devices
TWRP_REQUIRED_MODULES += \
        miui_prebuilt

# Include decryption support for TWRP to handle encrypted devices
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Fastbootd support, which is a mode of fastboot that runs within the recovery
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Include update engine components, critical for handling OTA updates
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Include additional debugging tools for update engine
PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Additional Soong namespaces for Qualcomm display components
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys-intf/display

# (Vibrator, thats it.) Enable AIDL haptics support for better vibration feedback in TWRP
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# Include vibrator service binaries required for haptics functionality
RECOVERY_BINARY_SOURCE_FILES += \
    $(TARGET_OUT_VENDOR_EXECUTABLES)/hw/vendor.qti.hardware.vibrator.service

# Include various device-specific libraries and modules required for the recovery environment
TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdisplayconfig.qti \
    vendor.qti.hardware.vibrator.service \
    vendor.qti.hardware.vibrator.impl \

# Include shared libraries required for the recovery environment
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
    $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/vendor.qti.hardware.vibrator.impl.so \
    $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libqtivibratoreffect.so