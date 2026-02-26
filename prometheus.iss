; Inno Setup Script for the prometheus soundpack
; Creates a Windows installer with Start Menu and Desktop shortcuts
;
; Requirements:
;   - Inno Setup 6.0 or later (https://jrsoftware.org/isinfo.php)
;   - PyInstaller build output in dist/PortkeyDrop_dir/
;
; Build:
;   iscc installer/portkeydrop.iss

#define MyAppName "Prometheus"
; Version is read from dist/version.txt (written by CI from pyproject.toml)
; Falls back to hardcoded default for local builds
#define MyAppVersion "26.2dev"
#ifexist "version.txt"
  #define MyAppVersion ReadIni("version.txt", "version", "value", "26.2dev")
#endif
#define MyAppPublisher "the prometheus development team"
#define MyAppURL "https://github.com/stickbear2015/prometheus"
#define MyAppExeName "mushclient.exe"
#define MyAppDescription "the prometheus sound pack"

[Setup]
; Application identity
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/issues
AppUpdatesURL={#MyAppURL}/releases
AppComments={#MyAppDescription}

; Installation settings
DefaultDirName={sd}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
DisableProgramGroupPage=yes

; Output settings
OutputDir=.
OutputBaseFilename=Prometheus_soundpack_v{#MyAppVersion}
UninstallDisplayIcon={app}\{#MyAppExeName}

; Compression
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes
LZMANumBlockThreads=4

; Privileges (no admin required for per-user install)
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

; Modern installer appearance
WizardStyle=modern
WizardSizePercent=100

; Windows version requirements
MinVersion=10.0

; Uninstaller settings
UninstallDisplayName={#MyAppName}
CreateUninstallRegKey=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked


[Files]
	Source: "prometheus\*"; DestDir: "{app}\mushclient"; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "changelog.html"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Start Menu shortcuts
Name: "{group}\{#MyAppName}"; Filename: "{app}\mushclient\{#MyAppExeName}"; Comment: "{#MyAppDescription}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

; Desktop shortcut (optional)
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\mushclient\{#MyAppExeName}"; Tasks: desktopicon; Comment: "{#MyAppDescription}"


[Run]
; Option to launch after installation
Filename: "{app}\mushclient\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
Filename: "{app}\changelog.html"; Description: "read the changelog"; Flags: nowait postinstall skipifsilent
Filename: "{app}\readme.html"; Description: "read the documentation"; Flags: nowait postinstall skipifsilent
[Registry]
; Register application path
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\App Paths\{#MyAppExeName}"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName}"; Flags: uninsdeletekey

[Code]
function InitializeSetup(): Boolean;
begin
  Result := True;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Post-installation tasks
  end;
end;

[UninstallDelete]
; Clean up any cached files
Type: files; Name: "{app}\mushclient\worlds\plugins\state\*.xml"
Type: dirifempty; Name: "{app}\mushclient\worlds\plugins\state"
Type: dirifempty; Name: "{app}\mushclient\worlds\plugins"
Type: dirifempty; Name: "{app}\mushclient\worlds"
Type: dirifempty; Name: "{app}\mushclient"
Type: dirifempty; Name: "{app}"