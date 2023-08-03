#!/bin/bash

# Function to check and install telnet on Ubuntu
function install_telnet_ubuntu() {
  echo "Checking if telnet is installed on Ubuntu..."
  if dpkg -l telnet | grep -q "^ii"; then
    echo "telnet is already installed on Ubuntu."
  else
    echo "Installing telnet on Ubuntu..."
    sudo apt-get update
    sudo apt-get install -y telnet
  fi
}

# Function to check and install telnet on AlmaLinux
function install_telnet_almalinux() {
  echo "Checking if telnet is installed on AlmaLinux..."
  if rpm -q telnet >/dev/null; then
    echo "telnet is already installed on AlmaLinux."
  else
    echo "Installing telnet on AlmaLinux..."
    sudo yum install -y telnet
  fi
}

# Execute the functions
install_telnet_ubuntu
install_telnet_almalinux
