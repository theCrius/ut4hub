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
echo MaxPlayerWait=60 >> $GAMECFG
echo MinPlayersToStart=1 >> $GAMECFG
echo MaxPlayersInLobby=$MAXPLAYERLOBBY >> $GAMECFG
echo >> $GAMECFG

#-----------

# UTGameMode
echo [/Script/UnrealTournament.UTGameMode] >> $GAMECFG
echo MapVoteTime=30 >> $GAMECFG
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
echo "Add Master Server configuration if available"
cat /config/masterserver.ini >> $ENGINECFG
echo >> $ENGINECFG

#----------

echo "Linking paks"
cd $PAKSDIR
find -type l | xargs rm
ln -s /paks/* $PAKSDIR
