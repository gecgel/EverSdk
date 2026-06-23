set(GREATEST_SOURCE_DIR "${CMAKE_SOURCE_DIR}/downloads/greatest")
set(GREATEST_BINARY_DIR "${CMAKE_BINARY_DIR}/downloads/greatest")

add_library(greatest INTERFACE)
set_target_properties(greatest PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${GREATEST_BINARY_DIR}"
    LIBRARY_OUTPUT_DIRECTORY "${GREATEST_BINARY_DIR}"
    RUNTIME_OUTPUT_DIRECTORY "${GREATEST_BINARY_DIR}"
)

target_sources(greatest INTERFACE
    FILE_SET HEADERS
    BASE_DIRS "${GREATEST_SOURCE_DIR}"
    FILES "${GREATEST_SOURCE_DIR}/greatest.h"
)

target_compile_definitions(greatest INTERFACE "GREATEST_USE_ABBREVS=0")

install(
    TARGETS greatest
    EXPORT EverSdk
    FILE_SET HEADERS
    DESTINATION "include"
)
