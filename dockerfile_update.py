import sys

#This file updates the Dockerfile.
#This file wouldn't exist if I knew sed commands better.

with open('Dockerfile', 'r') as file:
    file_data = file.read()

file_data = file_data.replace(
        sys.argv[1].strip(),
        sys.argv[2].strip()
        )
file_data = file_data.replace(
        sys.argv[1].strip().split('-')[-1][:-4],
        sys.argv[2].strip().split('-')[-1][:-4]
        )

with open('Dockerfile', 'w') as out_file:
    out_file.write(file_data)
