# ut4hub
Docker image for a stock install of a UT4 hub

# Build
Clone this repo with `git clone https://github.com/theCrius/ut4hub.git`, then run `chmod +x rebuild.sh` to grant permission to run to the script. Te build/rebuild simply run `./rebuild.sh`

# Configuration 

## Directories
Create a directory to hold some necessary files to launch the hub:

- `mkdir -p /home/$USER/ut4hub/config` 
- `mkdir -p /home/$USER/ut4hub/paks`
- `mkdir -p /home/$USER/ut4hub/rules`

These folders *can be anywhere and named anything*, as long as they map to `/config`, `/paks`, and `/rules` in the volumes section of the docker-compose.yml file

### /config

This directory should contain a file named `redirect.ini`. The file should contain `RedirectReferences` for whatever redirect server you're using. Example:

```
RedirectReferences=(PackageName="DM-Alanis-WindowsNoEditor",PackageURLProtocol="https",PackageURL="example.com/redirect/DM-Alanis-WindowsNoEditor.pak",PackageChecksum="MD5SumOfAlanis")
RedirectReferences=(PackageName="MutTeamSkins-WindowsNoEditor",PackageURLProtocol="https",PackageURL="example.com/redirect/MutTeamSkins-WindowsNoEditor.pak",PackageChecksum="MD5SumOfTeamSkins")
```

If you want to connect to a master server, you'll need to add a file with the additional configuration. Use the `/config/masterserver.ini.sample` as a guide.

### /paks

This directory should only contain valid pak files for maps, mutators, gametypes, etc

### /rules

This directory should contain `.json` files containing server rulesets. You can build these on UTCC or use your own.

## Environment Variables

The following environment variables can be specified in docker-compose.yml

- `SERVERNAME` - name to be displayed in the hub browser. Default is "UT4 Docker Hub"
- `SERVERMOTD` - MOTD shown when in the hub lobby. Default is "A UT4 Docker Hub!"
- `SERVERRCON` - admin password used with `rconauth <somepassword>`. Default is "asdf1234"
- `SERVERTICKRATE` - server tickrate. Default is 90, max is 120
- `SERVERNETSPEED` - client netspeed. Default is 24000, max is 24000

# Run
Modify `docker-compose.yml.sample` with your settings 
Launch with `docker-compose up -d`

