#!/bin/bash

# Function to update parameter in the sysctl.conf file
function update_parameter() {
    parameter="$1"
    value="$2"

    # Remove any existing lines containing the parameter
    sudo sed -i "/^$parameter/d" /etc/sysctl.conf

    # Add the new line with the parameter and value
    echo "$parameter = $value" | sudo tee -a /etc/sysctl.conf > /dev/null
}

# Backup the original sysctl.conf file
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Update IPv6 configuration in sysctl.conf
update_parameter "net.ipv6.conf.all.disable_ipv6" "1"
update_parameter "net.ipv6.conf.default.disable_ipv6" "1"
update_parameter "net.ipv6.conf.default.accept_redirects" "0"

# Reload sysctl.conf to apply the changes
sudo sysctl -p

# Set active kernel parameters to disable IPv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
sudo sysctl -w net.ipv6.route.flush=1

echo "IPv6 has been disabled through sysctl settings, and accept_redirects has been set to 0."
