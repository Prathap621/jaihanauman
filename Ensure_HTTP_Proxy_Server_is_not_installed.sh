#!/bin/bash

# Check if Squid Proxy Server is installed
if command -v squid &> /dev/null; then
    echo "Uninstalling Squid Proxy Server..."
    sudo apt-get purge squid -y
    echo "Squid Proxy Server has been uninstalled."
else
    echo "Squid Proxy Server is not installed."
fi

echo "HTTP Proxy Server check completed."
