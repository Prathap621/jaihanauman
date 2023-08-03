#!/bin/bash

# Check if CUPS is installed
if dpkg -s cups >/dev/null 2>&1; then
    # Uninstall CUPS
    echo "Uninstalling CUPS..."
    sudo apt-get purge cups -y

    # Remove CUPS related packages
    sudo apt-get autoremove -y

    # Inform the user that CUPS has been uninstalled
    echo "CUPS has been uninstalled."
else
    # Inform the user that CUPS is not installed
    echo "CUPS is not installed."
fi
