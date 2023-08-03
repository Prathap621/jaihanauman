#!/bin/bash

# Function to remove specific lines from rsyslog configuration files
remove_rsyslog_lines() {
    local config_files=(/etc/rsyslog.conf /etc/rsyslog.d/*.conf)
    
    for file in "${config_files[@]}"; do
        # Backup the original file
        cp "$file" "$file.bak"
        
        # Remove the lines matching the patterns
        sed -i '/^\h*\$ModLoad imtcp$/d' "$file"
        sed -i '/^\h*\$InputTCPServerRun$/d' "$file"
        sed -i '/^\h*module(load="imtcp")$/d' "$file"
        sed -i '/^\h*input(type="imtcp" port="514")$/d' "$file"
        
        echo "Lines removed from $file"
    done
}

# Restart rsyslog service
restart_rsyslog_service() {
    systemctl restart rsyslog
    echo "rsyslog service restarted"
}

# Call the function to remove lines and restart the service
remove_rsyslog_lines
restart_rsyslog_service
