#!/bin/bash

# Check if the cramfs.conf file exists
if [ ! -f "/etc/modprobe.d/cramfs.conf" ]; then
    # Create the cramfs.conf file
    sudo touch /etc/modprobe.d/cramfs.conf

    # Set the permissions of the file to 755
    sudo chmod 644 /etc/modprobe.d/cramfs.conf

    # Add the configuration line to disable cramfs in the cramfs.conf file
    echo "install cramfs /bin/true" | sudo tee /etc/modprobe.d/cramfs.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of cramfs filesystems has been disabled."
else
    # Inform the user that the cramfs.conf file already exists
    echo "cramfs.conf file already exists. No action taken."
fi
