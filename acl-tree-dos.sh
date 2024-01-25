#!/bin/bash
set -e

# Function to check if a package is installed
is_package_installed() {
    local package_name="$1"
    if dpkg -l | grep -q "ii  $package_name "; then
        return 0 # Package is installed
    else
        return 1 # Package is not installed
    fi
}

# Function to install dos2unix
install_dos2unix() {
    echo "Installing dos2unix..."
    sudo apt install dos2unix -y
}

# Function to install tree
install_tree() {
    echo "Installing tree..."
    sudo apt install tree -y
}

# Function to install acl
install_acl() {
    echo "Installing acl..."
    sudo apt install acl -y
}

# Function to install nmap
install_nmap() {
    echo "Installing nmap..."
    sudo apt install nmap -y
}

# Main script
main() {
    if ! is_package_installed "dos2unix"; then
        install_dos2unix
    else
        echo "dos2unix is already installed."
    fi

    if ! is_package_installed "tree"; then
        install_tree
    else
        echo "tree is already installed."
    fi

    if ! is_package_installed "acl"; then
        install_acl
    else
        echo "acl is already installed."
    fi

    if ! is_package_installed "nmap"; then
        install_nmap
    else
        echo "nmap is already installed."
    fi

    echo "Installation completed."
}

# Run the main function
main
