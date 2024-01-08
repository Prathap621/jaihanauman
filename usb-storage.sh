#!/bin/bash

# Check if the usb-storage.conf file exists
if [ ! -f "/etc/modprobe.d/usb-storage.conf" ]; then
    # Create the usb-storage.conf file
    sudo touch /etc/modprobe.d/usb-storage.conf

    # Set the permissions of the file to 755
    sudo chmod 644 /etc/modprobe.d/usb-storage.conf

    # Add the configuration line to disable cramfs in the usb-storage.conf file
    echo "install usb-storage /bin/true" | sudo tee /etc/modprobe.d/usb-storage.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of usb-storage filesystems has been disabled."
else
    # Inform the user that the usb-storage.conf file already exists
    echo "usb-storage.conf file already exists. No action taken."
fi
