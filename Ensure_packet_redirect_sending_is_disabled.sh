#!/bin/bash

# Backup the original sysctl.conf file
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Append parameter configurations to sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 0" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0" | sudo tee -a /etc/sysctl.conf

# Reload sysctl.conf to apply the changes
sudo sysctl -p

# Set active kernel parameters
sudo sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -w net.ipv4.conf.default.send_redirects=0
sudo sysctl -w net.ipv4.route.flush=1

echo "IPv4 send redirects have been disabled."
