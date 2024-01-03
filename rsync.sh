#!/bin/bash

# Check if rsync is installed
if command -v rsync &> /dev/null
then
    echo "rsync is already installed."
else
    # Install rsync
    echo "Installing rsync..."
    # You can use the package manager appropriate for your system (apt, yum, pacman, etc.)
    
    # For example, on Debian/Ubuntu-based systems:
    sudo apt-get update
    sudo apt-get install -y rsync
        
    echo "rsync installed successfully."
fi
