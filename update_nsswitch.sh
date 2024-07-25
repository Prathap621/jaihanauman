#!/bin/bash

# Print a message when the script starts
echo "Starting the script..."

# Define the path to nsswitch.conf
nsswitch_file="/etc/nsswitch.conf"

# Check if nsswitch.conf exists before proceeding
if [ -f "$nsswitch_file" ]; then
    echo "Found $nsswitch_file, proceeding with backup and update."
    
    # Backup file name with timestamp
    backup_file="$nsswitch_file_$(date +'%Y%m%d%H%M%S').bak"

    # Take a backup of the original nsswitch.conf file
    cp $nsswitch_file $backup_file

    # Define the new content to update nsswitch.conf
    new_content="# /etc/nsswitch.conf
    #
    # Example configuration of GNU Name Service Switch functionality.
    # If you have the \`glibc-doc-reference' and \`info' packages installed, try:
    # \`info libc \"Name Service Switch\"' for information about this file.

    passwd:         files ldap
    group:          files ldap
    shadow:         files ldap
    gshadow:        files ldap

    hosts:          files dns
    networks:       files

    protocols:      db files
    services:       db files
    ethers:         db files
    rpc:            db files

    netgroup:       nis
    "

    # Write the new content to nsswitch.conf
    echo "$new_content" > $nsswitch_file

    # Notify user about backup and update
    echo "Backup of $nsswitch_file saved as $backup_file"
    echo "Updated $nsswitch_file with the new configuration."
else
    echo "$nsswitch_file not found. Exiting script."
    exit 1
fi

# Print a final message when the script completes
echo "Script execution completed."
