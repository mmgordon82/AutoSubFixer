@echo off
setlocal

set VERSION=0.0.1a
set OUTPUT=dist

:: Build Parameters
set NoGUIWindow=-H=windowsgui
set LDFLAGS_PARAMETERS=%NoGUIWindow%

echo.
echo +--------------------------------+
echo ^|                                ^|
echo ^| AutoSubFixer Build Script V0.1 ^|
echo ^|                                ^|
echo +--------------------------------+
echo [+] Building version %VERSION% to /%OUTPUT%...
echo.

:: If there are parameters, add them to go build command
if ["%LDFLAGS_PARAMETERS%"]==[""] (
    set LDFLAGS_BUILD=
) else (
    set LDFLAGS_BUILD=-ldflags %LDFLAGS_PARAMETERS%
)

:: Remove Previous Build
del %OUTPUT% /q >nul


:: Create Syso files
echo [+] Building syso files...
"%GOPATH%\bin\go-winres.exe" make --in installer\winres\winres.json --product-version=%VERSION% --file-version=%VERSION%


:: Create the main executable file
go build -o %OUTPUT%/AutoSubFixer.exe %LDFLAGS_BUILD%

:: Create Setup
echo [+] Creating setup...
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "/DMyAppVersion=%VERSION%" "/DMyDistFolder=%OUTPUT%" installer\install.iss 1>nul

:: Rename to Portable
move %OUTPUT%\AutoSubFixer.exe %OUTPUT%\AutoSubFixer-Portable.exe >nul


:: Build for Other OSes
set GOOS=darwin
call :Build_OS_ARCH amd64 macOS
call :Build_OS_ARCH arm64 macOS

set GOOS=linux
call :Build_OS_ARCH amd64 linux
call :Build_OS_ARCH 386 linux


:: Delete residues
echo [+] Cleaning up...
del *.syso


echo Done! Press any key to exit...
endlocal
pause >nul
goto :eof

:: Usage:
::      set GOOS=<OS-TYPE>
::      call Build_OS_ARCH <GOARCH> <OS-NAME>
:Build_OS_ARCH
    set GOARCH=%1
    echo [+] Building for %2-%GOARCH%...
    go build -o %OUTPUT%/autosubfixer
    powershell -Command "Compress-Archive %OUTPUT%/autosubfixer dist\AutoSubFixer-%2-%GOARCH%.zip"
    del %OUTPUT%\autosubfixer