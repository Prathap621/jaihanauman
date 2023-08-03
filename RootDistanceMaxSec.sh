#!/bin/bash

# Define the file path
file_path="/etc/systemd/timesyncd.conf"

# Define the setting to add/modify
setting_name="RootDistanceMaxSec"
setting_value="1"

# Check if the setting already exists in the file
if grep -q "^$setting_name=" "$file_path"; then
    # If the setting exists, modify it
    sed -i "s/^$setting_name=.*/$setting_name=$setting_value/" "$file_path"
    echo "Modified $setting_name in $file_path to $setting_value"
else
    # If the setting doesn't exist, add it to the end of the file
    echo "$setting_name=$setting_value" >> "$file_path"
    echo "Added $setting_name=$setting_value to $file_path"
fi

# Remove any duplicate lines (in case they exist)
temp_file=$(mktemp)
awk '!seen[$0]++' "$file_path" > "$temp_file"
mv "$temp_file" "$file_path"
echo "Removed duplicate lines from $file_path"
