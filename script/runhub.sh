#!/bin/bash

cd $SERVERBIN

startHub() {
  ./UE4Server-Linux-Shipping UnrealTournament UT-Entry?game=lobby?ServerPassword=$(echo $SERVERPASSWORD | sed s/"//g)
}

# Acts as a watchdog - as soon as the server process dies, this will restart it.
while :; do startHub; done
