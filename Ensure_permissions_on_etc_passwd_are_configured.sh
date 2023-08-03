#!/bin/bash

ensure_passwd_permissions() {
    passwd_file="/etc/passwd"

    if [ -f "$passwd_file" ]; then
        permissions=$(stat -c "%a" "$passwd_file")

        if [[ "$permissions" != "644" ]]; then
            echo "Incorrect permissions set on $passwd_file. Setting permissions to 644..."
            chmod 644 "$passwd_file"
            echo "Permissions on $passwd_file have been corrected."
        else
            echo "Permissions on $passwd_file are already set correctly."
        fi
    else
        echo "File $passwd_file not found."
    fi
}

# Check the operating system
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    os_name="${ID,,}"
else
    echo "Unable to determine the operating system."
    exit 1
fi

# Run the appropriate function based on the operating system
if [[ "$os_name" == "ubuntu" || "$os_name" == "almalinux" ]]; then
    ensure_passwd_permissions
else
    echo "Unsupported operating system: $os_name"
    exit 1
fi
