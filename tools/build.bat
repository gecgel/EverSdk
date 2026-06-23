@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0.."

if not exist "build" mkdir "build" || (
    echo ERROR: Could not create the build directory!
    exit /b 1
)

:: Counters
set failureCount=0
set successCount=0

:: Iterate over preset names directly taken from CMake
for /f "skip=1 tokens=* delims=" %%L in ('cmake --list-presets') do (
    set "line=%%L"
    set "line=!line:"=!"
    for /f "tokens=1" %%P in ("!line!") do call :BuildPreset %%P
)

:: Report the outcome
if %failureCount% gtr 0 (
    echo ERROR: %failureCount% presets failed!
    endlocal
    exit /b 1
)

echo INFO: All %successCount% presets build successfully.
endlocal
exit /b 0

:: Takes the preset name.
:BuildPreset
set "preset=%~1"

:: Constants
set "logFile=build\%preset%.txt"

call :BuildPresetImplementation "%preset%" >"%logFile%" 2>&1 || (
    set /a failureCount+=1
    echo ERROR: Could not build preset %preset%! Check the logs at %logFile%.
    exit /b 1
)

set /a successCount+=1
echo INFO: Built preset %preset%.
exit /b 0

:: Takes the preset name.
:BuildPresetImplementation
set "preset=%~1"

cmake --preset "%preset%" || exit /b 1
cmake --build --preset "%preset%" || exit /b 1
cmake --install "build\%preset%" || exit /b 1
exit /b 0
