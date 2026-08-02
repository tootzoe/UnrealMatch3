// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;

public class Match3 : ModuleRules
{
	public Match3(ReadOnlyTargetRules Target) : base(Target)
	{
                // PrivatePCHHeaderFile = "Match3.h";

                PublicDependencyModuleNames.AddRange(new string[] {
                "Core", "CoreUObject", "Engine",
                "InputCore", "Paper2D", "UMG"
                });


               PublicDependencyModuleNames.AddRange(new string[]
               {   //tootzoe added for googlePlay plugin
                                "PlayIntegrity"
               });


                PrivateDependencyModuleNames.AddRange(new string[] {
                "OnlineSubsystem",
                });

		// Uncomment if you are using Slate UI
		PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" });





        // tootzoe commited below:
     //   PrivateDependencyModuleNames.AddRange(new string[] { "OnlineSubsystem", "OnlineSubsystemUtils" });

     //   DynamicallyLoadedModuleNames.Add("OnlineSubsystemNull");

     //   if (Target.Platform == UnrealTargetPlatform.IOS)
     //   {
     //       PrivateDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine"});
     //       DynamicallyLoadedModuleNames.Add("IOSAdvertising");
     //   }
     //   else if (Target.Platform == UnrealTargetPlatform.Android)
     //   {
     //       PrivateDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine"});
     //       DynamicallyLoadedModuleNames.Add("AndroidAdvertising");
     //       // Add UPL to add configrules.txt to our APK
     //       //tootzoe commited below 2 lines
     //      // string PluginPath = Utils.MakePathRelativeTo(ModuleDirectory, Target.RelativeEnginePath);
     //     //  AdditionalPropertiesForReceipt.Add("AndroidPlugin", System.IO.Path.Combine(PluginPath, "AddRoundIcon_UPL.xml"));

     //   }




    }
}
