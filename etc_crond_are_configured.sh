#!/bin/bash

# Check if the OS is Ubuntu
if [[ -f /etc/lsb-release && $(grep -c "Ubuntu" /etc/lsb-release) -gt 0 ]]; then
    CROND_FILE="/etc/crond"
elif [[ -f /etc/os-release && $(grep -c "AlmaLinux" /etc/os-release) -gt 0 ]]; then
    CROND_FILE="/etc/crond"
else
    echo "Unsupported operating system."
    exit 1
fi

# Check the permissions on /etc/crond
PERMISSIONS=$(stat -c "%a" $CROND_FILE)
if [[ $PERMISSIONS != "600" ]]; then
    # Set the correct permissions on /etc/crond
    sudo chmod 600 $CROND_FILE
    echo "Permissions on /etc/crond have been configured."
else
    echo "Permissions on /etc/crond are already properly configured."
fi
