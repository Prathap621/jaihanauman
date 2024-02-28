#!/bin/bash

# Function to install sysstat
install_sysstat() {
    echo "Installing sysstat..."
    sudo apt-get install sysstat -y
}

# Function to modify /etc/default/sysstat
modify_sysstat_config() {
    echo "Modifying /etc/default/sysstat..."
    # Check if ENABLED parameter exists and set it to true if found
    if grep -q '^ENABLED="false"' /etc/default/sysstat; then
        sudo sed -i 's/^ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
    elif ! grep -q '^ENABLED=' /etc/default/sysstat; then
        # Add ENABLED parameter if it doesn't exist
        sudo bash -c 'echo "ENABLED=\"true\"" >> /etc/default/sysstat'
    fi
}

# Main function
main() {
    install_sysstat
    modify_sysstat_config
    echo "Sysstat installed and configured successfully."
}

# Execute the main function
main
