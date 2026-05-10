@echo off
setlocal

::  Change this UE ROOT folder according to your environment
SET UE_FOLDER=C:/UnrealEngine
SET PROJECT=%~dp0

echo "++++++++========= Ver: 2026-05-03 ===++++++++++++++"
echo  Current Dir:  %PROJECT%
echo  UE_FOLDER Dir:  %UE_FOLDER%
echo "++++++++=============================++++++++++++++"
echo:


::  if exist "Source/*Editor.Target.cs" goto :init


:: echo %PROJECT%

 :: echo "++++++++=====================  For loop find *.pdb ========++++++++++++++"

 :: FOR    %%F in (Binaries\Win64\UnrealEditor-*.patch_*.pdb) do echo "%%~F"

 :: echo "++++++++=====================  For loop find *.pdb done ========++++++++++++++"


FOR /f %%F in ('dir /b *.uproject') do SET PRJNAMEPATH=%%~dpnxF
FOR /f %%F in ('dir /b *.uproject') do SET PRJNAME=%%~nF
IF EXIST Source\*Editor.Target.cs  FOR /f %%F in ('dir /b Source\*Editor.Target.cs') do for %%G in ("%%~nF") do SET TARGETNAME=%%~nG


echo Project Pathname: %PRJNAMEPATH%
echo Project Name: %PRJNAME%
IF DEFINED TARGETNAME echo Editor Target: %TARGETNAME%
echo:

echo "++++==== UE build UnrealEditor Dlls for:  %PRJNAME%.uproject, Target=%TARGETNAME%   ====++++"
echo:
echo:  :: UShell tools
SET USHELLSTR=%UE_FOLDER%/Engine/Extras/ushell/ushell.bat --project="%PRJNAMEPATH%"
echo %USHELLSTR%
echo:


IF /I "%1" == "cpp" goto :CREATE_EMPTY_MODULAR
IF /I "%1" == "gen" goto :GEN_MSVC_SLN
IF /I "%1" == "clr" goto :CLEAN_UE_PRJ

echo :: Win64 dev
echo %UE_FOLDER%/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -verbose -nop4 -utf8output -nocompileeditor -skipbuildeditor -project="%PRJNAMEPATH%" -unrealexe="%UE_FOLDER%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Win64 -SkipCookingErrorSummary  -SkipcookingEditorContent -build -cook -stage -package -pak -iostore -compressed -prereqs -clientconfig=Development -nocompile -nocompileuat -createreleaseversion="win64_1.0" -archive -archivedirectory="%PROJECT%tootbd/BaseRelease"
echo:
echo ::  Win64 shipping
echo %UE_FOLDER%/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -verbose -nop4 -utf8output -nocompileeditor -skipbuildeditor -project="%PRJNAMEPATH%" -unrealexe="%UE_FOLDER%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Win64 -SkipCookingErrorSummary  -SkipcookingEditorContent -build -cook -stage -package -pak -iostore -compressed -prereqs -distribution  -clientconfig=Shipping -nodebuginfo -nocompile -nocompileuat -createreleaseversion="win64_1.0" -archive -archivedirectory="%PROJECT%tootbd/BaseReleaseShipping"

echo:

SET AND_FLAVOR=ASTC
echo :: Android dev , flavor=%AND_FLAVOR%
echo %UE_FOLDER%/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -verbose -nop4 -utf8output -nocompileeditor -skipbuildeditor -project="%PRJNAMEPATH%" -unrealexe="%UE_FOLDER%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Android -cookflavor=%AND_FLAVOR% -SkipCookingErrorSummary  -SkipcookingEditorContent -build -cook -stage -package -pak -iostore -compressed -prereqs -clientconfig=Development -nocompile -nocompileuat -createreleaseversion="and_1.0" -archive -archivedirectory="%PROJECT%tootbd/BaseRelease"
echo:
echo ::  Android shipping , flavor=%AND_FLAVOR%
echo %UE_FOLDER%/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -verbose -nop4 -utf8output -nocompileeditor -skipbuildeditor -project="%PRJNAMEPATH%" -unrealexe="%UE_FOLDER%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Android -cookflavor=%AND_FLAVOR% -SkipCookingErrorSummary  -SkipcookingEditorContent -build -cook -stage -package -pak -iostore -compressed -prereqs -distribution -clientconfig=Shipping -nodebuginfo -nocompile -nocompileuat -createreleaseversion="and_1.0" -archive -archivedirectory="%PROJECT%tootbd/BaseReleaseShipping"

echo:


echo :: Win64 modular DLC pak   [dev ,  replace arg: -dlcname=yourPluginModularName]
echo %UE_FOLDER%/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -verbose -nop4 -utf8output -nocompileeditor -skipbuildeditor -project="%PRJNAMEPATH%" -unrealexe="%UE_FOLDER%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Win64 -SkipCookingErrorSummary  -SkipcookingEditorContent  -cook -stage -pak -iostore -compressed -prereqs -clientconfig=Development -nocompile -nocompileuat -basedonreleaseversion="win64_1.0" -dlcname=Roma

echo:

echo :: Android modular DLC pak   [dev , flavor=%AND_FLAVOR% , replace arg: -dlcname=yourPluginModularName]
echo %UE_FOLDER%/Engine/Build/BatchFiles/RunUAT.bat BuildCookRun -verbose -nop4 -utf8output -nocompileeditor -skipbuildeditor -project="%PRJNAMEPATH%" -unrealexe="%UE_FOLDER%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe" -platform=Android -cookflavor=%AND_FLAVOR% -SkipCookingErrorSummary  -SkipcookingEditorContent  -cook -stage -pak -iostore -compressed -prereqs -clientconfig=Development -nocompile -nocompileuat -basedonreleaseversion="and_1.0" -dlcname=Roma

echo:

echo :: Run Android  , flavor=%AND_FLAVOR%
echo   cmd.exe /c "chdir /d %~dp0tootbd\BaseRelease\Android_%AND_FLAVOR% && Install_%PRJNAME%-arm64.bat"

echo:

echo :: Run Win64
echo "          tootbd/BaseRelease/Windows/%PRJNAME%.exe  -log -WINDOWED -ResX=1280 -ResY=720           "


echo:


IF NOT DEFINED TARGETNAME goto :NO_TARGET

    SET ZOESTR=%UE_FOLDER%/Engine/Build/BatchFiles/Build.bat -Target="%TARGETNAME% Win64 Development -Project=%PRJNAMEPATH%" -Target="ShaderCompileWorker Win64 Development -Project=%PRJNAMEPATH% -Quiet" -WaitMutex -FromMsBuild -architecture=x64
:: call %UE_FOLDER%/Engine/Build/BatchFiles/Build.bat -Target="%TARGETNAME% Win64 Development -Project=%PRJNAMEPATH%" -Target="ShaderCompileWorker Win64 Development -Project=%PRJNAMEPATH% -Quiet" -WaitMutex -FromMsBuild -architecture=x64

ECHO:
ECHO "  >>>>> Building for UnrealEditor "
ECHO:
ECHO %ZOESTR%
ECHO:
ECHO:
goto :DONE

:NO_TARGET
echo !!!! "No Game main Modular found....Please generate c++ modular first...."

FOR /f %%F in ('dir /b %0') do  SET SCRIPTNAME=./%%~F

echo Run ::    %SCRIPTNAME% cpp
ECHO:

:DONE


:: cmd.exe /c "D:\UnrealEngine\Engine\Build\BatchFiles\Build.bat -Target="FirstRun560cppEditor Win64 Development -Project=D:\workprj\uePrj\FirstRun560cpp\FirstRun560cpp.uproject" -Target="ShaderCompileWorker Win64 Development -Project=D:\workprj\uePrj\FirstRun560cpp\FirstRun560cpp.uproject -Quiet" -WaitMutex -FromMsBuild -architecture=x64"


EXIT /b 0



::
::  Create Empty c++ source codes
::

:CREATE_EMPTY_MODULAR

echo Create Empty Game C++ modular ...... Start......

mkdir Source\%PRJNAME%

SET TMP_FILE=Source\%PRJNAME%.Target.cs
echo // Generated by tootzoe utility script, create a base c++ game modular based on UE-5.9.0 >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo using UnrealBuildTool; >> %TMP_FILE%
echo using System.Collections.Generic; >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo public class %PRJNAME%Target : TargetRules >> %TMP_FILE%
echo { >> %TMP_FILE%
echo         public %PRJNAME%Target(TargetInfo Target) : base(Target) >> %TMP_FILE%
echo         { >> %TMP_FILE%
echo                 Type = TargetType.Game; >> %TMP_FILE%
echo                 DefaultBuildSettings = BuildSettingsVersion.V7; >> %TMP_FILE%
echo                 IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_9; >> %TMP_FILE%
echo                 ExtraModuleNames.Add("%PRJNAME%"); >> %TMP_FILE%
echo         } >> %TMP_FILE%
echo } >> %TMP_FILE%



SET TMP_FILE=Source\%PRJNAME%Editor.Target.cs
echo // Generated by tootzoe utility script, create a base c++ game modular based on UE-5.9.0 >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo using UnrealBuildTool; >> %TMP_FILE%
echo using System.Collections.Generic; >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo public class %PRJNAME%EditorTarget : TargetRules >> %TMP_FILE%
echo { >> %TMP_FILE%
echo         public %PRJNAME%EditorTarget( TargetInfo Target) : base(Target) >> %TMP_FILE%
echo         { >> %TMP_FILE%
echo                 Type = TargetType.Editor; >> %TMP_FILE%
echo                 DefaultBuildSettings = BuildSettingsVersion.V7; >> %TMP_FILE%
echo                 IncludeOrderVersion = EngineIncludeOrderVersion.Unreal5_9; >> %TMP_FILE%
echo                 ExtraModuleNames.Add("%PRJNAME%"); >> %TMP_FILE%
echo         } >> %TMP_FILE%
echo } >> %TMP_FILE%


SET TMP_FILE=Source\%PRJNAME%\%PRJNAME%.Build.cs

echo // Generated by tootzoe utility script, create a base c++ game modular based on UE-5.9.0 >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo using UnrealBuildTool;  >> %TMP_FILE%
echo:  >> %TMP_FILE%
echo public class %PRJNAME% : ModuleRules  >> %TMP_FILE%
echo  {  >> %TMP_FILE%
echo          public %PRJNAME%(ReadOnlyTargetRules Target) : base(Target)  >> %TMP_FILE%
echo        {  >> %TMP_FILE%
echo                PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs; >> %TMP_FILE%

echo:   >> %TMP_FILE%
echo                PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "EnhancedInput" }); >> %TMP_FILE%

echo:   >> %TMP_FILE%
echo                PrivateDependencyModuleNames.AddRange(new string[] {  }); >> %TMP_FILE%
echo:   >> %TMP_FILE%

echo                // Uncomment if you are using Slate UI >> %TMP_FILE%
echo                // PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" }); >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo                // Uncomment if you are using online features  >> %TMP_FILE%
echo                // PrivateDependencyModuleNames.Add("OnlineSubsystem"); >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo                // To include OnlineSubsystemSteam, add it to the plugins section in your uproject file with the Enabled attribute set to true >> %TMP_FILE%
echo        } >> %TMP_FILE%
echo  }  >> %TMP_FILE%


SET TMP_FILE=Source\%PRJNAME%\%PRJNAME%.cpp
echo // Generated by tootzoe utility script, create a base c++ game modular based on UE-5.9.0 >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo #include "%PRJNAME%.h" >> %TMP_FILE%
echo #include "Modules/ModuleManager.h" >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo IMPLEMENT_PRIMARY_GAME_MODULE( FDefaultGameModuleImpl, %PRJNAME%, "%PRJNAME%" ); >> %TMP_FILE%


SET TMP_FILE=Source\%PRJNAME%\%PRJNAME%.h
echo // Generated by tootzoe utility script, create a base c++ game modular based on UE-5.9.0 >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo #pragma once >> %TMP_FILE%
echo:   >> %TMP_FILE%
echo #include "CoreMinimal.h" >> %TMP_FILE%




 echo Create Empty Game C++ modular ...... Done......



if %ERRORLEVEL% NEQ 0   pause

EXIT /b 0


::
:: >>>>>>>> Generate visual studio solution
::

:GEN_MSVC_SLN
echo >>>>>>>>> Generate MSVC solution ...... Start......

call %UE_FOLDER%/Engine/Build/BatchFiles/Mac/GenerateProjectFiles.bat -project="%PRJNAMEPATH%" -game


if %ERRORLEVEL% NEQ 0   pause
EXIT /b 0

::
:: >>>>>>>> Quick Clean UE Project
::

:CLEAN_UE_PRJ


echo:
echo "++++++++==== clean UE Project =====++++++++++++++"
echo:
echo:

if exist "Releases" rmdir /s /q "Releases"
if %ERRORLEVEL% EQU 0 (echo "del folder:  Releases  success.........")
echo:
  if exist "Saved" rmdir /s /q "Saved"
  if %ERRORLEVEL% EQU 0 (echo "del folder:  Saved  success.........")
echo:
 if exist "DerivedDataCache" rmdir /s /q "DerivedDataCache"
 if %ERRORLEVEL% EQU 0 (echo "del folder:  DerivedDataCache  success.........")
echo:
  if exist "Intermediate" rmdir /s /q "Intermediate"
  if %ERRORLEVEL% EQU 0 (echo "del folder:  Intermediate  success.........")
echo:
 if exist "Binaries" rmdir /s /q "Binaries"
 if %ERRORLEVEL% EQU 0 (echo "del folder:  Binaries  success.........")

echo:

 FOR /d /r ./Plugins %%d IN (Binaries) DO @IF EXIST "%%d" rmdir /s /q "%%d"
 if %ERRORLEVEL% EQU 0   (echo "del all folder: Binaries in Plugins -->  success.........")

echo:

 FOR /d /r ./Plugins %%d IN (Intermediate) DO @IF EXIST "%%d" rmdir /s /q "%%d"
 if %ERRORLEVEL% EQU 0   (echo "del all folder: Intermediate in Plugins -->  success.........")

echo:
echo:
echo "Clear UE Project templorary files done...."
echo:


if %ERRORLEVEL% NEQ 0   pause
EXIT /b 0




::  add this plug for turnning pure bllueprint project to modular project
::
::        "Modules": [
::                {
::                        "Name": "TestUShellIos",
::                        "Type": "Runtime",
::                        "LoadingPhase": "Default"
::                }
::        ],
::       "Plugins": [
::               {
::                       "Name": "ModelingToolsEditorMode",
::                       "Enabled": true,
::                       "TargetAllowList": [
::                               "Editor"
::                       ]
::               },
::               {
::                       "Name": "OnlineSubsystemEOS",
::                       "Enabled": true
::               }
::       ]
::
