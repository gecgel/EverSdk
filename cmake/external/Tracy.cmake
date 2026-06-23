set(TRACY_ENABLE ${EM_ENABLE_PROFILING})
set(TRACY_LTO ON)

add_subdirectory(
    "${CMAKE_SOURCE_DIR}/downloads/tracy"
    "${CMAKE_BINARY_DIR}/downloads/tracy"
)
