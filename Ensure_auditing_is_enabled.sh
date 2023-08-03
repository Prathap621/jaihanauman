#!/bin/bash

# Check if auditd package is installed
if ! dpkg -s auditd >/dev/null 2>&1; then
    echo "auditd is not installed. Installing auditd..."
    sudo apt update
    sudo apt install -y auditd
else
    echo "auditd is already installed."
fi

# Check if audispd-plugins package is installed
if ! dpkg -s audispd-plugins >/dev/null 2>&1; then
    echo "audispd-plugins is not installed. Installing audispd-plugins..."
    sudo apt update
    sudo apt install -y audispd-plugins
else
    echo "audispd-plugins is already installed."
fi

exit 0
