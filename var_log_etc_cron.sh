#!/bin/bash

# Check if permissions are already set for log files
if find /var/log -type f -perm /220 ! -perm /444 -print -quit | grep -q .; then
    echo "Permissions for log files are not set correctly. Updating permissions..."
    find /var/log -type f -exec chmod g-wx,o-rwx {} +
    echo "Permissions for log files updated."
else
    echo "Permissions for log files are already set correctly. No change needed."
fi

# Check if permissions are already set for /etc/cron.d/
if [ "$(stat -c %a /etc/cron.d/)" -ne 600 ]; then
    echo "Permissions for /etc/cron.d/ are not set correctly. Updating permissions..."
    sudo chmod 600 /etc/cron.d/
    echo "Permissions for /etc/cron.d/ updated."
else
    echo "Permissions for /etc/cron.d/ are already set correctly. No change needed."
fi
