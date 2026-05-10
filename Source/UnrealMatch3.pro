
# TOOTzoe @ 2026-04-19



#TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

#
# below one line project name need to be lowercaes
#### Module 1
PRJMODULE1  = Match3
DEFINES += "MATCH3_API=__declspec(dllexport)"
#
INCLUDEPATH += ../Intermediate/Build/Win64/UnrealEditor/Inc/$$PRJMODULE1/UHT
INCLUDEPATH += $$PRJMODULE1 $$PRJMODULE1/Public $$PRJMODULE1/Private
# ### Module 2
# PRJMODULE2  = LittleKnightEditor
# DEFINES += "LITTLEKNIGHTEDITOR_API=__declspec(dllexport)"
# #
# INCLUDEPATH += ../Intermediate/Build/Win64/UnrealEditor/Inc/$$PRJMODULE2/UHT
# INCLUDEPATH += $$PRJMODULE2 $$PRJMODULE2/Public $$PRJMODULE2/Private
# ###


#
# this is true during development with unreal-editor...

DEFINES += "WITH_EDITORONLY_DATA=1"

## this project only
DEFINES += PLATFORM_ANDROID
##

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
## INCLUDEPATH += $$UESRCROOT/Runtime/Renderer/Private
PLUGINSROOT = ../Plugins
#INCLUDEPATH += $$PLUGINSROOT/UIExtension/Source/Public



###
# #### Start Plugins1 Module 1 Start
# PLUGINNAME1  = $$PLUGINSROOT/CommonLoadingScreen
# PLUGIN1MODULE1  = CommonLoadingScreen
# DEFINES += "COMMONLOADINGSCREEN_API=__declspec(dllexport)"
# #
# INCLUDEPATH += $$PLUGINNAME1/Intermediate/Build/Win64/UnrealEditor/Inc/$$PLUGIN1MODULE1/UHT
# INCLUDEPATH += $$PLUGINNAME1/Source/$$PLUGIN1MODULE1
# INCLUDEPATH += $$PLUGINNAME1/Source/$$PLUGIN1MODULE1/Public
# INCLUDEPATH += $$PLUGINNAME1/Source/$$PLUGIN1MODULE1/Private
# #
# PLUGIN1MODULE2  = CommonStartupLoadingScreen
# DEFINES += "COMMONSTARTUPLOADINGSCREEN_API=__declspec(dllexport)"
# #
# INCLUDEPATH += $$PLUGINNAME1/Intermediate/Build/Win64/UnrealEditor/Inc/$$PLUGIN1MODULE2/UHT
# INCLUDEPATH += $$PLUGINNAME1/Source/$$PLUGIN1MODULE2
# INCLUDEPATH += $$PLUGINNAME1/Source/$$PLUGIN1MODULE2/Public
# INCLUDEPATH += $$PLUGINNAME1/Source/$$PLUGIN1MODULE2/Private
# #
# ########## End Plugins1 Module 1 End


##
#
#

DISTFILES += \
	Match3/AddRoundIcon_UPL.xml \
	Match3/Match3.Build.cs \
	UnrealMatch3.Target.cs \
	UnrealMatch3Editor.Target.cs

HEADERS += \
	Match3/Grid.h \
	Match3/Match3.h \
	Match3/Match3BlueprintFunctionLibrary.h \
	Match3/Match3GameInstance.h \
	Match3/Match3GameMode.h \
	Match3/Match3PlayerController.h \
	Match3/Match3SaveGame.h \
	Match3/Resources/Windows/Match3.rc \
	Match3/Tile.h

SOURCES += \
	Match3/Grid.cpp \
	Match3/Match3.cpp \
	Match3/Match3BlueprintFunctionLibrary.cpp \
	Match3/Match3GameInstance.cpp \
	Match3/Match3GameMode.cpp \
	Match3/Match3PlayerController.cpp \
	Match3/Match3SaveGame.cpp \
	Match3/Tile.cpp
