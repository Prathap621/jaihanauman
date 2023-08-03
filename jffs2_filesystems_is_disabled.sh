#!/bin/bash

# Check if the jffs2.conf file exists
if [ ! -f "/etc/modprobe.d/jffs2.conf" ]; then
    # Create the jffs2.conf file
    sudo touch /etc/modprobe.d/jffs2.conf

    # Set the permissions of the file to 755
    sudo chmod 644 /etc/modprobe.d/jffs2.conf

    # Add the configuration line to disable cramfs in the jffs2.conf file
    echo "install cramfs /bin/true" | sudo tee /etc/modprobe.d/jffs2.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of cramfs filesystems has been disabled."
else
    # Inform the user that the jffs2.conf file already exists
    echo "jffs2.conf file already exists. No action taken."
fi
