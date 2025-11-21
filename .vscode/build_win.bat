@echo off
setlocal

rem CONFIG = Debug o Release, default Debug
set CONFIG=%1
if "%CONFIG%"=="" set CONFIG=Debug

rem Inizializza l'ambiente di Visual Studio (adatta il path se serve)
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\vsdevcmd.bat" -arch=x64 -host_arch=x64

set BUILD_DIR=build_win

rem if exist "%BUILD_DIR%" rmdir /S /Q "%BUILD_DIR%"
mkdir "%BUILD_DIR%"
cd "%BUILD_DIR%"

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=%CONFIG% ..
if errorlevel 1 exit /b %errorlevel%

nmake
if errorlevel 1 exit /b %errorlevel%

endlocal
