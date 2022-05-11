vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PixarAnimationStudios/OpenTimelineIO
    REF v0.14
    SHA512 ddc6a2ffb84d773c4cc44aaba90dfd6e351a2aecaa5411de6fa1ca92bb8b9c1d87fdf03ea31777bb7f65c7a51f88f166bbe1470ac54c81c8852622ad74c0125e
    HEAD_REF master
    PATCHES
        set-runtime-dst.patch
)

vcpkg_download_distfile(ANY
    URLS
        "https://github.com/thelink2012/any/archive/f67bd5f8bbf7eb628bf38206d4ac5cb22438e6bb.zip"
    FILENAME "any-f67bd5f8bbf7eb628bf38206d4ac5cb22438e6bb.zip"
    SHA512 36e1570aebda67f338ce761c7e88db29ee424fe6e088378a7a4106047198cef750f7ed385b24cc95c966a07b0f1b6aa52e07038559d30faee4ab6a4cbd6212ac
)
vcpkg_extract_source_archive(${ANY} ${SOURCE_PATH}/src/deps)
file(REMOVE_RECURSE ${SOURCE_PATH}/src/deps/any)
file(RENAME ${SOURCE_PATH}/src/deps/any-f67bd5f8bbf7eb628bf38206d4ac5cb22438e6bb ${SOURCE_PATH}/src/deps/any)

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
