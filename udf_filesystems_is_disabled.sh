#!/bin/bash

# Check if the udf.conf file exists
if [ ! -f "/etc/modprobe.d/udf.conf" ]; then
    # Create the udf.conf file
    sudo touch /etc/modprobe.d/udf.conf

    # Set the permissions of the file to 755
    sudo chmod 755 /etc/modprobe.d/udf.conf

    # Add the configuration line to disable cramfs in the udf.conf file
    echo "install cramfs /bin/true" | sudo tee /etc/modprobe.d/udf.conf > /dev/null

    # Inform the user that the mounting of cramfs filesystems has been disabled
    echo "Mounting of cramfs filesystems has been disabled."
else
    # Inform the user that the udf.conf file already exists
    echo "udf.conf file already exists. No action taken."
fi
