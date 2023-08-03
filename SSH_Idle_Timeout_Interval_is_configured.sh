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
  SSHD_CONFIG="/etc/ssh/sshd_config"
elif [ "$OS_ID" == "almalinux" ]; then
  # AlmaLinux
  SSHD_CONFIG="/etc/ssh/sshd_config"
else
  echo "Unsupported operating system: $OS_ID"
  exit 1
fi

# Check if SSH Idle Timeout Interval is configured
if grep -qE '^[\t\s]*ClientAliveInterval[\t\s]+[0-9]+[\t\s]*$' "$SSHD_CONFIG" && grep -qE '^[\t\s]*ClientAliveCountMax[\t\s]+[0-9]+[\t\s]*$' "$SSHD_CONFIG"; then
  # Update the SSH Idle Timeout Interval
  sed -ri 's/^[\t\s]*ClientAliveInterval[\t\s]+[0-9]+[\t\s]*$/ClientAliveInterval 120/' "$SSHD_CONFIG"
  sed -ri 's/^[\t\s]*ClientAliveCountMax[\t\s]+[0-9]+[\t\s]*$/ClientAliveCountMax 3/' "$SSHD_CONFIG"
  echo "SSH Idle Timeout Interval has been configured for $OS_ID."
else
  # Add the SSH Idle Timeout Interval configuration
  echo "ClientAliveInterval 120" >> "$SSHD_CONFIG"
  echo "ClientAliveCountMax 3" >> "$SSHD_CONFIG"
  echo "SSH Idle Timeout Interval has been configured for $OS_ID."
fi
