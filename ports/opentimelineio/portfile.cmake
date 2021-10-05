vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PixarAnimationStudios/OpenTimelineIO
    REF b104129ee01fc25745ab0d7f003c03e6accd6330 # v2.0.1
    SHA512 51568e21eaf863747f67fbcffa7f42ba32f5892e8295dac6c9deb0f6205f57c231ea34ce028d84915e4be2f2773e362b74eaf057c2e4cf3ad4b60bf13a0b73db
    HEAD_REF master
    PATCHES
        # Add patches here
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DOTIO_PYTHON_INSTALL:BOOL=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

vcpkg_fixup_cmake_targets()

vcpkg_copy_pdbs()

# Clean redundant files
#file(REMOVE_RECURSE
#    ${CURRENT_PACKAGES_DIR}/debug/include
#    ${CURRENT_PACKAGES_DIR}/debug/share
#    ${CURRENT_PACKAGES_DIR}/debug/OpenColorIOConfig.cmake
#    ${CURRENT_PACKAGES_DIR}/OpenColorIOConfig.cmake
#)

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
