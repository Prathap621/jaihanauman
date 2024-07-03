#!/bin/bash

# Check if port 111 is already in use
echo "Checking if port 111 is in use:"
if netstat -plant | grep LIST | grep '\b111\b'; then
    echo "Port 111 is already in use. Exiting."
    exit 1
fi

# Check if nfs-common package is installed
echo "Checking if nfs-common package is installed..."
if ! dpkg -s nfs-common &> /dev/null; then
    echo "nfs-common package is not installed. Installing..."
    apt update
    apt install -y nfs-common
else
    echo "nfs-common package is already installed."
fi

# Stop and disable rpcbind.socket service
echo "Stopping rpcbind.socket service..."
systemctl stop rpcbind.socket
echo "Disabling rpcbind.socket service..."
systemctl disable rpcbind.socket

# Check again if port 111 is in use after stopping rpcbind.socket
echo "Checking if port 111 is still in use:"
netstat -plant | grep LIST | grep '\b111\b'
