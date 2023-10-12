#!/bin/bash

# Function to configure SSH parameters on Ubuntu
function configure_ssh_parameters_ubuntu() {
  echo "Configuring SSH parameters on Ubuntu..."
  # Edit sshd_config
  sudo sed -i '/^#LoginGraceTime/c\LoginGraceTime 60' /etc/ssh/sshd_config
  sudo sed -i '/^#ClientAliveInterval/c\ClientAliveInterval 120' /etc/ssh/sshd_config
  sudo sed -i '/^#ClientAliveCountMax/c\ClientAliveCountMax 3' /etc/ssh/sshd_config
  sudo sed -i '/^#PermitRootLogin/c\PermitRootLogin no' /etc/ssh/sshd_config
  sudo sed -i '/^#X11Forwarding/c\X11Forwarding no' /etc/ssh/sshd_config
  sudo sed -i '/^#MaxStartups/c\MaxStartups 10:30:100' /etc/ssh/sshd_config
  sudo sed -i '/^#allow_tcp_forwarding_count/c\allow_tcp_forwarding_count yes' /etc/ssh/sshd_config
}

# Function to configure SSH parameters on AlmaLinux
function configure_ssh_parameters_almalinux() {
  echo "Configuring SSH parameters on AlmaLinux..."
  # Edit sshd_config
  sudo sed -i '/^#LoginGraceTime/c\LoginGraceTime 60' /etc/ssh/sshd_config
  sudo sed -i '/^#ClientAliveInterval/c\ClientAliveInterval 120' /etc/ssh/sshd_config
  sudo sed -i '/^#ClientAliveCountMax/c\ClientAliveCountMax 3' /etc/ssh/sshd_config
  sudo sed -i '/^#PermitRootLogin/c\PermitRootLogin yes' /etc/ssh/sshd_config
  sudo sed -i '/^#X11Forwarding/c\X11Forwarding no' /etc/ssh/sshd_config
  sudo sed -i '/^#MaxStartups/c\MaxStartups 10:30:100' /etc/ssh/sshd_config
}

# Read OS distribution from /etc/os-release
os_distribution=$(grep -oP '(?<=^ID=).+' /etc/os-release)

# Check OS distribution and configure SSH parameters
case $os_distribution in
  "ubuntu"|"Ubuntu")
    echo "Detected Ubuntu..."
    configure_ssh_parameters_ubuntu
    ;;
  "almalinux"|"AlmaLinux")
    echo "Detected AlmaLinux..."
    configure_ssh_parameters_almalinux
    ;;
  *)
    echo "Unsupported OS distribution."
    ;;
esac
