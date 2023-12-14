#!/bin/bash

# Check if cloud-guest-utils is installed
if ! dpkg -l | grep -q "cloud-guest-utils"; then
    echo "cloud-guest-utils is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y cloud-guest-utils
else
    echo "cloud-guest-utils is already installed."
fi

# Check if xfsprogs is installed
if ! dpkg -l | grep -q "xfsprogs"; then
    echo "xfsprogs is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y xfsprogs
else
    echo "xfsprogs is already installed."
fi
