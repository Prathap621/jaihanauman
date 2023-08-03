#!/bin/bash

# Function to configure minimum days between password changes on Ubuntu
function configure_password_changes_ubuntu() {
  echo "Configuring minimum days between password changes on Ubuntu..."
  # Edit login.defs
  sudo sed -i '/^PASS_MIN_DAYS/c\PASS_MIN_DAYS   7' /etc/login.defs
}

# Function to configure minimum days between password changes on AlmaLinux
function configure_password_changes_almalinux() {
  echo "Configuring minimum days between password changes on AlmaLinux..."
  # Edit login.defs
  sudo sed -i '/^PASS_MIN_DAYS/c\PASS_MIN_DAYS   7' /etc/login.defs
}

# Read OS distribution from /etc/os-release
os_distribution=$(grep -oP '(?<=^ID=).+' /etc/os-release)

# Check OS distribution and configure minimum days between password changes
case $os_distribution in
  "ubuntu"|"Ubuntu")
    echo "Detected Ubuntu..."
    configure_password_changes_ubuntu
    ;;
  "almalinux"|"AlmaLinux")
    echo "Detected AlmaLinux..."
    configure_password_changes_almalinux
    ;;
  *)
    echo "Unsupported OS distribution."
    ;;
esac
