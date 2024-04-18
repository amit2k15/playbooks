import subprocess

# Define the source file and Windows file server path
source_file = '/path/to/Diplomat_win_server.csv'
windows_server_path = '\\\\apvrd35618\\zabbix_report'

# Define the smbclient command
smbclient_command = f'smbclient {windows_server_path} -c "put {source_file}"'

# Run the smbclient command using subprocess
try:
    subprocess.run(smbclient_command, shell=True, check=True)
    print('File copied successfully.')
except subprocess.CalledProcessError as e:
    print(f'Error copying file: {e}')
