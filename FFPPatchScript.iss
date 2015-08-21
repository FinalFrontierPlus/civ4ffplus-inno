;Final Frontier Plus - Patch Script
;Builds a patch installer for the mod.

#define PatchSource "Patch\Final Frontier Plus\"
#define Version "v1.84"

[Setup]
AppId={{FFP-PATCH-184}
AppName=Final Frontier Plus
AppVerName=Final Frontier Plus {#Version} Patch
DefaultDirName={code:RegKey}\Mods\Final Frontier Plus\
OutputBaseFilename=Final_Frontier_Plus_{#Version}_Patch
Compression=lzma
SolidCompression=yes
DisableProgramGroupPage=yes
SetupIconFile=FinalFrontierIcon.ico

[Types]
Name: "full"; Description: "Default installation"

[Components]
Name: "FinalFrontierPlus"; Description: "Final Frontier Plus Patch Files"; Types: full; Flags: fixed

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags:

[Files]
Source: "{#PatchSource}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: FinalFrontierPlus

[Icons]
Name: "{userdesktop}\Final Frontier Plus"; Filename: "{code:RegKey}\Civ4BeyondSword.exe"; Parameters: "mod=\Final Frontier Plus"; Tasks: desktopicon; IconFilename: "{app}\FinalFrontierIcon.ico"

[Run]
Filename: "{code:RegKey}\Civ4BeyondSword.exe"; Parameters: "mod=\Final Frontier Plus"; Description: "{cm:LaunchProgram,Final Frontier Plus}"; Flags: nowait postinstall skipifsilent

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