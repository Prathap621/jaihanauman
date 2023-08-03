#!/bin/bash

# Check if the dccp.conf file exists
if [ ! -f "/etc/modprobe.d/dccp.conf" ]; then
    # Create the dccp.conf file
    sudo touch /etc/modprobe.d/dccp.conf

    # Set the permissions of the file to 755
    sudo chmod 755 /etc/modprobe.d/dccp.conf

    # Add the configuration line to disable DCCP in the dccp.conf file
    echo "install dccp /bin/true" | sudo tee /etc/modprobe.d/dccp.conf > /dev/null

    # Inform the user that DCCP has been disabled
    echo "DCCP has been disabled."
else
    echo "DCCP is already disabled."
fi
