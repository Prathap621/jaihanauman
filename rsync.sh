#!/bin/bash

packages=("rsync" "cloud-guest-utils" "xfsprogs" "ssmtp" "mailutils" "nscd" "snmpd" "mlocate")

for package in "${packages[@]}"; do
    if command -v "$package" &> /dev/null; then
        echo "$package is already installed."
    else
        echo "Installing $package..."
        sudo apt-get update
        sudo apt-get install -y "$package"
        [ $? -eq 0 ] && echo "$package installed successfully." || echo "Error installing $package. Please check and try again."
    fi
done
