[Setup]
	AppName=prometheus soundpack
	AppVersion=development
	AppPublisher=prometheus soundpack development team
	AppPublisherURL=https://github.com/stickbear2015/prometheus
	AppSupportURL=https://github.com/stickbear2015/prometheus/issues
	AppUpdatesURL=https://github.com/stickbear2015/prometheus/releases
  UsePreviousAppDir=yes
	DefaultDirName={sd}\prometheus
	OutputDir=.
	OutputBaseFilename=prometheus_soundpack_dev
	Compression=lzma2/ultra64
	SolidCompression=yes
	WizardStyle=modern

[Languages]
	Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
	Source: "prometheus\*"; DestDir: "{app}\mushclient"; Flags: ignoreversion recursesubdirs createallsubdirs
  Source: "changelog.html"; DestDir: "{app}"; Flags: ignoreversion
  [Tasks]
	Name: "desktopicon"; Description: "Desktop Shortcut"
	[Run]
	Filename: "{app}\mushclient\mushclient.exe"; Description: "Launch the prometheus soundpack"; Flags: nowait postinstall skipifsilent unchecked
	Filename: "{app}\readme.html"; Description: "View readme"; Flags: shellexec postinstall skipifsilent unchecked
Filename: "{app}\changelog.html"; Description: "View changelog"; Flags: shellexec postinstall skipifsilent unchecked
