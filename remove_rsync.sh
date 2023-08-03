#!/bin/bash

# Function to check and remove rsync on Ubuntu
function remove_rsync_ubuntu() {
  echo "Checking if rsync is installed on Ubuntu..."
  if dpkg -l rsync | grep -q "^ii"; then
    echo "rsync is installed. Removing rsync..."
    sudo apt-get remove -y rsync
  else
    echo "rsync is not installed on Ubuntu."
  fi
}

# Function to check and remove rsync on AlmaLinux
function remove_rsync_almalinux() {
  echo "Checking if rsync is installed on AlmaLinux..."
  if rpm -q rsync >/dev/null; then
    echo "rsync is installed. Removing rsync..."
    sudo yum remove -y rsync
  else
    echo "rsync is not installed on AlmaLinux."
  fi
}

# Read OS distribution from /etc/os-release
os_distribution=$(grep -oP '(?<=^ID=).+' /etc/os-release)

# Check OS distribution and remove rsync
case $os_distribution in
  "ubuntu"|"Ubuntu")
    echo "Detected Ubuntu..."
    remove_rsync_ubuntu
    ;;
  "almalinux"|"AlmaLinux")
    echo "Detected AlmaLinux..."
    remove_rsync_almalinux
    ;;
  *)
    echo "Unsupported OS distribution."
    ;;
esac

