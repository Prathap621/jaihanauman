#!/bin/bash

# Check if the squashfs.conf file exists
if [ ! -f "/etc/modprobe.d/squashfs.conf" ]; then
    # Create the squashfs.conf file
    sudo touch /etc/modprobe.d/squashfs.conf

    # Set the permissions of the file to 755
    sudo chmod 755 /etc/modprobe.d/squashfs.conf

    # Add the configuration line to disable cramfs in the squashfs.conf file
    echo "install cramfs /bin/true" | sudo tee /etc/modprobe.d/squashfs.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of cramfs filesystems has been disabled."
else
    # Inform the user that the squashfs.conf file already exists
    echo "squashfs.conf file already exists. No action taken."
fi
