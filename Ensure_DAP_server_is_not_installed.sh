#!/bin/bash

# Check if LDAP server packages are installed
if dpkg -l slapd | grep "^ii" >/dev/null; then
    # Stop the LDAP server service
    sudo systemctl stop slapd

    # Uninstall LDAP server packages
    sudo apt-get purge slapd -y

    # Inform the user that LDAP server has been uninstalled
    echo "LDAP server has been uninstalled."
else
    # Inform the user that LDAP server is not installed
    echo "LDAP server is not installed."
fi
