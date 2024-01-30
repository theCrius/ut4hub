#!/bin/bash

mkdir -p $CONFIGDIR

echo "Removing old configs"
rm $GAMECFG
rm $ENGINECFG

#-----------

echo "Setting MOTD and server name"

#UTGameState
echo [/Script/UnrealTournament.UTGameState] >> $GAMECFG
echo ServerMOTD=$SERVERMOTD >> $GAMECFG
echo ServerName=$SERVERNAME >> $GAMECFG
echo >> $GAMECFG

#-----------

echo "Setting Game.ini defaults"

#UTLobbyGameMode
echo [/Script/UnrealTournament.UTLobbyGameMode] >> $GAMECFG
echo LobbyPassword=$LOBBYPASSWORD >> $GAMECFG
echo AutoLaunchGameMode= >> $GAMECFG
echo AutoLaunchGameOptions= >> $GAMECFG
echo AutoLaunchMap= >> $GAMECFG
echo MinPlayersToStart=1 >> $GAMECFG
echo MaxPlayersInLobby=$MAXPLAYERLOBBY >> $GAMECFG
echo >> $GAMECFG

#-----------

echo "Adding redirect references"

#UTBaseGameMode
echo [/Script/UnrealTournament.UTBaseGameMode] >> $GAMECFG
cat /config/redirect.ini >> $GAMECFG
echo ServerInstanceID= >> $GAMECFG

#-----------

echo "Setting Rcon and Tickrate"

# UTGameEngine
echo [/Script/UnrealTournament.UTGameEngine] >> $ENGINECFG
echo RconPassword=$SERVERRCON >> $ENGINECFG
echo bFirstRun=False >> $ENGINECFG
echo >> $ENGINECFG

# IpNetDriver
echo [/Script/OnlineSubsystemUtils.IpNetDriver] >> $ENGINECFG
echo NetServerMaxTickRate=$SERVERTICKRATE >> $ENGINECFG
echo MaxInternetClientRate=$SERVERNETSPEED >> $ENGINECFG
echo MaxClientRate=$SERVERNETSPEED >> $ENGINECFG
echo >> $ENGINECFG

# Master Server Connections
if [[ -z "${MASTERSERVERURL}" ]]; then
    echo "Master server URL not found. Skipping."
else
	echo "Master Server URL found. Adding configuration."

    echo [OnlineSubsystemMcp.BaseServiceMcp] >> $ENGINECFG
    echo Protocol=https >> $ENGINECFG
    echo ;Domain=entitlement-public-service-prod08.ol.epicgames.com >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo EngineName=UE4 >> $ENGINECFG
    echo ServiceName=entitlement >> $ENGINECFG
    echo GameName=UnrealTournament >> $ENGINECFG
    echo >> $ENGINECFG
    
    echo [OnlineSubsystemMcp.GameServiceMcp] >> $ENGINECFG
    echo Protocol=https >> $ENGINECFG
    echo ;Domain=ut-public-service-prod10.ol.epicgames.com >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo ServiceName=ut >> $ENGINECFG
    echo GameName=UnrealTournament >> $ENGINECFG
    echo >> $ENGINECFG

    echo [OnlineSubsystemMcp.AccountServiceMcp] >> $ENGINECFG
    echo Protocol=https >> $ENGINECFG
    echo ;Domain=account-public-service-prod03.ol.epicgames.com >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo ServiceName=account >> $ENGINECFG
    echo GameName=UnrealTournament >> $ENGINECFG
    echo >> $ENGINECFG

    echo [OnlineSubsystemMcp.OnlineFriendsMcp] >> $ENGINECFG
    echo Protocol=https >> $ENGINECFG
    echo ;Domain=friends-public-service-prod06.ol.epicgames.com >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo ServiceName=friends >> $ENGINECFG
    echo GameName=UnrealTournament >> $ENGINECFG
    echo >> $ENGINECFG

    echo [OnlineSubsystemMcp.PersonaServiceMcp] >> $ENGINECFG
    echo ;Domain=persona-public-service-prod06.ol.epicgames.com >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo >> $ENGINECFG

    echo [OnlineSubsystemMcp.OnlineImageServiceMcp] >> $ENGINECFG
    echo Protocol=https >> $ENGINECFG
    echo ;Domain=cdn1.unrealengine.com >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo >> $ENGINECFG

    echo [OnlineSubsystemMcp.ContentControlsServiceMcp] >> $ENGINECFG
    echo Protocol=https >> $ENGINECFG
    echo ;Domain=content-controls-prod.ol.epicgames.net >> $ENGINECFG
    echo Domain=$MASTERSERVERURL >> $ENGINECFG
    echo >> $ENGINECFG

    echo "Master Server config added."
fi
#----------

echo "Linking paks"
cd $PAKSDIR
find -type l | xargs rm
ln -s /paks/* $PAKSDIR
