import sys
from pathlib import Path

#This file updates the Dockerfile.
#This file wouldn't exist if I knew sed commands better.

home = str(Path.home())

with open(home+'/terraria_server_autoupdate/Dockerfile.template', 'r') as file:
    file_data = file.read()

file_data = file_data.replace(
        "placeholder_1",
        sys.argv[1].strip()
        )
file_data = file_data.replace(
        "placeholder_2",
        sys.argv[1].strip().split('-')[-1][:-4]
        )

with open(home+'/terraria_server_autoupdate/Dockerfile', 'w') as out_file:
    out_file.write(file_data)
