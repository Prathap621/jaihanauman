#!/bin/bash

# Check if Talk client is installed
if dpkg -s talk &> /dev/null; then
    echo "Uninstalling Talk Client..."
    sudo apt-get purge talk -y
    echo "Talk Client has been uninstalled."
else
    echo "Talk Client is not installed."
fi

echo "Talk Client check completed."
