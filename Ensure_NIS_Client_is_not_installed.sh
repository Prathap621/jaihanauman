#!/bin/bash

# Check if NIS client is installed
if dpkg -s nis &> /dev/null; then
    echo "Uninstalling NIS Client..."
    sudo apt-get purge nis -y
    echo "NIS Client has been uninstalled."
else
    echo "NIS Client is not installed."
fi

echo "NIS Client check completed."
