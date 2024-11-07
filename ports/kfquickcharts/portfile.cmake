vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO KDE/kquickcharts
  REF "v6.8.0-rc1"
  SHA512 fc18beefbb12526210bfd2b2f17522637897f1a920e2036d516a143fbcf0cf27fd8a7f47cfb2904177dcd98f1e7a330770cf101a8fda11728272127a5b5295d7
  HEAD_REF master
)

# Prevent KDEClangFormat from writing to source effectively blocking parallel configure
file(WRITE ${SOURCE_PATH}/.clang-format "DisableFormat: true\nSortIncludes: false\n")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DBUILD_TESTING=OFF)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME KF6QuickCharts CONFIG_PATH lib/cmake/KF6QuickCharts)
vcpkg_copy_pdbs()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(GLOB LICENSE_FILES "${SOURCE_PATH}/LICENSES/*")
vcpkg_install_copyright(FILE_LIST ${LICENSE_FILES})

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")