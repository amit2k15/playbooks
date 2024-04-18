import subprocess

# Source file path on RHEL 7 server
source_file = '/path/to/source/file.txt'

# Destination file path on Windows file server
destination_path = '\\\\apvrd35618\\zabbix_report'

# Build the smbclient command
smbclient_command = [
    'smbclient',
    '-N',  # Do not prompt for password
    '-c', f'put {source_file} {destination_path}'
]

# Run smbclient command using subprocess
try:
    subprocess.run(smbclient_command, check=True)
    print('File copied successfully!')
except subprocess.CalledProcessError as e:
    print(f'Error: {e}')
