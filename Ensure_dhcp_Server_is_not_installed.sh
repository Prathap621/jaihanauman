#!/bin/bash

# Check if DHCP server packages are installed
if dpkg -l isc-dhcp-server | grep "^ii" >/dev/null; then
    # Stop the DHCP server service
    sudo systemctl stop isc-dhcp-server.service

    # Uninstall DHCP server packages
    sudo apt-get purge isc-dhcp-server -y

    # Inform the user that DHCP server has been uninstalled
    echo "DHCP server has been uninstalled."
else
    # Inform the user that DHCP server is not installed
    echo "DHCP server is not installed."
fi
