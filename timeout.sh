#!/bin/bash

TMOUT_VALUE=600

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Define the desired TMOUT value
TMOUT=$TMOUT_VALUE
export TMOUT

# Update /etc/profile with the new TMOUT setting
echo "TMOUT=$TMOUT" | tee -a /etc/profile

echo "TMOUT set to $TMOUT seconds in /etc/profile."

# Apply the change immediately to the current shell session
. /etc/profile
