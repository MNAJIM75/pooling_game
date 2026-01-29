@echo off

SET lua=..\raylua_s.exe
@echo off
REM Check if 'ray' compiler exists
where ray >nul 2>nul
if %errorlevel%==0 (
    echo Found ray compiler. Using ray...
    SET lua=ray
) else (
    echo Ray compiler not found. Checking for lua...
    where lua >nul 2>nul
    if %errorlevel%==0 (
        echo Found lua compiler. Using lua...
        SET lua=..\raylib_s.exe
    ) else (
        echo Neither ray nor lua compiler found.
        exit /b 1
    )
)
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
                IF /I "%~1"=="mouse" (
                    Echo Mouse Testing
                   %lua% main.lua tests\mouse_game.lua
                ) ELSE (
                    echo Unknown argument: %~1
                    echo Usage: run.bat [test]
                )
            )
        )
    )
)

@echo on
