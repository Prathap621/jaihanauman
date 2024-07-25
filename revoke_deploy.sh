#!/bin/bash

# Directory and file path
ssh_dir="/home/deploy/.ssh"
revoked_keys_file="${ssh_dir}/revoked_keys"

# Ensure .ssh directory exists
if [ ! -d "$ssh_dir" ]; then
    mkdir -p "$ssh_dir"
fi

# Create or update revoked_keys file
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoi480+wu9b3gUNEDCGG4cCC7dSUNrHNyCoRkzIgtDhPf/nQbgRqr8dKAE9OOh9uaCFMZ/jqP61gHziHEO84lSeBGV72sKQ7rX2VkoPQm+mtcuF7+qlytD91Y934DSc/QiG+SOFAOnIfxViqLyERLJefgk5qlUjaBLagpaioW8uDUB+YUcldFPRR2o915Ijr+vdCGsE76sk1Gc04sfrszScEhB/aZ8EUEBqW/OBIRGcOyFRiXyd/y2kUmn4FEmqGzGHxXGG9NDIXzwiKp5UE0IzfeBgnL1KKVmq/KsN/lo2l2gZwNHmhwyk3tH45I3mcmNaVh0X4kaD77arWccgsSIvXlVEHQLHr/NEnp5nwPmxOubi/uJM7lqhWmpN6MubbymrfQdEK4GwBUJpWIf0Y9634Lfbf6y8bzTu48BDN9L1WuufSdeCBUUH4wriL632X+jUt4U+WP9iITFj0IXx4cQiBxf9WXFljFZAeqGO44Fup7GVoFNprAaxvoEKGYxlL+dgXkP99cXcqaDHPSgzT1AHQdlagD9q3J9lPdiiINUooJ2dauk9wO8TfzdgAdODvHMMLGAsCM2jbWDnxPbZK0X61nPPer9xc/2MF0tV6Gr6fOtt/VJfhna01DH0HftAz/FL88NvSG+3Ud1Z9O/nIBliriWt3XcMaqlcw4aAEWrgw==" > "$revoked_keys_file"

# Ensure correct permissions on revoked_keys file
chmod 600 "$revoked_keys_file"

echo "revoked_keys file updated successfully."
