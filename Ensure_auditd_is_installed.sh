#!/bin/bash

# Check if auditd package is installed
if ! dpkg -s auditd &> /dev/null; then
    echo "auditd is not installed. Installing..."
    apt install -y auditd
fi

# Check if audispd-plugins package is installed
if ! dpkg -s audispd-plugins &> /dev/null; then
    echo "audispd-plugins is not installed. Installing..."
    apt install -y audispd-plugins
fi

# Verify installation
dpkg -s auditd audispd-plugins
