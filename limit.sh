#!/bin/bash

# Lines to add to /etc/security/limits.conf
lines_to_add="tomcat soft nofile 100000
tomcat hard nofile 100000"

# Check if the lines are already present
if grep -Fxq "$lines_to_add" /etc/security/limits.conf; then
    echo "Lines are already present in /etc/security/limits.conf. No update needed."
else
    # Append lines to /etc/security/limits.conf
    echo "$lines_to_add" | sudo tee -a /etc/security/limits.conf > /dev/null
    echo "Lines added to /etc/security/limits.conf successfully."
fi

# Install nscd if not already installed
if ! command -v nscd &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y nscd
    echo "nscd installed successfully."
else
    echo "nscd is already installed. No update needed."
fi
