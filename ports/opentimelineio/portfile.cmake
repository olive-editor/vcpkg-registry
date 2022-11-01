vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PixarAnimationStudios/OpenTimelineIO
    REF v0.15
    SHA512 c70103dcea5d6efc733a1cd2b7661ea8f709b1ea4b2b8bf404c8d7a22a9cae8f5e99a61adc1ddfa025459b08d7cf227791db5357a832b066c569665359c1f40a
    HEAD_REF main
    PATCHES
        set-runtime-dst.patch
)

vcpkg_download_distfile(RAPIDJSON
    URLS
        "https://github.com/Tencent/rapidjson/archive/06d58b9e848c650114556a23294d0b6440078c61.zip"
    FILENAME "rapidjson-06d58b9e848c650114556a23294d0b6440078c61.zip"
    SHA512 0fd3f52f5083a4080594c7e122ff5882b690c3f601bed05101578079e0120e9fb16c0d1acb5b085d26c3d83e34f92628d99cab32e947a21db8da180969703489
)
vcpkg_extract_source_archive(${RAPIDJSON} ${SOURCE_PATH}/src/deps)
file(REMOVE_RECURSE ${SOURCE_PATH}/src/deps/rapidjson)
file(RENAME ${SOURCE_PATH}/src/deps/rapidjson-06d58b9e848c650114556a23294d0b6440078c61 ${SOURCE_PATH}/src/deps/rapidjson)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DOTIO_PYTHON_INSTALL:BOOL=OFF
        -DCMAKE_CXX_STANDARD=17
        ${FEATURE_OPTIONS}
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()

vcpkg_copy_pdbs()

# Clean redundant files
file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/share
)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
