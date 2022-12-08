#!/usr/bin/env bash

FILE=./current_server_version.txt
if [ -f "$FILE" ]
  then
    :
  else
    touch current_server_version.txt
fi
OLD=$(<current_server_version.txt)
RESULT="`wget -qO- https://terraria.org/api/get/dedicated-servers-names`"
CURRENT="$(echo $RESULT | jq -r '.[0]')"
echo "$CURRENT" > current_server_version.txt
if [ "$OLD" == "$CURRENT" ]
  then
    :
  else
    rm ./Dockerfile
    python3 dockerfile_update.py $CURRENT
    docker stop terraria
    docker image rm terraria_local
    docker build -t terraria_local .
    docker run -d -it --rm -p 7777:7777 -v $HOME/terraria/world:/root/.local/share/Terraria/Worlds --name="terraria" -e WORLD_FILENAME=New_World.wld terraria_local
fi
