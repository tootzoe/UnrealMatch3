// Copyright Epic Games, Inc. All Rights Reserved.

#include "UnrealMatch3.h"
#include "Match3SaveGame.h"
#include "UnrealClient.h"
#include "Online.h"
#include "OnlineSubsystem.h"
#include "Kismet/GameplayStatics.h"
#include "Interfaces/OnlinePurchaseInterface.h"
#include "Match3GameInstance.h"

UMatch3GameInstance::UMatch3GameInstance()
{
	DefaultSaveGameSlot = TEXT("_Match3Game");
}

bool UMatch3GameInstance::FindSaveDataForLevel(UObject* WorldContextObject, FMatch3LevelSaveData& OutSaveData)
{
	const FString LevelName = UGameplayStatics::GetCurrentLevelName(WorldContextObject, true);
	if (FMatch3LevelSaveData* FoundData = InstanceGameData->Match3SaveData.Find(LevelName))
	{
		OutSaveData = *FoundData;
		return true;
	}
	return false;
}

void UMatch3GameInstance::UpdateSave(UObject* WorldContextObject, FMatch3LevelSaveData& NewData)
{
	const FString LevelName = UGameplayStatics::GetCurrentLevelName(WorldContextObject, true);
	InstanceGameData->Match3SaveData.FindOrAdd(LevelName) = NewData;
	UpdateUIAfterSave();
}

void UMatch3GameInstance::SaveGame()
{
	UGameplayStatics::SaveGameToSlot(InstanceGameData, GetSaveSlotName(), 0);
}

bool UMatch3GameInstance::LoadCustomInt(FString FieldName, int32& Value)
{
	check(InstanceGameData);
	return InstanceGameData->LoadCustomInt(FieldName, Value);
}

void UMatch3GameInstance::SaveCustomInt(FString FieldName, int32 Value)
{
	check(InstanceGameData);
	InstanceGameData->SaveCustomInt(FieldName, Value);
}

void UMatch3GameInstance::ClearCustomInt(FString FieldName)
{
	check(InstanceGameData);
	InstanceGameData->ClearCustomInt(FieldName);
}

void UMatch3GameInstance::Init()
{
	// Point to a default save slot at startup. We will later change our save slot when we log in.
	InitSaveGameSlot();

	
	LoginChangedHandle = FCoreDelegates::OnUserLoginChangedEvent.AddUObject(this, &UMatch3GameInstance::OnLoginChanged);
	EnteringForegroundHandle = FCoreDelegates::ApplicationHasEnteredForegroundDelegate.AddUObject(this, &UMatch3GameInstance::OnEnteringForeground);
	EnteringBackgroundHandle = FCoreDelegates::ApplicationWillEnterBackgroundDelegate.AddUObject(this, &UMatch3GameInstance::OnEnteringBackground);
	ViewportHandle = FViewport::ViewportResizedEvent.AddUObject(this, &UMatch3GameInstance::OnViewportResize_Internal);

	IOnlinePurchasePtr PurchaseInterface = Online::GetPurchaseInterface();
	if (PurchaseInterface.IsValid())
	{
		UnexpectedPurchaseHandle = PurchaseInterface->AddOnUnexpectedPurchaseReceiptDelegate_Handle(FOnUnexpectedPurchaseReceiptDelegate::CreateUObject(this, &UMatch3GameInstance::OnUnexpectedPurchase_Internal));
	}
	

	Super::Init();
}



void UMatch3GameInstance::Shutdown()
{
	FCoreDelegates::OnUserLoginChangedEvent.Remove(LoginChangedHandle);
	FCoreDelegates::ApplicationHasEnteredForegroundDelegate.Remove(EnteringForegroundHandle);
	FCoreDelegates::ApplicationWillEnterBackgroundDelegate.Remove(EnteringBackgroundHandle);
	FViewport::ViewportResizedEvent.Remove(ViewportHandle);
	

	Super::Shutdown();
}

void UMatch3GameInstance::InitSaveGameSlot()
{
	const FString SaveSlotName = GetSaveSlotName();
	if (!UGameplayStatics::DoesSaveGameExist(SaveSlotName, 0))
	{
		// Clear default save file, if it exists.
		if (UGameplayStatics::DoesSaveGameExist(DefaultSaveGameSlot, 0))
		{
			UGameplayStatics::DeleteGameInSlot(DefaultSaveGameSlot, 0);
		}
		// If we have no save object, create one.
		if (InstanceGameData == nullptr)
		{
			// We're either not logged in with an Online ID, or we have no save data to transfer over (usually, this indicates program startup).
			InstanceGameData = Cast<UMatch3SaveGame>(UGameplayStatics::CreateSaveGameObject(UMatch3SaveGame::StaticClass()));
		}
		UGameplayStatics::SaveGameToSlot(InstanceGameData, SaveSlotName, 0);
	}
	else
	{
		InstanceGameData = Cast<UMatch3SaveGame>(UGameplayStatics::LoadGameFromSlot(SaveSlotName, 0));
	}
	check(InstanceGameData);
}

FString UMatch3GameInstance::GetSaveSlotName() const
{
	return SaveGamePrefix + DefaultSaveGameSlot;
}

void UMatch3GameInstance::RegisterOnlineID(FString NewOnlineID)
{
	SaveGamePrefix = NewOnlineID;
	InitSaveGameSlot();
}

void UMatch3GameInstance::OnViewportResize_Internal(FViewport* Viewport, uint32 ID)
{
	OnViewportResize();
}

void UMatch3GameInstance::OnUnexpectedPurchase_Internal(const FUniqueNetId& UserId)
{
	OnUnexpectedPurchase();
}
