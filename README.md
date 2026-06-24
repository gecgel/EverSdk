# EverSdk

Here is a collection of libraries that I use for my game. Instead of copying them in to that project's directory, I made them compile separately. This way, CMake configuration times are significantly faster. Also, some libraries touch their source files at configuration time, which causes my code to relink to them after they are compiled again.

## Usage

1. Clone.
2. Run `tools/download.bat`.
3. Run `tools/build.bat`.
4. Add directory to environment variables as `EVER_SDK_ROOT`. You can skip this and hardcode the path.
5. In your project, create the same presets as in SDK's `CMakePresets.json`.
6. In your `CMakePresets.json`, configure `CMAKE_PREFIX_PATH` to `$env{EVER_SDK_ROOT}/install/${presetName}`.
7. Add `find_package(EverSdk REQUIRED)` somewhere early in your `CMakeLists.txt`.
8. Add `include("$env{EVER_SDK_ROOT}/cmake/ConfigurationSettings.cmake")` somewhere early in your `CMakeLists.txt`.
9. Link your targets with the ones provided by the SDK.

## Libraries in the SDK

```CMake
target_link_libraries(${TARGET_NAME} PRIVATE
  Clipper2::Clipper2
  earcut_hpp::earcut_hpp
  EverSdk::greatest
  EverSdk::lua
  EverSdk::ok_color
  EverSdk::poly2tri
  EverSdk::tracy
  SDL3_image::SDL3_image
  SDL3_shadercross::SDL3_shadercross
  SDL3_ttf::SDL3_ttf
  SDL3::SDL3
  yyjson::yyjson
)
```

> NOTE: Libraries that do not support installing with CMake are fixed with a wrapper library. Thus, they use `EverSdk::` namespace instead of their own.

## Example `CMakePresets.json`

```JSON
{
  "$schema": "https://cmake.org/cmake/help/latest/_downloads/3e2d73bff478d88a7de0de736ba5e361/schema.json",
  "version": 10,
  "cmakeMinimumRequired": {
    "major": 4,
    "minor": 0
  },
  "configurePresets": [
    {
      "name": "release",
      "generator": "Ninja",
      "binaryDir": "${sourceDir}/build/${presetName}",
      "cacheVariables": {
        "CMAKE_C_COMPILER": "clang",
        "CMAKE_CXX_COMPILER": "clang++",
        "CMAKE_PREFIX_PATH": "$env{EVER_SDK_ROOT}/install/${presetName}",
        "EM_ENABLE_ASSERTING": false,
        "EM_ENABLE_DEBUGGING": false,
        "EM_ENABLE_OPTIMIZING": true,
        "EM_ENABLE_PROFILING": false
      }
    },
    {
      "name": "instrumented",
      "inherits": ["release"],
      "cacheVariables": {
        "EM_ENABLE_PROFILING": true
      }
    },
    {
      "name": "debug",
      "inherits": ["release"],
      "cacheVariables": {
        "EM_ENABLE_DEBUGGING": true,
        "EM_ENABLE_OPTIMIZING": false
      }
    },
    {
      "name": "checked",
      "inherits": ["debug"],
      "cacheVariables": {
        "EM_ENABLE_ASSERTING": true
      }
    },
    {
      "name": "optimized",
      "inherits": ["release"],
      "cacheVariables": {
        "EM_ENABLE_DEBUGGING": true
      }
    },
    {
      "name": "profile",
      "inherits": ["optimized"],
      "cacheVariables": {
        "EM_ENABLE_PROFILING": true
      }
    },
    {
      "name": "analysis",
      "inherits": ["profile"],
      "cacheVariables": {
        "EM_ENABLE_ASSERTING": true
      }
    }
  ],
  "buildPresets": [
    {
      "name": "release",
      "configurePreset": "release"
    },
    {
      "name": "instrumented",
      "configurePreset": "instrumented"
    },
    {
      "name": "debug",
      "configurePreset": "debug"
    },
    {
      "name": "checked",
      "configurePreset": "checked"
    },
    {
      "name": "optimized",
      "configurePreset": "optimized"
    },
    {
      "name": "profile",
      "configurePreset": "profile"
    },
    {
      "name": "analysis",
      "configurePreset": "analysis"
    }
  ]
}
```

> NOTE: This is exactly what I use in my game.

## Bonus - Launching in VsCode

Having this many presets might make you think you have to create separate launch settings for each. However, the currently selected configure preset gives the build directory to you.

For a target named `application`, you can do the following:

```JSON
    {
      "name": "Launch application",
      "type": "cppvsdbg",
      "request": "launch",
      "program": "${command:cmake.buildDirectory}/application",
      "preLaunchTask": "Build application"
    },
```

> NOTE: Here we are assuming you have a task named `Build application`, which will create the executable that will be launched. Those automatically work for the currently selected preset, thus you do not have to do anything out of ordinary there.
>
> For completeness, here is the build task:
> ```JSON
>  {
>     "label": "Build application",
>     "type": "cmake",
>     "command": "build",
>     "targets": ["application"],
>     "group": {
>       "kind": "build"
>     }
>   },
>   ```
