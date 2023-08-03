#!/bin/bash

# Check if the script is being run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or using sudo."
  exit 1
fi

# Check if the lines are already present in /etc/sysctl.conf
if grep -Fxq "fs.suid_dumpable = 0" /etc/sysctl.conf && grep -Fxq "kernel.randomize_va_space = 2" /etc/sysctl.conf; then
  echo "Both fs.suid_dumpable = 0 and kernel.randomize_va_space = 2 are already present in /etc/sysctl.conf. No changes needed."
  exit 0
fi

# Add the lines to /etc/sysctl.conf if they are not already present
if ! grep -Fxq "fs.suid_dumpable = 0" /etc/sysctl.conf; then
  echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
fi

if ! grep -Fxq "kernel.randomize_va_space = 2" /etc/sysctl.conf; then
  echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
fi

# Apply the changes immediately
sysctl -p

echo "Core dump restrictions and kernel address space randomization have been enabled."

