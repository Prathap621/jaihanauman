#!/bin/bash

check_duplicate_user_names() {
    os_id=$(grep -oP 'ID=\K\w+' /etc/os-release)

    case "$os_id" in
        ubuntu)
            passwd_file="/etc/passwd"
            ;;
        almalinux)
            passwd_file="/etc/shadow"
            ;;
        *)
            echo "Unsupported operating system."
            exit 1
            ;;
    esac

    duplicate_users=$(cut -d: -f1 "$passwd_file" | sort | uniq -d)
    
    if [[ -z $duplicate_users ]]; then
        echo "No duplicate user names found."
    else
        echo "Duplicate user names found:"
        echo "$duplicate_users"
    fi
}

# Execute the function with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

check_duplicate_user_names
