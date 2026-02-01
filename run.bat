@echo off

REM Script: getfilename.bat
REM Usage: getfilename.bat "C:\path\to\your\file.txt"

set "filepath=%~1"
set "filename=%~n1"

echo Full path: %filepath%
echo File name: %filename%

SET COMPILER=..\..\raylua_s.exe
SET LOCAL_COMP=..\..\raylua_s.exe

set RAYLIB_BARF=false

REM Try to locate ray compiler in PATH
where ray.exe >nul 2>&1

if %errorlevel%==0 (
    echo Found ray compiler in PATH.
    REM ray.exe main.lua %*
    ray.exe main.lua tests.%filename% %RAYLIB_BARF%
) else (
    echo Ray compiler not found. Using local compiler.
    REM ..\..\raylua_s.exe main.lua %*
    ..\..\raylua_s.exe main.lua tests.%filename% %RAYLIB_BARF%
)


@echo on
