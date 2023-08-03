#!/bin/bash

# Check if the maxlogins limit is already set in limits.conf
if grep -q "^.*\s*maxlogins\s*.*$" /etc/security/limits.conf; then
    # Update the maxlogins limit in limits.conf
    sudo sed -i 's/^\(.*\)\(\s*maxlogins\s*\).*$/\1\2 10/' /etc/security/limits.conf
else
    # Append the maxlogins limit to limits.conf
    echo "*               hard    maxlogins         10" | sudo tee -a /etc/security/limits.conf > /dev/null
fi

# Inform the user that the maxlogins limit has been set
echo "The maxlogins limit has been set to 10 or less."
