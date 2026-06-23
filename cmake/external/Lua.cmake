set(LUA_SOURCE_DIR "${CMAKE_SOURCE_DIR}/downloads/lua")
set(LUA_BINARY_DIR "${CMAKE_BINARY_DIR}/downloads/lua")

# cSpell: disable
file(GLOB LUA_SOURCES "${LUA_SOURCE_DIR}/l*.c")
list(REMOVE_ITEM LUA_SOURCES "${LUA_SOURCE_DIR}/ltests.c")
list(REMOVE_ITEM LUA_SOURCES "${LUA_SOURCE_DIR}/lua.c")

file(GLOB LUA_HEADERS "${LUA_SOURCE_DIR}/l*.h")
# cSpell: enable

add_library(lua ${LUA_SOURCES})
set_target_properties(lua PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${LUA_BINARY_DIR}"
    LIBRARY_OUTPUT_DIRECTORY "${LUA_BINARY_DIR}"
    RUNTIME_OUTPUT_DIRECTORY "${LUA_BINARY_DIR}"
)

target_compile_features(lua PUBLIC c_std_99)

if(UNIX AND NOT APPLE)
    target_compile_definitions(lua PUBLIC LUA_USE_LINUX)
    target_link_libraries(lua PUBLIC m dl)
elseif(APPLE)
    target_compile_definitions(lua PUBLIC LUA_USE_MACOSX)
endif()

target_sources(lua PUBLIC
    FILE_SET HEADERS
    BASE_DIRS "${LUA_SOURCE_DIR}"
    FILES ${LUA_HEADERS}
)

install(
    TARGETS lua
    EXPORT EverSdk
    FILE_SET HEADERS
    DESTINATION "include/lua"
)
