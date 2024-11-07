vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO KDE/kquickcharts
  REF v6.7.0
  SHA512 d62091185c26c4eec83f7b2e06468c3c3691ae0e71f4d60aafaf32be262677affc686a4e54159f487005854bdf46c4c3a2214775daf850039b733ad02edc3936
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