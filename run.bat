@echo off

SET COMPILER=..\..\raylua_s.exe
SET LOCAL_COMP=..\..\raylua_s.exe

REM Try to locate ray compiler in PATH
where ray.exe >nul 2>&1

if %errorlevel%==0 (
    echo Found ray compiler in PATH.
    ray.exe main.lua %*
) else (
    echo Ray compiler not found. Using local compiler.
    ..\..\raylua_s.exe main.lua %*
)


@echo on
