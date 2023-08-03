#!/bin/bash

# Check if the OS is Ubuntu
if [[ -f /etc/lsb-release && $(grep -c "Ubuntu" /etc/lsb-release) -gt 0 ]]; then
    CRON_DIR="/etc/cron.hourly"
elif [[ -f /etc/os-release && $(grep -c "AlmaLinux" /etc/os-release) -gt 0 ]]; then
    CRON_DIR="/etc/cron.hourly"
else
    echo "Unsupported operating system."
    exit 1
fi

# Check the permissions on /etc/cron.hourly
PERMISSIONS=$(stat -c "%a" $CRON_DIR)
if [[ $PERMISSIONS != "700" ]]; then
    # Set the correct permissions on /etc/cron.hourly
    sudo chmod 700 $CRON_DIR
    echo "Permissions on /etc/cron.hourly have been configured."
else
    echo "Permissions on /etc/cron.hourly are already properly configured."
fi
