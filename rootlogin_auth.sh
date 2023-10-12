#!/bin/bash

# Check if the script is being run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Location of the sshd_config file
sshd_config_file="/etc/ssh/sshd_config"

# Check if PermitRootLogin exists in the sshd_config file and update it to 'yes'
if grep -q "PermitRootLogin" "$sshd_config_file"; then
  sed -i 's/PermitRootLogin.*/PermitRootLogin yes/' "$sshd_config_file"
fi

# Check if PasswordAuthentication exists in the sshd_config file and update it to 'yes'
if grep -q "PasswordAuthentication" "$sshd_config_file"; then
  sed -i 's/PasswordAuthentication.*/PasswordAuthentication yes/' "$sshd_config_file"
fi

# Restart SSH service to apply the changes
service ssh restart

echo "PermitRootLogin and PasswordAuthentication have been set to 'yes' if they existed in the sshd_config file. SSH service has been restarted."
