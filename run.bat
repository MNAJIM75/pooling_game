@echo off

SET lua=..\raylua_s.exe

REM Check if an argument was passed
IF "%~1"=="" (
    REM No arguments → run main.lua
   %lua% main.lua
) ELSE (
    REM If the first argument is "test"
    IF /I "%~1"=="test" (
       %lua% vector_test.lua
    ) ELSE (
        IF /I "%~1"=="file" (
           %lua% test_p.lua
        ) ELSE (
            IF /I "%~1"=="rc" (
               %lua% test_r_c.lua
            ) ELSE (
                echo Unknown argument: %~1
                echo Usage: run.bat [test]
            )
        )
    )
)

@echo on
