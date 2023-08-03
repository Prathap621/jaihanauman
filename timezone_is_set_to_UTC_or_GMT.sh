#!/bin/bash

# Check the current system timezone
current_timezone=$(timedatectl show --property=Timezone --value)

# Check if the current timezone is already set to UTC or GMT
if [[ $current_timezone == "UTC" || $current_timezone == "GMT" ]]; then
    echo "The system timezone is already set to UTC or GMT."
else
    # Set the system timezone to UTC
    sudo timedatectl set-timezone UTC

    # Inform the user that the system timezone has been set to UTC
    echo "The system timezone has been set to UTC."
fi
