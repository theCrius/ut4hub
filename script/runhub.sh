#!/bin/bash

cd $SERVERBIN

startHub() {
  ./UE4Server-Linux-Shipping UnrealTournament UT-Entry?game=lobby?ServerPassword=$SERVERPASSWORD?MapVoteTime=30?BalanceTeams=1?ForceNoBots=1
}

# Acts as a watchdog - as soon as the server process dies, this will restart it.
while :; do startHub; done
