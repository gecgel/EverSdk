set(SDLTTF_INSTALL ON)
set(SDLTTF_VENDORED ON)

add_subdirectory(
    "${CMAKE_SOURCE_DIR}/downloads/SDL_ttf"
    "${CMAKE_BINARY_DIR}/downloads/SDL_ttf"
)
