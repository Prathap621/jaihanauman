#!/bin/bash

# Check if the motd file exists
if [ -f /etc/motd ]; then
    # Remove the motd file
    sudo rm -f /etc/motd

    # Inform the user that the motd file has been removed
    echo "The message of the day (motd) file has been removed."
else
    # Inform the user that the motd file is not present
    echo "The message of the day (motd) file is not present."
fi
