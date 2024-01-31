#!/bin/bash

cd $SERVERBIN

ServerPassword=$(echo $SERVERPASSWORD | sed 's/"//g')

startHub() {
  ./UE4Server-Linux-Shipping UnrealTournament UT-Entry?game=lobby?ServerPassword=$ServerPassword?mutators=AntiCheatV3
}

# Acts as a watchdog - as soon as the server process dies, this will restart it.
while :; do startHub; done
