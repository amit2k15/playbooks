import shutil
import os

# Define paths
csv_filename = 'your_csv_file.csv'
file_server_path = '\\\\apvrd35618\\zabbix_report'

# Debugging output
print(f"Copying file {csv_filename} to {file_server_path}")

# Copy the file
shutil.copy(csv_filename, f'{file_server_path}\\{csv_filename}')

# Check if the file exists after copying
if os.path.exists(f'{file_server_path}\\{csv_filename}'):
    print("File copied successfully")
else:
    print("Error: File not copied")
