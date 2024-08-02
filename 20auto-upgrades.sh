#!/bin/bash

# backup file path
CONFIG_FILE="/etc/apt/apt.conf.d/20auto-upgrades"
BACKUP_FILE="/etc/apt/apt.conf.d/20auto-upgrades.bak"

# run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

# Backup the existing file
if [ -f "$CONFIG_FILE" ]; then
    echo "Backing up existing configuration file to $BACKUP_FILE"
    cp $CONFIG_FILE $BACKUP_FILE
else
    echo "No existing configuration file found. Skipping backup."
fi

# Write the new configuration settings to the file
cat <<EOF > $CONFIG_FILE
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

# Notify the user
echo "Automatic updates have been disabled."

# Optionally, you can check the result
echo "New configuration file contents:"
cat $CONFIG_FILE

# Check the status of the unattended-upgrades service
echo "Checking status of unattended-upgrades service..."
systemctl status unattended-upgrades --no-pager
