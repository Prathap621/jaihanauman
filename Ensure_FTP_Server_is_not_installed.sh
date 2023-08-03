#!/bin/bash

# Check if vsftpd is installed
if ! command -v vsftpd &> /dev/null; then
    echo "FTP Server is not installed."
    exit
fi

# Uninstall vsftpd
echo "Uninstalling vsftpd..."
sudo apt-get purge vsftpd -y

# Remove vsftpd configuration files
echo "Removing vsftpd configuration files..."
sudo rm -rf /etc/vsftpd.conf

echo "FTP Server is disabled and uninstalled."
