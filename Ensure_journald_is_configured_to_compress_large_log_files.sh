#!/bin/bash

# Check the OS
if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  if [[ "$ID" == "ubuntu" ]]; then
    # Ubuntu
    conf_file="/etc/systemd/journald.conf"
    service_name="systemd-journald"
  elif [[ "$ID" == "almalinux" ]]; then
    # AlmaLinux
    conf_file="/etc/systemd/journald.conf.d/00-journald.conf"
    service_name="systemd-journald"
  else
    echo "Unsupported OS: $ID"
    exit 1
  fi

  # Check if the configuration file exists
  if [[ -f "$conf_file" ]]; then
    # Configure journald to compress large log files
    sudo sed -i 's/#Compress=yes/Compress=yes/' "$conf_file"
    sudo systemctl restart "$service_name"
    echo "journald configuration updated."
  else
    echo "journald configuration file not found."
  fi
else
  echo "Unable to determine the OS."
  exit 1
fi
