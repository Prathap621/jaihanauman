#!/bin/bash

# Define the desired MACs and Key Exchange Algorithms
desired_macs="umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512"
desired_kex="curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256"

# Define the SSHD config file path
sshd_config_file="/etc/ssh/sshd_config"

# Ensure the MACs line exists or add it
if ! grep -q "MACs $desired_macs" "$sshd_config_file"; then
    echo "Adding MACs line to $sshd_config_file."
    echo "MACs $desired_macs" >> "$sshd_config_file"
fi

# Ensure the Key Exchange Algorithms line exists or add it
if ! grep -q "KexAlgorithms $desired_kex" "$sshd_config_file"; then
    echo "Adding Key Exchange Algorithms line to $sshd_config_file."
    echo "KexAlgorithms $desired_kex" >> "$sshd_config_file"
fi
