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
	  python3 dockerfile_update.py $OLD $CURRENT
fi
