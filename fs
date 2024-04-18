import subprocess

def copy_file_to_windows(file_path, windows_share_path):
    # Escape backslashes in the Windows share path
    windows_share_path = windows_share_path.replace('\\', '\\\\')

    # Construct the smbclient command to copy the file
    command = [
        'smbclient',
        windows_share_path,
        '-c', f'send "{file_path}"',
        '--no-pass',  # Do not prompt for a password
        '-N'  # Use guest access
    ]

    # Execute the smbclient command
    try:
        subprocess.run(command, check=True)
        print(f'File "{file_path}" copied successfully to Windows file server at "{windows_share_path}".')
    except subprocess.CalledProcessError as e:
        print(f'Error copying file to Windows file server: {e}')

# Example usage
file_path = '/path/to/your/file.txt'
windows_share_path = '//apvrd35618/zabbix_report'

copy_file_to_windows(file_path, windows_share_path)
