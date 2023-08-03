#!/bin/bash

# Check if NIS server is installed
if dpkg -s nis &> /dev/null; then
    echo "Uninstalling NIS Server..."
    sudo apt-get purge nis -y
    echo "NIS Server has been uninstalled."
else
    echo "NIS Server is not installed."
fi

echo "NIS Server check completed."
