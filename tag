from pyzabbix import ZabbixAPI
import pandas as pd

# Zabbix API connection details
zabbix_server = 'http://your_zabbix_server'
zabbix_user = 'your_username'
zabbix_password = 'your_password'

# Connect to Zabbix API
zapi = ZabbixAPI(zabbix_server)
zapi.login(zabbix_user, zabbix_password)

# Define the host group IDs you want to query
host_group_ids = [1, 2, 3]  # Replace with your host group IDs

# Fetch host information for each host group
data = []
for host_group_id in host_group_ids:
    hosts = zapi.host.get(output=['host', 'status', 'tags'], groupids=host_group_id)
    for host in hosts:
        hostname = host['host']
        status = 'Enabled' if host['status'] == '0' else 'Disabled'
        tags = host['tags']
        tag_name = None
        tag_value = None
        if tags:
            tag_name = tags[0]['tag']
            tag_value = tags[0]['value']
        data.append([hostname, host_group_id, status, tag_name, tag_value])

# Convert data to DataFrame
df = pd.DataFrame(data, columns=['Hostname', 'Host Group ID', 'Status', 'Tag Name', 'Tag Value'])

# Convert status column values
df['Status'] = df['Status'].apply(lambda x: 'Enabled' if x == '0' else 'Disabled')

# Save to Excel
excel_file = 'zabbix_host_info.xlsx'
df.to_excel(excel_file, index=False)

print(f"Data saved to '{excel_file}' successfully.")

# Logout from Zabbix API
zapi.logout()