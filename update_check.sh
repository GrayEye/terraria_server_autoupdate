#!/usr/bin/env bash

if [ "./current_server_version.txt" ]
  then
    :
  else
    touch current_server_version.txt
fi
OLD=$(<current_server_version.txt)
RESULT="`wget -qO- https://terraria.org/api/get/dedicated-servers-names`"
CURRENT="$(echo $RESULT | jq -r '.[0]')"
echo "$CURRENT" > current_server_version.txt
if [ $OLD == $CURRENT ]
  then
    exit 0
  else
    echo 'no'
fi
