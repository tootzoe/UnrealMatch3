




#TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

#
#
PRJNAMETOOT = UNREALMATCH3
DEFINES += "UNREALMATCH3_API="
DEFINES += "UNREALMATCH3_API(...)="
#
DEFINES += "UCLASS()=UNREALMATCH3_API"
DEFINES += "UCLASS(...)=UNREALMATCH3_API"
#
# this is true during development with unreal-editor...

DEFINES += "WITH_EDITORONLY_DATA=1"

## this project only

##


INCLUDEPATH += ../Intermediate/Build/Win64/UnrealEditor/Inc/$$PRJNAMETOOT/UHT
INCLUDEPATH += $$PRJNAMETOOT/Public $$PRJNAMETOOT/Private
#INCLUDEPATH += ../Plugins/NNEPostProcessing/Source/NNEPostProcessing/Public
# we should follow UE project struct to include files, start from prj.Build.cs folder
#
#  The Thirdparty libs
#
#
#
include(defs.pri)
include(inc.pri)
#
## this project only
# INCLUDEPATH += $$UESRCROOT/Runtime/Renderer/Private
##
#
#

DISTFILES += \
    UnrealMatch3.Target.cs \
    UnrealMatch3/AddRoundIcon_UPL.xml \
    UnrealMatch3/UnrealMatch3.Build.cs \
    UnrealMatch3Editor.Target.cs

HEADERS += \
    UnrealMatch3/Grid.h \
    UnrealMatch3/Match3BlueprintFunctionLibrary.h \
    UnrealMatch3/Match3GameInstance.h \
    UnrealMatch3/Match3GameMode.h \
    UnrealMatch3/Match3PlayerController.h \
    UnrealMatch3/Match3SaveGame.h \
    UnrealMatch3/Resources/Windows/Match3.rc \
    UnrealMatch3/Tile.h \
    UnrealMatch3/UnrealMatch3.h

SOURCES += \
    UnrealMatch3/Grid.cpp \
    UnrealMatch3/Match3BlueprintFunctionLibrary.cpp \
    UnrealMatch3/Match3GameInstance.cpp \
    UnrealMatch3/Match3GameMode.cpp \
    UnrealMatch3/Match3PlayerController.cpp \
    UnrealMatch3/Match3SaveGame.cpp \
    UnrealMatch3/Tile.cpp \
    UnrealMatch3/UnrealMatch3.cpp
