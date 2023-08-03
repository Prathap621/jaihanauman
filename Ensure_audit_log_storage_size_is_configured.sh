#!/bin/bash

# Set the desired storage size in megabytes
storage_size_mb=100

# Update the auditd.conf file with the storage size configuration
sudo sed -i "s/^max_log_file = .*/max_log_file = ${storage_size_mb}/" /etc/audit/auditd.conf

# Restart the auditd service to apply the changes
sudo service auditd restart

# Inform the user that the audit log storage size has been configured
echo "Audit log storage size has been configured to ${storage_size_mb} MB."