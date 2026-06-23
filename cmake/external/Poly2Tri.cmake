add_subdirectory(
    "${CMAKE_SOURCE_DIR}/downloads/poly2tri"
    "${CMAKE_BINARY_DIR}/downloads/poly2tri"
)

set_target_properties(
    poly2tri PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES
        "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/downloads/poly2tri>;$<INSTALL_INTERFACE:include/poly2tri>"
)

install(
    TARGETS poly2tri
    EXPORT EverSdk
)

install(
    DIRECTORY "${CMAKE_SOURCE_DIR}/downloads/poly2tri/"
    DESTINATION "include/poly2tri"
    FILES_MATCHING PATTERN "*.h"
)
