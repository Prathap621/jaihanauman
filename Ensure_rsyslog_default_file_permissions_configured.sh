#!/bin/bash

# Check the operating system
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" ]]; then
        rsyslogConfigFile="/etc/rsyslog.conf"
    elif [[ $ID == "almalinux" ]]; then
        rsyslogConfigFile="/etc/rsyslog/rsyslog.conf"
    else
        echo "Unsupported operating system: $ID"
        exit 1
    fi
else
    echo "Failed to detect the operating system."
    exit 1
fi

# Verify and update the rsyslog configuration file
if [[ -f $rsyslogConfigFile ]]; then
    if grep -qE '^\$FileCreateMode\s+0640$' "$rsyslogConfigFile" && grep -qE '^\$DirCreateMode\s+0755$' "$rsyslogConfigFile"; then
        echo "Default file permissions for rsyslog are already configured correctly."
    else
        # Update the file permissions
        sed -i 's/^\($FileCreateMode\s\+\).*/\10640/' "$rsyslogConfigFile"
        sed -i 's/^\($DirCreateMode\s\+\).*/\10755/' "$rsyslogConfigFile"
        echo "Default file permissions for rsyslog have been configured."
    fi

    # Restart the rsyslog service
    systemctl restart rsyslog
    echo "rsyslog service has been restarted."
else
    echo "rsyslog configuration file not found: $rsyslogConfigFile"
    exit 1
fi
