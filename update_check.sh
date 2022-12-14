#!/usr/bin/env bash

FILE=~/terraria_server_autoupdate/current_server_version.txt
if [ -f "$FILE" ]
  then
    :
  else
    touch ~/terraria_server_autoupdate/current_server_version.txt
fi
OLD=$(<~/terraria_server_autoupdate/current_server_version.txt)
RESULT="`wget -qO- https://terraria.org/api/get/dedicated-servers-names`"
CURRENT="$(echo $RESULT | jq -r '.[0]')"
echo "$CURRENT" > ~/terraria_server_autoupdate/current_server_version.txt
if [ "$OLD" != "$CURRENT" ]: then
  #Look into passing vaiables in the Docker Build
  rm ~/terraria_server_autoupdate/Dockerfile
  sed -e "s/placeholder_1/$CURRENT/g" Dockerfile.template > Dockerfile
  VERSION=${CURRENT##*-}
  VERSION=${VERSION%%.zip}
  sed -i "s/placeholder_2/$VERSION/g" Dockerfile
  docker stop terraria
  docker image rm terraria_local
  docker build -t terraria_local ~/terraria_server_autoupdate/.
  docker run -d -it --rm -p 7777:7777 -v $HOME/terraria/world:/root/.local/share/Terraria/Worlds --name="terraria" -e WORLD_FILENAME=New_World.wld terraria_local
fi
