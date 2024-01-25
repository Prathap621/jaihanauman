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

# Function to purge apparmor
purge_apparmor() {
    echo "Purging apparmor..."
    sudo apt purge apparmor -y
}

# Function to purge ufw
purge_ufw() {
    echo "Purging ufw..."
    sudo apt purge ufw -y
}

# Function to update package list
update_package_list() {
    echo "Updating package list..."
    sudo apt update
}

# Function to perform apt autoremove
perform_autoremove() {
    echo "Performing apt autoremove..."
    sudo apt autoremove -y
}

# Main script
main() {
    update_package_list

    if is_package_installed "apparmor"; then
        purge_apparmor
    else
        echo "apparmor is not installed."
    fi

    if is_package_installed "ufw"; then
        purge_ufw
    else
        echo "ufw is not installed."
    fi

    perform_autoremove
    echo "Tasks completed."
}

# Run the main function
main
