#!/bin/bash

update_cron() {
    stat=$(cat /etc/cron.d/sysstat | grep "*/5 \* \* \* \* root command -v debian-sa1")
    if [ -z "$stat" ]; then
        echo "Updating existing cron entry..."
        sudo sed -i 's/^5-55\/10 \* \* \* \* .*$/\*/5 \* \* \* \* root command -v debian-sa1 > \/dev\/null \&\& debian-sa1 1 1/' /etc/cron.d/sysstat
    else
        echo "The cron is already updated"
    fi
}

stop_and_start_sysstat() {
    echo "Stopping sysstat service..."
    sudo /etc/init.d/sysstat stop
    echo "Starting sysstat service..."
    sudo /etc/init.d/sysstat start
}

# Check and update cron entry
update_cron

# Restart sysstat service
stop_and_start_sysstat
