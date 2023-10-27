#!/bin/bash

# Define the backup file name
backup_file="/etc/default/grub.bak"

# Check if the backup file already exists, and create one if it doesn't
if [ ! -f "$backup_file" ]; then
  sudo cp /etc/default/grub "$backup_file"
fi

# Define the new audit setting
new_audit_setting='GRUB_CMDLINE_LINUX="audit=1"'

# Check if the audit setting already exists in the grub file
if grep -q 'GRUB_CMDLINE_LINUX="audit=' /etc/default/grub; then
  # The audit setting exists; update it to 1
  sudo sed -i 's/GRUB_CMDLINE_LINUX="audit=[0-9]*"/'$new_audit_setting'/' /etc/default/grub
else
  # The audit setting doesn't exist; add it as "audit=1"
  echo "$new_audit_setting" | sudo tee -a /etc/default/grub > /dev/null
fi

# Update the grub configuration
sudo update-grub

echo "GRUB configuration updated with audit=1."
