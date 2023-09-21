#!/bin/bash

# Function to install sysstat
install_sysstat() {
    echo "Installing sysstat..."
    sudo apt-get install sysstat -y
}

# Function to modify /etc/default/sysstat
modify_sysstat_config() {
    echo "Modifying /etc/default/sysstat..."
    sudo sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
}

# Function to modify /etc/cron.d/sysstat
modify_cron_config() {
    echo "Modifying /etc/cron.d/sysstat..."
    sudo sed -i 's/5-55\/10 \* \* \* \* root command -v debian-sa1 > \/dev\/null && debian-sa1 1 1/\/5 \* \* \* \* root command -v debian-sa1 > \/dev\/null && debian-sa1 1 1/' /etc/cron.d/sysstat
}

# Function to stop sysstat service
stop_sysstat_service() {
    echo "Stopping sysstat service..."
    sudo /etc/init.d/sysstat stop
}

# Function to start sysstat service
start_sysstat_service() {
    echo "Starting sysstat service..."
    sudo /etc/init.d/sysstat start
}

# Main script
main() {
    install_sysstat
    modify_sysstat_config
    modify_cron_config
    stop_sysstat_service
    start_sysstat_service
    echo "Sysstat configuration has been updated."
}

# Run the main function
main
