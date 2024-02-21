#!/bin/bash

# Define the desired MACs and Key Exchange Algorithms
desired_macs="umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1,hmac-sha1-96,hmac-sha1-etm@openssh.com,hmac-sha1-96-etm@openssh.com"
desired_kex="curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1"

# Define the SSHD config file path
sshd_config_file="/etc/ssh/sshd_config"

update_config() {
    local key="$1"
    local desired_value="$2"
    local config_file="$3"
    local current_value

    current_value=$(grep "^${key}" "$config_file" | head -n 1 | awk '{$1=""; print $0}' | xargs)

    if [[ -z "$current_value" ]]; then
        # Key does not exist, add it
        echo "Adding ${key} to $config_file."
        echo "${key} ${desired_value}" >> "$config_file"
    else
        # Key exists, check if update is needed
        if [[ ! "$current_value" == *"$desired_value"* ]]; then
            # Update needed, append missing values
            echo "Updating ${key} in $config_file."
            sed -i "/^${key}/ s/$/,${desired_value}/" "$config_file"
        else
            echo "${key} is already up to date in $config_file."
        fi
    fi
}

# Ensure the MACs and Key Exchange Algorithms lines exist or add them
update_config "MACs" "$desired_macs" "$sshd_config_file"
update_config "KexAlgorithms" "$desired_kex" "$sshd_config_file"

# Restart the sshd service to apply changes
echo "Restarting SSHD service to apply changes."
systemctl restart sshd

echo "Update complete."
