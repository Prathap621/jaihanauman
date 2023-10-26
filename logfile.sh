#!/bin/bash

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Use find to locate log files under /var/log and change their permissions
find /var/log -type f -exec chmod g-wx,o-rwx {} +

echo "Permissions for log files under /var/log have been updated."
