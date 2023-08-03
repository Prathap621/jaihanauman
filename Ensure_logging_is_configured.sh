#!/bin/bash

# Check if OS is Ubuntu
if [[ -f /etc/lsb-release && "$(grep -E '^DISTRIB_ID=Ubuntu$' /etc/lsb-release)" ]]; then
  # Ubuntu configuration
  sudo sed -i '/^\*\.=\(.*\)$/s/^#//' /etc/rsyslog.conf
  sudo sed -i '/^\*\.=\/var\/log\/syslog$/s/^#//' /etc/rsyslog.conf
  sudo service rsyslog restart
  echo "Logging configuration updated for Ubuntu."
fi

# Check if OS is AlmaLinux
if [[ -f /etc/os-release && "$(grep -E '^ID=alma$' /etc/os-release)" ]]; then
  # AlmaLinux configuration
  sudo sed -i '/^\*\.=\(.*\)$/s/^#//' /etc/rsyslog.conf
  sudo sed -i '/^\*\.=\/var\/log\/messages$/s/^#//' /etc/rsyslog.conf
  sudo systemctl restart rsyslog
  echo "Logging configuration updated for AlmaLinux."
fi
