#!/bin/bash

# Check if the OS is Ubuntu
if [[ -f /etc/lsb-release && $(grep -c "Ubuntu" /etc/lsb-release) -gt 0 ]]; then
    CRONTAB_FILE="/etc/crontab"
elif [[ -f /etc/os-release && $(grep -c "AlmaLinux" /etc/os-release) -gt 0 ]]; then
    CRONTAB_FILE="/etc/crontab"
else
    echo "Unsupported operating system."
    exit 1
fi

# Check the permissions on /etc/crontab
PERMISSIONS=$(stat -c "%a" $CRONTAB_FILE)
if [[ $PERMISSIONS != "600" ]]; then
    # Set the correct permissions on /etc/crontab
    sudo chmod 600 $CRONTAB_FILE
    echo "Permissions on /etc/crontab have been configured."
else
    echo "Permissions on /etc/crontab are already properly configured."
fi
