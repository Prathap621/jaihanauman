#!/bin/bash

# Check if the OS is Ubuntu
if [[ -f /etc/lsb-release && $(grep -c "Ubuntu" /etc/lsb-release) -gt 0 ]]; then
    CRON_SERVICE="cron"
elif [[ -f /etc/os-release && $(grep -c "AlmaLinux" /etc/os-release) -gt 0 ]]; then
    CRON_SERVICE="crond"
else
    echo "Unsupported operating system."
    exit 1
fi

# Check if the cron daemon is enabled
if [[ $(systemctl is-enabled $CRON_SERVICE) == "disabled" ]]; then
    # Enable the cron daemon
    sudo systemctl enable $CRON_SERVICE
    sudo systemctl start $CRON_SERVICE
    echo "Cron daemon has been enabled."
else
    echo "Cron daemon is already enabled."
fi
