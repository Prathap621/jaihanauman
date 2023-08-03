#!/bin/bash

# Function to check if a command exists
function command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if ufw is installed
if command_exists ufw; then
  echo "ufw is installed."

  # Disable ufw
  echo "Disabling ufw..."
  if command_exists systemctl; then
    sudo systemctl stop ufw
  else
    sudo service ufw stop
  fi

  # Uninstall ufw
  echo "Uninstalling ufw..."
  if command_exists apt-get; then
    sudo apt-get remove ufw -y
  elif command_exists dnf; then
    sudo dnf remove ufw -y
  elif command_exists yum; then
    sudo yum remove ufw -y
  else
    echo "Package manager not found. Please uninstall ufw manually."
    exit 1
  fi

  echo "ufw has been disabled and uninstalled."
else
  echo "ufw is not installed."
fi

# Check if iptables is installed
if ! command_exists iptables; then
  echo "iptables is not installed."

  # Install iptables
  echo "Installing iptables..."
  if command_exists apt-get; then
    sudo apt-get install iptables -y
  elif command_exists dnf; then
    sudo dnf install iptables -y
  elif command_exists yum; then
    sudo yum install iptables -y
  else
    echo "Package manager not found. Please install iptables manually."
    exit 1
  fi

  echo "iptables has been installed."
else
  echo "iptables is already installed."
fi
