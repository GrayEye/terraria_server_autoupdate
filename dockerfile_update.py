import sys

#This file updates the Dockerfile.
#This file wouldn't exist if I knew sed commands better.

with open('Dockerfile.template', 'r') as file:
    file_data = file.read()

file_data = file_data.replace(
        "placeholder_1",
        sys.argv[1].strip()
        )
file_data = file_data.replace(
        "placeholder_2",
        sys.argv[1].strip().split('-')[-1][:-4]
        )

with open('Dockerfile', 'w') as out_file:
    out_file.write(file_data)
