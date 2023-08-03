#!/bin/bash

# Function to edit the configuration file
edit_config() {
  config_file="$1"
  line_to_add1="Storage=persistent"
  line_to_add2="ForwardToSyslog=yes"
  
  # Check if the lines already exist in the file
  if grep -Fxq "$line_to_add1" "$config_file" && grep -Fxq "$line_to_add2" "$config_file"; then
    echo "The lines '$line_to_add1' and '$line_to_add2' already exist in '$config_file'. No changes needed."
  else
    # Add the lines to the file
    echo "$line_to_add1" >> "$config_file"
    echo "$line_to_add2" >> "$config_file"
    echo "The lines '$line_to_add1' and '$line_to_add2' have been added to '$config_file'."
  fi
}

# Edit /etc/systemd/journald.conf
edit_config "/etc/systemd/journald.conf"

# Edit files ending in .conf in /etc/systemd/journald.conf.d/
for file in /etc/systemd/journald.conf.d/*.conf; do
  if [ -f "$file" ]; then
    edit_config "$file"
  fi
done

# Restart the systemd-journald service
systemctl restart systemd-journald

echo "The configuration has been updated and the systemd-journald service has been restarted."
