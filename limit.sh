#!/bin/bash

# Lines to add to /etc/security/limits.conf
lines_to_add="* soft nofile 100000
* hard nofile 100000"

# Check if the lines are already present
if grep -Fxq "$lines_to_add" /etc/security/limits.conf; then
    echo "Lines are already present. No update needed."
else
    # Append lines to /etc/security/limits.conf
    echo "$lines_to_add" | sudo tee -a /etc/security/limits.conf > /dev/null
    echo "Lines added successfully."
fi
