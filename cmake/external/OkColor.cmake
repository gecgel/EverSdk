set(OK_COLOR_SOURCE_DIR "${CMAKE_SOURCE_DIR}/downloads/ok_color")
set(OK_COLOR_BINARY_DIR "${CMAKE_BINARY_DIR}/downloads/ok_color")

add_library(ok_color INTERFACE)
set_target_properties(ok_color PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${OK_COLOR_BINARY_DIR}"
    LIBRARY_OUTPUT_DIRECTORY "${OK_COLOR_BINARY_DIR}"
    RUNTIME_OUTPUT_DIRECTORY "${OK_COLOR_BINARY_DIR}"
)

target_sources(ok_color INTERFACE
    FILE_SET HEADERS
    BASE_DIRS "${OK_COLOR_SOURCE_DIR}/misc"
    FILES "${OK_COLOR_SOURCE_DIR}/misc/ok_color.h"
)

install(
    TARGETS ok_color
    EXPORT EverSdk
    FILE_SET HEADERS
    DESTINATION "include"
)
