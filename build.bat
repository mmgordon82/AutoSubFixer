@echo off

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
IF ["%LDFLAGS_PARAMETERS%"]==[""] (
    set LDFLAGS_BUILD=
) ELSE (
    set LDFLAGS_BUILD=-ldflags %LDFLAGS_PARAMETERS%
)


:: Create Syso files
echo [+] Building syso files...
go-winres make --in installer\winres\winres.json --product-version=%VERSION% --file-version=%VERSION%

:: Remove Previous Build
del dist /q

:: Create the main executable file
go build -o %OUTPUT%/AutoSubFixer.exe %LDFLAGS_BUILD%

:: Create Setup
echo [+] Creating setup...
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "/DMyAppVersion=%VERSION%" "/DMyDistFolder=%OUTPUT%" installer\install.iss 1>nul

:: Rename to Portable
move %OUTPUT%\AutoSubFixer.exe %OUTPUT%\AutoSubFixer-Portable.exe

:: Delete residues
echo [+] Cleaning up...
del *.syso

echo Done!
