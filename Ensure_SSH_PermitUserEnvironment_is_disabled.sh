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
  SSH_CONFIG="/etc/ssh/sshd_config"
elif [ "$OS_ID" == "almalinux" ]; then
  # AlmaLinux
  SSH_CONFIG="/etc/ssh/sshd_config"
else
  echo "Unsupported operating system: $OS_ID"
  exit 1
fi

# Check if PermitUserEnvironment is enabled in sshd_config
if grep -q "^PermitUserEnvironment yes" "$SSH_CONFIG"; then
  # Disable PermitUserEnvironment
  sed -i 's/^PermitUserEnvironment yes/PermitUserEnvironment no/' "$SSH_CONFIG"
  echo "SSH PermitUserEnvironment has been disabled for $OS_ID."
else
  echo "SSH PermitUserEnvironment is already disabled for $OS_ID."
fi
