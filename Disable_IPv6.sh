#!/bin/bash

# Backup the original sysctl.conf file
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Append IPv6 disable configuration to sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf

# Reload sysctl.conf to apply the changes
sudo sysctl -p

# Set active kernel parameters to disable IPv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.route.flush=1

echo "IPv6 has been disabled through sysctl settings."
