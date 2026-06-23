cmake_minimum_required(VERSION 4.0)
project(EverSdk)

include("${CMAKE_SOURCE_DIR}/cmake/external/Clipper2.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/EarCutHpp.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/Greatest.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/Lua.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/OkColor.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/Poly2Tri.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/Sdl.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/SdlImage.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/SdlShaderCross.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/SdlTtf.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/Tracy.cmake")
include("${CMAKE_SOURCE_DIR}/cmake/external/Yyjson.cmake")

include(CMakePackageConfigHelpers)

install(
    EXPORT EverSdk
    FILE "EverSdk.cmake"
    NAMESPACE EverSdk::
    DESTINATION "lib/cmake/EverSdk"
)

configure_package_config_file(
    "${CMAKE_SOURCE_DIR}/cmake/EverSdkConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/EverSdkConfig.cmake"
    INSTALL_DESTINATION "lib/cmake/EverSdk"
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/EverSdkConfigVersion.cmake"
    VERSION 1.0.0
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/EverSdkConfig.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/EverSdkConfigVersion.cmake"
    DESTINATION "lib/cmake/EverSdk"
)
