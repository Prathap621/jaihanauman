#!/bin/bash

# Set the log directory path
log_directory="/var/log"

# Set the desired permissions for log files
log_file_permissions="640"

# Set the desired permissions for log directories
log_directory_permissions="750"

# Check the operating system
if [ -f "/etc/lsb-release" ]; then
  # Ubuntu
  find "$log_directory" -type f -perm /g+wx,o+rwx -exec chmod --changes g-wx,o-rwx "{}" +
  find "$log_directory" \( -type d -exec chmod --changes g-wx,o-rwx "{}" + \) -o \( -type f -exec chmod --changes "$log_file_permissions" "{}" + \)
elif [ -f "/etc/os-release" ]; then
  # Alma Linux
  find "$log_directory" -type f -perm /g+wx,o+wx -exec chmod --changes g-wx,o-wx "{}" +
  find "$log_directory" -type d -perm /g+wx,o+wx -exec chmod --changes g-wx,o-wx "{}" +
  find "$log_directory" -type f -exec chmod --changes "$log_file_permissions" "{}" +
  find "$log_directory" -type d -exec chmod --changes "$log_directory_permissions" "{}" +
else
  echo "Unsupported operating system."
  exit 1
fi

echo "Permissions on log files and directories have been configured."
