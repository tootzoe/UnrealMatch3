// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class UnrealMatch3Target : TargetRules
{
	public UnrealMatch3Target(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Game;
                DefaultBuildSettings = BuildSettingsVersion.V9;
                IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		ExtraModuleNames.AddRange( new string[] { "Match3" } );


                //tootzoe commented
                //       if (Target.Platform == UnrealTargetPlatform.IOS && !bIsEngineInstalled)
                //       {
                //           bCompileAPEX = false;
                //           bCompileNvCloth = false;
                //           bCompileICU = true;
                //                       bBuildDeveloperTools = false;
                //           bCompileRecast = true;
                //           bCompileFreeType = true;
                //           bCompileForSize = true;
                //       }


                ExtraModuleNames.AddRange( new string[] {
                "OnlineSubsystem" ,
                "OnlineSubsystemUtils"
                } );

                                if (Target.Platform == UnrealTargetPlatform.Win64)
                                {
                                    ExtraModuleNames.Add("OnlineSubsystemNull");

                                }


                if (Target.Platform == UnrealTargetPlatform.Android)
                {
                    ExtraModuleNames.Add("OnlineSubsystemGooglePlay");
                    ExtraModuleNames.Add("AndroidAdvertising");

                  //  AdditionalCompilerArguments += " -w";

                  //      bUseLoggingInShipping = true;
                  //      GlobalDefinitions.Add("USE_LOGGING_IN_SHIPPING=1");


                }

                if (Target.Platform == UnrealTargetPlatform.IOS)
                {
                        ExtraModuleNames.Add("IOSAdvertising");

                       // AdditionalCompilerArguments += " -w";

                    //    bUseLoggingInShipping = true;
                    //    GlobalDefinitions.Add("USE_LOGGING_IN_SHIPPING=1");

                }


	}
}
