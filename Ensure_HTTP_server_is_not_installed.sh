#!/bin/bash

# Verify if Apache HTTP Server is installed
dpkg -s apache2 | grep -E '(Status:|not installed)' > /dev/null

if [ $? -eq 0 ]; then
    echo "Apache HTTP Server is not installed."
else
    echo "Uninstalling Apache HTTP Server..."
    sudo apt purge apache2 -y
    echo "Apache HTTP Server has been uninstalled."
fi
