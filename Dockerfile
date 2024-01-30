FROM ubuntu:20.04
ENV HUBROOT=/hub
ENV CONFIGDIR=$HUBROOT/server/LinuxServer/UnrealTournament/Saved/Config/LinuxServer
ENV MASTERSERVERCONFIG=
ENV RULESDIR=$HUBROOT/server/LinuxServer/UnrealTournament/Saved/Config/Rulesets
ENV SERVERBIN=$HUBROOT/server/LinuxServer/Engine/Binaries/Linux
ENV ENGINECFG=$CONFIGDIR/Engine.ini
ENV GAMECFG=$CONFIGDIR/Game.ini
ENV PAKSDIR=$HUBROOT/server/LinuxServer/UnrealTournament/Content/Paks
ENV SERVERNAME="UT4 Docker Hub"
ENV SERVERMOTD="A UT4 Docker Hub!"
ENV SERVERRCON="asdf1234"
ENV LOBBYPASSWORD=""
ENV MAXPLAYERLOBBY=30
ENV SERVERTICKRATE=120
ENV SERVERNETSPEED=24000
ENV HUBPACKAGE=UnrealTournament-Server-XAN-3525360-Linux.zip
ADD https://s3.amazonaws.com/unrealtournament/ShippedBuilds/%2B%2BUT%2BRelease-Next-CL-3525360/UnrealTournament-Server-XAN-3525360-Linux.zip /hub/
RUN apt-get update && \
    apt-get install -y unzip  && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY script /hub/script/
RUN /hub/script/root.sh
RUN groupadd -g 999 hubadmin && \ 
    useradd -r -u 999 -g hubadmin hubadmin && \
    chown -R hubadmin /hub
USER hubadmin
RUN /hub/script/hubadmin.sh
WORKDIR /hub
CMD ["/hub/script/startup.sh"]

