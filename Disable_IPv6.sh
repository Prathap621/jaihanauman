#!/bin/bash

# Backup the original sysctl.conf file
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak

# Append IPv6 configuration to sysctl.conf
if ! grep -q "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf; then
    echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
fi

if ! grep -q "net.ipv6.conf.default.disable_ipv6 = 1" /etc/sysctl.conf; then
    echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
fi

if ! grep -q "net.ipv6.conf.default.accept_redirects = 0" /etc/sysctl.conf; then
    echo "net.ipv6.conf.default.accept_redirects = 0" | sudo tee -a /etc/sysctl.conf
fi

# Reload sysctl.conf to apply the changes
sudo sysctl -p

# Set active kernel parameters to disable IPv6
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
sudo sysctl -w net.ipv6.route.flush=1

echo "IPv6 has been disabled through sysctl settings, and accept_redirects has been set to 0."
