#!/bin/bash

file="/etc/issue.net"
backup_file="/etc/issue.net.backup"

# Check if the file exists
if [ -f "$file" ]; then
    # Take a backup of the file
    sudo cp "$file" "$backup_file"
    echo "Backup of $file created: $backup_file"

    # Set ownership to root:root
    sudo chown root:root "$file"

    # Set permissions to u-x, go-wx
    sudo chmod u-x,go-wx "$file"

    echo "The permissions on $file are configured properly."
else
    echo "$file does not exist."
fi
