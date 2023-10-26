#!/bin/bash

# Define the paths for the original and backup files
original_file="/etc/pam.d/common-password"
backup_file="/etc/pam.d/common-password.bak"

# backup file
sudo cp "$original_file" "$backup_file"

# update with new content
new_content="password  sufficient   pam_unix.so use_authok md5 shadow
password  sufficient   pam_krb5.so use_first_pass ignore_root
password  required     pam_deny.so"

# Remove the original file's contents
sudo truncate -s 0 "$original_file"

# new content to the original file
echo "$new_content" | sudo tee -a "$original_file"

echo "Backup created at $backup_file"
echo "Original file updated with new content."
