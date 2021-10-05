vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PixarAnimationStudios/OpenTimelineIO
    REF v0.13
    SHA512 2e11fa46e0fbb17568c578fc9619a2e9e2fdb9beb6838878f803ceb68754023d68a9c591f5c9308b5f557460beeae51c4374b970e9e63b74fb87be47221bd6b3
    HEAD_REF master
    PATCHES
        remove-pybind.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH/src/deps/any
    REPO thelink2012/any
    REF f67bd5f8bbf7eb628bf38206d4ac5cb22438e6bb
    SHA512 f6b251a6bb99e3ef4f46ecb49b4c0137f103271d37b78d359c6338a6d4a87d96110d0297a4f76ef0df40cdc56a08c297504f00242006f081eefddb8a2ff25fa4
    HEAD_REF master
    PATCHES
        # Patches here
)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DOTIO_PYTHON_INSTALL:BOOL=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets()

vcpkg_copy_pdbs()

# Clean redundant files
file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/share
    ${CURRENT_PACKAGES_DIR}/debug/OpenTimelineIOConfig.cmake
    ${CURRENT_PACKAGES_DIR}/OpenTimelineIOConfig.cmake
)

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
