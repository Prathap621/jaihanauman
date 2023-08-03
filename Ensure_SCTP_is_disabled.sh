#!/bin/bash

# Check if the sctp.conf file exists
if [ ! -f "/etc/modprobe.d/sctp.conf" ]; then
    # Create the sctp.conf file
    sudo touch /etc/modprobe.d/sctp.conf

    # Set the permissions of the file to 755
    sudo chmod 755 /etc/modprobe.d/sctp.conf

    # Add the configuration line to disable SCTP in the sctp.conf file
    echo "install sctp /bin/true" | sudo tee /etc/modprobe.d/sctp.conf > /dev/null

    # Inform the user that SCTP has been disabled
    echo "SCTP has been disabled."
else
    echo "SCTP is already disabled."
fi

# Reload the kernel modules
sudo update-initramfs -u

# Verify if SCTP is disabled
if lsmod | grep -q sctp; then
    echo "SCTP is still enabled."
else
    echo "SCTP is disabled."
fi
