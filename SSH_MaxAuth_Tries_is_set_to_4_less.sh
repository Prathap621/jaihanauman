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

# Get the operating system
OS=$(get_os)

if [ "$OS" == "Ubuntu" ]; then
  # Ubuntu
  if [ -f "/etc/ssh/sshd_config" ]; then
    # Set MaxAuthTries to 4 or less in sshd_config
    sed -i 's/^#MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
    echo "SSH MaxAuthTries has been set to 4 or less for Ubuntu."
  else
    echo "File /etc/ssh/sshd_config not found for Ubuntu."
  fi
elif [ "$OS" == "AlmaLinux" ]; then
  # AlmaLinux
  if [ -f "/etc/ssh/sshd_config" ]; then
    # Set MaxAuthTries to 4 or less in sshd_config
    sed -i 's/^#MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
    echo "SSH MaxAuthTries has been set to 4 or less for AlmaLinux."
  else
    echo "File /etc/ssh/sshd_config not found for AlmaLinux."
  fi
else
  echo "Unsupported operating system: $OS"
fi
