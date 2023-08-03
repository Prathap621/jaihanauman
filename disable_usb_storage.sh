#!/bin/bash

# Check if the usb-storage module is loaded
if lsmod | grep -q usb_storage; then
    # Blacklist the usb-storage module
    echo 'blacklist usb-storage' | sudo tee /etc/modprobe.d/disable-usb-storage.conf > /dev/null

    # Update the initramfs
    sudo update-initramfs -u

    # Inform the user that USB storage has been disabled
    echo "USB storage has been disabled."
else
    # Inform the user that USB storage is already disabled
    echo "USB storage is already disabled."
fi

