vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO KDE/kquickcharts
  REF v6.7.0
  SHA512 9e8537e12d2f4f1f43a36aa0cc5406de25be190a12cbeb81b4811656b3a3b4489229b68a5cb85962bd540cc3295dcc220b27fe472bd551fad7133f7cce6939f0
  HEAD_REF master
)

# Prevent KDEClangFormat from writing to source effectively blocking parallel configure
file(WRITE ${SOURCE_PATH}/.clang-format "DisableFormat: true\nSortIncludes: false\n")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DBUILD_TESTING=OFF)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME KF6QuickCharts CONFIG_PATH lib/cmake/KF6QuickCharts DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_copy_pdbs()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(GLOB LICENSE_FILES "${SOURCE_PATH}/LICENSES/*")
vcpkg_install_copyright(FILE_LIST ${LICENSE_FILES})
