#!/bin/bash

# Create a backup of the original sources.list file
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Set the desired repository URLs
main_repo="http://archive.ubuntu.com/ubuntu/"
security_repo="http://security.ubuntu.com/ubuntu/"

# Update the sources.list file with the repository URLs
sudo tee /etc/apt/sources.list > /dev/null <<EOL
deb ${main_repo} focal main restricted universe multiverse
deb ${main_repo} focal-updates main restricted universe multiverse
deb ${main_repo} focal-backports main restricted universe multiverse
deb ${security_repo} focal-security main restricted universe multiverse
EOL

# Update the package lists
sudo apt update

# Inform the user that the repositories have been configured
echo "Package manager repositories have been configured."