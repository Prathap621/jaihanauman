#!/bin/bash

# Function to check the operating system ID
get_os_id() {
  if [ -f "/etc/os-release" ]; then
    . /etc/os-release
    OS_ID="$ID"
  elif [ -f "/etc/lsb-release" ]; then
    . /etc/lsb-release
    OS_ID="$DISTRIB_ID"
  elif [ -f "/etc/redhat-release" ]; then
    OS_ID=$(awk '{print $1}' /etc/redhat-release)
  else
    OS_ID=$(uname -s)
  fi
  echo "$OS_ID"
}

# Get the operating system ID
OS_ID=$(get_os_id)

if [ "$OS_ID" == "ubuntu" ]; then
  # Ubuntu
  if [ -f "/etc/login.defs" ]; then
    # Set PASS_MAX_DAYS to 99999
    sed -i 's/^#?PASS_MAX_DAYS.*/PASS_MAX_DAYS 99999/' /etc/login.defs
    echo "Password expiration has been set to 99999 days for Ubuntu."
  else
    echo "File /etc/login.defs not found for Ubuntu."
  fi
elif [ "$OS_ID" == "almalinux" ]; then
  # AlmaLinux
  if [ -f "/etc/login.defs" ]; then
    # Set PASS_MAX_DAYS to 99999
    sed -i 's/^#?PASS_MAX_DAYS.*/PASS_MAX_DAYS 99999/' /etc/login.defs
    echo "Password expiration has been set to 99999 days for AlmaLinux."
  else
    echo "File /etc/login.defs not found for AlmaLinux."
  fi
else
  echo "Unsupported operating system: $OS_ID"
fi
