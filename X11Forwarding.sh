#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Define the parameter and its desired value
param="X11Forwarding"
desired_value="no"

# Path to the sshd_config file
config_file="/etc/ssh/sshd_config"

# Check if the parameter is already set in the config file with the desired value
if grep -q "^\s*$param\s$desired_value" "$config_file"; then
    # If already set, no need to update
    echo "Configuration is already set correctly."
else
    # If not set or set differently, update the parameter value
    if grep -q "^\s*$param" "$config_file"; then
        # If found, update the value
        sed -i "s/^\s*$param.*/$param $desired_value/" "$config_file"
    else
        # If not found, add the parameter above any Include entries
        sed -i "/^Include/ i $param $desired_value" "$config_file"
    fi
    echo "Configuration updated."
fi
