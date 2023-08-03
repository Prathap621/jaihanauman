#!/bin/bash

# Check if the OS is Ubuntu
if [[ -f /etc/lsb-release && $(grep -c "Ubuntu" /etc/lsb-release) -gt 0 ]]; then
    # Check if rsyslog package is installed
    if ! dpkg -s rsyslog &> /dev/null; then
        # Install rsyslog
        sudo apt-get update
        sudo apt-get install rsyslog -y
        echo "rsyslog has been installed."
    else
        echo "rsyslog is already installed."
    fi
elif [[ -f /etc/os-release && $(grep -c "AlmaLinux" /etc/os-release) -gt 0 ]]; then
    # Check if rsyslog package is installed
    if ! rpm -q rsyslog &> /dev/null; then
        # Install rsyslog
        sudo dnf install rsyslog -y
        echo "rsyslog has been installed."
    else
        echo "rsyslog is already installed."
    fi
else
    echo "Unsupported operating system."
    exit 1
fi
