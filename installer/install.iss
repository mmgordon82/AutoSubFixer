
#define MyAppName "AutoSubFixer"

[Setup]
AppId={{5BE36CE8-EA4D-4171-886B-BCB0A3101585}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=mmgordon82
AppPublisherURL=https://github.com/mmgordon82/AutoSubFixer
AppSupportURL=https://github.com/mmgordon82/AutoSubFixer
AppUpdatesURL=https://github.com/mmgordon82/AutoSubFixer
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
; Runs from installer\ folder
LicenseFile=License.txt
InfoAfterFile=AfterInstall.txt
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline
OutputBaseFilename=AutoSubFixer-{#MyAppVersion}-Installer-win
OutputDir=..\{#MyDistFolder}
SetupIconFile=icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern


[Files]
Source: "..\{#MyDistFolder}\AutoSubFixer.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Name: "{group}\{#MyAppName}"; Filename: "{app}\AutoSubFixer.exe"; IconFilename: "{app}\icon.ico"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; IconFilename: "{app}\icon.ico"
; Add to Sendto
Name: "{userappdata}\Microsoft\Windows\SendTo\{#MyAppName}"; Filename: "{app}\AutoSubFixer.exe"; WorkingDir: "."; IconFilename: "{app}\icon.ico"
Name: "{userappdata}\Microsoft\Windows\SendTo\{#MyAppName} (Overwrite)"; Filename: "{app}\AutoSubFixer.exe"; Parameters: "-override"; WorkingDir: "."; IconFilename: "{app}\icon.ico"
