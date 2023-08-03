#!/bin/bash

# Check if the hfsplus.conf file exists
if [ ! -f "/etc/modprobe.d/hfsplus.conf" ]; then
    # Create the hfsplus.conf file
    sudo touch /etc/modprobe.d/hfsplus.conf

    # Set the permissions of the file to 755
    sudo chmod 644 /etc/modprobe.d/hfsplus.conf

    # Add the configuration line to disable cramfs in the hfsplus.conf file
    echo "install cramfs /bin/true" | sudo tee /etc/modprobe.d/hfsplus.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of cramfs filesystems has been disabled."
else
    # Inform the user that the hfsplus.conf file already exists
    echo "hfsplus.conf file already exists. No action taken."
fi
