set(SDL_EXAMPLES OFF)
set(SDL_INSTALL ON)
set(SDL_TEST_LIBRARY OFF)

add_subdirectory(
    "${CMAKE_SOURCE_DIR}/downloads/SDL"
    "${CMAKE_BINARY_DIR}/downloads/SDL"
)
