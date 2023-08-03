#!/bin/bash

# Specify the path to the rds.conf file
rds_conf_file="/etc/modprobe.d/rds.conf"

# Check if the rds.conf file exists
if [ ! -f "$rds_conf_file" ]; then
    # Create the rds.conf file
    sudo touch "$rds_conf_file"
    sudo chmod 644 "$rds_conf_file"

    # Add the configuration line to disable rds in the rds.conf file
    echo "install rds /bin/true" | sudo tee "$rds_conf_file" > /dev/null

    echo "rds.conf file created and RDS has been disabled."
else
    echo "rds.conf file already exists. No action taken."
fi

exit 0
