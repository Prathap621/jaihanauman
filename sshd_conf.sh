#!/bin/bash

# Function to update or add SSH configuration settings uniquely
update_sshd_config_unique() {
    local key="$1"
    local value="$2"
    local sshd_config="/etc/ssh/sshd_config"
    local tmp_file=$(mktemp)

    # Check parameter already exists in the file
    if grep -qE "^[#\s]*${key}\b" "$sshd_config"; then
        # Configuration parameter already exists, remove all occurrences
        sed -e "/^[#\s]*${key}\b/d" "$sshd_config" > "$tmp_file"
    else
        # Configuration parameter doesn't exist yet
        cp "$sshd_config" "$tmp_file"
    fi

    # Append new parameter
    echo "${key} ${value}" >> "$tmp_file"

    # Replace the original config file with the modified one
    mv "$tmp_file" "$sshd_config"
    chmod 600 "$sshd_config" # Ensure the file permissions are secure
}

# Example usage for Ubuntu 20.04
echo "Configuring SSH parameters..."

# Update SSH configuration parameters uniquely
update_sshd_config_unique "ClientAliveInterval" "120"
update_sshd_config_unique "ClientAliveCountMax" "3"
update_sshd_config_unique "X11Forwarding" "no"
update_sshd_config_unique "AllowTcpForwarding" "yes"
update_sshd_config_unique "PrintMotd" "no"
update_sshd_config_unique "MaxStartups" "10:30:100"
update_sshd_config_unique "PubkeyAuthentication" "yes"
update_sshd_config_unique "RevokedKeys" "/home/deploy/.ssh/revoked_keys"

echo "SSH configuration updated. Restarting SSH service..."

# Restart SSH service to apply changes
sudo systemctl restart sshd

echo "SSH service restarted successfully."
