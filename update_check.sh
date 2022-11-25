#!/usr/bin/env bash
set -euxo pipefail

RESULT="`wget -qO- https://terraria.org/api/get/dedicated-servers-names`"
CURRENT="$(echo $RESULT | jq -r '.[0]')"
#CURRENT="$(echo $RESULT | sed 's/^[^"]*"\([^"]*\)".*/\1/')"
echo "$CURRENT" > current_server_version.txt
