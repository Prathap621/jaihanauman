#!/bin/bash

# Check if RSH client is installed
if dpkg -s rsh-client &> /dev/null; then
    echo "Uninstalling RSH Client..."
    sudo apt-get purge rsh-client -y
    echo "RSH Client has been uninstalled."
else
    echo "RSH Client is not installed."
fi

echo "RSH Client check completed."
