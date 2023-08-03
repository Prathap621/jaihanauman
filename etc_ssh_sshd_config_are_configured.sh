#!/bin/bash

# Function to check the operating system
get_os() {
  if [ -f "/etc/os-release" ]; then
    . /etc/os-release
    OS="$NAME"
  elif [ -f "/etc/lsb-release" ]; then
    . /etc/lsb-release
    OS="$DISTRIB_ID"
  elif [ -f "/etc/redhat-release" ]; then
    OS=$(awk '{print $1}' /etc/redhat-release)
  else
    OS=$(uname -s)
  fi
  echo "$OS"
}

# Set the desired permissions for the sshd_config file
sshd_config_permissions="600"

# Get the operating system
OS=$(get_os)

if [ "$OS" == "Ubuntu" ]; then
  # Ubuntu
  if [ -f "/etc/ssh/sshd_config" ]; then
    # Set the correct permissions
    chmod "$sshd_config_permissions" /etc/ssh/sshd_config
    echo "Permissions on /etc/ssh/sshd_config have been configured for Ubuntu."
  else
    echo "File /etc/ssh/sshd_config not found for Ubuntu."
  fi
elif [ "$OS" == "AlmaLinux" ]; then
  # AlmaLinux
  if [ -f "/etc/ssh/sshd_config" ]; then
    # Set the correct permissions
    chmod "$sshd_config_permissions" /etc/ssh/sshd_config
    echo "Permissions on /etc/ssh/sshd_config have been configured for AlmaLinux."
  else
    echo "File /etc/ssh/sshd_config not found for AlmaLinux."
  fi
else
  echo "Unsupported operating system: $OS"
fi
