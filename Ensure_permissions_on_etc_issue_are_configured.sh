#!/bin/bash

# Check if the /etc/issue file exists
if [ -f /etc/issue ]; then
    # Set ownership to root:root
    sudo chown root:root $(readlink -e /etc/issue)

    # Set permissions to u-x, go-wx
    sudo chmod u-x,go-wx $(readlink -e /etc/issue)

    # Inform the user that the permissions on /etc/issue are configured properly
    echo "The permissions on /etc/issue are configured properly."
else
    # Inform the user that the /etc/issue file is not present
    echo "The /etc/issue file is not present."
fi
