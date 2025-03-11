// Copyright Epic Games, Inc. All Rights Reserved.

#include "UnrealMatch3.h"
#include "Match3GameMode.h"
#include "GameFramework/PlayerState.h"
#include "Kismet/GameplayStatics.h"
#include "Match3BlueprintFunctionLibrary.h"

APlayerController* UMatch3BlueprintFunctionLibrary::GetLocalPlayerController(UObject* WorldContextObject)
{
	if (UWorld* World = GEngine->GetWorldFromContextObject(WorldContextObject, EGetWorldErrorMode::LogAndReturnNull))
	{
		for (FConstPlayerControllerIterator Iterator = World->GetPlayerControllerIterator(); Iterator; ++Iterator)
		{
			APlayerController* PlayerController = Iterator->Get();
			if (PlayerController && PlayerController->IsLocalController())
			{
				// For this project, we will only ever have one local player.
				return PlayerController;
			}
		}
	}
	return nullptr;
}

FString UMatch3BlueprintFunctionLibrary::GetOnlineAccountID(APlayerController* PlayerController)
{
	if (PlayerController && PlayerController->PlayerState && PlayerController->PlayerState->GetUniqueId().IsValid())
	{
		return PlayerController->PlayerState->GetUniqueId()->GetHexEncodedString();
	}
	return FString();
}

bool UMatch3BlueprintFunctionLibrary::IsGameActive(UObject* WorldContextObject)
{
	if (AMatch3GameMode* GameMode = Cast<AMatch3GameMode>(UGameplayStatics::GetGameMode(WorldContextObject)))
	{
		if (GameMode->IsGameActive())
		{
			return true;
		}
	}
	return false;
}

void UMatch3BlueprintFunctionLibrary::PauseGameTimer(UObject* WorldContextObject, bool bPause)
{
	if (AMatch3GameMode* GameMode = Cast<AMatch3GameMode>(UGameplayStatics::GetGameMode(WorldContextObject)))
	{
		GameMode->PauseGameTimer(bPause);
	}
}
