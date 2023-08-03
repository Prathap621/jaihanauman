#!/bin/bash

# Check if the freevxfs.conf file exists
if [ ! -f "/etc/modprobe.d/freevxfs.conf" ]; then
    # Create the freevxfs.conf file
    sudo touch /etc/modprobe.d/freevxfs.conf

    # Set the permissions of the file to 755
    sudo chmod 644 /etc/modprobe.d/freevxfs.conf

    # Add the configuration line to disable cramfs in the freevxfs.conf file
    echo "install cramfs /bin/true" | sudo tee /etc/modprobe.d/freevxfs.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of cramfs filesystems has been disabled."
else
    # Inform the user that the freevxfs.conf file already exists
    echo "freevxfs.conf file already exists. No action taken."
fi
