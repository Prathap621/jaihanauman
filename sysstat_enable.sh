#!/bin/bash

# Check if ENABLED is not set in /etc/default/sysstat
if grep -q '^ENABLED=""' /etc/default/sysstat; then
    # Set ENABLED="true"
    sed -i 's/ENABLED=""/ENABLED="true"/' /etc/default/sysstat

    # Update /etc/cron.d/sysstat entry
    sed -i 's/5-55\/10 \* \* \* \* root command -v debian-sa1 > \/dev\/null && debian-sa1 1 1/\/5 \* \* \* \* root command -v debian-sa1 > \/dev\/null && debian-sa1 1 1/' /etc/cron.d/sysstat

    # Stop sysstat service
    /etc/init.d/sysstat stop

    # Start sysstat service
    /etc/init.d/sysstat start

    echo "Configuration updated and sysstat service restarted."
else
    echo "ENABLED is already set to true. No changes made."
fi
