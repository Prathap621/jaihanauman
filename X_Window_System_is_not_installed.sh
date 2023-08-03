#!/bin/bash

# Check if X Window System packages are installed
if dpkg -l xserver-xorg* | grep "^ii" >/dev/null; then
    # Uninstall X Window System packages
    sudo apt-get purge xserver-xorg* -y

    # Inform the user that X Window System has been uninstalled
    echo "X Window System has been uninstalled."
else
    # Inform the user that X Window System is not installed
    echo "X Window System is not installed."
fi
