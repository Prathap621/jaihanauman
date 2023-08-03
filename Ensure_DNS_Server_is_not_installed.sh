#!/bin/bash

# Check if DNS server packages are installed
if dpkg -l bind9 | grep "^ii" >/dev/null; then
    # Stop the DNS server service
    sudo systemctl stop bind9

    # Uninstall DNS server packages
    sudo apt-get purge bind9 -y

    # Inform the user that DNS server has been uninstalled
    echo "DNS server has been uninstalled."
else
    # Inform the user that DNS server is not installed
    echo "DNS server is not installed."
fi
