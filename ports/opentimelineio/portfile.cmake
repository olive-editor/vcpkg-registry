vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PixarAnimationStudios/OpenTimelineIO
    REF v0.13
    SHA512 2e11fa46e0fbb17568c578fc9619a2e9e2fdb9beb6838878f803ceb68754023d68a9c591f5c9308b5f557460beeae51c4374b970e9e63b74fb87be47221bd6b3
    HEAD_REF master
    PATCHES
        remove-pybind.patch
        set-archive-dst.patch
)

vcpkg_download_distfile(ANY
    URLS
        "https://github.com/thelink2012/any/archive/refs/heads/master.zip"
    FILENAME "any-master.zip"
    SHA512 54466355837c1a723fbc425c441779fd5e2aeb885826181c8c2d6ab99e03bd8e009454fe941101194825051228dd9be2e03f34457106c49b4baff3601c314b8c
)
vcpkg_extract_source_archive(${ANY} ${SOURCE_PATH}/src/deps)
file(REMOVE_RECURSE ${SOURCE_PATH}/src/deps/any)
file(RENAME ${SOURCE_PATH}/src/deps/any-master ${SOURCE_PATH}/src/deps/any)

vcpkg_download_distfile(OPTIONAL_LITE
    URLS
        "https://github.com/martinmoene/optional-lite/archive/52f2b6185bbc81e2282ce7fbcf4e57df3cef97a7.zip"
    FILENAME "optional-lite-52f2b6185bbc81e2282ce7fbcf4e57df3cef97a7.zip"
    SHA512 cc691e9360297f866284b7a3d08a47a864f6eb683e17b0dc36756352777c18c43d2a23ef511053d3f8a0a00c310410689d153215ea543f082fc33286b667dd08
)
vcpkg_extract_source_archive(${OPTIONAL_LITE} ${SOURCE_PATH}/src/deps)
file(REMOVE_RECURSE ${SOURCE_PATH}/src/deps/optional-lite)
file(RENAME ${SOURCE_PATH}/src/deps/optional-lite-52f2b6185bbc81e2282ce7fbcf4e57df3cef97a7 ${SOURCE_PATH}/src/deps/optional-lite)

vcpkg_download_distfile(RAPIDJSON
    URLS
        "https://github.com/Tencent/rapidjson/archive/00dbcf2c6e03c47d6c399338b6de060c71356464.zip"
    FILENAME "rapidjson-00dbcf2c6e03c47d6c399338b6de060c71356464.zip"
    SHA512 0fd3f52f5083a4080594c7e122ff5882b690c3f601bed05101578079e0120e9fb16c0d1acb5b085d26c3d83e34f92628d99cab32e947a21db8da180969703489
)
vcpkg_extract_source_archive(${RAPIDJSON} ${SOURCE_PATH}/src/deps)
file(REMOVE_RECURSE ${SOURCE_PATH}/src/deps/rapidjson)
file(RENAME ${SOURCE_PATH}/src/deps/rapidjson-00dbcf2c6e03c47d6c399338b6de060c71356464 ${SOURCE_PATH}/src/deps/rapidjson)

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DOTIO_PYTHON_INSTALL:BOOL=OFF
        ${FEATURE_OPTIONS}
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()

vcpkg_copy_pdbs()

# Clean redundant files
file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/share
    ${CURRENT_PACKAGES_DIR}/debug/OpenTimelineIOConfig.cmake
    ${CURRENT_PACKAGES_DIR}/OpenTimelineIOConfig.cmake
)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
