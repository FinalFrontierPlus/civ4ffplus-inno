;Final Frontier Plus - Main Installer Script
;Builds an installer with just changes from Final Frontier

#define SourceDirectory "D:\Programming\Civilization 4 Mods\Final Frontier\Final Frontier Plus\Final Frontier Plus"
#define Version "v1.83"

[Setup]
AppId={{FFP-183}
AppName=Final Frontier Plus
AppVerName=Final Frontier Plus {#Version}
DefaultDirName={code:RegKey}\Mods\Final Frontier Plus\
OutputBaseFilename=Final_Frontier_Plus_{#Version}
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
SetupIconFile="FinalFrontierIcon.ico"

[Types]
Name: "full"; Description: "Default installation"

[Components]
Name: "FinalFrontierPlus"; Description: "Final Frontier Plus Core Files"; Types: full; Flags: fixed
Name: "FinalFrontier"; Description: "Copy Final Frontier Files"; Types: full; Flags: fixed

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop icon (for users without Steam)"; GroupDescription: "{cm:AdditionalIcons}"; Flags: exclusive
Name: "steamicon"; Description: "Create a desktop icon (for users with Steam)"; GroupDescription: "{cm:AdditionalIcons}"; Flags: exclusive unchecked

[Files]
Source: "{code:RegKey}\Mods\Final Frontier\*"; DestDir: "{app}"; Flags: external recursesubdirs createallsubdirs comparetimestamp; Components: FinalFrontier
Source: "{#SourceDirectory}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: FinalFrontierPlus

[Icons]
Name: "{userdesktop}\Final Frontier Plus"; Filename: "{code:RegKey}\Civ4BeyondSword.exe"; Parameters: "mod=\Final Frontier Plus"; Tasks: desktopicon; IconFilename: {app}\FinalFrontierIcon.ico
Name: "{userdesktop}\Final Frontier Plus (Steam)"; Filename: "{reg:HKLM\Software\Valve\Steam,InstallPath}\Steam.exe"; Parameters: "-applaunch 8800 mod=""\Final Frontier Plus"""; Tasks: steamicon; IconFilename: {app}\FinalFrontierIcon.ico

[Run]
Filename: "{code:RegKey}\Civ4BeyondSword.exe"; Parameters: "mod=\Final Frontier Plus"; Description: "{cm:LaunchProgram,Final Frontier Plus (without Steam)}"; Flags: nowait postinstall skipifsilent unchecked
Filename: "{reg:HKLM\Software\Valve\Steam,InstallPath}\Steam.exe"; Parameters: "-applaunch 8800 mod=""\Final Frontier Plus"""; Description: "{cm:LaunchProgram,Final Frontier Plus (with Steam)}"; Flags: nowait postinstall skipifsilent unchecked

[Code]
function RegKeyHelper(CurrentUser: Integer; LocalMachine: Integer; Param: String): String;
var
    Path: String;
begin
    if RegKeyExists(LocalMachine, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 - Beyond the Sword') then
    begin
        RegQueryStringValue(LocalMachine, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 - Beyond the Sword', 'INSTALLDIR', Path);                                                                                                                       
    end;
    if RegKeyExists(LocalMachine, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 Complete\Beyond the Sword') then
    begin
        RegQueryStringValue(LocalMachine, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 Complete\Beyond the Sword', 'INSTALLDIR', Path);
    end;
    if RegKeyExists(CurrentUser, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 - Beyond the Sword') then
    begin
        RegQueryStringValue(CurrentUser, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 - Beyond the Sword', 'INSTALLDIR', Path);                                                                                                                      
      end;
    if RegKeyExists(CurrentUser, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 Complete\Beyond the Sword') then
    begin
        RegQueryStringValue(CurrentUser, 'SOFTWARE\Firaxis Games\Sid Meier''s Civilization 4 Complete\Beyond the Sword', 'INSTALLDIR', Path);
    end;
    Log(Path);  
    Result := Path;
end;

function RegKey(Param: String): String;
var
    Path: String;
begin
    Path := RegKeyHelper(HKCU32, HKLM32, Param)
    if (Length(Path) = 0) and (IsWin64) then
    begin
        Path := RegKeyHelper(HKCU64, HKLM64, Param)
    end;
    Result := Path;
end;