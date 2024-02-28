#!/bin/bash

# Define the new content for the /etc/cron.d/sysstat file
NEW_CONTENT="
# The first element of the path is a directory where the debian-sa1
# script is located
PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin

# Activity reports every 5 minutes everyday
*/5 * * * * root command -v debian-sa1 > /dev/null && debian-sa1 1 1

# Additional run at 23:59 to rotate the statistics file
59 23 * * * root command -v debian-sa1 > /dev/null && debian-sa1 60 2
"

# Update the /etc/cron.d/sysstat file with the new content
echo "$NEW_CONTENT" | sudo tee /etc/cron.d/sysstat >/dev/null

# Restart the sysstat service
sudo systemctl restart sysstat
