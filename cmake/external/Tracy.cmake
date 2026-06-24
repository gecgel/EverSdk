cmake_policy(SET CMP0077 NEW)

set(TRACY_ENABLE ${EM_ENABLE_PROFILING})
set(TRACY_LTO ON)

add_subdirectory(
    "${CMAKE_SOURCE_DIR}/downloads/tracy"
    "${CMAKE_BINARY_DIR}/downloads/tracy"
)

# NOTE: With TRACY_LTO, TracyClient is always an OBJECT target. We link the
# object files to a wrapper target and install that instead.

add_library(tracy)
set_target_properties(tracy PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/downloads/tracy"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/downloads/tracy"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/downloads/tracy"
)

target_link_libraries(tracy PUBLIC Tracy::TracyClient)

install(
    TARGETS tracy
    EXPORT EverSdk
)
